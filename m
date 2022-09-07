Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B63A5AFC0D
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Sep 2022 07:56:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMs216y2Hz30JR
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Sep 2022 15:56:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMs1v0XJMz2xHF
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Sep 2022 15:56:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VOwMHB2_1662530150;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VOwMHB2_1662530150)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 13:55:52 +0800
Date: Wed, 7 Sep 2022 13:55:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 4/4] erofs-utils: mkfs: introduce global compressed data
 deduplication
Message-ID: <YxgyZqrZs1X2V1pC@B-P7TQMD6M-0146.local>
References: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
 <20220906114057.151445-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906114057.151445-4-ZiyangZhang@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 06, 2022 at 07:40:57PM +0800, ZiyangZhang wrote:
> From: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> 
> This patch introduces global compressed data deduplication to
> reuse potential prefixes for each pcluster.
> 
> It also uses rolling hashing and shortens the previous compressed
> extent in order to explore more possibilities for deduplication.
> 
> Co-developped-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Some preliminary numbers:
Image				Fs	Type						Size
system.raven.87e115a1           erofs   uncompressed                                    910082048
system.raven.87e115a1           erofs   4k pcluster + lz4hc,9 + ztailpacking            584970240       -35.7% off
system.raven.87e115a1           erofs   4k pcluster + lz4hc,9 + ztailpacking + dedupe   569376768       -37.4% off

linux-5.10 + linux-5.10.87      erofs   uncompressed                                     1943691264
linux-5.10 + linux-5.10.87      erofs   4k pcluster + lz4hc,9 + ztailpacking             661987328      -65.9% off
linux-5.10 + linux-5.10.87      erofs   4k pcluster + lz4hc,9 + ztailpacking + dedupe    490295296      -74.8% off

linux-5.10.87                   erofs   4k pcluster + lz4hc,9                            331292672

One observation is since the tailpacking pcluster doesn't have blkaddr
so data relating to tailpacking pcluster cannot be deduped.

On the other side, it can work with `fragment' feature later together to
minimize image sizes.


Attach a fix for uncompressed pcluster:

diff --git a/lib/dedupe.c b/lib/dedupe.c
index c53a64edfc8d..c382303e2ceb 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -21,7 +21,7 @@ struct z_erofs_dedupe_item {
 	unsigned int	compressed_blks;
 
 	int		original_length;
-	bool		partial;
+	bool		partial, raw;
 	u8		extra_data[];
 };
 
@@ -86,6 +86,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 		ctx->e.length = window_size + extra;
 		ctx->e.partial = e->partial ||
 			(window_size + extra < e->original_length);
+		ctx->e.raw = e->raw;
 		ctx->e.blkaddr = e->compressed_blkaddr;
 		ctx->e.compressedblks = e->compressed_blks;
 		return 0;
@@ -114,6 +115,7 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 	di->compressed_blkaddr = e->blkaddr;
 	di->compressed_blks = e->compressedblks;
 	di->partial = e->partial;
+	di->raw = e->raw;
 
 	/* with the same rolling hash */
 	if (!rb_tree_insert(dedupe_subtree, di))
-- 
2.30.2

