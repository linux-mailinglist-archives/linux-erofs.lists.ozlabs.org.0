Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750EB7A6B06
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 21:00:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqrZh2MSlz3bw9
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 05:00:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqrZV6FTlz2ygx
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 05:00:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsSLA5q_1695149988;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsSLA5q_1695149988)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 02:59:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: support tgz streams for tarerofs
Date: Wed, 20 Sep 2023 02:59:47 +0800
Message-Id: <20230919185947.3996843-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce iostream to wrap up the input tarball stream for tarerofs.

Besides, add bultin tgz support if zlib is linked to mkfs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/tar.h |  21 +++
 lib/tar.c           | 309 ++++++++++++++++++++++++++++++++------------
 mkfs/main.c         |  34 ++++-
 3 files changed, 278 insertions(+), 86 deletions(-)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index b50db1d..a76f740 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -7,6 +7,9 @@ extern "C"
 {
 #endif
 
+#if defined(HAVE_ZLIB)
+#include <zlib.h>
+#endif
 #include <sys/stat.h>
 
 #include "internal.h"
@@ -21,8 +24,24 @@ struct erofs_pax_header {
 	char *path, *link;
 };
 
+#define EROFS_IOS_DECODER_NONE		0
+#define EROFS_IOS_DECODER_GZIP		1
+
+struct erofs_iostream {
+	union {
+		int fd;			/* original fd */
+		void *handler;
+	};
+	u64 sz;
+	char *buffer;
+	unsigned int head, tail, bufsize;
+	int decoder;
+	bool feof;
+};
+
 struct erofs_tarfile {
 	struct erofs_pax_header global;
+	struct erofs_iostream ios;
 	char *mapfile;
 
 	int fd;
@@ -30,6 +49,8 @@ struct erofs_tarfile {
 	bool index_mode, aufs;
 };
 
+void erofs_iostream_close(struct erofs_iostream *ios);
+int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder);
 int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
 
 #ifdef __cplusplus
diff --git a/lib/tar.c b/lib/tar.c
index f6320b0..8e71f11 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -3,6 +3,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
+#if defined(HAVE_ZLIB)
+#include <zlib.h>
+#endif
 #include "erofs/print.h"
 #include "erofs/cache.h"
 #include "erofs/diskbuf.h"
@@ -14,8 +17,6 @@
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
 
-static char erofs_libbuf[16384];
-
 struct tar_header {
 	char name[100];		/*   0-99 */
 	char mode[8];		/* 100-107 */
@@ -60,35 +61,165 @@ s64 erofs_read_from_fd(int fd, void *buf, u64 bytes)
         return i;
 }
 
-/*
- * skip this many bytes of input. Return 0 for success, >0 means this much
- * left after input skipped.
- */
-u64 erofs_lskip(int fd, u64 sz)
+void erofs_iostream_close(struct erofs_iostream *ios)
+{
+	free(ios->buffer);
+	if (ios->decoder == EROFS_IOS_DECODER_GZIP) {
+#if defined(HAVE_ZLIB)
+		gzclose(ios->handler);
+#endif
+		return;
+	}
+	close(ios->fd);
+}
+
+int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
 {
-	s64 cur = lseek(fd, 0, SEEK_CUR);
+	s64 fsz;
+
+	ios->tail = ios->head = 0;
+	ios->decoder = decoder;
+	if (decoder == EROFS_IOS_DECODER_GZIP) {
+#if defined(HAVE_ZLIB)
+		ios->handler = gzdopen(fd, "r");
+		if (!ios->handler)
+			return -ENOMEM;
+		ios->sz = fsz = 0;
+		ios->bufsize = 32768;
+#else
+		return -EOPNOTSUPP;
+#endif
+	} else {
+		ios->fd = fd;
+		fsz = lseek(fd, 0, SEEK_END);
+		if (fsz <= 0) {
+			ios->feof = !fsz;
+			ios->sz = 0;
+		} else {
+			ios->feof = false;
+			ios->sz = fsz;
+			if (lseek(fd, 0, SEEK_SET))
+				return -EIO;
+			if (posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL))
+				erofs_warn("failed to fadvise: %s, ignored.",
+					   erofs_strerror(errno));
+		}
+		ios->bufsize = 16384;
+	}
+
+	do {
+		ios->buffer = malloc(ios->bufsize);
+		if (ios->buffer)
+			break;
+		ios->bufsize >>= 1;
+	} while (ios->bufsize >= 1024);
 
-	if (cur >= 0) {
-		s64 end = lseek(fd, 0, SEEK_END) - cur;
+	if (!ios->buffer)
+		return -ENOMEM;
+	return 0;
+}
+
+int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
+{
+	unsigned int rabytes = ios->tail - ios->head;
+	int ret;
 
-		if (end > 0 && end < sz)
-			return sz - end;
+	if (rabytes >= bytes) {
+		*buf = ios->buffer + ios->head;
+		ios->head += bytes;
+		return bytes;
+	}
 
-		end = cur + sz;
-		if (end == lseek(fd, end, SEEK_SET))
-			return 0;
+	if (ios->head) {
+		memmove(ios->buffer, ios->buffer + ios->head, rabytes);
+		ios->head = 0;
+		ios->tail = rabytes;
 	}
 
-	while (sz) {
-		int try = min_t(u64, sz, sizeof(erofs_libbuf));
-		int or;
+	if (!ios->feof) {
+		if (ios->decoder == EROFS_IOS_DECODER_GZIP) {
+#if defined(HAVE_ZLIB)
+			ret = gzread(ios->handler, ios->buffer + rabytes,
+				     ios->bufsize - rabytes);
+			if (!ret) {
+				int errnum;
+				const char *errstr;
 
-		or = read(fd, erofs_libbuf, try);
-		if (or <= 0)
-			break;
-		else
-			sz -= or;
+				errstr = gzerror(ios->handler, &errnum);
+				if (errnum != Z_STREAM_END) {
+					erofs_err("failed to gzread: %s", errstr);
+					return -EIO;
+				}
+				ios->feof = true;
+			}
+			ios->tail += ret;
+#else
+			return -EOPNOTSUPP;
+#endif
+		} else {
+			ret = erofs_read_from_fd(ios->fd, ios->buffer + rabytes,
+						 ios->bufsize - rabytes);
+			if (ret < 0)
+				return ret;
+			ios->tail += ret;
+			if (ret < ios->bufsize - rabytes)
+				ios->feof = true;
+		}
 	}
+	*buf = ios->buffer;
+	ret = min_t(int, ios->tail, bytes);
+	ios->head = ret;
+	return ret;
+}
+
+int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
+{
+	u64 rem = bytes;
+	void *src;
+	int ret;
+
+	do {
+		ret = erofs_iostream_read(ios, &src, rem);
+		if (ret < 0)
+			return ret;
+		memcpy(buf, src, ret);
+		rem -= ret;
+	} while (rem && ret);
+
+	return rem;
+}
+
+int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
+{
+	unsigned int rabytes = ios->tail - ios->head;
+	int ret;
+	void *dummy;
+
+	if (rabytes >= sz) {
+		ios->head += sz;
+		return 0;
+	}
+
+	sz -= rabytes;
+	ios->head = ios->tail = 0;
+	if (ios->feof)
+		return sz;
+
+	if (ios->sz) {
+		s64 cur = lseek(ios->fd, sz, SEEK_CUR);
+
+		if (cur > ios->sz)
+			return cur - ios->sz;
+		return 0;
+	}
+
+	do {
+		ret = erofs_iostream_read(ios, &dummy, sz);
+		if (ret < 0)
+			return ret;
+		sz -= ret;
+	} while (!(ios->feof || !ret || !sz));
+
 	return sz;
 }
 
@@ -251,7 +382,8 @@ static int base64_decode(const char *src, int len, u8 *dst)
 	return cp - dst;
 }
 
-int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
+int tarerofs_parse_pax_header(struct erofs_iostream *ios,
+			      struct erofs_pax_header *eh, u32 size)
 {
 	char *buf, *p;
 	int ret;
@@ -261,7 +393,7 @@ int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
 		return -ENOMEM;
 	p = buf;
 
-	ret = erofs_read_from_fd(fd, buf, size);
+	ret = erofs_iostream_bread(ios, buf, size);
 	if (ret != size)
 		goto out;
 
@@ -407,10 +539,10 @@ void tarerofs_remove_inode(struct erofs_inode *inode)
 static int tarerofs_write_file_data(struct erofs_inode *inode,
 				    struct erofs_tarfile *tar)
 {
-	unsigned int j, rem;
-	int fd;
+	unsigned int j;
+	void *buf;
+	int fd, nread;
 	u64 off;
-	char buf[65536];
 
 	if (!inode->i_diskbuf) {
 		inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
@@ -425,12 +557,14 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 		return -EBADF;
 
 	for (j = inode->i_size; j; ) {
-		rem = min_t(unsigned int, sizeof(buf), j);
-
-		if (erofs_read_from_fd(tar->fd, buf, rem) != rem ||
-		    write(fd, buf, rem) != rem)
-			return -EIO;
-		j -= rem;
+		nread = erofs_iostream_read(&tar->ios, &buf, j);
+		if (nread < 0)
+			break;
+		if (write(fd, buf, nread) != nread) {
+			nread = -EIO;
+			break;
+		}
+		j -= nread;
 	}
 	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
 	inode->with_diskbuf = true;
@@ -445,7 +579,7 @@ static int tarerofs_write_file_index(struct erofs_inode *inode,
 	ret = tarerofs_write_chunkes(inode, data_offset);
 	if (ret)
 		return ret;
-	if (erofs_lskip(tar->fd, inode->i_size))
+	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
 		return -EIO;
 	return 0;
 }
@@ -459,7 +593,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	struct stat st;
 	erofs_off_t tar_offset, data_offset;
 
-	struct tar_header th;
+	struct tar_header *th;
 	struct erofs_dentry *d;
 	struct erofs_inode *inode;
 	unsigned int j, csum, cksum;
@@ -474,7 +608,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 restart:
 	rem = tar->offset & 511;
 	if (rem) {
-		if (erofs_lskip(tar->fd, 512 - rem)) {
+		if (erofs_iostream_lskip(&tar->ios, 512 - rem)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -482,11 +616,14 @@ restart:
 	}
 
 	tar_offset = tar->offset;
-	ret = erofs_read_from_fd(tar->fd, &th, sizeof(th));
-	if (ret != sizeof(th))
+	ret = erofs_iostream_read(&tar->ios, (void **)&th, sizeof(*th));
+	if (ret != sizeof(*th)) {
+		erofs_err("failed to read header block @ %llu", tar_offset);
+		ret = -EIO;
 		goto out;
-	tar->offset += sizeof(th);
-	if (*th.name == '\0') {
+	}
+	tar->offset += sizeof(*th);
+	if (*th->name == '\0') {
 		if (e) {	/* end of tar 2 empty blocks */
 			ret = 1;
 			goto out;
@@ -495,14 +632,14 @@ restart:
 		goto restart;
 	}
 
-	if (strncmp(th.magic, "ustar", 5)) {
+	if (memcmp(th->magic, "ustar", 5)) {
 		erofs_err("invalid tar magic @ %llu", tar_offset);
 		ret = -EIO;
 		goto out;
 	}
 
 	/* chksum field itself treated as ' ' */
-	csum = tarerofs_otoi(th.chksum, sizeof(th.chksum));
+	csum = tarerofs_otoi(th->chksum, sizeof(th->chksum));
 	if (errno) {
 		erofs_err("invalid chksum @ %llu", tar_offset);
 		ret = -EBADMSG;
@@ -513,12 +650,12 @@ restart:
 		cksum += (unsigned int)' ';
 	ckksum = cksum;
 	for (j = 0; j < 148; ++j) {
-		cksum += (unsigned int)((u8*)&th)[j];
-		ckksum += (int)((char*)&th)[j];
+		cksum += (unsigned int)((u8*)th)[j];
+		ckksum += (int)((char*)th)[j];
 	}
 	for (j = 156; j < 500; ++j) {
-		cksum += (unsigned int)((u8*)&th)[j];
-		ckksum += (int)((char*)&th)[j];
+		cksum += (unsigned int)((u8*)th)[j];
+		ckksum += (int)((char*)th)[j];
 	}
 	if (csum != cksum && csum != ckksum) {
 		erofs_err("chksum mismatch @ %llu", tar_offset);
@@ -526,14 +663,14 @@ restart:
 		goto out;
 	}
 
-	st.st_mode = tarerofs_otoi(th.mode, sizeof(th.mode));
+	st.st_mode = tarerofs_otoi(th->mode, sizeof(th->mode));
 	if (errno)
 		goto invalid_tar;
 
 	if (eh.use_uid) {
 		st.st_uid = eh.st.st_uid;
 	} else {
-		st.st_uid = tarerofs_parsenum(th.uid, sizeof(th.uid));
+		st.st_uid = tarerofs_parsenum(th->uid, sizeof(th->uid));
 		if (errno)
 			goto invalid_tar;
 	}
@@ -541,7 +678,7 @@ restart:
 	if (eh.use_gid) {
 		st.st_gid = eh.st.st_gid;
 	} else {
-		st.st_gid = tarerofs_parsenum(th.gid, sizeof(th.gid));
+		st.st_gid = tarerofs_parsenum(th->gid, sizeof(th->gid));
 		if (errno)
 			goto invalid_tar;
 	}
@@ -549,7 +686,7 @@ restart:
 	if (eh.use_size) {
 		st.st_size = eh.st.st_size;
 	} else {
-		st.st_size = tarerofs_parsenum(th.size, sizeof(th.size));
+		st.st_size = tarerofs_parsenum(th->size, sizeof(th->size));
 		if (errno)
 			goto invalid_tar;
 	}
@@ -560,25 +697,25 @@ restart:
 		ST_MTIM_NSEC(&st) = ST_MTIM_NSEC(&eh.st);
 #endif
 	} else {
-		st.st_mtime = tarerofs_parsenum(th.mtime, sizeof(th.mtime));
+		st.st_mtime = tarerofs_parsenum(th->mtime, sizeof(th->mtime));
 		if (errno)
 			goto invalid_tar;
 	}
 
-	if (th.typeflag <= '7' && !eh.path) {
+	if (th->typeflag <= '7' && !eh.path) {
 		eh.path = path;
 		j = 0;
-		if (*th.prefix) {
-			memcpy(path, th.prefix, sizeof(th.prefix));
-			path[sizeof(th.prefix)] = '\0';
+		if (*th->prefix) {
+			memcpy(path, th->prefix, sizeof(th->prefix));
+			path[sizeof(th->prefix)] = '\0';
 			j = strlen(path);
 			if (path[j - 1] != '/') {
 				path[j] = '/';
 				path[++j] = '\0';
 			}
 		}
-		memcpy(path + j, th.name, sizeof(th.name));
-		path[j + sizeof(th.name)] = '\0';
+		memcpy(path + j, th->name, sizeof(th->name));
+		path[j + sizeof(th->name)] = '\0';
 		j = strlen(path);
 		while (path[j - 1] == '/')
 			path[--j] = '\0';
@@ -586,20 +723,30 @@ restart:
 
 	data_offset = tar->offset;
 	tar->offset += st.st_size;
-	if (th.typeflag == '0' || th.typeflag == '7' || th.typeflag == '1') {
+	switch(th->typeflag) {
+	case '0':
+	case '7':
+	case '1':
 		st.st_mode |= S_IFREG;
-	} else if (th.typeflag == '2') {
+		break;
+	case '2':
 		st.st_mode |= S_IFLNK;
-	} else if (th.typeflag == '3') {
+		break;
+	case '3':
 		st.st_mode |= S_IFCHR;
-	} else if (th.typeflag == '4') {
+		break;
+	case '4':
 		st.st_mode |= S_IFBLK;
-	} else if (th.typeflag == '5') {
+		break;
+	case '5':
 		st.st_mode |= S_IFDIR;
-	} else if (th.typeflag == '6') {
+		break;
+	case '6':
 		st.st_mode |= S_IFIFO;
-	} else if (th.typeflag == 'g') {
-		ret = tarerofs_parse_pax_header(tar->fd, &tar->global, st.st_size);
+		break;
+	case 'g':
+		ret = tarerofs_parse_pax_header(&tar->ios, &tar->global,
+						st.st_size);
 		if (ret)
 			goto out;
 		if (tar->global.path) {
@@ -611,31 +758,31 @@ restart:
 			eh.link = strdup(tar->global.link);
 		}
 		goto restart;
-	} else if (th.typeflag == 'x') {
-		ret = tarerofs_parse_pax_header(tar->fd, &eh, st.st_size);
+	case 'x':
+		ret = tarerofs_parse_pax_header(&tar->ios, &eh, st.st_size);
 		if (ret)
 			goto out;
 		goto restart;
-	} else if (th.typeflag == 'L') {
+	case 'L':
 		free(eh.path);
 		eh.path = malloc(st.st_size + 1);
-		if (st.st_size != erofs_read_from_fd(tar->fd, eh.path,
-						     st.st_size))
+		if (st.st_size != erofs_iostream_bread(&tar->ios, eh.path,
+						       st.st_size))
 			goto invalid_tar;
 		eh.path[st.st_size] = '\0';
 		goto restart;
-	} else if (th.typeflag == 'K') {
+	case 'K':
 		free(eh.link);
 		eh.link = malloc(st.st_size + 1);
 		if (st.st_size > PATH_MAX || st.st_size !=
-		    erofs_read_from_fd(tar->fd, eh.link, st.st_size))
+		    erofs_iostream_bread(&tar->ios, eh.link, st.st_size))
 			goto invalid_tar;
 		eh.link[st.st_size] = '\0';
 		goto restart;
-	} else {
+	default:
 		erofs_info("unrecognized typeflag %xh @ %llu - ignoring",
-			   th.typeflag, tar_offset);
-		(void)erofs_lskip(tar->fd, st.st_size);
+			   th->typeflag, tar_offset);
+		(void)erofs_iostream_lskip(&tar->ios, st.st_size);
 		ret = 0;
 		goto out;
 	}
@@ -644,22 +791,22 @@ restart:
 	if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
 		int major, minor;
 
-		major = tarerofs_parsenum(th.devmajor, sizeof(th.devmajor));
+		major = tarerofs_parsenum(th->devmajor, sizeof(th->devmajor));
 		if (errno) {
 			erofs_err("invalid device major @ %llu", tar_offset);
 			goto out;
 		}
 
-		minor = tarerofs_parsenum(th.devminor, sizeof(th.devminor));
+		minor = tarerofs_parsenum(th->devminor, sizeof(th->devminor));
 		if (errno) {
 			erofs_err("invalid device minor @ %llu", tar_offset);
 			goto out;
 		}
 
 		st.st_rdev = (major << 8) | (minor & 0xff) | ((minor & ~0xff) << 12);
-	} else if (th.typeflag == '1' || th.typeflag == '2') {
+	} else if (th->typeflag == '1' || th->typeflag == '2') {
 		if (!eh.link)
-			eh.link = strndup(th.linkname, sizeof(th.linkname));
+			eh.link = strndup(th->linkname, sizeof(th->linkname));
 	}
 
 	if (tar->index_mode && !tar->mapfile &&
@@ -689,7 +836,7 @@ restart:
 		DBG_BUGON(!d->inode);
 		ret = erofs_set_opaque_xattr(d->inode);
 		goto out;
-	} else if (th.typeflag == '1') {	/* hard link cases */
+	} else if (th->typeflag == '1') {	/* hard link cases */
 		struct erofs_dentry *d2;
 		bool dumb;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index ea868bb..6d2b700 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -66,6 +66,9 @@ static struct option long_options[] = {
 	{"block-list-file", required_argument, NULL, 515},
 #endif
 	{"ovlfs-strip", optional_argument, NULL, 516},
+#ifdef HAVE_ZLIB
+	{"gzip", no_argument, NULL, 517},
+#endif
 	{0, 0, 0, 0},
 };
 
@@ -111,6 +114,9 @@ static void usage(void)
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
 	      " --uid-offset=#        add offset # to all file uids (# = id offset)\n"
 	      " --gid-offset=#        add offset # to all file gids (# = id offset)\n"
+#ifdef HAVE_ZLIB
+	      " --gzip                try to filter the tarball stream through gzip\n"
+#endif
 	      " --help                display this help and exit\n"
 	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
@@ -139,7 +145,7 @@ static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
-static bool tar_mode, rebuild_mode;
+static bool tar_mode, rebuild_mode, gzip_supported;
 
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
@@ -525,6 +531,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			else
 				cfg.c_ovlfs_strip = false;
 			break;
+		case 517:
+			gzip_supported = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -560,7 +569,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			erofs_err("missing argument: SOURCE(s)");
 			return -EINVAL;
 		} else {
-			erofstar.fd = STDIN_FILENO;
+			int dupfd;
+
+			dupfd = dup(STDIN_FILENO);
+			if (dupfd < 0) {
+				erofs_err("failed to duplicate STDIN_FILENO: %s",
+					  strerror(errno));
+				return -errno;
+			}
+			err = erofs_iostream_open(&erofstar.ios, dupfd, gzip_supported);
+			if (err)
+				return err;
 		}
 	} else {
 		struct stat st;
@@ -573,12 +592,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 
 		if (tar_mode) {
-			erofstar.fd = open(cfg.c_src_path, O_RDONLY);
-			if (erofstar.fd < 0) {
+			int fd = open(cfg.c_src_path, O_RDONLY);
+
+			if (fd < 0) {
 				erofs_err("failed to open file: %s", cfg.c_src_path);
-				usage();
 				return -errno;
 			}
+			err = erofs_iostream_open(&erofstar.ios, fd, gzip_supported);
+			if (err)
+				return err;
 		} else {
 			err = lstat(cfg.c_src_path, &st);
 			if (err)
@@ -1182,6 +1204,8 @@ exit:
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
 	erofs_exit_configure();
+	if (tar_mode)
+		erofs_iostream_close(&erofstar.ios);
 
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
-- 
2.39.3

