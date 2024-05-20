Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 154018C97EE
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 04:26:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aRHGIRlp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjLsY2Nzyz3cWP
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 12:21:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aRHGIRlp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjLsN4fSFz3bs0
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:21:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716171665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JEAxIHH4Mzu7tZcEd3SvUP+FFw/Ul2NIJxhCNffO0+0=;
	b=aRHGIRlpoo7Taya/3LLtnAUlWgZZXveCcTZG+OifHab28qWAZM/MW9qOIPijCnvn0msJakmgd+4gysfdzp+C4NtH8ugeThMeihvcShWKHgYVuLYG13rEw1r/Lo+h3mrxCYGXgSsH1kpATIva2S1t42RRGOQiC+z+9DxxUi3edY8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6kg4SN_1716171661;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6kg4SN_1716171661)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 10:21:03 +0800
Message-ID: <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
Date: Mon, 20 May 2024 10:20:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] cachefiles: remove request from xarry during
 flush requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-2-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-2-libaokun@huaweicloud.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>


The subject line can be
"cachefiles: remove requests from xarray during flushing requests"

> 
> Even with CACHEFILES_DEAD set, we can still read the requests, so in the
> following concurrency the request may be used after it has been freed:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>   cachefiles_ondemand_init_object
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                                    // close dev fd
>                                    cachefiles_flush_reqs
>                                     complete(&REQ_A->done)
>     kfree(REQ_A)
>                xa_lock(&cache->reqs);
>                cachefiles_ondemand_select_req
>                  req->msg.opcode != CACHEFILES_OP_READ
>                  // req use-after-free !!!
>                xa_unlock(&cache->reqs);
>                                     xa_destroy(&cache->reqs)
> 
> Hence remove requests from cache->reqs when flushing them to avoid
> accessing freed requests.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/cachefiles/daemon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..ccb7b707ea4b 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>   	xa_for_each(xa, index, req) {
>   		req->error = -EIO;
>   		complete(&req->done);
> +		__xa_erase(xa, index);
>   	}
>   	xa_unlock(xa);
>   
