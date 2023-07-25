Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BFF76065E
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 05:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690254571;
	bh=ZLkcXzJjvvDBLgu5DbJbwRAKtejO8FK7VlKqBEYpGhg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z6QLFalHhv57hXYLRdptNw/Nui7xJ4QqOgcfN0R7U9WmNOlfa5042eEtnfVjw7lqo
	 RnGMs5s25M+Sp23WEQlRaU7Xj4GuqVZX+Emjba4rg4DJ3IjK6Fsqo2td6YvR2cFdMA
	 +fSk8i5IWWqKIrUzbAMVqEYyDZ0BLOhFaBJ/G8XcoiCABa65lnqJj9Rrq5QFtvYGR3
	 DH0ADv4nzXmg07rviNhcYeT/Z3DspArhXxR7GWYUlE3NTNNPCjsLjp+KzHsM6cDETi
	 1evqQaa5oD7Kg6hk516392ZX66nO7Dut3JRnbibKpSzd02QHh+2v4vGA+EcwpKLbTk
	 m+jzLAxPyEnVA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R927b52TXz30RS
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 13:09:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T37460kh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R927W51Mhz309q
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 13:09:26 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25e847bb482so707989a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 20:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690254562; x=1690859362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLkcXzJjvvDBLgu5DbJbwRAKtejO8FK7VlKqBEYpGhg=;
        b=MXrZUcg+inOsNEBdELSPbdon7SxOIs4d8mQSbyMtE3kMgEvMFlA09VNUZ6qpMF5fem
         4o/3wZBLdZBmHoQyW4w964kSOAen/jYXxQ7fTY7+kkizMv3uNcTganCZXphE/cf4DBqx
         TWAlE5gGhG77bCfeut5gSmXC9o0fKkabj5ufyMu2kx9leS6P59BKZpqDkMgLab78SI+C
         98q0qvWbwX3orfJwyQ0HD2f4Tbip5yFh/PkBRc1yCZ8OG78+kvqrGuOTWFidalenRD+Y
         A0wYNeDA07QL1+mh2Yasg4frBfB54l4M4OJ4MmRf6BkygQWFrUI47PHxuy6lqDGTCPRG
         j0Sg==
X-Gm-Message-State: ABy/qLaXs9k7M6DEvhKcvpl0TavHVEU588HHhEkINeLCPKziDVGJamq2
	HT4kFkDKDZi248nxOMjcKH5UGw==
X-Google-Smtp-Source: APBJJlEruF0WFFXXZAOwcLJKfTF/P8Yek4Wx/bwgxp4VRr2IRHJr9OEk7izXq54CPTEEiNehAqKYyg==
X-Received: by 2002:a17:90a:50f:b0:263:730b:f568 with SMTP id h15-20020a17090a050f00b00263730bf568mr10246975pjh.3.1690254562043;
        Mon, 24 Jul 2023 20:09:22 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a199500b002633fa95ac2sm9540001pji.13.2023.07.24.20.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 20:09:21 -0700 (PDT)
Message-ID: <d2621ad0-8b99-9154-5ff5-509dec2f32a3@bytedance.com>
Date: Tue, 25 Jul 2023 11:09:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/47] mm: vmscan: move shrinker-related code into a
 separate file
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-2-zhengqi.arch@bytedance.com>
 <97E80C37-8872-4C5A-A027-A0B35F39152A@linux.dev>
In-Reply-To: <97E80C37-8872-4C5A-A027-A0B35F39152A@linux.dev>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, Vlastimil Babka <vbabka@suse.cz>, linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, netdev <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foun
 dation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/25 10:35, Muchun Song wrote:
> 
> 
>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> The mm/vmscan.c file is too large, so separate the shrinker-related
>> code from it into a separate file. No functional changes.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> include/linux/shrinker.h |   3 +
>> mm/Makefile              |   4 +-
>> mm/shrinker.c            | 707 +++++++++++++++++++++++++++++++++++++++
>> mm/vmscan.c              | 701 --------------------------------------
>> 4 files changed, 712 insertions(+), 703 deletions(-)
>> create mode 100644 mm/shrinker.c
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 224293b2dd06..961cb84e51f5 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -96,6 +96,9 @@ struct shrinker {
>>   */
>> #define SHRINKER_NONSLAB (1 << 3)
>>
>> +unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>> +			   int priority);
> 
> A good cleanup, vmscan.c is so huge.
> 
> I'd like to introduce a new header in mm/ directory and contains those
> declarations of functions (like this and other debug function in
> shrinker_debug.c) since they are used internally across mm.

How about putting them in the mm/internal.h file?

> 
> Thanks.
> 
