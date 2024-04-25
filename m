Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA38B1950
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 05:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714015040;
	bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UiWuK+XBBMgA/Ima7BLUPUlLH8J40dMfmKeuP/Wv4tUa0mff2R1/3dj/nOadYlxqk
	 soWLSvBJKA0pgL5ef8xhHJWzNrIMemLIjV8ambRlI+Hx/J2arT/35EKdX9cuQvFwOH
	 4G4YpvoTseaIr1Q3t3RJgT5zUrvhEsiVMy3nfOjaZ6fNLOB/WqNvsm8mQqsrSuf+X2
	 qAq8ry1n2BulaG5Dmr2MIkkHJX7ItUrXlFcPWPtfmUqa1oO+Bxtz5daUvJHv1lKdDd
	 dPkZIWWlPAqcsZO80MBW+BohbNIxIpK0JwI5SL6JRvLtubEMbqQt537IjoutjNN49v
	 c63kNRl3ivzCw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ1Hh4MBRz3dHD
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 13:17:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LMoSOfIP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ1Hc5477z3cYh
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 13:17:16 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so527478b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015034; x=1714619834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
        b=Ha5lEP8zl6l973VqU7Ns3RHgbyLoDm6eEB1sb6ioYVGsPDnVViI9EK55J4sDBJ7/4A
         fRcX8eVCISmVTSP09Feox8Q/kxXfuZOIcyR1XKvqJIrAyuo0sZT3Bm39pzw4tkBvlhDu
         GlJVzAf8oO6pm+9K8Xa+IkIIcnwYbd0j+2eIMvGHdMft+uoCarfyqEwZwTRgkg1TVg7u
         WFV8+RalvxeQriHm+sqCQmy/95DJIrhfbyHqIJxN/tuGInROzUK6c1lV3lEU3OlUPdF8
         QK4GLspgsbaCw50Vd5SPMabWeQplxZxdCKbS5N3AUYbpfdqP2vBIPw85mOsTTj2jBj6M
         hWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXM+hqQMwOo/Aj718FR+Aw7kGC19n+EkSK8mKF6fb5z1Fr9KfCL8jUnV/OL9QjwE8qrwOGehBPRT6R5h9iHpEv/djkVXEfuvg9i2ZZ
X-Gm-Message-State: AOJu0YzTwxWAoLNEPE2kPZbIZZNBy3yPNU1Swir+66MnTTEeruKsfJfO
	Tz97MPk+36PwHAV7LH4wO8VdJN97yT6x8o+AyMNCMsmpNmmSiOWyLymmgknciMDwld0u+drwOAT
	P
X-Google-Smtp-Source: AGHT+IFsDUKcepwhTMfngbtOJkYdquZcdm/7+0FnSBhsRuUAiazYGUUz8MH7tc0XTEkAcFEoXbsTQw==
X-Received: by 2002:a05:6a21:3d89:b0:1ac:dead:1370 with SMTP id bj9-20020a056a213d8900b001acdead1370mr4849697pzc.21.1714015034157;
        Wed, 24 Apr 2024 20:17:14 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006edadf8058asm12160586pfh.23.2024.04.24.20.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:17:13 -0700 (PDT)
Message-ID: <9228a873-8250-4b63-bf75-473e9a87ab80@bytedance.com>
Date: Thu, 25 Apr 2024 11:17:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-3-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-3-libaokun@huaweicloud.com>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd tag is only used once, so remove it to make the code more
> readable.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..fd49728d8bae 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
> -		goto err_put_fd;
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +		goto error;
>   	}
>   
>   	/* CLOSE request has no reply */
> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	return n;
>   
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>   error:
>   	xa_erase(&cache->reqs, id);
>   	req->error = ret;
