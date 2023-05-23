Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BE70D0B0
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 03:53:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQHQm6fD6z3cKj
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 11:53:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQHQd4rGpz3bgr
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 11:53:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjI-vRX_1684806786;
Received: from 30.97.48.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjI-vRX_1684806786)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 09:53:07 +0800
Message-ID: <3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
Date: Tue, 23 May 2023 09:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
To: Yue Hu <zbestahu@gmail.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
 <20230523085226.00006933.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230523085226.00006933.zbestahu@gmail.com>
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
Cc: zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/23 17:52, Yue Hu wrote:
> On Mon, 22 May 2023 17:21:41 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> As Sandeep shown [1], high priority RT per-cpu kthreads are
>> typically helpful for Android scenarios to minimize the scheduling
>> latencies.
>>
>> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
>> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
>> EROFS_FS_PCPU_KTHREAD.
>>
>> Also clean up unneeded sched_set_normal().
>>
>> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
>> Cc: Sandeep Dhavale <dhavale@google.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/Kconfig | 1 +
>>   fs/erofs/zdata.c | 2 --
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 704fb59577e0..f259d92c9720 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
>>   config EROFS_FS_PCPU_KTHREAD_HIPRI
>>   	bool "EROFS high priority per-CPU kthread workers"
>>   	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
>> +	default y
> 
> How about removing this config option?

I tend to leave it as is.

Thanks,
Gao Xiang
