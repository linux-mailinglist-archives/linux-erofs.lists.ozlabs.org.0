Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA92835A1B
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 05:41:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJHc93FPdz3bnv
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 15:41:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJHc56K5Pz309c
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 15:41:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.0b9Nb_1705898477;
Received: from 30.97.48.216(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.0b9Nb_1705898477)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 12:41:18 +0800
Message-ID: <df584384-b672-4434-8d10-e488b0d91a69@linux.alibaba.com>
Date: Mon, 22 Jan 2024 12:41:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: add a global page pool for lz4 decompression
To: Chunhai Guo <guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
References: <20240109074143.4138783-1-guochunhai@vivo.com>
 <d8a104d4-1a58-423a-ba12-ea82d622de48@linux.alibaba.com>
 <a5c5acb5-2ad1-41e1-8b86-344394baacbf@vivo.com>
 <69711d55-f7a2-420b-9ba8-fa2921f66a4c@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <69711d55-f7a2-420b-9ba8-fa2921f66a4c@vivo.com>
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2024/1/12 09:58, Chunhai Guo wrote:
> On 2024/1/10 14:45, Chunhai Guo wrote:
>> On 2024/1/9 21:08, Gao Xiang wrote:
>>> [你通常不会收到来自 hsiangkao@linux.alibaba.com 的电子邮件。请访问
>>> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>
>>> Hi Chunhai,
>>>
>>> On 2024/1/9 15:41, Chunhai Guo wrote:
>>>> Using a global page pool for LZ4 decompression significantly reduces
>>>> the
>>>> time spent on page allocation in low memory scenarios.
>>>>
>>>> The table below shows the reduction in time spent on page allocation
>>>> for
>>>> LZ4 decompression when using a global page pool.  The results were
>>>> obtained from multi-app launch benchmarks on ARM64 Android devices
>>>> running the 5.15 kernel with an 8-core CPU and 8GB of memory. In the
>>>> benchmark, we launched 16 frequently-used apps, and the camera app was
>>>> the last one in each round. The data in the table is the average
>>>> time of
>>>> camera app for each round.
>>>> After using the page pool, there was an average improvement of 150ms in
>>>> the launch time of the camera app, which was obtained from systrace
>>>> log.
>>>> +--------------+---------------+--------------+---------+
>>>> |              | w/o page pool | w/ page pool |  diff   |
>>>> +--------------+---------------+--------------+---------+
>>>> | Average (ms) |     3434      |      21      | -99.38% |
>>>> +--------------+---------------+--------------+---------+
>>>>
>>>> Based on the benchmark logs, 64 pages are sufficient for 95% of
>>>> scenarios. This value can be adjusted from the module parameter. The
>>>> default value is 0.
>>>>
>>>> This patch currently only supports the LZ4 decompressor, other
>>>> decompressors will be supported in the next step.
>>>>
>>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>>>
>>> This patch looks good to me, yet we're in the merge window for v6.8.
>>> I will address it after -rc1 is out since no stable tag these days.
>>>
>>> Also it would be better to add some results of changing max_distance
>>> if you have more time to test.
>>
>> OK. I will reply to this email when the experiment is finished.
> 
> Dear Xiang,
> 
> The experiment is done and table below shows the results. We can find
> that a 16k sliding window reduces 38.2% of time used in page allocation
> for LZ4 decompression compared to a 64k sliding window. However, using a
> global page pool is still far better than both of them.
> 
> +--------------+---------------+--------------+---------+
> |              |   64k window  |  16k window  |  diff   |
> +--------------+---------------+--------------+---------+
> | Average (ms) |     3364      |      2079    | -38.2%  |
> +--------------+---------------+--------------+---------+
> 
> Thanks,

Let's rebase this onto
commit ("erofs: relaxed temporary buffers allocation on readahead")

I will merge these after the rebase patch is received.

Thanks,
Gao Xiang
