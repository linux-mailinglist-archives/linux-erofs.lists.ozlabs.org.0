Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF58B1945
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 05:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714014832;
	bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iOhhpRfRVGrN2oNCfeaA/P/rDFokahNcjAuL5VuSDvTL9qFQZB8/6NFv3p52o8CTt
	 5o6Wf26vyoYjIFz9inmbRO4yFo8Vrg7M5RfBRfpLEHVL9quETRyx7MtE2lhhW+XFsF
	 SUc6DK0ZTcW5Q8IwrAu/7yd5898tg23nOxR/Jfu+VJ677CVqK7cmlKCwYGeDeS27zV
	 J9K2Q9wixMMuKtG2yOXgvSuHNowbaHH/Ys4s6qJQc4N/ovxmbg39sC63ZNfsFEmNUi
	 oq3h+icZ83YcJKhy0xc97RGMVWVKmHDxdz0p4Wy+EiOd2b4uX7fzyKvgVp4JZ5L0Nd
	 uCxliBEHD/WoA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ1Ch3tC5z3dFm
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 13:13:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I2ij9fKe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ1CW22sDz3cRk
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 13:13:40 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso473826a91.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014817; x=1714619617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
        b=cXzAuN9RGb4zthlhqhD/Td4QGz37AgoVR7j8RCvuShb4nu7bQMoxguLyAC/1WuK3aa
         cUqg+nyiz9ZZNUuX+Amw0hkDg8do4P/Nb65GxoImofGxUreZtdnuXoJXfSGOG5mO0bFr
         jMBTHxKmYpUTnB/NZxNJwoTTumGGTE9OAYTZlO9TltFXA4DRW/HyhVxIW+lejqMgW63q
         x+tgmgv3mt6rtLP8ncuMdPS4MrAKy46uyx5p8QghFyZTUqiJ3wNiJasCfhEwTrdhoSJk
         zbBKr3siHDHz55qdkZT+vu/bkODPMQd2lHfSj4ZUrdQCLJDpWjtHwroB4csInKscSo3B
         yUGA==
X-Forwarded-Encrypted: i=1; AJvYcCUeGMIXAinT8CQokL1rF6CHmlbxyGxUEJwAySQAlKl3hStJEz7MOzZhb1kiqzg/13leOndMttAbeLlWaEE2JHg6pkjMUykbdL6Icwja
X-Gm-Message-State: AOJu0YzI8w57W/58oYvDh2h5p3DdndO9FenOajalunC8HrFnGWtD5pLQ
	yPQQjFMT/FM1CoHIXn9MFbJ7x0xwS2p+PM+SOE7rriIUvHSfA/cH/FSbR7sSbm4=
X-Google-Smtp-Source: AGHT+IEuq2nC3+NrQjBJkDqAEPYGH85KMdEqJehJWR0o0NQ3qmkCAsRYPwQPdvh8mGs6423pdhVCfA==
X-Received: by 2002:a17:90a:6b47:b0:2ad:6294:7112 with SMTP id x7-20020a17090a6b4700b002ad62947112mr4177222pjl.14.1714014817331;
        Wed, 24 Apr 2024 20:13:37 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id gk1-20020a17090b118100b002a5290ad3d4sm11981013pjb.3.2024.04.24.20.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:13:36 -0700 (PDT)
Message-ID: <6c04aab1-44d7-464c-8080-b06d5c0f16ee@bytedance.com>
Date: Thu, 25 Apr 2024 11:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-2-libaokun@huaweicloud.com>
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
> This prevents concurrency from causing access to a freed req.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

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
