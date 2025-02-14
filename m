Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDFA35704
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 07:24:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvMTM3x5Zz3brm
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:24:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739514262;
	cv=none; b=KTW3fjI/k9HWW1xQCoczuid6FpqMrGrMxvmON35H0jTAquliV+Z8/yiL7/bTbBejRgpXMTypAg4kFeWEhqPKPf3RWJlTgz91EpKX3N9ZMbEcYpK9OL/jtpxw4ODq2bSW0ppNsYn81vf7bnTptRqfuiJcwvp516JPnz62cr5WtVERQVqeKL8x0AIFJ36HjSGuxP4uXd19yFhWl/4aw1Wgwd+eAMehpy9OQTz+k+ffvjJm3E+ORFJhzNC/UAXWTi7eMeeo35Oi7opyX/yskX/t66yENkOa35GGdt3vFdJJzWwyxfITwM2iQzCdCPkrtOa0KoAdN2tbo3SjUlCJV6W/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739514262; c=relaxed/relaxed;
	bh=XX08GkMovkU4A4UnlAyn5kjZI52cB+g/8yN7+zstFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm++daq4gkFszMFGxxc6LIHfBKerM+wth/Scv+ie+t/gEXjEvMictZhnHHL4ly2oUR8h2yM5z96/Sdy8/Ke/7sZs3ai4tdnZ6lacHPSdeJ5cHXmGvjRYqaW56gba+XOBE7J5Uz/CNEuP8hZkq9IlYKxR1vWW1QW5T7Ck9tvUOHee0oN2PH88X4M4AA5nDmYK6ZmVxsq9TLW/NgNJ0DcngwmHh6EhBnqSL4ZLSetRxwDGG/a9o2Lf3sqvGfwrv+YOuoONE0tXecm1axCSyqErPkIrSKxm1xeytmKu3X3C5ciWlDeewMadwzieESStY0bJzcoZZ70rSUP57drBaaeqRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ozkFoeLx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ozkFoeLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvMTH49fjz304f
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 17:24:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739514255; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XX08GkMovkU4A4UnlAyn5kjZI52cB+g/8yN7+zstFxw=;
	b=ozkFoeLxZwnGzxClg7IQvahHdpkRYOChJ0HQE51adzrrSJRQ0abTg9y03ZXsq+1FecT8xziWlNSZgNoKdeOOJ0Y0eBqNNkLfUvz409yPsahiEwoAciWuf68qbvrw7eX9M2u97QkB84/oE1fSl0TWRbeXfE/Ykjk2j6rMhwLYlVE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPPo5jk_1739514252 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 14:24:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: get rid of tmpfile()
Date: Fri, 14 Feb 2025 14:24:06 +0800
Message-ID: <20250214062407.3281416-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250214062407.3281416-1-hsiangkao@linux.alibaba.com>
References: <20250214062407.3281416-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Currently, `tmpfile()` is problematic:

 - It uses `FILE *` instead of `fd`;
 - It may not leverage `$TMPDIR`, see `__gen_tempfd()`:
   https://sourceware.org/git?p=glibc.git;a=blob;f=stdio-common/tmpfile.c;hb=glibc-2.41

Switch to `erofs_tmpfile()` throughout the codebase.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac              |  1 -
 include/erofs/fragments.h |  2 +-
 include/erofs/io.h        |  2 +
 lib/blobchunk.c           | 44 +++++++++---------
 lib/fragments.c           | 94 +++++++++++++++++++--------------------
 lib/io.c                  | 22 +++++++++
 lib/liberofs_private.h    |  2 +
 lib/xattr.c               | 23 ++++++----
 8 files changed, 110 insertions(+), 80 deletions(-)

diff --git a/configure.ac b/configure.ac
index c9b4acf..6e1e7a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -281,7 +281,6 @@ AC_CHECK_FUNCS(m4_flatten([
 	strrchr
 	strtoull
 	sysconf
-	tmpfile64
 	utimensat]))
 
 # Detect maximum block size if necessary
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 14a1b4a..ccfdd9b 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -22,7 +22,7 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
 int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
-FILE *erofs_packedfile(struct erofs_sb_info *sbi);
+int erofs_packedfile(struct erofs_sb_info *sbi);
 
 int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
 void erofs_packedfile_exit(struct erofs_sb_info *sbi);
diff --git a/include/erofs/io.h b/include/erofs/io.h
index d9b33d2..3179ea1 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -49,6 +49,8 @@ struct erofs_vfile {
 	};
 };
 
+ssize_t __erofs_io_write(int fd, const void *buf, size_t len);
+
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf);
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
 int erofs_io_fsync(struct erofs_vfile *vf);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 8e2360f..5b8a6db 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -9,6 +9,7 @@
 #include "erofs/blobchunk.h"
 #include "erofs/block_list.h"
 #include "erofs/cache.h"
