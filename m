Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE5923DD3
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 14:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719923398;
	bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IKatOyG/Jfz57Nhpki/VwtPqahtp4E3sOxOcdSHt8/RvR5Plbi31U58uxYHv1351S
	 FpPQnium+5d7e1602HNWusNTZffheAxTf4gIpyxtbeviy7t0C6XrnA9Kjvtfw7S9ae
	 shwxCekaa46aWcIcVwcI3sImF18+o/gDggDUjyeFqXcR2RZC3hp1FLMvuq8iaQvjwB
	 dNnzx2nTWRWcF6/ko2EuSbATHRj6o+icYJ8ixe81poucFMygNsCXQQRRk+lR3sIQNJ
	 fLgs9VEpsGrI1x0sWWJ3O5gRaq066QCUb4s3hzJjf6zVoyFlskm0vWkldBfeysOWXO
	 Gp4zeYPRbQ+0Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD2Ky4vxzz3fp1
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 22:29:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=To7MVEYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD2Kt3dHNz3fSY
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 22:29:54 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3331558b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jul 2024 05:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923390; x=1720528190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
        b=hykNSMofR6fF9Q1nk73m+/YPLNDS4EN6nYm40ZswTO1jqerNeZo/CR/nfS9Pmalbdz
         yunjZ2slug4fl3CwM8W1ClQs2BkRIJd56sdb+Lrn2QIqSUQfYBvqPB2tDsSjqgU80Xh0
         2IghG2h+yMVdsjtUishdPhEAaGGKIY/T7vZzD6AmU/bPqduzTwYVEw+EuKQfmtYrbMiV
         ggLr1trHVn56M3X9888AXesirti/eq00fRXAklDVbID1zUYCIPQFJ9ILvEMPFIWG4hVo
         7hzMOwCI4XiduiURRAMnabCnePY7VIpsUpyLXrjpV1JU3RKpbBimGcVHFczBxO9yX1bw
         rrYw==
X-Forwarded-Encrypted: i=1; AJvYcCWLhUZkB+1Znqa7Q9ah7FqPdp/IVtcl6xQVheJHpgrVEKmqoxQUo612nInHogqzFI+PGx/wbgwmI2BKAWKMjFqiJcBrkx2rHHnOBbDR
X-Gm-Message-State: AOJu0Yx6FOjd7ib4OlpU3BVsDKdjZJdwg+2j/TzDzO5cOM+hrBm9+XPD
	A5OeiHoud4waccrX/bqDeO5E1jCKzvXGzs9uTUMUAyLs/85hK/XGbNKhWlydthM=
X-Google-Smtp-Source: AGHT+IHJjOmbGv3nMlY5xA5nReKwCC+9X/1gT2v0Ln7U8fmaF5LI6r20bPQGA8L6C0NsTtIhJ5COlQ==
X-Received: by 2002:a05:6a00:1944:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-70aaad2c0f3mr11867186b3a.5.1719923390615;
        Tue, 02 Jul 2024 05:29:50 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8374995b3a.163.2024.07.02.05.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:29:49 -0700 (PDT)
Message-ID: <20375364-9147-4079-9f25-8ed8d9ebc057@bytedance.com>
Date: Tue, 2 Jul 2024 20:29:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 5/9] cachefiles: stop sending new request
 when dropping object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-6-libaokun@huaweicloud.com>
In-Reply-To: <20240628062930.2467993-6-libaokun@huaweicloud.com>
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
> Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
> object is being dropped, and is set after the close request for the dropped
> object completes, and no new requests are allowed to be sent after this
> state.
> 
> This prepares for the later addition of cancel_work_sync(). It prevents
> leftover reopen requests from being sent, to avoid processing unnecessary
> requests and to avoid cancel_work_sync() blocking by waiting for daemon to
> complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  2 ++
>   fs/cachefiles/ondemand.c | 10 ++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 6845a90cdfcc..a1a1d25e9514 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -48,6 +48,7 @@ enum cachefiles_object_state {
>   	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
>   	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
>   	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
> +	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
>   };
>   
>   struct cachefiles_ondemand_info {
> @@ -335,6 +336,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>   CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
>   CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
>   CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
> +CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
>   
>   static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
>   {
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bce005f2b456..8a3b52c3ebba 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -517,7 +517,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		 */
>   		xas_lock(&xas);
>   
> -		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
> +		    cachefiles_ondemand_object_is_dropping(object)) {
>   			xas_unlock(&xas);
>   			ret = -EIO;
>   			goto out;
> @@ -568,7 +569,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   	 * If error occurs after creating the anonymous fd,
>   	 * cachefiles_ondemand_fd_release() will set object to close.
>   	 */
> -	if (opcode == CACHEFILES_OP_OPEN)
> +	if (opcode == CACHEFILES_OP_OPEN &&
> +	    !cachefiles_ondemand_object_is_dropping(object))
>   		cachefiles_ondemand_set_object_close(object);
>   	kfree(req);
>   	return ret;
> @@ -667,8 +669,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	if (!object->ondemand)
> +		return;
> +
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +	cachefiles_ondemand_set_object_dropping(object);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
