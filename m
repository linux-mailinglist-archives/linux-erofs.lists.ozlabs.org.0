Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38409142C9
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 08:32:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpefKEaL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W6ynb1t6Zz3cGS
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 16:32:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpefKEaL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W6ynR6J7sz30VJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 16:32:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719210757; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SEfT4ZPL7mCBPgB2lB+vCMsH6UyEdlITOj0GImebdDY=;
	b=lpefKEaLwGZBS1N6cvkZBYM8wO4q2E5fH3dd3x8+uez24tanHcF4K4Woy38s1KRdKLM+vXP9eYzidybDLqFbxLrBsWvOEYPzuEiToCrdvhqJasOe6P/t1MPAgTPUot6s1BmyN1Ee2MAqUIbNfyvcOP9J24265v8AqanOixmq9Nc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W93eBRI_1719210754;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W93eBRI_1719210754)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 14:32:35 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: improve compatibility and reduce header conflicts
Date: Mon, 24 Jun 2024 14:32:17 +0800
Message-Id: <20240624063217.170251-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Adjusted the initialization of union in erofs-utils to ensure
compatibility with various compilers. The original C99 designated
initializer style was not supported in other compilers (e.g., C++11),
causing build issues. In addition, modified the code to reduce
potential conflicts with headers from other projects.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/defs.h     |  4 ++--
 include/erofs/internal.h |  2 +-
 include/erofs_fs.h       |  4 +++-
 lib/compress.c           |  2 +-
 lib/inode.c              |  2 +-
 lib/io.c                 | 12 ++++++------
 lib/kite_deflate.c       |  2 +-
 lib/tar.c                |  4 ++--
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 5b62054..e0798c8 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -343,8 +343,8 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define ST_MTIM_NSEC(stbuf) 0
 #endif
 
-#define likely(x)      __builtin_expect(!!(x), 1)
-#define unlikely(x)    __builtin_expect(!!(x), 0)
+#define __erofs_likely(x)      __builtin_expect(!!(x), 1)
+#define __erofs_unlikely(x)    __builtin_expect(!!(x), 0)
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 72cface..1835cfd 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -301,7 +301,7 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 
 static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
 {
-	return (void *)((unsigned long)inode->i_parent & ~1UL);
+	return (struct erofs_inode *)((unsigned long)inode->i_parent & ~1UL);
 }
 
 #define IS_ROOT(x)	((x) == erofs_parent_inode(x))
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 907f3d8..0d603c4 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -454,7 +454,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		struct z_erofs_map_header h;
 		__le64 v;
 	} fmh __maybe_unused = {
-		.h.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT,
+		.h = {
+			.h_clusterbits = 1 <<Z_EROFS_FRAGMENT_INODE_BIT,
+		},
 	};
 
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
diff --git a/lib/compress.c b/lib/compress.c
index c9fd5b6..b473587 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1197,7 +1197,7 @@ int z_erofs_mt_wq_tls_init_compr(struct erofs_sb_info *sbi,
 	struct erofs_compress_cfg *lc = &tls->ccfg[alg_id];
 	int ret;
 
-	if (likely(lc->enable))
+	if (__erofs_likely(lc->enable))
 		return 0;
 
 	ret = erofs_compressor_init(sbi, &lc->handle, alg_name,
diff --git a/lib/inode.c b/lib/inode.c
index e797b7c..4701b8f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -323,7 +323,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 		erofs_dbg("Assign nid %llu to file %s (mode %05o)",
 			  inode->nid, inode->i_srcpath, inode->i_mode);
 	}
-	if (unlikely(IS_ROOT(inode)) && inode->nid > 0xffff)
+	if (__erofs_unlikely(IS_ROOT(inode)) && inode->nid > 0xffff)
 		return sbi->root_nid;
 	return inode->nid;
 }
diff --git a/lib/io.c b/lib/io.c
index a2ef344..4226526 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -28,7 +28,7 @@
 
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 {
-	if (unlikely(cfg.c_dry_run)) {
+	if (__erofs_unlikely(cfg.c_dry_run)) {
 		buf->st_size = 0;
 		buf->st_mode = S_IFREG | 0777;
 		return 0;
@@ -44,7 +44,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 {
 	ssize_t ret, written = 0;
 
-	if (unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -78,7 +78,7 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 {
 	int ret;
 
-	if (unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -98,7 +98,7 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
 
-	if (unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -124,7 +124,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 	int ret;
 	struct stat st;
 
-	if (unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -145,7 +145,7 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
 	ssize_t ret, read = 0;
 
-	if (unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 570bc5a..a5ebd66 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -866,7 +866,7 @@ static void kite_mf_reset(struct kite_matchfinder *mf,
 	 *
 	 * [1] https://github.com/tukaani-project/xz/blob/v5.4.0/src/liblzma/lz/lz_encoder_mf.c#L94
 	 */
-	if (unlikely(mf->base > ((typeof(mf->base))-1) >> 1)) {
+	if (__erofs_unlikely(mf->base > ((typeof(mf->base))-1) >> 1)) {
 		mf->base = kHistorySize32 + 1;
 		memset(mf->hash, 0, 0x10000 * sizeof(mf->hash[0]));
 	}
diff --git a/lib/tar.c b/lib/tar.c
index 532e566..5e2c5b8 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -202,7 +202,7 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 			if (ret < ios->bufsize - rabytes)
 				ios->feof = true;
 		}
-		if (unlikely(ios->dumpfd >= 0))
+		if (__erofs_unlikely(ios->dumpfd >= 0))
 			if (write(ios->dumpfd, ios->buffer + rabytes, ret) < ret)
 				erofs_err("failed to dump %d bytes of the raw stream: %s",
 					  ret, erofs_strerror(-errno));
@@ -246,7 +246,7 @@ int erofs_iostream_lskip(struct erofs_iostream *ios, u64 sz)
 	if (ios->feof)
 		return sz;
 
-	if (ios->sz && likely(ios->dumpfd < 0)) {
+	if (ios->sz && __erofs_likely(ios->dumpfd < 0)) {
 		s64 cur = erofs_io_lseek(&ios->vf, sz, SEEK_CUR);
 
 		if (cur > ios->sz)
-- 
2.39.3

