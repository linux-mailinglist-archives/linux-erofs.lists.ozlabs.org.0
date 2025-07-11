Return-Path: <linux-erofs+bounces-593-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9AB022E8
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 19:43:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdzb85gg3z30Ql;
	Sat, 12 Jul 2025 03:43:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752255812;
	cv=none; b=Z47/iAWM6F0fmNTscCtFn30TcBMvKW77A9Bjvke6XQ5jvAvxbE9RoviA879hG69ROiGmV3Z6Sw45nVgzMfmaK9VLe3B6Bwd2k24MK8jDBnB2DPx6cioWVCdP4RoRzqwpjLwjlr4Jk8kRVTZlF+2+v9UnSoFL8Mpd4yxp7lpCHfhwY1TEUVILGnxYkEK4jliFPZy1qfEkFSsgZ5Q9I2Si3zY6Kh37NExXHFsrKURFFEy0/zVGF6IHSWWleGsWduYqYoWuZJ9tC28ubyvkBuN/eGk2TE3iwlMR1xTawGUQejWWYUkBK29RapsV6Grns5pM3eDuGyCm02fVWXHZUUSnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752255812; c=relaxed/relaxed;
	bh=LWFFLKV73XmGbO1bZF5ADhPQPQK4EjMwpZ9Fx5EcN1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbPtfPFDy3Mj8TuDi9/rmMA3xf7DhMhOUVBnhENOLeOo7l70rOmPXdsSI5XRQ+s2W411184dSzsdUIufDjcwh5QkUugqHH9q9/md1+3cjMXgPEX1kt1rGFMmbLfvUj23cjQ1T8DSo/IiaiSm2Dmc5tjZPhtSI/WjlYHawEDFIF7ujs1V3AEfR1GNQiwm+J6M6yv4IeFsYftM9LPq6MDZoEBVceJVK8qIcXjtyaQqHcy5r0Ky6wRHgHM3I5PHtSaK9d1e35dEh3XOE9MAfyha0o6ojA51peakM7k8XhYmxj4YscY7JFlGs41g8aIu94OZ9g5SBg5aMASyGS/5Zb+nCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lOlAB78A; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lOlAB78A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdzb76sHhz2ym2
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 03:43:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752255808; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LWFFLKV73XmGbO1bZF5ADhPQPQK4EjMwpZ9Fx5EcN1c=;
	b=lOlAB78ABOtL3csVewEywGMPh0zNBC8S+ccZjTCzFrFMRqF/K3FafSA7/DN1yiCTveC2JeI9QI5m/0OPrQGqqWXGThCMxmeduPCvsmxXk7rJMtsuL5QrjD5ckpiyV1IhGWq9F7KAvcm4PXGymnneaesA0thY7dlLwsTaPKP+j7E=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wihf1Fz_1752255805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 01:43:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>
Subject: [PATCH] erofs-utils: mkfs: fix extent-based deduplication
Date: Sat, 12 Jul 2025 01:43:24 +0800
Message-ID: <20250711174324.3428957-1-hsiangkao@linux.alibaba.com>
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

- `pstart` should be `erofs_off_t` instead of `erofs_blk_t`, otherwise,
  its upper 32 bits may be truncated;

- If it falls back to uncompressed inodes due to insufficient
  space savings, dedupe-ext records should also be revoked.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Fixes: cf04b8b78f09 ("erofs-utils: mkfs: implement extent-based deduplication")
Closes: https://github.com/erofs/erofs-utils/issues/23
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/dedupe.h |  2 +-
 lib/compress.c         | 15 +++++++++------
 lib/dedupe_ext.c       | 21 +++++++++++----------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
index ffb00a50..f9caa611 100644
--- a/include/erofs/dedupe.h
+++ b/include/erofs/dedupe.h
@@ -34,7 +34,7 @@ void z_erofs_dedupe_exit(void);
 
 int z_erofs_dedupe_ext_insert(struct z_erofs_inmem_extent *e,
 			      u64 hash);
-erofs_blk_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
+erofs_off_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
 			u8 *encoded, unsigned int size, bool raw, u64 *hash);
 void z_erofs_dedupe_ext_commit(bool drop);
 int z_erofs_dedupe_ext_init(void);
