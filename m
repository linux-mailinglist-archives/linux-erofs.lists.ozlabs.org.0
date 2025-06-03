Return-Path: <linux-erofs+bounces-384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2CACBEFF
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:57:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH3B1zmhz2yPS;
	Tue,  3 Jun 2025 13:57:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748923030;
	cv=none; b=deMmE6I3DFx7t74ONUdNmxFIYgOUvTyyJkcw3FixOrVXpv/ZztRN2ms9nP1aFGowrUFjVI/vDVWSkqkdyX33kqRCc0RMrl3KMCsmLKO9XhL3jHkRp8nxDNvY/Qux1LzufZ3elfmqfdUCL/XMPlyrkvgUEUaJ4xJHkA2mw6R6nzdlA35lbQeHUCbXiJ4Th5+nQAzu8IuVRJ3T5aeIm7c1fW3IQT6ypYSc7lCUM3XwvrtH19mGRHm8yuXabE+4yT1w8uCe+SIZVaNI/POfxYOG6fBOuH1hPzVbv77QvOwoARlEiC0l7vP5J260sjQQ67C0G9FLJ0QEqrcR9OSoiutm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748923030; c=relaxed/relaxed;
	bh=rNjdyABfEqUiTVgFwrWdcRftwzjjXTYjTK8URqaKB+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyt9a51Mez4TvQniAobUsS+/uzn68oY26nbLOz4BJK9TMghO/S/NC7jsLOcG91efFt6dyeIa97Wk6cSBVPXRfEkoXm38dzRPzu8RnluTF3BmaR3h/hhAIQlaXPH7LHMFy4F4xHpVDsKf3qcih7ZJ85LOnU2gIxLVcLDRjCqFVbAGpYarGDE8/1vx2qdYVafoKnI8L9zTSijv/WjcJD4kLjhg4bj8EwbIbAu9uHXUM+tTgMqw5OfdjZYFr75otSCuLy2YEbJmGxJRaWZFNZD9JBSffISpDe2NI74kCRlNEi2KCUmh8B89vZ2iPhI3b2F6PJlhTJSsu50J2A1Bzt1qxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hms/d+cU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hms/d+cU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH3774dqz2yGM
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:57:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748923023; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rNjdyABfEqUiTVgFwrWdcRftwzjjXTYjTK8URqaKB+Y=;
	b=hms/d+cUN0iffyr7l+H6K6Sq3mcDx3rFwrwZn+kPHuMA0E1OWQ9+f9pCENBZGJXke9q+lp6DsDLoV8+SbLw8Vtc32Iks2DemtDGpNJnamoNuWQiSVgBUN3Vit7lT/w6dtPdhQVqKHZollSvgZ2hC++RzY7oLCg0KNEzk+QRqdbI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WchYNGK_1748923017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:57:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/5] erofs-utils: lib: introduce z_erofs_fragments_tofh()
Date: Tue,  3 Jun 2025 11:56:53 +0800
Message-ID: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Introduce a separate z_erofs_fragments_tofh() to get the tail hash in
order to prepare for the upcoming multi-threaded fragment improvement.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/fragments.h |  3 +-
 lib/compress.c            | 38 ++++++++++----------
 lib/fragments.c           | 75 ++++++++++++++++++---------------------
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index a57b63c..75f1055 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,7 +15,8 @@ extern "C"
 extern const char *erofs_frags_packedname;
 #define EROFS_PACKED_INODE	erofs_frags_packedname
 
-int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
+u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh);
 
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
diff --git a/lib/compress.c b/lib/compress.c
index d046112..a260dc4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -46,7 +46,7 @@ struct z_erofs_compress_ictx {		/* inode context */
 	int fd;
 	u64 fpos;
 
-	u32 tof_chksum;
+	u32 tofh;
 	bool fix_dedupedfrag;
 	bool fragemitted;
 	bool dedupe;
@@ -626,7 +626,7 @@ nocompression:
 		   (!inode->fragment_size || ictx->fix_dedupedfrag)) {
 frag_packing:
 		ret = z_erofs_pack_fragments(inode, ctx->queue + ctx->head,
-					     len, ictx->tof_chksum);
+					     len, ictx->tofh);
 		if (ret < 0)
 			return ret;
 		e->plen = 0;	/* indicate a fragment */
