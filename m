Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34796CD40C
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 10:09:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmfMj5PyMz3cf1
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 19:09:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680077345;
	bh=mVRpG2dAr/nWYNSNRqghl5EEZFHlwrwTvwCgPASuUmU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QoJcddZmf+keQeXKPP/tUvk7HoxRZ+uTm/WPT3OmsQFiogoq5nImZoceZZfFR6qwR
	 P6nPHCfDQagG2sMtFQ4Rg8DHGxznoCeTZDdlghvXeEVH2/94MM+p9NWGFiY9G9RK7M
	 qcej4dPLCZlTmdQAV46HcXgoCnpmB44Pwh0g+Ho5v9SzrCArxz5gr5fRc+VlY0+6IJ
	 AjB6luv8xzf9JOYazE3tRC7WRjldJKUaYvDDYBHmEwPQwXXGgjj59+XUM6KtUJqX5P
	 sLuCUu3vAxM77P+86faBbzB81RkCBlRkcEVhvk40LMkPBYy0Dw4Z2KP7YCsfmMootW
	 NeA6SybMHY60g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fjjwB2zF;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmfMZ5MNLz3cB8
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 19:08:57 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so13370199pjh.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 01:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVRpG2dAr/nWYNSNRqghl5EEZFHlwrwTvwCgPASuUmU=;
        b=tClLXIHG2U6uO12+2Sa6d81DfeyRhIAoNVEdY2AAXDeBQGj7oo4jYKVsrzkwjzm9l+
         PsSXgQedzl5y02mRYcgLxSwZylgcP9eZKS+qff89KY4/zEwwMx4DerkAKJRYg+zoL0CO
         1jz30e58kf9/i6zkAoQj4303gcZpwo4QxpwOIWoVPJONl0qicFK9F4cQjzj1dAt46XFH
         msXMmrZ38dvgKL8gjXpUyuc7w518Ob3tLtRGSssoBaZs1FkGvMalF3zGB1WW4Bm62kZY
         IFUsZpKLLQt9u+aooiiliBgdjplODX4En1mU60UUTZzDvikf26/lE7ABbdDOTGQktQB/
         CL6w==
X-Gm-Message-State: AAQBX9doua9TV5BVaOG7/KQFvr+/XvdN8lCK5OnUwoVd1IZkRcEK0OnI
	a7M7j2qpHCaKJlQrgXSCnRZ5sw==
X-Google-Smtp-Source: AKy350YkuPVOI4SkoYUmjVLLsU+g0OQwvsA0hoKkKc7WLUm0Sa5StE4Ydf+KVToEOuvk5LGwIcWN8g==
X-Received: by 2002:a17:90b:3ece:b0:23f:6edd:41da with SMTP id rm14-20020a17090b3ece00b0023f6edd41damr20304030pjb.29.1680077335048;
        Wed, 29 Mar 2023 01:08:55 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090ae38f00b002369e16b276sm859568pjz.32.2023.03.29.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:08:54 -0700 (PDT)
Message-ID: <2a39ced1-05f1-d696-1905-4ff5199fa41b@bytedance.com>
Date: Wed, 29 Mar 2023 16:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [External] Re: [PATCH V4 4/5] cachefiles: narrow the scope of
 triggering EPOLLIN events in ondemand mode
To: David Howells <dhowells@redhat.com>
References: <20230111052515.53941-5-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <133078.1680013145@warthog.procyon.org.uk>
In-Reply-To: <133078.1680013145@warthog.procyon.org.uk>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/3/28 22:19, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +		if (!xa_empty(xa)) {
>> +			xa_lock(xa);
>> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
>> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
>> +					mask |= EPOLLIN;
>> +					break;
>> +				}
>> +			}
>> +			xa_unlock(xa);
>> +		}
> 
> I wonder if there's a more efficient way to do this.  I guess it depends on
> how many reqs you expect to get in a queue.  It might be worth taking the
> rcu_read_lock before calling xa_lock() and holding it over the whole loop.
> 
Thanks for the advice, will use rcu_read_lock（unlock） to replace it.
> David
> 
