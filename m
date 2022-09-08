Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393195B11AD
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Sep 2022 02:57:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MNLLK4KYWz2yx8
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Sep 2022 10:56:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j1yJmjKa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j1yJmjKa;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MNLLB5k1bz2yx8
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Sep 2022 10:56:50 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7D74061ACC;
	Thu,  8 Sep 2022 00:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEEEC433D6;
	Thu,  8 Sep 2022 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662598606;
	bh=JjH7yb3wgrQz2zDGR97m1+MhIZ9XuqkmQigbpgC7a6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1yJmjKaiMYBOZ/k74qhPdu8kxnvCAsUnX9UKpvPQ1nCfvKBzroWggQzN23YoAILu
	 wDTMUmC8hAzwNsSLOmCMc6LKpFEPnP5V32CMa41vZo/El/XzXZRNE1XTpKBqX+AfZN
	 cgDxjocFxqMVOxrkxgXbM6xUXU/u6RExMgHC0ytJvpc0tfeIIH6Dhbs3RFJqrnpIFW
	 TlfZZgZAYwwztLk40pw3rKaT4acMaCscbSfgZYwamAi0aGCE86l2CttxujMg72D5nF
	 a/sT83MKUjNtSCHJKVDEJCUuxNmNgXNxwIDVrGngLX0+056swTYe+GlNS6Q+3j7n6s
	 7SCCmp56PwUtA==
Date: Thu, 8 Sep 2022 08:56:32 +0800
From: Gao Xiang <xiang@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 4/4] erofs-utils: mkfs: introduce global compressed data
 deduplication
Message-ID: <Yxk9wKhFaROqoySM@hsiangkao-PC>
Mail-Followup-To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
References: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
 <20220906114057.151445-4-ZiyangZhang@linux.alibaba.com>
 <YxgyZqrZs1X2V1pC@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxgyZqrZs1X2V1pC@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org, ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 07, 2022 at 01:55:50PM +0800, Gao Xiang wrote:
> On Tue, Sep 06, 2022 at 07:40:57PM +0800, ZiyangZhang wrote:
> > From: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> > 
> > This patch introduces global compressed data deduplication to
> > reuse potential prefixes for each pcluster.
> > 
> > It also uses rolling hashing and shortens the previous compressed
> > extent in order to explore more possibilities for deduplication.
> > 
> > Co-developped-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> 
> Some preliminary numbers:
> Image				Fs	Type						Size
> system.raven.87e115a1           erofs   uncompressed                                    910082048
> system.raven.87e115a1           erofs   4k pcluster + lz4hc,9 + ztailpacking            584970240       -35.7% off
> system.raven.87e115a1           erofs   4k pcluster + lz4hc,9 + ztailpacking + dedupe   569376768       -37.4% off
> 
> linux-5.10 + linux-5.10.87      erofs   uncompressed                                     1943691264
> linux-5.10 + linux-5.10.87      erofs   4k pcluster + lz4hc,9 + ztailpacking             661987328      -65.9% off
> linux-5.10 + linux-5.10.87      erofs   4k pcluster + lz4hc,9 + ztailpacking + dedupe    490295296      -74.8% off
> 
> linux-5.10.87                   erofs   4k pcluster + lz4hc,9                            331292672
> 
> One observation is since the tailpacking pcluster doesn't have blkaddr
> so data relating to tailpacking pcluster cannot be deduped.
> 
> On the other side, it can work with `fragment' feature later together to
> minimize image sizes.
> 
> 
> Attach a fix for uncompressed pcluster:
> 
> diff --git a/lib/dedupe.c b/lib/dedupe.c
> index c53a64edfc8d..c382303e2ceb 100644
> --- a/lib/dedupe.c
> +++ b/lib/dedupe.c
> @@ -21,7 +21,7 @@ struct z_erofs_dedupe_item {
>  	unsigned int	compressed_blks;
>  
>  	int		original_length;
> -	bool		partial;
> +	bool		partial, raw;
>  	u8		extra_data[];
>  };
>  
> @@ -86,6 +86,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
>  		ctx->e.length = window_size + extra;
>  		ctx->e.partial = e->partial ||
>  			(window_size + extra < e->original_length);
> +		ctx->e.raw = e->raw;
>  		ctx->e.blkaddr = e->compressed_blkaddr;
>  		ctx->e.compressedblks = e->compressed_blks;
>  		return 0;
> @@ -114,6 +115,7 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
>  	di->compressed_blkaddr = e->blkaddr;
>  	di->compressed_blks = e->compressedblks;
>  	di->partial = e->partial;
> +	di->raw = e->raw;
>  
>  	/* with the same rolling hash */
>  	if (!rb_tree_insert(dedupe_subtree, di))
> -- 
> 2.30.2
>

Another fix detected by an Android system image:

diff --git a/lib/compress.c b/lib/compress.c
index bdb6e78d32ca..3247835b75b6 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -158,9 +158,14 @@ static int z_erofs_compress_dedupe(struct erofs_inode *inode,
 
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
-			.start = ctx->queue + ctx->head -
-				(ctx->e.length < EROFS_BLKSIZ ? 0 :
-					ctx->e.length - EROFS_BLKSIZ),
+			.start = ctx->queue + ctx->head - ({ int rc;
+				if (ctx->e.length <= EROFS_BLKSIZ)
+					rc = 0;
+				else if (ctx->e.length - EROFS_BLKSIZ >= ctx->head)
+					rc = ctx->head;
+				else
+					rc = ctx->e.length - EROFS_BLKSIZ;
+				rc; }),
 			.end = ctx->queue + ctx->head + *len,
 			.cur = ctx->queue + ctx->head,
 		};

