Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B618A7AB92E
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Sep 2023 20:31:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rsgp54Vmfz3clL
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Sep 2023 04:31:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rsgnv0JWFz3c76
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Sep 2023 04:31:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VseCbpK_1695407468;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VseCbpK_1695407468)
          by smtp.aliyun-inc.com;
          Sat, 23 Sep 2023 02:31:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: lib: drop prefix_sha256 digests
Date: Sat, 23 Sep 2023 02:30:55 +0800
Message-Id: <20230922183055.1583756-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922183055.1583756-1-hsiangkao@linux.alibaba.com>
References: <20230922183055.1583756-1-hsiangkao@linux.alibaba.com>
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

People care more about speed when building.  Later, we could also
try to use file-backed memory to avoid memory pressure.

As a result, it could decrease time by 50% (0m58.255s -> 0m29.120s).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/dedupe.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/dedupe.c b/lib/dedupe.c
index 4b0edbf..19a1c8d 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -69,7 +69,6 @@ struct z_erofs_dedupe_item {
 	struct list_head list;
 	struct z_erofs_dedupe_item *chain;
 	long long	hash;
-	u8		prefix_sha256[32];
 	u64		prefix_xxh64;
 
 	erofs_blk_t	compressed_blkaddr;
@@ -77,7 +76,7 @@ struct z_erofs_dedupe_item {
 
 	int		original_length;
 	bool		partial, raw;
-	u8		extra_data[];
+	u8		payload[];
 };
 
 int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
@@ -101,7 +100,6 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 
 		unsigned int extra = 0;
 		u64 xxh64_csum;
-		u8 sha256[32];
 
 		if (initial) {
 			/* initial try */
@@ -127,13 +125,12 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 		if (&e->list == p)
 			continue;
 
-		erofs_sha256(cur, window_size, sha256);
-		if (memcmp(sha256, e->prefix_sha256, sizeof(sha256)))
+		if (memcmp(cur, e->payload, window_size))
 			continue;
 
 		extra = min_t(unsigned int, ctx->end - cur - window_size,
 			      e->original_length - window_size);
-		extra = erofs_memcmp2(cur + window_size, e->extra_data, extra);
+		extra = erofs_memcmp2(cur + window_size, e->payload + window_size, extra);
 		if (window_size + extra <= ctx->cur - cur)
 			continue;
 		ctx->cur = cur;
@@ -157,18 +154,16 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 	if (!window_size || e->length < window_size)
 		return 0;
 
-	di = malloc(sizeof(*di) + e->length - window_size);
+	di = malloc(sizeof(*di) + e->length);
 	if (!di)
 		return -ENOMEM;
 
 	di->original_length = e->length;
-	erofs_sha256(original_data, window_size, di->prefix_sha256);
 
 	di->prefix_xxh64 = xxh64(original_data, window_size, 0);
 	di->hash = erofs_rolling_hash_init(original_data,
 			window_size, true);
-	memcpy(di->extra_data, original_data + window_size,
-	       e->length - window_size);
+	memcpy(di->payload, original_data, e->length);
 	di->compressed_blkaddr = e->blkaddr;
 	di->compressed_blks = e->compressedblks;
 	di->partial = e->partial;
-- 
2.39.3