+#include "liberofs_private.h"
 #include "sha256.h"
 #include <unistd.h>
 
@@ -27,7 +28,7 @@ struct erofs_blobchunk {
 };
 
 static struct hashmap blob_hashmap;
-static FILE *blobfile;
+static int blobfile = -1;
 static erofs_blk_t remapped_base;
 static erofs_off_t datablob_size;
 static bool multidev;
@@ -86,7 +87,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
 	chunk->chunksize = chunksize;
 	memcpy(chunk->sha256, sha256, sizeof(sha256));
-	blkpos = ftell(blobfile);
+	blkpos = lseek(blobfile, 0, SEEK_CUR);
 	DBG_BUGON(erofs_blkoff(sbi, blkpos));
 
 	if (sbi->extra_devices)
@@ -97,18 +98,22 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
 	erofs_dbg("Writing chunk (%llu bytes) to %u", chunksize | 0ULL,
 		  chunk->blkaddr);
-	ret = fwrite(buf, chunksize, 1, blobfile);
-	if (ret == 1) {
+	ret = __erofs_io_write(blobfile, buf, chunksize);
+	if (ret == chunksize) {
 		padding = erofs_blkoff(sbi, chunksize);
 		if (padding) {
 			padding = erofs_blksiz(sbi) - padding;
-			ret = fwrite(zeroed, padding, 1, blobfile);
+			ret = __erofs_io_write(blobfile, zeroed, padding);
+			if (ret > 0 && ret != padding)
+				ret = -EIO;
 		}
+	} else if (ret > 0) {
+		ret = -EIO;
 	}
 
-	if (ret < 1) {
+	if (ret < 0) {
 		free(chunk);
-		return ERR_PTR(-ENOSPC);
+		return ERR_PTR(-errno);
 	}
 
 	hashmap_entry_init(&chunk->ent, hash);
@@ -488,9 +493,8 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 	ssize_t length, ret;
 	u64 pos_in, pos_out;
 
-	if (blobfile) {
-		fflush(blobfile);
-		length = ftell(blobfile);
+	if (blobfile >= 0) {
+		length = lseek(blobfile, 0, SEEK_CUR);
 		if (length < 0)
 			return -errno;
 
@@ -534,11 +538,11 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 	pos_out = erofs_btell(bh, false);
 	remapped_base = erofs_blknr(sbi, pos_out);
 	pos_out += sbi->bdev.offset;
-	if (blobfile) {
+	if (blobfile >= 0) {
 		pos_in = 0;
 		do {
 			length = min_t(erofs_off_t, datablob_size,  SSIZE_MAX);
-			ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
+			ret = erofs_copy_file_range(blobfile, &pos_in,
 					sbi->bdev.fd, &pos_out, length);
 		} while (ret > 0 && (datablob_size -= ret));
 
@@ -565,8 +569,8 @@ void erofs_blob_exit(void)
 	struct hashmap_entry *e;
 	struct erofs_blobchunk *bc, *n;
 
-	if (blobfile)
-		fclose(blobfile);
+	if (blobfile >= 0)
+		close(blobfile);
 
 	/* Disable hashmap shrink, effectively disabling rehash.
 	 * This way we can iterate over entire hashmap efficiently
@@ -620,18 +624,14 @@ static int erofs_insert_zerochunk(erofs_off_t chunksize)
 int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
 {
 	if (!blobfile_path) {
-#ifdef HAVE_TMPFILE64
-		blobfile = tmpfile64();
-#else
-		blobfile = tmpfile();
-#endif
+		blobfile = erofs_tmpfile();
 		multidev = false;
 	} else {
-		blobfile = fopen(blobfile_path, "wb");
+		blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
 		multidev = true;
 	}
-	if (!blobfile)
-		return -EACCES;
+	if (blobfile < 0)
+		return -errno;
 
 	hashmap_init(&blob_hashmap, erofs_blob_hashmap_cmp, 0);
 	return erofs_insert_zerochunk(chunksize);
diff --git a/lib/fragments.c b/lib/fragments.c
index 9633a2b..3e97f14 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -3,9 +3,6 @@
  * Copyright (C), 2022, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@coolpad.com>
  */
-#ifndef _LARGEFILE_SOURCE
-#define _LARGEFILE_SOURCE
-#endif
 #ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
 #endif
@@ -25,6 +22,7 @@
 #include "erofs/internal.h"
 #include "erofs/fragments.h"
 #include "erofs/bitops.h"
+#include "liberofs_private.h"
 
 struct erofs_fragment_dedupe_item {
 	struct list_head	list;
@@ -41,7 +39,7 @@ struct erofs_fragment_dedupe_item {
 
 struct erofs_packed_inode {
 	struct list_head *hash;
-	FILE *file;
+	int fd;
 	unsigned long *uptodate;
 #if EROFS_MT_ENABLED
 	pthread_mutex_t mutex;
@@ -108,8 +106,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 
 				sz = min_t(u64, pos, sizeof(buf[0]));
 				sz = min_t(u64, sz, inode->i_size - i);
-				if (pread(fileno(epi->file), buf[0], sz,
-					  pos - sz) != sz)
+				if (pread(epi->fd, buf[0], sz, pos - sz) != sz)
 					break;
 				if (pread(fd, buf[1], sz,
 					  inode->i_size - i - sz) != sz)
@@ -208,14 +205,10 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-#ifdef HAVE_FTELLO64
-	off64_t offset = ftello64(epi->file);
-#else
-	off_t offset = ftello(epi->file);
-#endif
+	s64 offset, rc;
 	char *memblock;
-	int rc;
 
+	offset = lseek(epi->fd, 0, SEEK_CUR);
 	if (offset < 0)
 		return -errno;
 
@@ -233,15 +226,22 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 						sizeof(buf));
 
 			rc = read(fd, buf, sz);
+			if (rc != sz) {
+				if (rc <= 0) {
+					if (!rc)
+						rc = -EIO;
+					else
+						rc = -errno;
+					goto out;
+				}
+				sz = rc;
+			}
+			rc = __erofs_io_write(epi->fd, buf, sz);
 			if (rc != sz) {
 				if (rc < 0)
 					rc = -errno;
 				else
-					rc = -EAGAIN;
-				goto out;
-			}
-			if (fwrite(buf, sz, 1, epi->file) != 1) {
-				rc = -EIO;
+					rc = -EIO;
 				goto out;
 			}
 			remaining -= sz;
@@ -251,9 +251,15 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 			rc = -errno;
 			goto out;
 		}
-	} else if (fwrite(memblock, inode->fragment_size, 1, epi->file) != 1) {
-		rc = -EIO;
-		goto out;
+	} else {
+		rc = __erofs_io_write(epi->fd, memblock, inode->fragment_size);
+		if (rc != inode->fragment_size) {
+			if (rc < 0)
+				rc = -errno;
+			else
+				rc = -EIO;
+			goto out;
+		}
 	}
 
 	erofs_dbg("Recording %llu fragment data at %llu",
@@ -279,11 +285,7 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-#ifdef HAVE_FTELLO64
-	off64_t offset = ftello64(epi->file);
-#else
-	off_t offset = ftello(epi->file);
-#endif
+	s64 offset = lseek(epi->fd, 0, SEEK_CUR);
 	int ret;
 
 	if (offset < 0)
@@ -292,8 +294,12 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	inode->fragmentoff = (erofs_off_t)offset;
 	inode->fragment_size = len;
 
-	if (fwrite(data, len, 1, epi->file) != 1)
+	ret = write(epi->fd, data, len);
+	if (ret != len) {
+		if (ret < 0)
+			return -errno;
 		return -EIO;
+	}
 
 	erofs_dbg("Recording %llu fragment data at %llu",
 		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
@@ -313,19 +319,18 @@ int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
 	if (!epi || !erofs_sb_has_fragments(sbi))
 		return -EINVAL;
 
-	fflush(epi->file);
-	if (!ftello(epi->file))
+	if (lseek(epi->fd, 0, SEEK_CUR) <= 0)
 		return 0;
-	inode = erofs_mkfs_build_special_from_fd(sbi, fileno(epi->file),
+	inode = erofs_mkfs_build_special_from_fd(sbi, epi->fd,
 						 EROFS_PACKED_INODE);
 	sbi->packed_nid = erofs_lookupnid(inode);
 	erofs_iput(inode);
 	return 0;
 }
 
-FILE *erofs_packedfile(struct erofs_sb_info *sbi)
+int erofs_packedfile(struct erofs_sb_info *sbi)
 {
-	return sbi->packedinode->file;
+	return sbi->packedinode->fd;
 }
 
 void erofs_packedfile_exit(struct erofs_sb_info *sbi)
@@ -347,8 +352,8 @@ void erofs_packedfile_exit(struct erofs_sb_info *sbi)
 		free(epi->hash);
 	}
 
-	if (epi->file)
-		fclose(epi->file);
+	if (epi->fd >= 0)
+		close(epi->fd);
 	free(epi);
 	sbi->packedinode = NULL;
 }
@@ -376,14 +381,9 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			init_list_head(&epi->hash[i]);
 	}
 
-	epi->file =
-#ifdef HAVE_TMPFILE64
-		tmpfile64();
-#else
-		tmpfile();
-#endif
-	if (!epi->file) {
-		err = -errno;
+	epi->fd = erofs_tmpfile();
+	if (epi->fd < 0) {
+		err = epi->fd;
 		goto err_out;
 	}
 
@@ -392,6 +392,7 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			.sbi = sbi,
 			.nid = sbi->packed_nid,
 		};
+		s64 offset;
 
 		err = erofs_read_inode_from_disk(&ei);
 		if (err) {
@@ -400,8 +401,8 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			goto err_out;
 		}
 
-		err = fseek(epi->file, ei.i_size, SEEK_SET);
-		if (err) {
+		offset = lseek(epi->fd, ei.i_size, SEEK_SET);
+		if (offset < 0) {
 			err = -errno;
 			goto err_out;
 		}
@@ -472,13 +473,12 @@ static void *erofs_packedfile_preload(struct erofs_inode *pi,
 	if (err)
 		goto err_out;
 
-	fflush(epi->file);
-	err = pwrite(fileno(epi->file), buffer, map->m_llen, map->m_la);
+	err = pwrite(epi->fd, buffer, map->m_llen, map->m_la);
 	if (err < 0) {
 		err = -errno;
 		if (err == -ENOSPC) {
 			memset(epi->uptodate, 0, epi->uptodate_size);
-			(void)!ftruncate(fileno(epi->file), 0);
+			(void)!ftruncate(epi->fd, 0);
 		}
 		goto err_out;
 	}
@@ -557,7 +557,7 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			if (!uptodate)
 				continue;
 
-			err = pread(fileno(epi->file), buf, len, pos);
+			err = pread(epi->fd, buf, len, pos);
 			if (err < 0)
 				break;
 			if (err == len) {
diff --git a/lib/io.c b/lib/io.c
index dacf8dc..b6eb22a 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -26,6 +26,28 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
+ssize_t __erofs_io_write(int fd, const void *buf, size_t len)
+{
+	ssize_t ret, written = 0;
+
+	do {
+		ret = write(fd, buf, len);
+		if (ret <= 0) {
+			if (!ret)
+				break;
+			if (errno != EINTR) {
+				erofs_err("failed to write: %s", strerror(errno));
+				return -errno;
+			}
+			ret = 0;
+		}
+		buf += ret;
+		written += ret;
+	} while (written < len);
+
+	return written;
+}
+
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 {
 	if (__erofs_unlikely(cfg.c_dry_run)) {
diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
index 0eeca3c..ebd9e70 100644
--- a/lib/liberofs_private.h
+++ b/lib/liberofs_private.h
@@ -23,3 +23,5 @@ static inline void *memrchr(const void *s, int c, size_t n)
 	return NULL;
 }
 #endif
+
+int erofs_tmpfile(void);
diff --git a/lib/xattr.c b/lib/xattr.c
index 063b01a..cb44786 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -811,21 +811,22 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 
 int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi)
 {
-	FILE *f = erofs_packedfile(sbi);
+	int fd = erofs_packedfile(sbi);
 	struct ea_type_node *tnode;
-	off_t offset;
+	s64 offset;
+	int err;
 
 	if (!ea_prefix_count)
 		return 0;
-	offset = ftello(f);
+	offset = lseek(fd, 0, SEEK_CUR);
 	if (offset < 0)
 		return -errno;
-	if (offset > UINT32_MAX)
-		return -EOVERFLOW;
-
 	offset = round_up(offset, 4);
-	if (fseek(f, offset, SEEK_SET))
+	if (lseek(fd, offset, SEEK_SET) < 0)
 		return -errno;
+
+	if ((offset >> 2) > UINT32_MAX)
+		return -EOVERFLOW;
 	sbi->xattr_prefix_start = (u32)offset >> 2;
 	sbi->xattr_prefix_count = ea_prefix_count;
 
@@ -846,10 +847,14 @@ int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi)
 		       infix_len);
 		len = sizeof(struct erofs_xattr_long_prefix) + infix_len;
 		u.s.size = cpu_to_le16(len);
-		if (fwrite(&u.s, sizeof(__le16) + len, 1, f) != 1)
+		err = __erofs_io_write(fd, &u.s, sizeof(__le16) + len);
+		if (err != sizeof(__le16) + len) {
+			if (err < 0)
+				return -errno;
 			return -EIO;
+		}
 		offset = round_up(offset + sizeof(__le16) + len, 4);
-		if (fseek(f, offset, SEEK_SET))
+		if (lseek(fd, offset, SEEK_SET) < 0)
 			return -errno;
 	}
 	erofs_sb_set_fragments(sbi);
-- 
2.43.5

