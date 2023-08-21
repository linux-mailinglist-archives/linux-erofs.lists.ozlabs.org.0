Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21D782311
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 07:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1692594697;
	bh=UCEokYW1ggLoMOverOChIRKDlGVyOygY3QXKhy1wG6M=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=jARqdkVvMRL6EG3GU9HGGg4vtvLcGA9qqVzxKKLq7yMZgyCEzn+lZYzViU0/XDAd6
	 COQ151+AaUl6E7YxbtA8l+N7uiaHmtdlQyG0khA2tJEeMQ2APkOxlXRYJREqNLu4CA
	 rPTAdWyXESpI/zp+SBvXNz2UXkTWQNXpUG2jo+2+YQKfHkVzVtJgk0vZIBPxduKnX1
	 dmDqeezHltUEcrh6WMRsvbutdQ3dBeb6qIaI79ag/aFJpqclns6gXHfHGhMrGdtNSj
	 g5pBqQN8vZZeBmlWD05GhF5b9pmvdsYeDnc0nW0pOOREhN93rMSA6+dMj7HpwifhJZ
	 pVPTiPab1mBsA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTgZ06vXqz30Nr
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 15:11:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=guoxuenan@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RTgYw1ZWZz2yKy
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Aug 2023 15:11:29 +1000 (AEST)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTgVD6LMQzLp7D;
	Mon, 21 Aug 2023 13:08:20 +0800 (CST)
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 13:11:23 +0800
Message-ID: <3c645595-e612-f6a2-f301-4bc28f845a6d@huawei.com>
Date: Mon, 21 Aug 2023 13:11:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] erofs-utils: mkfs: introduce multi-thread compression
To: <linux-erofs@lists.ozlabs.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20230819180104.4824-1-zhaoyifan@sjtu.edu.cn>
 <8e890c0d-bddb-139d-def0-9e5fac977d37@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <8e890c0d-bddb-139d-def0-9e5fac977d37@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.238]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi，Xiang

Is there a develop branch for multi-thread compression，
then we can work together to make it better.

Thanks
Xuenan
On 2023/8/20 2:41, Gao Xiang wrote:
> Hi Yifan,
>
> On 2023/8/20 02:01, Yifan Zhao wrote:
>> This patch introduce multi-thread compression to accelerate image
>> packaging.
>> ---
>> Hi all:
>>
>> This is a very imperfect patch not ready for merging, and any 
>> suggestions would be appreciated!
>> If it's on track, I'd like to follow up on that.
>>
>> The inefficiency of EROFS compressed image creation is a much 
>> criticized problem,
>> and this patch attempts to address by creating multiple threads
>> to run the compression algorithm in parallel.
>
> Many thanks if you could have time following on that.
>
> Yet due to the release process timing, erofs-utils 1.7 will be released
> in about a month, so I think multithreaded support will be supported as
> part of erofs-utils v1.8.
>
>>
>> Specifically, each input file over 16MB is split into segments,
>> and each thread compresses a segment as if it were a separate file.
>> Finally, the main thread merges all the compressed segments into one 
>> file.
>> This process does not involve any data contention.
>>
>> Current issues:
>> 1.    For each large file, we create and destroy a batch of worker 
>> threads, causing unnecessary overhead.
>>     Moreover, each worker thread's context is a global variable, 
>> making the binary bigger.
>>     In the future, we can pre-create worker threads when the program 
>> starts running.
>>     Worker threads serve as consumers and the main thread that makes 
>> the compression request is the producer.
>
> I'd suggest if we could use (or enhance?)
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=e5b83309b199966cc757cb095d1ff1ebd0923b3e 
>
>
> as a start?
>
>> 2.    Fragment/Dedupe together with other advanced features are not 
>> fully tested
>>     due to my poor knowledge of the compression process. Not sure if 
>> they work well with multithreading.
>
> I have a preliminary design of Fragment/Dedupe, we could talk more 
> details
> later if you'd like to take more time on this, thanks! ;)
>
>> 3.    There is a lot of code redundancy between the
>>     erofs_write_compressed_file() and 
>> erofs_write_compressed_file_single() functions.
>>     I don't want to break the original single-threaded execution logic,
>>     but erofs_write_compressed_file() has a high complexity and
>>     my failed attempt to merge the two functions makes the matter worse.
>>     I'm not sure if we should merge them together or keep two 
>> different function entries for single and multi-threaded compression.
> I think we need to merge these finally.
>
>>
>> Performance:
>>     Despite the naive patch, we still see performance gain due to the 
>> poor baseline performance especially for lz4hc.
>>     1. Packing time of an Arch linux container image [1] provided by 
>> @wszqkzqk [2].
>>         lz4  : 8s(multi-thread) v.s. 10s(single-thread)
>>         lz4hc: 48s(multi-thread) v.s. 54s(single-thread)
>>     2. Packint time of Linux v6.4 git repository (with several ~GB 
>> git object files).
>>         lz4  : 14s(multi-thread) v.s. 23s(single-thread)
>>         lz4hc: 49s(multi-thread) v.s. 212s(single-thread)
>
> That is reasonable anyway, but in order to make multi-threaded support
> better, some code needs to be refactored first.
>
> Actually I'm have some cleanup patches to prepare for multithreaded
> support on hand, but I will apply these after 1.7 is released, again.
>
>>
>> BTW, is there any format file (e.g., .clang-format) available for me 
>> to format erofs-utils project?
>
> Not yet, erofs-utils follows Linux kernel coding style, would you mind
> submit a patch for this?
>
> Thanks,
> Gao Xiang
>
-- 
Guo Xuenan [OS Kernel Lab]
-----------------------------
Email: guoxuenan@huawei.com