diff --git a/lib/compress.c b/lib/compress.c
index 6f65993c..b16f5d1d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -403,7 +403,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
 
 	if (ctx->membuf) {
-		erofs_dbg("Writing %u uncompressed data of %s", count,
+		erofs_dbg("Recording %u uncompressed data of %s", count,
 			  inode->i_srcpath);
 		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
 		ctx->memoff += erofs_blksiz(sbi);
@@ -705,7 +705,7 @@ frag_packing:
 
 		/* write compressed data */
 		if (ctx->membuf) {
-			erofs_dbg("Writing %u compressed data of %u bytes of %s",
+			erofs_dbg("Recording %u compressed data of %u bytes of %s",
 				  e->length, e->plen, inode->i_srcpath);
 
 			memcpy(ctx->membuf + ctx->memoff,
@@ -1207,6 +1207,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size && ptotal + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
+		z_erofs_dedupe_ext_commit(true);
 		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
 		goto err_free_meta;
@@ -1411,7 +1412,7 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 	bool dedupe_ext = cfg.c_fragments;
 	erofs_off_t off = 0;
 	int ret = 0, ret2;
-	erofs_blk_t dupb;
+	erofs_off_t dpo;
 	u64 hash;
 
 	list_for_each_entry_safe(ei, n, &sctx->extents, list) {
@@ -1429,10 +1430,10 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 			continue;
 
 		if (dedupe_ext) {
-			dupb = z_erofs_dedupe_ext_match(sbi, sctx->membuf + off,
+			dpo = z_erofs_dedupe_ext_match(sbi, sctx->membuf + off,
 						ei->e.plen, ei->e.raw, &hash);
-			if (dupb != EROFS_NULL_ADDR) {
-				ei->e.pstart = dupb;
+			if (dpo) {
+				ei->e.pstart = dpo;
 				sctx->pstart -= ei->e.plen;
 				off += ei->e.plen;
 				ictx->dedupe = true;
@@ -1444,6 +1445,8 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 				continue;
 			}
 		}
+		erofs_dbg("Writing %u %scompressed data of %s to %llu", ei->e.length,
+			  ei->e.raw ? "un" : "", ictx->inode->i_srcpath, ei->e.pstart);
 		ret2 = erofs_dev_write(sbi, sctx->membuf + off, ei->e.pstart,
 				       ei->e.plen);
 		off += ei->e.plen;
diff --git a/lib/dedupe_ext.c b/lib/dedupe_ext.c
index c2c5ca94..d7a9b737 100644
--- a/lib/dedupe_ext.c
+++ b/lib/dedupe_ext.c
@@ -32,14 +32,14 @@ int z_erofs_dedupe_ext_insert(struct z_erofs_inmem_extent *e,
 	return 0;
 }
 
-erofs_blk_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
+erofs_off_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
 				     u8 *encoded, unsigned int len,
 				     bool raw, u64 *hash)
 {
 	struct z_erofs_dedupe_ext_item *item;
 	struct list_head *p;
 	u64 _xxh64;
-	char *memb;
+	char *memb = NULL;
 	int ret;
 
 	*hash = _xxh64 = xxh64(encoded, len, 0);
@@ -47,19 +47,20 @@ erofs_blk_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
 	list_for_each_entry(item, p, list) {
 		if (item->xxh64 == _xxh64 && item->e.plen == len &&
 		    item->e.raw == raw) {
-			memb = malloc(len);
-			if (!memb)
-				break;
-			ret = erofs_dev_read(sbi, 0, memb, item->e.pstart, len);
-			if (ret < 0 || memcmp(memb, encoded, len)) {
-				free(memb);
-				break;
+			if (!memb) {
+				memb = malloc(len);
+				if (!memb)
+					break;
 			}
+			ret = erofs_dev_read(sbi, 0, memb, item->e.pstart, len);
+			if (ret < 0 || memcmp(memb, encoded, len))
+				continue;
 			free(memb);
 			return item->e.pstart;
 		}
 	}
-	return EROFS_NULL_ADDR;
+	free(memb);
+	return 0;
 }
 
 void z_erofs_dedupe_ext_commit(bool drop)
-- 
2.43.5


