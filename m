Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E8623CFD
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Nov 2022 08:59:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N7Dkk3GxJz3cJF
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Nov 2022 18:59:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N7Dkd3p3Cz3c7G
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Nov 2022 18:59:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VURww1u_1668067154;
Received: from 30.221.128.250(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VURww1u_1668067154)
          by smtp.aliyun-inc.com;
          Thu, 10 Nov 2022 15:59:15 +0800
Message-ID: <315099ec-b6c3-1aa0-c83e-86f6074bd674@linux.alibaba.com>
Date: Thu, 10 Nov 2022 15:59:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] erofs: enable large folio in device-based mode
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 11/10/22 3:40 PM, Jingbo Xu wrote:
> Enable large folio in device-based mode. Then the radahead routine will
> pass down large folio containing multiple pages.
> 
> Enable this feature for non-compressed format for now, until the
> compression part supports large folio later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> I have tested it under workload of Linux compiling. I know it's not a
> perfect workload testing this feature, because large folio is less
> likely hit in this case since source files are generally small. But I
> indeed observed large folios (e.g. 16 pages) by peeking
> readahead_count(rac) in erofs_readahead().

Sorry, readahead_count(rac) returns the whole number of pages inside the
rac, which can not prove large folio passed in.

I retired later and observed large folio (e.g. with order 2) by peeking
folio_order(ctx->cur_folio) inside iomap_readahead_iter()

> ---
>  fs/erofs/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index ad2a82f2eb4c..e457b8a59ee7 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -295,6 +295,8 @@ static int erofs_fill_inode(struct inode *inode)
>  		goto out_unlock;
>  	}
>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +	if (!erofs_is_fscache_mode(inode->i_sb))
> +		mapping_set_large_folios(inode->i_mapping);
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	if (erofs_is_fscache_mode(inode->i_sb))
>  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;

-- 
Thanks,
Jingbo
