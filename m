Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD9923DDC
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 14:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719923493;
	bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fqvuPSInxI2rtEsjll4hkNn/UZ+8uqPZFAyiQlKgrsIt+QJKCW6VfxA1QiFN6FDsI
	 GzIQMZ6+EXbPnK7CdDUhGLaH7DHRQEyHNYE0K9qlVZj8EwUuSO3bFS8U6C29ZN1xpT
	 Rx8J+HoKjlDgEMd+qjNKT7CWe/KyqLFU7p3Tz/UEdcniIkfJXcZnCz9tzAClZLBJHj
	 8+2KKUTu7+Pu5NnEavIX8SamRJzvmuKsACw82Nk4GM/lnH7C7HNYxPhAECs/vCWdbT
	 A9XIUVdOOIcB1/H658eAD9cqHKTGg4cVCjqdj3wR1V/xepK4DSJbN1HcPKUTL4Plpk
	 CZpwqfdHrbmTw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD2Mn6Rmyz3fp3
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 22:31:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BlEmCcCr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD2Mk2MzTz3fTS
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 22:31:29 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2595190a91.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jul 2024 05:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923487; x=1720528287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
        b=CZXA2cGPBqluzhQufjYRnxw6DGQT/RdNwvC8d3RHDVf6YqrYl48A2Zng7Q3XVps6vM
         qupiM/0cIcqHcc5IU6v9WKiloJMtoykM3M602aLC+BMliEm9lRUE5idjYpJhLzZf3tIF
         9bmREUczu4epOXWOVUoVVzOYd4BP11VwrfBMnFRwv5E86JYbqcfXLvwKs/JMg1ggn36R
         x7Y+c1Y+b20+LMnJyHlF3ziOkzevgZtvik2lh+0cjnyeSZQpjpL98hT+8vchyBV39m/o
         XK5njeJRLGg1JPNaVAiVDCk1OAg/zipAXMIaQXH7WnUnnPy2eiwRbjL1PMDUBaJBzB7K
         U6KA==
X-Forwarded-Encrypted: i=1; AJvYcCUP6kzgB1utspkF1s5a/0camc4U2Emi/XV3P7kjBZ3Fu+p5QIiKiBRhqEFTwG9gsdDEo09lzQ9xuFdXQTj7xbNZLlJ27JqoUe6AtYBV
X-Gm-Message-State: AOJu0Yzf7uWImv7huW+UnSEvxxFJWdbZHoCuE5jl8zW1W0vlFILcfInj
	r6MI2BPlQJTIGSPhyAtyJky2hi1/6ePLubBrVXP0YLL1YUrp80tquSKu7DMYEm8=
X-Google-Smtp-Source: AGHT+IEQmgs/v36TUzW9XWoPCZpKUIq41uJJFgwIz5VYPSN0CR6cvSwMrpKZEhWHqcEZfDk9htY4FA==
X-Received: by 2002:a17:90b:2dca:b0:2c9:57a4:a8c4 with SMTP id 98e67ed59e1d1-2c957a4baa0mr1358052a91.42.1719923487273;
        Tue, 02 Jul 2024 05:31:27 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce432dasm8743605a91.17.2024.07.02.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:31:26 -0700 (PDT)
Message-ID: <a5c8edce-a314-4321-b2fb-4ed2dfeea481@bytedance.com>
Date: Tue, 2 Jul 2024 20:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 6/9] cachefiles: cancel all requests for the
 object that is being dropped
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-7-libaokun@huaweicloud.com>
In-Reply-To: <20240628062930.2467993-7-libaokun@huaweicloud.com>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because after an object is dropped, requests for that object are useless,
> cancel them to avoid causing other problems.
> 
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, cancel it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 8a3b52c3ebba..36b97ded16b4 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -669,12 +669,31 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	unsigned long index;
> +	struct cachefiles_req *req;
> +	struct cachefiles_cache *cache;
> +
>   	if (!object->ondemand)
>   		return;
>   
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +
> +	if (!object->ondemand->ondemand_id)
> +		return;
> +
> +	/* Cancel all requests for the object that is being dropped. */
> +	cache = object->volume->cache;
> +	xa_lock(&cache->reqs);
>   	cachefiles_ondemand_set_object_dropping(object);
> +	xa_for_each(&cache->reqs, index, req) {
> +		if (req->object == object) {
> +			req->error = -EIO;
> +			complete(&req->done);
> +			__xa_erase(&cache->reqs, index);
> +		}
> +	}
> +	xa_unlock(&cache->reqs);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
