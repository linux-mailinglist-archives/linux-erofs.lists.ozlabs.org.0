Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16E781AC7
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Aug 2023 20:41:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RSndT5f6xz2yW5
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Aug 2023 04:41:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RSndP3XNGz2yW5
	for <linux-erofs@lists.ozlabs.org>; Sun, 20 Aug 2023 04:41:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vq61yFt_1692470478;
Received: from 192.168.2.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vq61yFt_1692470478)
          by smtp.aliyun-inc.com;
          Sun, 20 Aug 2023 02:41:20 +0800
Message-ID: <8e890c0d-bddb-139d-def0-9e5fac977d37@linux.alibaba.com>
Date: Sun, 20 Aug 2023 02:41:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] erofs-utils: mkfs: introduce multi-thread compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230819180104.4824-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230819180104.4824-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yifan,

On 2023/8/20 02:01, Yifan Zhao wrote:
> This patch introduce multi-thread compression to accelerate image
> packaging.
> ---
> Hi all:
> 
> This is a very imperfect patch not ready for merging, and any suggestions would be appreciated!
> If it's on track, I'd like to follow up on that.
> 
> The inefficiency of EROFS compressed image creation is a much criticized problem,
> and this patch attempts to address by creating multiple threads
> to run the compression algorithm in parallel.

Many thanks if you could have time following on that.

Yet due to the release process timing, erofs-utils 1.7 will be released
in about a month, so I think multithreaded support will be supported as
part of erofs-utils v1.8.

> 
> Specifically, each input file over 16MB is split into segments,
> and each thread compresses a segment as if it were a separate file.
> Finally, the main thread merges all the compressed segments into one file.
> This process does not involve any data contention.
> 
> Current issues:
> 1.	For each large file, we create and destroy a batch of worker threads, causing unnecessary overhead.
> 	Moreover, each worker thread's context is a global variable, making the binary bigger.
> 	In the future, we can pre-create worker threads when the program starts running.
> 	Worker threads serve as consumers and the main thread that makes the compression request is the producer.

I'd suggest if we could use (or enhance?)
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=e5b83309b199966cc757cb095d1ff1ebd0923b3e

as a start?

> 2.	Fragment/Dedupe together with other advanced features are not fully tested
> 	due to my poor knowledge of the compression process. Not sure if they work well with multithreading.

I have a preliminary design of Fragment/Dedupe, we could talk more details
later if you'd like to take more time on this, thanks! ;)

> 3.	There is a lot of code redundancy between the
> 	erofs_write_compressed_file() and erofs_write_compressed_file_single() functions.
> 	I don't want to break the original single-threaded execution logic,
> 	but erofs_write_compressed_file() has a high complexity and
> 	my failed attempt to merge the two functions makes the matter worse.
> 	I'm not sure if we should merge them together or keep two different function entries for single and multi-threaded compression.
I think we need to merge these finally.

> 
> Performance:
> 	Despite the naive patch, we still see performance gain due to the poor baseline performance especially for lz4hc.
> 	1. Packing time of an Arch linux container image [1] provided by @wszqkzqk [2].
> 		lz4  : 8s(multi-thread) v.s. 10s(single-thread)
> 		lz4hc: 48s(multi-thread) v.s. 54s(single-thread)
> 	2. Packint time of Linux v6.4 git repository (with several ~GB git object files).
> 		lz4  : 14s(multi-thread) v.s. 23s(single-thread)
> 		lz4hc: 49s(multi-thread) v.s. 212s(single-thread)

That is reasonable anyway, but in order to make multi-threaded support
better, some code needs to be refactored first.

Actually I'm have some cleanup patches to prepare for multithreaded
support on hand, but I will apply these after 1.7 is released, again.

> 
> BTW, is there any format file (e.g., .clang-format) available for me to format erofs-utils project?

Not yet, erofs-utils follows Linux kernel coding style, would you mind
submit a patch for this?

Thanks,
Gao Xiang
