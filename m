Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F786BFE6
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 05:34:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tlddw15M5z3cZB
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 15:33:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tlddn45wmz3bwJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 15:33:47 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 0CC741008EE04;
	Thu, 29 Feb 2024 12:33:43 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9BAA637C80D;
	Thu, 29 Feb 2024 12:33:40 +0800 (CST)
Message-ID: <a59dfa27-0961-472a-b7ed-57769123d430@sjtu.edu.cn>
Date: Thu, 29 Feb 2024 12:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] erofs-utils: mkfs: introduce multi-threaded
 compression
Content-Language: en-US
To: Noboru Asai <asai@sijam.com>
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
 <CAFoAo-+1crK3Oh7ftbWHk0WY7y-9=3ii3iX-W6anDvEfcgPJtg@mail.gmail.com>
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <CAFoAo-+1crK3Oh7ftbWHk0WY7y-9=3ii3iX-W6anDvEfcgPJtg@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2/29/24 11:12, Noboru Asai wrote:
>> - remove inter-file compression support from this patchset
> Do you have any problems about inter-file compression functionarity?
> Or make steps (split this functionarity as separate patch set)?
> I'm testing v1 patch set and I have no problem like making wrong images for now.
> (I couldn't apply v2 patch set without rejects.)
>
> 2024年2月25日(日) 23:28 Yifan Zhao <zhaoyifan@sjtu.edu.cn>:
>
We split the inter-file compression functionality as a separate patch 
set for ease of review. It will be re-sent shortly (maybe a few days) 
after we finish polishing the inner-file patch set.

I am sorry that the v2 patchset cannot be cleanly applied due to my 
missteps, and I believe the latest one (v4) works. Thank you for your 
testing!


Thanks,

Yifan Zhao

>> change log since v2:
>> - squash per-worker tmpfile commit into previous PATCH
>> - give static global variable `erofs_` prefix
>> - remove inter-file compression support from this patchset
>> - introduce a new `z_erofs_file_compress_ctx` struct to divide the segment
>>    context from the file context
>> - remove the patch related to pring warning from this patchset, which may be
>>    supported later with atomic variables
>>
>> Gao Xiang (1):
>>    erofs-utils: add a helper to get available processors
>>
>> Yifan Zhao (3):
>>    erofs-utils: introduce multi-threading framework
>>    erofs-utils: mkfs: add --worker=# parameter
>>    erofs-utils: mkfs: introduce inner-file multi-threaded compression
>>
>>   configure.ac              |  17 +
>>   include/erofs/compress.h  |   1 +
>>   include/erofs/config.h    |   5 +
>>   include/erofs/internal.h  |   3 +
>>   include/erofs/workqueue.h |  37 ++
>>   lib/Makefile.am           |   4 +
>>   lib/compress.c            | 690 +++++++++++++++++++++++++++++++-------
>>   lib/compressor.c          |   2 +
>>   lib/config.c              |  16 +
>>   lib/workqueue.c           | 132 ++++++++
>>   mkfs/main.c               |  38 +++
>>   11 files changed, 827 insertions(+), 118 deletions(-)
>>   create mode 100644 include/erofs/workqueue.h
>>   create mode 100644 lib/workqueue.c
>>
>> --
>> 2.44.0
>>
