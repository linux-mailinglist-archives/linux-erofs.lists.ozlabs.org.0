Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B97486E2735
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 17:45:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyglC0dkGz3fVQ
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 01:45:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681487143;
	bh=7gutJ4yAe/JkNa5xIKaFp+nwMYRP6dEdLjl9hZY/uZI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ka+HskaG2vTZiZsLoeMUxP44jT3cP9oRFIyYfGhpQsx/pwTPrCeKere73RjjiIFaK
	 O/8XG9fm3sfGV5ziwCMI05gXhaL/iG2lZgaT1kwIMS2zz8p0j7IVon/CrlmiKElOFh
	 ofcZCGeqtNWKdsb7B/LlDbyvYayzFa3TumwcVQ7ZbY5oick85m1y6Tbtw7eMcSyqrH
	 wD2xvZ5QMiUc7//W6FYo2gFEl0Iad0HmvLGEWie+d29YPxFTs988kTJDlBFgjHT8JD
	 7Tp36F8F3JqkriFgu5SfNV1REe/WP3cpeuElJ6CaYpzAo0OZZ8f0qM60IY41BEGigh
	 davIl7YH/mPCw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PvGDFGLr;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pygl44d3rz3fR3
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 01:45:34 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so889813pjl.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 08:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487132; x=1684079132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gutJ4yAe/JkNa5xIKaFp+nwMYRP6dEdLjl9hZY/uZI=;
        b=SaYyjFt/M6soC+5gAgsQd2vTzFlnEVeOJnWX4EXceAtermiBpeJXsUhXTe2RtLQxKx
         CRRU04f5AXAnsTHtI5DaSLXa5DFHDyzX+iMzBPR13zFxKAEWX1OEspNd2GVxKLGTi3vZ
         71adU/ZQk7hQaX6v0pxCMdGI3GuuZecHEmmgbNWCFe6D1PzadtLhxJYDtjvU1IiePiWZ
         xL50+Nq2gl4lSKwUegUvrlNx1PXdWlPy+ozu/xJdmv4sXacOv02GVgxe+oJwq52ID2dw
         UavibLAoO356Ecbsbtmd6OyLjJ5Fe4WZx9aZv1/sKVE92sowmK7N/Bz8+ZnjqcDl2Ddt
         xIyg==
X-Gm-Message-State: AAQBX9ct+kjqrtAQDND3SN+6YA5xIR2BtPXiaeYHMlTCDFQLwhCF3z34
	VaUv/A13I03reYdxbsmlbJb1vA==
X-Google-Smtp-Source: AKy350Y7T+7xKTE2jnOyKS8B+OM1XJANTVOkZ6bFQpjwSG5ySowVYCk/VmCO7z52L/JBVLB93/WFng==
X-Received: by 2002:a17:902:e801:b0:1a6:4714:5cb2 with SMTP id u1-20020a170902e80100b001a647145cb2mr4074836plg.2.1681487131808;
        Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
Received: from [10.255.185.5] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm3201794plo.206.2023.04.14.08.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
Message-ID: <c310a5e7-e410-dbdb-cada-3eca82a9ceb0@bytedance.com>
Date: Fri, 14 Apr 2023 23:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH V5 2/5] cachefiles: extract ondemand info field from
 cachefiles_object
To: David Howells <dhowells@redhat.com>
References: <20230329140155.53272-3-zhujia.zj@bytedance.com>
 <20230329140155.53272-1-zhujia.zj@bytedance.com>
 <1250339.1681480291@warthog.procyon.org.uk>
In-Reply-To: <1250339.1681480291@warthog.procyon.org.uk>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/4/14 21:51, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>>   #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
>>   static inline bool								\
>>   cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
>>   {												\
>> -	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>> +	return object->ondemand->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>>   }												\
>>   												\
>>   static inline void								\
>>   cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>>   {												\
>> -	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>> +	object->ondemand->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>>   }
> 
> I wonder if those need barriers - smp_load_acquire() and smp_store_release().
> 
> David

There are three object states: OPEN, CLOSE, REOPENING.

Here is no logic in the code such like: A has to watching and waiting
for B's status change.

And so far I haven't constructed a scenario requires barrier pairs. Thus
I didn't add barriers here.

Jia
> 
