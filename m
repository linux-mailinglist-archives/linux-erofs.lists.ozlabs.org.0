Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FA820971
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 02:09:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T2gxq6Fb3z3cLL
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Dec 2023 12:09:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T2gxd2mhMz2xcw
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Dec 2023 12:09:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzVfoQr_1703984955;
Received: from 192.168.70.84(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzVfoQr_1703984955)
          by smtp.aliyun-inc.com;
          Sun, 31 Dec 2023 09:09:17 +0800
Message-ID: <d40f429a-0e8e-4e03-97c7-b260bf827530@linux.alibaba.com>
Date: Sun, 31 Dec 2023 09:09:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add a global page pool for lz4 decompression
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <96632ab5-3748-4512-aeae-2e931ff14674@linux.alibaba.com>
 <20231229044833.2026565-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231229044833.2026565-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/29 12:48, Chunhai Guo wrote:
>> Hi Chunhai,
>>
>> On 2023/12/28 21:00, Chunhai Guo wrote:
>>> Using a global page pool for LZ4 decompression significantly reduces
>>> the time spent on page allocation in low memory scenarios.
>>>
>>> The table below shows the reduction in time spent on page allocation
>>> for
>>> LZ4 decompression when using a global page pool.
>>> The results were obtained from multi-app launch benchmarks on ARM64
>>> Android devices running the 5.15 kernel.
>>> +--------------+---------------+--------------+---------+
>>> |              | w/o page pool | w/ page pool |  diff   |
>>> +--------------+---------------+--------------+---------+
>>> | Average (ms) |     3434      |      21      | -99.38% |
>>> +--------------+---------------+--------------+---------+
>>>
>>> Based on the benchmark logs, it appears that 256 pages are sufficient
>>> for most cases, but this can be adjusted as needed. Additionally,
>>> turning on CONFIG_EROFS_FS_DEBUG will simplify the tuning process.
>>
>> Thanks for the patch. I have some questions:
>>    - what pcluster sizes are you using? 4k or more?
> We currently use a 4k pcluster size.
> 
>>    - what the detailed configuration are you using for the multi-app
>>      launch workload? Such as CPU / Memory / the number of apps.
> 
> We ran the benchmark on Android devices with the following configuration.
> In the benchmark, we launched 16 frequently-used apps, and the camera app
> was the last one in each round. The results in the table above were
> obtained from the launching process of the camera app.
> 	CPU: 8 cores
> 	Memory: 8GB

It's the accumulated time of camera app for all rounds or the average
time of camera app for each round?

> 
>>>
>>> This patch currently only supports the LZ4 decompressor, other
>>> decompressors will be supported in the next step.
>>>
>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>>> ---
>>>    fs/erofs/compress.h     |   1 +
>>>    fs/erofs/decompressor.c |  42 ++++++++++++--
>>>    fs/erofs/internal.h     |   5 ++
>>>    fs/erofs/super.c        |   1 +
>>>    fs/erofs/utils.c        | 121 ++++++++++++++++++++++++++++++++++++++++
>>>    5 files changed, 165 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h index
>>> 279933e007d2..67202b97d47b 100644
>>> --- a/fs/erofs/compress.h
>>> +++ b/fs/erofs/compress.h
>>> @@ -31,6 +31,7 @@ struct z_erofs_decompressor {
>>>    /* some special page->private (unsigned long, see below) */
>>>    #define Z_EROFS_SHORTLIVED_PAGE             (-1UL << 2)
>>>    #define Z_EROFS_PREALLOCATED_PAGE   (-2UL << 2)
>>> +#define Z_EROFS_POOL_PAGE            (-3UL << 2)
>>>
>>>    /*
>>>     * For all pages in a pcluster, page->private should be one of diff
>>> --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index
>>> d08a6ee23ac5..41b34f01416f 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -54,6 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
>>>        sbi->lz4.max_distance_pages = distance ?
>>>                                        DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
>>>                                        LZ4_MAX_DISTANCE_PAGES;
>>> +     erofs_global_page_pool_init();
>>>        return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
>>>    }
>>>
>>> @@ -111,15 +112,42 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>>>                        victim = availables[--top];
>>>                        get_page(victim);
>>>                } else {
>>> -                     victim = erofs_allocpage(pagepool,
>>> +                     victim = erofs_allocpage_for_decmpr(pagepool,
>>>                                                 GFP_KERNEL |
>>> __GFP_NOFAIL);
>>
>> For each read request, the extreme case here will be 15 pages for 64k LZ4 sliding window (60k = 64k-4k). You could reduce
>> LZ4 sliding window to save more pages with slight compression ratio loss.
> 
> OK, we will do the test on this. However, based on the data we have, 97% of
> the compressed pages that have been read can be decompressed to less than 4
> pages. Therefore, we may not put too much hope on this.

Yes, but I'm not sure if just 3% of compressed data denodes the majority of
latencies.  It'd be better to try it out anyway.

> 
>>
>> Or, here __GFP_NOFAIL is actually unnecessary since we could bail out this if allocation failed for all readahead requests
>> and only address __read requests__.   I have some plan to do
>> this but it's too close to the next merge window.  So I was once to work this out for Linux 6.9.
> 
> This sounds great. It is more likely another optimization related to this
> case.
> 
>>
>> Anyway, I'm not saying mempool is not a good idea, but I tend to reserve memory as less as possible if there are some other way to mitigate the same workload since reserving memory is not free (which means 1 MiB memory will be only used for this.) Even we will do a mempool, I wonder if we could unify pcpubuf and mempool together to make a better pool.
> 
> I totally agree with your opinion. We use 256 pages for the worst-case
> scenario, and 1 MiB is acceptable in 8GB devices. However, for 95% of
> scenarios, 64 pages are sufficient and more acceptable for other devices.
> And you are right, I will create a patch to unify the pcpubuf and mempool
> in the next step.

Anyway, if a global mempool is really needed.  I'd like to add
some new sysfs interface to change this value (by default, 0).
Also you could reuse some of shortlived interfaces for global
pool rather than introduce another type of pages.

Thanks,
Gao Xiang
