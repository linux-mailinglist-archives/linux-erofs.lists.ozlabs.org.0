Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D96A0FC6
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 19:53:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PN2GV1DDPz3cct
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Feb 2023 05:53:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PN2GR2d39z3bhD
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Feb 2023 05:53:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcLG3xX_1677178375;
Received: from 30.25.216.19(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcLG3xX_1677178375)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 02:52:57 +0800
Message-ID: <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
Date: Fri, 24 Feb 2023 02:52:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
To: Eric Biggers <ebiggers@kernel.org>
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/ewpGQkpWvOf7qh@gmail.com>
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
Cc: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>, Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Eric,

On 2023/2/24 02:29, Eric Biggers wrote:
> Hi,
> 
> On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
>> From: Sandeep Dhavale <dhavale@google.com>
>>
>> Using per-cpu thread pool we can reduce the scheduling latency compared
>> to workqueue implementation. With this patch scheduling latency and
>> variation is reduced as per-cpu threads are high priority kthread_workers.
>>
>> The results were evaluated on arm64 Android devices running 5.10 kernel.
> 
> I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
> ("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.
> 
> Why is this more complex solution better than simply removing WQ_UNBOUND?

I do think it's a specific issue on specific arm64 hardwares (assuming
qualcomm, I don't know) since WQ_UNBOUND decompression once worked well
on the hardwares I once used (I meant Hisilicon, and most x86_64 CPUs,
I tested at that time) compared with per-cpu workqueue.

Also RT threads are also matchable with softirq approach.  In addition,
many configurations work without dm-verity.

I don't have more time to dig into it for now but it's important to
resolve this problem on some arm64 hardwares first.  Also it's an
optional stuff, if the root cause of workqueue issue can be resolved,
we could consider drop it then.

Thsnka,
Gao Xiang

> 
> - Eric
