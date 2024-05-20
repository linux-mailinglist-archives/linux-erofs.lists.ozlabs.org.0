Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB18C997B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 09:46:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YcHHmNQo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjTyM4KmKz3cfB
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 17:40:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YcHHmNQo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjTyJ3FZTz3cc6
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 17:40:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716190852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=crYhzYLF/Z9aGaDX2S1xu5VnG4QQ1Zxh17dm47AJQSo=;
	b=YcHHmNQoGkMvwhd3nE2Dg8nHFZaUHbVFXF+Svws7kzQOMyHe8yds7knBujmwJ6gF02RT9I/3YepIyoZGDCXX3gB4Wow/7Wugti+XXKn7Pw8Q4Ue3fRhcHivDdlsV5yXkrROFQ1zVBeVJVCajGKutDGPN+Z9QyXIzCV78wk8C13M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6nyCdl_1716190849;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6nyCdl_1716190849)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 15:40:50 +0800
Message-ID: <af4b9591-d82e-4da3-b681-eb677369ced3@linux.alibaba.com>
Date: Mon, 20 May 2024 15:40:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] cachefiles: add output string to
 cachefiles_obj_[get|put]_ondemand_fd
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-6-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-6-libaokun@huaweicloud.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This lets us see the correct trace output.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>


Could we move this simple fix to the beginning of the patch set?

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  include/trace/events/cachefiles.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index 119a823fb5a0..bb56e3104b12 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -130,6 +130,8 @@ enum cachefiles_error_trace {
>  	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>  	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
>  	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")      \
> +	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")      \
>  	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
>  	E_(cachefiles_obj_put_read_req,		"PUT read_req")
>  

-- 
Thanks,
Jingbo
