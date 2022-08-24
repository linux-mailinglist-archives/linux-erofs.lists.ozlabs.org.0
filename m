Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2959F587
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Aug 2022 10:46:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MCKSl1NRJz3bVt
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Aug 2022 18:46:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MCKSc02Yyz2xjv
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Aug 2022 18:46:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VN6doxe_1661330759;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VN6doxe_1661330759)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 16:46:01 +0800
Date: Wed, 24 Aug 2022 16:45:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: zbestahu@gmail.com
Subject: Re: [RFC PATCH v4 2/3] erofs-utils: lib: support on-disk offset for
 shifted decompression
Message-ID: <YwXlR0lL6eZPtTTC@B-P7TQMD6M-0146.local>
References: <cover.1661087840.git.huyue2@coolpad.com>
 <9f59c86102b06555e39e62c99ca288647120ee01.1661087840.git.huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f59c86102b06555e39e62c99ca288647120ee01.1661087840.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Sun, Aug 21, 2022 at 09:57:24PM +0800, zbestahu@gmail.com wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add support to uncompressed data layout with on-disk offset for
> compressed files.

Sorry for some delay.

Add interlaced uncompressed data layout for compressed files.

> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  include/erofs/decompress.h |  3 +++
>  lib/data.c                 |  8 +++++++-
>  lib/decompress.c           | 10 ++++++++--
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index 82bf7b8..b622df5 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
> @@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
>  	unsigned int decodedskip;
>  	unsigned int inputsize, decodedlength;
>  
> +	/* head offset of uncompressed data */
> +	unsigned int shiftedhead;

	/* cut point of interlaced uncompressed data */
	unsigned int interlaced_offset;

> +
>  	/* indicate the algorithm will be used for decompression */
>  	unsigned int alg;
>  	bool partial_decoding;
> diff --git a/lib/data.c b/lib/data.c
> index 2af73c7..008790d 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>  	};
>  	struct erofs_map_dev mdev;
>  	bool partial;
> -	unsigned int bufsize = 0;
> +	unsigned int bufsize = 0, head;
>  	char *raw = NULL;
>  	int ret = 0;
>  
> @@ -307,10 +307,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>  		if (ret < 0)
>  			break;
>  
> +		head = 0;
> +		if (erofs_sb_has_fragments() &&

Can we add another Z_EROFS_ADVISE_ for this, such as
Z_EROFS_ADVISE_INTERLACED_UNCOMPRESSED_DATA ?

> +		    map.m_algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
> +			head = erofs_blkoff(end);
> +
>  		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>  					.in = raw,
>  					.out = buffer + end - offset,
>  					.decodedskip = skip,
> +					.shiftedhead = head,
>  					.inputsize = map.m_plen,
>  					.decodedlength = length,
>  					.alg = map.m_algorithmformat,
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 1661f91..08a0861 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -132,14 +132,20 @@ out:
>  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
>  {
>  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> +		unsigned int count, rightpart;
> +
>  		if (rq->inputsize > EROFS_BLKSIZ)
>  			return -EFSCORRUPTED;
>  
>  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
>  		DBG_BUGON(rq->decodedlength < rq->decodedskip);
>  
> -		memcpy(rq->out, rq->in + rq->decodedskip,
> -		       rq->decodedlength - rq->decodedskip);
> +		count = rq->decodedlength - rq->decodedskip;
> +		rightpart = min(EROFS_BLKSIZ - rq->shiftedhead, count);
> +
> +		memcpy(rq->out, rq->in + (erofs_sb_has_fragments() ?

same here.

Thanks,
Gao Xiang

> +		       rq->shiftedhead : rq->decodedskip), rightpart);
> +		memcpy(rq->out + rightpart, rq->in, count - rightpart);
>  		return 0;
>  	}
>  
> -- 
> 2.17.1
