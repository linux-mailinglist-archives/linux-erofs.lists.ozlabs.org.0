Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59556B253
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 07:42:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LfMby2LBYz3c3s
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 15:42:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LfMbr6GM4z3bs2
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 15:41:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIiBeZe_1657258907;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIiBeZe_1657258907)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 13:41:49 +0800
Date: Fri, 8 Jul 2022 13:41:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: guowei du <duguoweisz@gmail.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
Message-ID: <YsfDm5q9wIyewtWR@B-P7TQMD6M-0146.local>
References: <20220708031155.21878-1-duguoweisz@gmail.com>
 <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
 <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, duguowei <duguowei@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Fri, Jul 08, 2022 at 12:49:07PM +0800, guowei du wrote:
> hi,
> I am sorry，there is only one patch.
> 
> If two or more tasks are doing a shrinking job, there are different results
> for each task.
> That is to say, the status of each task is not persistent each time,
> although they have
> the same purpose to release memory.
> 
> And, If two tasks are shrinking, the erofs_sb_list will become no order,
> because each task will
> move one sbi to tail, but sbi is random, so results are more complex.

Thanks for the explanation. So it doesn't sound like a real issue but seems
like an improvement? If it's more like this, you could patch this to the
products first and beta for more time and see if it works well.. I'm
more careful about such change to shrinker since it could impact
downstream users...

Yes, I know this behavior, but I'm not sure if it's needed to be treated
as this way, because in principle shrinker can be processed by multiple
tasks since otherwise it could be stuck by some low priority task (I
remember it sometimes happens in Android.)

> 
> Because of the use of the local variable 'run_no', it took me a long time
> to understand the
> procedure of each task when they are concurrent.
> 
> There is the same issue for other fs, such as
> fs/ubifs/shrink.c、fs/f2fs/shrink.c.
> 
> If scan_objects cost a long time ,it will trigger a watchdog, shrinking
> should
> not make work time-consuming. It should be done ASAP.
> So, I add a new spin lock to let tasks shrink fs sequentially, it will just
> make all tasks shrink
> one by one.

Actually such shrinker is used for managed slots (sorry I needs more
work to rename workgroup to such name). But currently one of my ongoing
improvements is to remove pclusters immediately from managed slots if
no compressed buffer is cached, so it's used for inflight I/Os (to merge
decompression requests, including ongoing deduplication requests) and
cached I/O only.  So in that way objects will be more fewer than now.

> 
> 
> Thanks very much.

Thank you.

Thanks,
Gao Xiang

