Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5F484FBD
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 10:04:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JTNpq5gwBz2ylk
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 20:04:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JTNpk3KJzz2y7J
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 20:04:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V10Yc.y_1641373459; 
Received: from 30.225.24.102(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V10Yc.y_1641373459) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 05 Jan 2022 17:04:20 +0800
Message-ID: <9ab680eb-beb2-07eb-eab2-833fde48906d@linux.alibaba.com>
Date: Wed, 5 Jan 2022 17:04:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 07/23] erofs: add nodev mode
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
 gerry@linux.alibaba.com, eguan@linux.alibaba.com,
 linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-8-jefflexu@linux.alibaba.com>
 <YdRattisu+ITYvvZ@B-P7TQMD6M-0146.local>
 <YdRgrWEDU8sJVExX@B-P7TQMD6M-0146.local>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YdRgrWEDU8sJVExX@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/4/22 10:58 PM, Gao Xiang wrote:
> On Tue, Jan 04, 2022 at 10:33:26PM +0800, Gao Xiang wrote:
>> On Mon, Dec 27, 2021 at 08:54:28PM +0800, Jeffle Xu wrote:
>>> Until then erofs is exactly blockdev based filesystem. In other using
>>> scenarios (e.g. container image), erofs needs to run upon files.
>>>
>>> This patch introduces a new nodev mode, in which erofs could be mounted
>>> from a bootstrap blob file containing the complete erofs image.
>>>
>>> The following patch will introduce a new mount option "uuid", by which
>>> users could specify the bootstrap blob file.
>>>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>
>> I think the order of some patches in this patchset can be improved.
>>
>> Take this patch as an example. This patch introduces a new mount
>> option called "uuid", so the kernel will just accept it (which
>> generates a user-visible impact) after this patch but it doesn't
>> actually work.
>>
>> Therefore, we actually have three different behaviors here:
>>  - kernel doesn't support "uuid" mount option completely;
>>  - kernel support "uuid" but it doesn't work;
>>  - kernel support "uuid" correctly (maybe after some random patch);
>>
>> Actually that is bad for bisecting since there are some commits
>> having temporary behaviors. And we don't know which commit
>> actually fully implements this "uuid" mount option.
>>
>> So personally I think the proper order is just like the bottom-up
>> approach, and make sure each patch can be tested / bisected
>> independently.
> 
> Oh, I may misread this patch, but I still think we'd better to
> avoid dead paths "TODO" like this as much as possible.
> 
> Just do in the bottom-up way.
> 

OK, it is better to be put at the latter part of the whole patch set.
Would be fixed in the next version. Thanks.

-- 
Thanks,
Jeffle
