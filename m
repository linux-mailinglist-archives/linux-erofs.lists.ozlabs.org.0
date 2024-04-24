Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EB8B0147
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 07:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713937624;
	bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gwkb2j94Pwg6oj9v5luXLxy7CFP/7v2B9u3IfMtUdLfaPm4U4+An75big8y2QqXvM
	 eyp12txOq7WVPUKJ3ldqGZpypvJn75i7HQ+VNSsn/4hmE3e0E/J0MibKVe05L7dr6r
	 l84aUtpqZVMh480Edh+xvufSA06h/xDpRP9aftrla+Fciz6KeE/+c1JLcu1LJPEInC
	 ZrGp5CugHeI/haRnL5kkfYq4rH228+Vi38TB7Z3pn8oxgw57Fcsd01VQL9udr2OsA6
	 3OITva4HDENTH8pgyLhL/r47lUEox3tms2G2bJbfLeW3aCooe41y6PJbOMshiWU3NU
	 beF/sesota9eQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPSfw5rCYz3cDw
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 15:47:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MohQxkHL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPSfp3164z3bsT
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 15:46:57 +1000 (AEST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3c74b27179dso2603381b6e.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Apr 2024 22:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937615; x=1714542415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oav/nBjbNQkJSHj491t5Rtmwwi8lc2zcpFduDWDdqHo=;
        b=YqenWL5oVw4L+f+idPx5OpYBeOU2SRpo+UacwKgapLzd7tFtAboAX+JMZaHVwpOm6g
         LgkQPVrz632qUE8hcbvtY3eK7etM7friUM0ZaArQYPXuOoy699d13L91CeDp8pypEqYj
         Z/N0uwmAkaWkpiMjh+azOKXC1cCqJ9tTow9kK5UxbGyKQFKXbMclsZZWtWhX6Z5A8fEr
         xaAzHBD1n0UuucpVLkFHyKlJldeCGPgJnCBw7I02y+EEUJgjap5ztojrik9NVm/LI+iT
         6LHjDtVxaJxSRzi2CG93r6VgosJoJNK62l+8MBbpbvIMTjybJxw/daDDtVnNAKCtn/Wv
         v9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXLGiBR32ddVzWTe+ZSq1zvwM9bE44z6XSJ/T9v23Njus92afiG/3ThP58WA+2jTLX5vtZQMmMkrKUzlXe9JGPkLRSCN/kiJoZGEW44
X-Gm-Message-State: AOJu0YyUlpMLom6p39BIt4frDvXbxsI+guKfbvJ8l0xPHnjOxn+WwOqD
	9D0cSiPRVYJXhoEXrML3HMY+aEYhBZIIzsmT0EHb5Ayy/ikCK38ocn/U6Bff9zo=
X-Google-Smtp-Source: AGHT+IGXNptk+olxPRJcLAW0W9h984MMeb0Lybawe6fqDXiy7gt7eKH1E3YmxBnctdni7giQ3i6BUw==
X-Received: by 2002:a05:6808:170e:b0:3c6:6e1:b166 with SMTP id bc14-20020a056808170e00b003c606e1b166mr1792336oib.28.1713937615179;
        Tue, 23 Apr 2024 22:46:55 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b006eae2d9298esm10560634pfu.194.2024.04.23.22.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:46:54 -0700 (PDT)
Message-ID: <a2593b0a-1ddc-4f87-8b6d-68900fdcf612@bytedance.com>
Date: Wed, 24 Apr 2024 13:46:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cachefiles: add missing lock protection when polling
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-6-libaokun@huaweicloud.com>
In-Reply-To: <20240424033409.2735257-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Add missing lock protection in poll routine when iterating xarray,
> otherwise:
> 
> Even with RCU read lock held, only the slot of the radix tree is
> ensured to be pinned there, while the data structure (e.g. struct
> cachefiles_req) stored in the slot has no such guarantee.  The poll
> routine will iterate the radix tree and dereference cachefiles_req
> accordingly.  Thus RCU read lock is not adequate in this case and
> spinlock is needed here.
> 
> Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for catching this.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/daemon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..73ed2323282a 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
>   
>   	if (cachefiles_in_ondemand_mode(cache)) {
>   		if (!xa_empty(&cache->reqs)) {
> -			rcu_read_lock();
> +			xas_lock(&xas);
>   			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
>   				if (!cachefiles_ondemand_is_reopening_read(req)) {
>   					mask |= EPOLLIN;
>   					break;
>   				}
>   			}
> -			rcu_read_unlock();
> +			xas_unlock(&xas);
>   		}
>   	} else {
>   		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
