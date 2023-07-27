Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1576513E
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 12:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690453955;
	bh=4VsKgOIlO7JTMbURB3u+V7Qr/QzOpc+0Bt56AjhAYAM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oxhQCMT+NSHT4y/fwO9stHkZ3Y0e6Ona1FMVoAMCx2cbsgqX1r33FpGYxOTnO35OQ
	 CeYR1byaUeU1dF1kTF7FJ4f6H2Vi/crqsbyOLAvdJt/yIkr+MPhdkM81jpZE7KLTnK
	 ZusHo50aTeOKG1bMnqWVLHsFt1bhlK+ucwhyPZ9RjshVTAv2UBpiuvDAKFp5ailIYu
	 M+5MZ0fSoeRQNIiXBkUFD1x2uk7j0Lvy05jy5/DAICrxjfEg34ZEbmuY5R1qy+n77+
	 CRZZ3aQyjrJ9aFpcodnBxuH6q8prAWpfgLwbMVuGomN9qQCdoszT3yor01ygpf/xrD
	 HevRQqjemQD5w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBRsv3pRhz3cK4
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 20:32:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lto/iWnI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBRsp2jqSz3cCr
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 20:32:28 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2680edb9767so163342a91.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 03:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453946; x=1691058746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VsKgOIlO7JTMbURB3u+V7Qr/QzOpc+0Bt56AjhAYAM=;
        b=UUVbGjTtDv4tO/G0CKHXiYUOZXLBPzo9HMCA5YtXznDyOe8l3+6/72z9Z9Gj2T4uw8
         FM07LQrZwjLGyTr9wJ3gYRHKN9LBPvp6ncBAToKms65FGUnskXdcVGcpL8DnUZ1Bl39T
         amRKWyr0v6REnrNiHj8rfOP9fwFcecAgJWZ0hUpZFanROfXyqO13bVzBXNtq6fdhJa7G
         VhrF9Mww1HYsuJY0fRjYc/hBW8u5EZwBkidAXdcK1+wM7EMgsv+JqalqPIe/mGSl2Ddq
         MA/Ernwso1HRNV8j0JmJuxhpQ6kz6/jAn8ljeCD9JkbGmOiS1A6erivEhY6U4thYUwI6
         ArZw==
X-Gm-Message-State: ABy/qLYTQ0K5sd/rYWgqKSpd0UuvA+Ww0M9u1cTtQNcL0+3aOhJRKpPu
	IfStZkUnBrzIVjee3vrmPa+8DQ==
X-Google-Smtp-Source: APBJJlGmzPZn88CMJAqpsojyTb97uikW28yo5O3pi8rH8SDlSH8BwjASuoOudfeGFyxgCSRxAf0mLA==
X-Received: by 2002:a17:90a:1b06:b0:263:2312:60c2 with SMTP id q6-20020a17090a1b0600b00263231260c2mr4299433pjq.3.1690453945653;
        Thu, 27 Jul 2023 03:32:25 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b0026309d57724sm2755058pjc.39.2023.07.27.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:32:25 -0700 (PDT)
Message-ID: <cc819e13-cb25-ddaa-e0e3-7328f5ea3a4f@bytedance.com>
Date: Thu, 27 Jul 2023 18:32:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
 <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
In-Reply-To: <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, brauner@kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu, netdev@vger.kernel.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/27 18:20, Damien Le Moal wrote:
> On 7/27/23 17:55, Qi Zheng wrote:
>>>>            goto err;
>>>>        }
>>>>    +    zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
>>>> +    zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
>>>> +    zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
>>>> +    zmd->mblk_shrinker->private_data = zmd;
>>>> +
>>>> +    shrinker_register(zmd->mblk_shrinker);
>>>
>>> I fail to see how this new shrinker API is better... Why isn't there a
>>> shrinker_alloc_and_register() function ? That would avoid adding all this code
>>> all over the place as the new API call would be very similar to the current
>>> shrinker_register() call with static allocation.
>>
>> In some registration scenarios, memory needs to be allocated in advance.
>> So we continue to use the previous prealloc/register_prepared()
>> algorithm. The shrinker_alloc_and_register() is just a helper function
>> that combines the two, and this increases the number of APIs that
>> shrinker exposes to the outside, so I choose not to add this helper.
> 
> And that results in more code in many places instead of less code + a simple
> inline helper in the shrinker header file... So not adding that super simple

It also needs to be exported to the driver for use.

> helper is not exactly the best choice in my opinion.

Hm, either one is fine for me. If no one else objects, I can add this
helper. ;)

> 
