Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB656A5F14
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 19:55:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PR64p6KvTz3cLR
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 05:55:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PR64d4400z3c7X
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 05:55:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VckM4RK_1677610508;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VckM4RK_1677610508)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 02:55:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: add `-Eall-fragments` option
Date: Wed,  1 Mar 2023 02:54:59 +0800
Message-Id: <20230228185459.117762-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
References: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
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

It's almost the same as `-Efragments` option, except that will
explicitly pack the whole data into the special inode instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac              |  1 +
 include/erofs/config.h    |  1 +
 include/erofs/fragments.h |  1 +
 lib/compress.c            | 32 ++++++++++++++++-------------
 lib/fragments.c           | 43 ++++++++++++++++++++++++++++++++++++++-
 man/mkfs.erofs.1          | 25 ++++++++++++++---------
 mkfs/main.c               |  6 ++++++
 7 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index cdbeb33..4dbe86f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -134,6 +134,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	stdlib.h
 	string.h
 	sys/ioctl.h
+	sys/mman.h
 	sys/stat.h
 	sys/sysmacros.h
 	sys/time.h
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 39a6162..648a3e8 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -48,6 +48,7 @@ struct erofs_configure {
 	bool c_noinline_data;
 	bool c_ztailpacking;
 	bool c_fragments;
+	bool c_all_fragments;
 	bool c_dedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 4caaf6b..21753ec 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -16,6 +16,7 @@ extern const char *frags_packedname;
 #define EROFS_PACKED_INODE	frags_packedname
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
+int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
 void z_erofs_fragments_commit(struct erofs_inode *inode);
diff --git a/lib/compress.c b/lib/compress.c
index 8169990..65c6f90 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -899,22 +899,26 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.remaining = inode->i_size - inode->fragment_size;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
+	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
+	    !inode->fragment_size) {
+		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
+	} else {
+		while (ctx.remaining) {
+			const u64 rx = min_t(u64, ctx.remaining,
+					     sizeof(ctx.queue) - ctx.tail);
+
+			ret = read(fd, ctx.queue + ctx.tail, rx);
+			if (ret != rx) {
+				ret = -errno;
+				goto err_bdrop;
+			}
+			ctx.remaining -= rx;
+			ctx.tail += rx;
 
-	while (ctx.remaining) {
-		const u64 readcount = min_t(u64, ctx.remaining,
-					    sizeof(ctx.queue) - ctx.tail);
-
-		ret = read(fd, ctx.queue + ctx.tail, readcount);
-		if (ret != readcount) {
-			ret = -errno;
-			goto err_bdrop;
+			ret = vle_compress_one(&ctx);
+			if (ret)
+				goto err_free_idata;
 		}
-		ctx.remaining -= readcount;
-		ctx.tail += readcount;
-
-		ret = vle_compress_one(&ctx);
-		if (ret)
-			goto err_free_idata;
 	}
 	DBG_BUGON(ctx.head != ctx.tail);
 
diff --git a/lib/fragments.c b/lib/fragments.c
index 1e41485..ebff4b5 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -17,6 +17,7 @@
 #endif
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include "erofs/err.h"
 #include "erofs/inode.h"
 #include "erofs/compress.h"
@@ -154,7 +155,11 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
 
 	if (len <= EROFS_TOF_HASHLEN)
 		return 0;
-
+	if (len > EROFS_CONFIG_COMPR_MAX_SZ) {
+		data += len - EROFS_CONFIG_COMPR_MAX_SZ;
+		pos += len - EROFS_CONFIG_COMPR_MAX_SZ;
+		len = EROFS_CONFIG_COMPR_MAX_SZ;
+	}
 	di = malloc(sizeof(*di) + len);
 	if (!di)
 		return -ENOMEM;
@@ -204,6 +209,42 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 	erofs_sb_set_fragments();
 }
 
+int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
+			      u32 tofcrc)
+{
+#ifdef HAVE_FTELLO64
+	off64_t offset = ftello64(packedfile);
+#else
+	off_t offset = ftello(packedfile);
+#endif
+	char *memblock;
+	int rc;
+
+	if (offset < 0)
+		return -errno;
+
+	memblock = mmap(NULL, inode->i_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (memblock == MAP_FAILED)
+		return -EFAULT;
+
+	inode->fragmentoff = (erofs_off_t)offset;
+	inode->fragment_size = inode->i_size;
+
+	if (fwrite(memblock, inode->fragment_size, 1, packedfile) != 1) {
+		rc = -EIO;
+		goto out;
+	}
+
+	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
+		  inode->fragmentoff);
+
+	rc = z_erofs_fragments_dedupe_insert(memblock, inode->fragment_size,
+					     inode->fragmentoff, tofcrc);
+out:
+	munmap(memblock, inode->i_size);
+	return rc;
+}
+
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc)
 {
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index ba66a81..61ed24b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -42,6 +42,21 @@ and may take an extra argument using the equals ('=') sign.
 The following extended options are supported:
 .RS 1.2i
 .TP
+.BI all-fragments
+Forcely record the whole files into a special inode for better compression and
+it may take an argument as the pcluster size of the packed inode in bytes.
+(Linux v6.1+)
+.TP
+.BI dedupe
+Enable global compressed data deduplication to minimize duplicated data in
+the filesystem. It may be used with \fI-Efragments\fR option together to
+further reduce image sizes. (Linux v6.1+)
+.TP
+.BI fragments
+Pack the tail part (pcluster) of compressed files or the whole files into a
+special inode for smaller image sizes, and it may take an argument as the
+pcluster size of the packed inode in bytes. (Linux v6.1+)
+.TP
 .BI force-inode-compact
 Forcely generate compact inodes (32-byte inodes) to output.
 .TP
@@ -64,16 +79,6 @@ Don't inline regular files to enable FSDAX for these files (Linux v5.15+).
 .BI ztailpacking
 Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
-.TP
-.BI fragments
-Pack the tail part (pcluster) of compressed files or the whole files into a
-special inode for smaller image sizes, and it may take an argument as the
-pcluster size of the packed inode in bytes. (Linux v6.1+)
-.TP
-.BI dedupe
-Enable global compressed data deduplication to minimize duplicated data in
-the filesystem. It may be used with \fI-Efragments\fR option together to
-further reduce image sizes. (Linux v6.1+)
 .RE
 .TP
 .BI "\-L " volume-label
diff --git a/mkfs/main.c b/mkfs/main.c
index d055902..bc973e7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -208,10 +208,16 @@ static int parse_extended_opts(const char *opts)
 			cfg.c_ztailpacking = true;
 		}
 
+		if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
+			cfg.c_all_fragments = true;
+			goto handle_fragment;
+		}
+
 		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
 			char *endptr;
 			u64 i;
 
+handle_fragment:
 			cfg.c_fragments = true;
 			if (vallen) {
 				i = strtoull(value, &endptr, 0);
-- 
2.36.1

