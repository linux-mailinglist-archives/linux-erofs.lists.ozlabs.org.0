Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2A652D73
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 08:49:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NcQZg2bfvz3c6K
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 18:49:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcQZY4XFNz3bZV
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 18:49:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VXoYY9E_1671608974;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXoYY9E_1671608974)
          by smtp.aliyun-inc.com;
          Wed, 21 Dec 2022 15:49:36 +0800
Date: Wed, 21 Dec 2022 15:49:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: support interlaced uncompressed
 pcluster
Message-ID: <Y6K6jkYwJW0ZE8F3@B-P7TQMD6M-0146.local>
References: <20221221074130.26034-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221074130.26034-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 21, 2022 at 03:41:30PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Support uncompressed data layout with on-disk interlaced offset in
> compression mode for fsck.erofs.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fsck/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 410e756..c2f57bc 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -458,12 +458,16 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>  				.in = raw,
>  				.out = buffer,
>  				.decodedskip = 0,
> +				.interlaced_offset = 0,

Could we use
	.interlace_offset =
		map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
			rq.interlaced_offset : 0,

here instead?

Thanks,
Gao Xiang

>  				.inputsize = map.m_plen,
>  				.decodedlength = map.m_llen,
>  				.alg = map.m_algorithmformat,
>  				.partial_decoding = 0
>  			};
>  
> +			if (map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
> +				rq.interlaced_offset = erofs_blkoff(map.m_la);
> +
>  			ret = z_erofs_decompress(&rq);
>  			if (ret < 0) {
>  				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
> -- 
> 2.17.1
