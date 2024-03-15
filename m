Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A434187C7F6
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 04:31:52 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZDQ3AizC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwqYL35kpz3c9x
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 14:31:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZDQ3AizC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwqYF4fpbz307y
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 14:31:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710473499; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jSE61FNf4EfQicXRoPQeO23SG20+csvIE49gD33vwJo=;
	b=ZDQ3AizCLcMSHHc8D7NHJBmcgclkrPweD6Gix+S/cn7BnFMsPswpAotQVtyJe2ro2Lldk0pnSOY61BQNJ1UcpsmZBVmb3GNsCrda4Zo0QJccKP5ipH0+Wh5YbKDpH5RNTld+09R6V2ntYI6IhYwCM6k7YMrX1fVnrcuFeTV4lcI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2UXtme_1710473497;
Received: from 30.221.132.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2UXtme_1710473497)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 11:31:38 +0800
Message-ID: <309cb6e8-fca6-49f8-80e5-64b9ddb2878f@linux.alibaba.com>
Date: Fri, 15 Mar 2024 11:31:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] erofs-utils: mkfs: introduce inner-file
 multi-threaded compression
To: linux-erofs@lists.ozlabs.org
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
 <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Tong Xin <xin_tong@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/15 09:10, Gao Xiang wrote:
> From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> 
> Currently, the creation of EROFS compressed image creation is
> single-threaded, which suffers from performance issues. This patch
> attempts to address it by compressing the large file in parallel.
> 
> Specifically, each input file larger than 16MB is splited into segments,
> and each worker thread compresses a segment as if it were a separate
> file. Finally, the main thread merges all the compressed segments.
> 
> Multi-threaded compression is not compatible with -Ededupe,
> -E(all-)fragments and -Eztailpacking for now.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v7:
>   - support -Eztailpacking;

Apply the following diff to fix this:

diff --git a/lib/compress.c b/lib/compress.c
index 0d796c8..7ad48b0 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -509,10 +509,10 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
  	struct erofs_compress *const h = ctx->chandle;
  	unsigned int len = ctx->tail - ctx->head;
  	bool is_packed_inode = erofs_is_packed_inode(inode);
-	bool final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && final && !is_packed_inode &&
-			    !z_erofs_mt_enabled);
-	bool may_inline = (cfg.c_ztailpacking && final && !may_packing);
+	bool tsg = (ctx->seg_idx + 1 >= ctx->seg_num), final = !ctx->remaining;
+	bool may_packing = (cfg.c_fragments && tsg && final &&
+			    !is_packed_inode && !z_erofs_mt_enabled);
+	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
  	unsigned int compressedsize;
  	int ret;

Thanks,
Gao Xiang
