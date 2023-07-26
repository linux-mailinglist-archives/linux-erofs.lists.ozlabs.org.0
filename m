Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3E7631DF
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690363522;
	bh=ajWZi1kTG9ZsFll3P13XRfH/M90QTcK5ZSE2yNZ8xrc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AbHZs2XvtC7iW0x44dKcxNEZu0s9Ty9f0omJyl/WA0cNfchq7gDZziMLYeKwflk5A
	 YVuM8dP5OEVm+zLewyxV1/+LJ9lM7LQW+uMeilGskXPiv4bsEZiWQKX27c1RBpppAm
	 s9ESvixQ8ba56OKCnuFNOVNZJoqNnJF5JR+/4TQYydiVa1GMxNPUk/9HQdzdHzUVVJ
	 4EApH4uwBIjgSFZ+S0a5AkwR+6HvSGu/ZQh2qqmf2jWXwtAflHkINpF/itsVMZcGWx
	 fP/LCxFE3TebPSEWXm1MI2dJSD+KsRS289kZnywS9NTF8hCZBedts2W72jwQ3PuSGf
	 nQK4dwfLEcwiQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9pQp18fjz3byv
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 19:25:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FbQ/cU5K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9pQg5zkXz30N3
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 19:25:14 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so1488065b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363511; x=1690968311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajWZi1kTG9ZsFll3P13XRfH/M90QTcK5ZSE2yNZ8xrc=;
        b=UUjlLDXX2XG18+QmJ5JOkcgOS9PkrYZEbFP3HfxLnK3WK00VK8wf0sVDyhpIJt/uug
         RpUk7zbQdRWJK/mXFYQpw56YRAyg9nSE+RK7QRVIgiDksqe5OmcDx1UbiJMZyXdwAScn
         hOavue2dZFpF9cmL7mdnNgSRWV2ChxIzKJzADy8JkjA0r78+7DycSWQpHCxE4nBVbiYK
         lyCIk5eA+7QV7IW67x8dOSSAWR6nWVMXDFlf3gqOI37VqfnvVDCarBMk/J0LMo8PBYgI
         FxZN23DYvt9wh25VA+pimADpLz8VgBVyIh5NktPVJUOKEYxE1lUGhrapyqLOZ/hB+VUy
         Lm+g==
X-Gm-Message-State: ABy/qLbgn1FNGZtXfJPmZ7WxMCvOw/EN7SsxG9sxwHORifegOY7UgHlK
	p7XtQysTw3fRrkpZumUbGHTEgg==
X-Google-Smtp-Source: APBJJlH7Lt4w+KKgSvUzSkJhF0oF8+b3ljHzveqc3Noqsk7KflIEw6xDKQ/sXRTNdo5n0Hc+oIf56w==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr1785615pzk.2.1690363511718;
        Wed, 26 Jul 2023 02:25:11 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b00682a99b01basm2004283pfo.0.2023.07.26.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:25:11 -0700 (PDT)
Message-ID: <491f5c8f-ccc6-dab8-71b3-caeedc8c4b39@bytedance.com>
Date: Wed, 26 Jul 2023 17:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/47] rcu: dynamically allocate the rcu-lazy shrinker
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-18-zhengqi.arch@bytedance.com>
 <3A164818-56E1-4EB4-A927-1B2D23B81659@linux.dev>
In-Reply-To: <3A164818-56E1-4EB4-A927-1B2D23B81659@linux.dev>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, Vlastimil Babka <vbabka@suse.cz>, linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@
 ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/26 15:04, Muchun Song wrote:
> 
> 
>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Use new APIs to dynamically allocate the rcu-lazy shrinker.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> kernel/rcu/tree_nocb.h | 19 +++++++++++--------
>> 1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 43229d2b0c44..919f17561733 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1397,12 +1397,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>> return count ? count : SHRINK_STOP;
>> }
>>
>> -static struct shrinker lazy_rcu_shrinker = {
>> -	.count_objects = lazy_rcu_shrink_count,
>> -	.scan_objects = lazy_rcu_shrink_scan,
>> -	.batch = 0,
>> -	.seeks = DEFAULT_SEEKS,
>> -};
>> +static struct shrinker *lazy_rcu_shrinker;
> 
> Seems there is no users of this variable, maybe we could drop
> this.

Yeah, will change it to a local variable. And the patch #15 is
the same.

> 