@@ -1103,7 +1103,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
 	if (offset != -1 && frag && !inode->fragment_size &&
 	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
-		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
+		ret = z_erofs_fragments_dedupe(inode, fd, ictx->tofh);
 		if (ret < 0)
 			return ret;
 		if (inode->fragment_size > ctx->remaining)
@@ -1622,21 +1622,23 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
-	/*
-	 * Handle tails in advance to avoid writing duplicated
-	 * parts into the packed inode.
-	 */
-	if (cfg.c_fragments && !erofs_is_packed_inode(inode) &&
-	    ictx == &g_ictx && cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
-		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
-		if (ret < 0)
-			goto err_free_ictx;
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+		ictx->tofh = z_erofs_fragments_tofh(inode, fd, fpos);
+		if (ictx == &g_ictx && cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
+			/*
+			 * Handle tails in advance to avoid writing duplicated
+			 * parts into the packed inode.
+			 */
+			ret = z_erofs_fragments_dedupe(inode, fd, ictx->tofh);
+			if (ret < 0)
+				goto err_free_ictx;
 
-		if (cfg.c_fragdedupe == FRAGDEDUPE_INODE &&
-		    inode->fragment_size < inode->i_size) {
-			erofs_dbg("Discard the sub-inode tail fragment of %s",
-				  inode->i_srcpath);
-			inode->fragment_size = 0;
+			if (cfg.c_fragdedupe == FRAGDEDUPE_INODE &&
+			    inode->fragment_size < inode->i_size) {
+				erofs_dbg("Discard the sub-inode tail fragment of %s",
+					  inode->i_srcpath);
+				inode->fragment_size = 0;
+			}
 		}
 	}
 	ictx->inode = inode;
@@ -1647,7 +1649,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->dedupe = false;
 
 	if (all_fragments && !inode->fragment_size) {
-		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
+		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tofh);
 		if (ret)
 			goto err_free_idata;
 	}
diff --git a/lib/fragments.c b/lib/fragments.c
index 9dfe0e3..9f5f1f9 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -3,9 +3,6 @@
  * Copyright (C), 2022, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@coolpad.com>
  */
-#ifndef _LARGEFILE64_SOURCE
-#define _LARGEFILE64_SOURCE
-#endif
 #ifndef _FILE_OFFSET_BITS
 #define _FILE_OFFSET_BITS 64
 #endif
@@ -49,23 +46,39 @@ struct erofs_packed_inode {
 
 const char *erofs_frags_packedname = "packed_file";
 
-#ifndef HAVE_LSEEK64
-#define erofs_lseek64 lseek
-#else
-#define erofs_lseek64 lseek64
-#endif
+u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos)
+{
+	u8 data_to_hash[EROFS_TOF_HASHLEN];
+	u32 hash;
+	int ret;
+
+	if (inode->i_size <= EROFS_TOF_HASHLEN)
+		return ~0U;
+
+	ret = pread(fd, data_to_hash, EROFS_TOF_HASHLEN,
+		    fpos + inode->i_size - EROFS_TOF_HASHLEN);
+	if (ret < 0)
+		return -errno;
+	if (ret != EROFS_TOF_HASHLEN) {
+		DBG_BUGON(1);
+		return -EIO;
+	}
+	hash = erofs_crc32c(~0, data_to_hash, EROFS_TOF_HASHLEN);
+	return hash != ~0U ? hash : 0;
+}
 
-static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
-					 u32 crc)
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	struct erofs_fragment_dedupe_item *cur, *di = NULL;
-	struct list_head *head = &epi->hash[FRAGMENT_HASH(crc)];
+	struct list_head *head = &epi->hash[FRAGMENT_HASH(tofh)];
 	unsigned int s1, e1;
 	erofs_off_t deduped;
 	u8 *data;
 	int ret;
 
+	if (inode->i_size <= EROFS_TOF_HASHLEN)
+		return 0;
 	if (list_empty(head))
 		return 0;
 
@@ -138,27 +151,13 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	return 0;
 }
 
-int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
-{
-	u8 data_to_hash[EROFS_TOF_HASHLEN];
-	int ret;
-
-	if (inode->i_size <= EROFS_TOF_HASHLEN)
-		return 0;
-
-	ret = pread(fd, data_to_hash, EROFS_TOF_HASHLEN,
-		    inode->i_size - EROFS_TOF_HASHLEN);
-	if (ret != EROFS_TOF_HASHLEN)
-		return -errno;
-
-	*tofcrc = erofs_crc32c(~0, data_to_hash, EROFS_TOF_HASHLEN);
-	return z_erofs_fragments_dedupe_find(inode, fd, *tofcrc);
-}
-
-static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
-					   unsigned int len, erofs_off_t pos)
+static int z_erofs_fragments_dedupe_insert(struct erofs_inode *inode,
+					   void *data, u32 tofh)
 {
+	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	struct erofs_fragment_dedupe_item *di;
+	erofs_off_t len = inode->fragment_size;
+	erofs_off_t pos = inode->fragmentoff;
 
 	if (len <= EROFS_TOF_HASHLEN)
 		return 0;
@@ -172,14 +171,13 @@ static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
 		return -ENOMEM;
 
 	memcpy(di->data, data, len);
-	di->length = len;
 	di->pos = pos;
-
-	list_add_tail(&di->list, hash);
+	di->length = len;
+	list_add_tail(&di->list, &epi->hash[FRAGMENT_HASH(tofh)]);
 	return 0;
 }
 
-int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
+int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	s64 offset, rc;
@@ -240,9 +238,7 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 		  inode->i_srcpath);
 
 	if (memblock)
-		rc = z_erofs_fragments_dedupe_insert(
-			&epi->hash[FRAGMENT_HASH(tofcrc)], memblock,
-			inode->fragment_size, inode->fragmentoff);
+		rc = z_erofs_fragments_dedupe_insert(inode, memblock, tofh);
 	else
 		rc = 0;
 out:
@@ -256,7 +252,7 @@ out:
 }
 
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len, u32 tofcrc)
+			   unsigned int len, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	s64 offset = lseek(epi->fd, 0, SEEK_CUR);
@@ -279,8 +275,7 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL,
 		  inode->i_srcpath);
 
-	ret = z_erofs_fragments_dedupe_insert(&epi->hash[FRAGMENT_HASH(tofcrc)],
-					      data, len, inode->fragmentoff);
+	ret = z_erofs_fragments_dedupe_insert(inode, data, tofh);
 	if (ret)
 		return ret;
 	return len;
-- 
2.43.5


