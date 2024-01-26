Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4583D30D
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 04:50:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tXVMVg0/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLkGx52MXz3cBH
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 14:50:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tXVMVg0/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLkGr1Kgdz30g2
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 14:49:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706240989; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oZ7ovobS0uzA7iH4QrwdJlcQz77R3YBpWwb4t3Q7YSs=;
	b=tXVMVg0/kTDGf+3/hEBSk2JgF4wTM7URQnBnWhoj2unHt+0jc/eoLk+G8EncWSJWGOUugCnHXXd9FSWxjNd6omRYXCYYDg4PXc/sRyNgWVDji+8Tb9gIFrsqtO2LRwvUC8BD4O1qlZJ/xcNfkR6eCFYPDM2kAvzDFH7C/WrTWFQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.MJdgi_1706240986;
Received: from 30.97.48.207(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.MJdgi_1706240986)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 11:49:47 +0800
Message-ID: <12768969-cea8-41c7-a9d7-fa3a3e6ca985@linux.alibaba.com>
Date: Fri, 26 Jan 2024 11:49:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: relaxed temporary buffers allocation on
 readahead
To: Chunhai Guo <guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
References: <20240120145551.1941483-1-guochunhai@vivo.com>
 <cd64ee05-e8b2-4cd0-93e5-6bf787774d1f@linux.alibaba.com>
 <0aae43b2-c37b-41c8-be3f-3ebf0bb3d052@vivo.com>
 <da8060aa-2ed4-404c-8f06-06e35a4f4d27@linux.alibaba.com>
 <cd6c4dcc-cdb9-4b38-9ef7-e953cdc47441@vivo.com>
 <66d22178-88fa-409f-a33b-bcaee905b0d0@vivo.com>
 <61c6c462-11cf-4e66-ab24-712e55f9cf19@linux.alibaba.com>
 <369dbe84-ae27-40f0-8945-fd06b7b628a4@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <369dbe84-ae27-40f0-8945-fd06b7b628a4@vivo.com>
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



On 2024/1/26 11:42, Chunhai Guo wrote:
> On 2024/1/26 10:47, Gao Xiang wrote:
>> [你通常不会收到来自 hsiangkao@linux.alibaba.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> On 2024/1/26 10:41, Chunhai Guo wrote:
>>> On 2024/1/22 15:42, Chunhai Guo wrote:
>>>> On 2024/1/22 12:37, Gao Xiang wrote:
>>>>> [你通常不会收到来自 hsiangkao@linux.alibaba.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>>>
>>>>> On 2024/1/22 11:49, Chunhai Guo wrote:
>>>>>> On 2024/1/22 10:07, Gao Xiang wrote:
>>>>>>> [你通常不会收到来自 hsiangkao@linux.alibaba.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>>>>>
>>>>>>> On 2024/1/20 22:55, Chunhai Guo wrote:
>>>>>>>> Even with inplace decompression, sometimes extra temporary buffers are
>>>>>>>> still needed for decompression.  In low-memory scenarios, it would be
>>>>>>>> better to try to allocate with GFP_NOWAIT on readahead first. That can
>>>>>>>> help reduce the time spent on page allocation under memory pressure.
>>>>>>>>
>>>>>>>> There is an average reduction of 21% in page allocation time under
>>>>>>> It would be better to add a table to show the absolute numbers too
>>>>>>> (like what you did in the global pool commit.)  If it's possible, there
>>>>>>> is no need to send a update version for this, just reply the updated
>>>>>>> commit message and I will update the commit manually.
>>>>>> The table below shows detailed numbers. The reduction I mentioned before
>>>>>> was not accurate enough. Please help correct the improvement from 21% to
>>>>>> 20.21%.
>>>>>>
>>>>>>
>>>>>> +--------------+----------------+---------------+---------+
>>>>>> |              | w/o GFP_NOWAIT | w/ GFP_NOWAIT |  diff   |
>>>>>> +--------------+----------------+---------------+---------+
>>>>>> | Average (ms) |     3364       |      2684     | -20.21% |
>>>>>> +--------------+----------------+---------------+---------+
>>>>> Did it test without the 16k sliding window change?
>>>>> https://lore.kernel.org/linux-erofs/69711d55-f7a2-420b-9ba8-fa2921f66a4c@vivo.com
>>>> The result is tested with 64k sliding window change.
>>>>
>>>>> Could you benchmark these two optimizations together to
>>>>> show the extreme optimized case without a global pool?
>>>>> With a new table if possible? I will add this to
>>>>> the commit message too.
>>>> OK. I will reply to this email when the benchmark is finished.
>>> The benchmark has been completed and the table below shows that there is
>>> an average 52.14% reduction in page allocation time with these two
>>> optimizations.
>>>
>>> +--------------+----------------+---------------+---------+ | | 64k
>>> window | 16k window | | | | w/o GFP_NOWAIT | w/ GFP_NOWAIT | diff |
>>> +--------------+----------------+---------------+---------+ | Average
>>> (ms) | 3364 | 1610 | -52.14% |
>>> +--------------+----------------+---------------+---------+
>>>
>>> Table below summarizes the results of these three benchmarks.
>>>
>>> +--------------+----------------+----------------+---------------+---------------+
>>> |              |   64k window   |   16k window   |   64k window  | 16k
>>> window  |
>>> |              | w/o GFP_NOWAIT | w/o GFP_NOWAIT | w/ GFP_NOWAIT | w/
>>> GFP_NOWAIT |
>>> +--------------+----------------+----------------+---------------+---------------+
>>> | Average (ms) |     3364       |      2079      |      2684 |
>>> 1610     |
>>> +--------------+----------------+----------------+---------------+---------------+
>>> |     diff     |                |     -38.19%    |     -20.81% |
>>> -52.14%   |
>>> +--------------+----------------+----------------+---------------+---------------+
>>
>> The tables shows in a mess, could you just list the
>> numbers so I could refine this?
> 
> Sorry that there might be some issues with my email client. Here are the
> numerical results below.
>       64k window w/o GFP_NOWAIT : 3364
>       16k window w/o GFP_NOWAIT : 2079, diff: -38.19%
>       64k window w/  GFP_NOWAIT : 2684, diff: -20.81%
>       16k window w/  GFP_NOWAIT : 1610, diff: -52.14%
> 
> Images size comparision:
>       64k: 9117044 KB
>       16k: 9113096 KB

That is with 4k pcluster, yes?  I guess the overall image size
won't have great impacts, but it seems even getting smaller. :-)

I think this optimization would be helpful to everyone without
any extra memory reservation (which will be good too for much
much low-ended devices), let me revise the commit for formal
submission..

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
> 
> 
