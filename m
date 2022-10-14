Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75C5FE8E4
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 08:31:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mpc451KP9z3c9B
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 17:31:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mpc3w5Vx3z3bN6
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 17:31:39 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS6WuA7_1665729090;
Received: from 30.221.130.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS6WuA7_1665729090)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 14:31:32 +0800
Message-ID: <5ca5d4bd-63b4-12e9-39cd-7580958980db@linux.alibaba.com>
Date: Fri, 14 Oct 2022 14:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH V2 3/5] cachefiles: resend an open request if the read
 request's object is closed
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com, xiang@kernel.org
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
 <20221014030745.25748-4-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221014030745.25748-4-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 10/14/22 11:07 AM, Jia Zhu wrote:

> +/*
> + * Reopen the closed object with associated read request.

I think "Reopen the closed object if there's any inflight or subsequent
READ request on this object" would be better?

> + * Skip read requests whose related object are reopening.
					       ^
					      is ?


> @@ -277,14 +308,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	id = xas.xa_index;
> -	msg->msg_id = id;
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
> -		if (ret)
> +		if (ret) {
> +			cachefiles_ondemand_set_object_close(req->object);
>  			goto error;
> +		}
>  	}
>  
> +	msg->msg_id = id;
> +	msg->object_id = req->object->private->ondemand_id;

Since currently msg->object_id is always assigned in
cachefiles_ondemand_daemon_read(), we can remove the assignment in
cachefiles_ondemand_get_fd().


Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
