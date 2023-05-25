Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F571058A
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 07:56:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRckK1QqWz3f7D
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 15:56:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRckF3nKLz3bnr
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 15:56:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjR-1Ir_1684994174;
Received: from 30.97.48.238(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjR-1Ir_1684994174)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 13:56:15 +0800
Message-ID: <c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
Date: Thu, 25 May 2023 13:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: don't calculate new start when expanding read
 length
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230525055147.13220-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230525055147.13220-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/25 22:51, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> We only expand the trailing edge and not the leading edge.  So no need
> to obtain new start again.  Let's use the existing ->headoffset instead.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fs/erofs/zdata.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 874fee35af32..bab8dcb8e848 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   {
>   	struct inode *inode = f->inode;
>   	struct erofs_map_blocks *map = &f->map;
> -	erofs_off_t cur, end;
> +	erofs_off_t cur, end, headoffset = f->headoffset;


That is not quite useful, or could you merge this info the original patch?

Thanks,
Gao Xiang

>   	int err;
>   
>   	if (backmost) {
>   		if (rac)
> -			end = f->headoffset + readahead_length(rac) - 1;
> +			end = headoffset + readahead_length(rac) - 1;
>   		else
> -			end = f->headoffset + PAGE_SIZE - 1;
> +			end = headoffset + PAGE_SIZE - 1;
>   		map->m_la = end;
>   		err = z_erofs_map_blocks_iter(inode, map,
>   					      EROFS_GET_BLOCKS_READMORE);
>   		if (err)
>   			return;
>   
> -		/* expend ra for the trailing edge if readahead */
> +		/* expand ra for the trailing edge if readahead */
>   		if (rac) {
> -			loff_t newstart = readahead_pos(rac);
> -
>   			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> -			readahead_expand(rac, newstart, cur - newstart);
> +			readahead_expand(rac, headoffset, cur - headoffset);
>   			return;
>   		}
>   		end = round_up(end, PAGE_SIZE);
