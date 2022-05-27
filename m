Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B52405360E0
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 14:01:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8k164qk0z3bkw
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 22:01:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.13; helo=out199-13.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L8k126J4bz2yph
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 May 2022 22:01:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VEXCV6U_1653652874;
Received: from 30.225.24.46(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VEXCV6U_1653652874)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 20:01:15 +0800
Message-ID: <dfc3c10a-5f95-cfa3-53ba-d159d2a2f50b@linux.alibaba.com>
Date: Fri, 27 May 2022 20:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: fix crash when enable tracepoint
 cachefiles_prep_read
Content-Language: en-US
To: Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
 chao@kernel.org
References: <20220527101800.22360-1-yinxin.x@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220527101800.22360-1-yinxin.x@bytedance.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi, thanks for catching this.


On 5/27/22 6:18 PM, Xin Yin wrote:
> RIP: 0010:trace_event_raw_event_cachefiles_prep_read+0x88/0xe0
> [cachefiles]
> Call Trace:
>   <TASK>
>   cachefiles_prepare_read+0x1d7/0x3a0 [cachefiles]
>   erofs_fscache_read_folios+0x188/0x220 [erofs]
>   erofs_fscache_meta_readpage+0x106/0x160 [erofs]
>   do_read_cache_folio+0x42a/0x590
>   ? bdi_register_va.part.14+0x1a7/0x210
>   ? super_setup_bdi_name+0x76/0xe0
>   erofs_bread+0x5b/0x170 [erofs]
>   erofs_fc_fill_super+0x12b/0xc50 [erofs]
> 
> This tracepoint uses rreq->inode, should set it when allocating.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache
> readpage/readahead")

The "Fixes" line should better be one single line. But no worry, I think
Gao Xiang will fix this then :)

> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/erofs/fscache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index a5cc4ed2cd0d..8e01d89c3319 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -17,6 +17,7 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
>  	rreq->start	= start;
>  	rreq->len	= len;
>  	rreq->mapping	= mapping;
> +	rreq->inode	= mapping->host;
>  	INIT_LIST_HEAD(&rreq->subrequests);
>  	refcount_set(&rreq->ref, 1);
>  	return rreq;

Otherwise, LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
