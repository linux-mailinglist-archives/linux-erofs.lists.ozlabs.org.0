Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE118025C7
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Dec 2023 17:52:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SjtC844ccz3cLY
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 03:52:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SjtC407hWz2yhT
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Dec 2023 03:52:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VxgSxzN_1701622352;
Received: from 30.27.64.151(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxgSxzN_1701622352)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 00:52:34 +0800
Message-ID: <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
Date: Mon, 4 Dec 2023 00:52:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Weird EROFS data corruption
To: Juhyung Park <qkrwngud825@gmail.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
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
Cc: Yann Collet <yann.collet.73@gmail.com>, linux-crypto@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Juhyung,

On 2023/12/4 00:22, Juhyung Park wrote:
> (Cc'ing f2fs and crypto as I've noticed something similar with f2fs a
> while ago, which may mean that this is not specific to EROFS:
> https://lore.kernel.org/all/CAD14+f2nBZtLfLC6CwNjgCOuRRRjwzttp3D3iK4Of+1EEjK+cw@mail.gmail.com/
> )
> 
> Hi.
> 
> I'm encountering a very weird EROFS data corruption.
> 
> I noticed when I build an EROFS image for AOSP development, the device
> would randomly not boot from a certain build.
> After inspecting the log, I noticed that a file got corrupted.

Is it observed on your laptop (i7-1185G7), yes? or some other arm64
device?

> 
> After adding a hash check during the build flow, I noticed that EROFS
> would randomly read data wrong.
> 
> I now have a reliable method of reproducing the issue, but here's the
> funny/weird part: it's only happening on my laptop (i7-1185G7). This
> is not happening with my 128 cores buildfarm machine (Threadripper
> 3990X).> 
> I first suspected a hardware issue, but:
> a. The laptop had its motherboard replaced recently (due to a failing
> physical Type-C port).
> b. The laptop passes memory test (memtest86).
> c. This happens on all kernel versions from v5.4 to the latest v6.6
> including my personal custom builds and Canonical's official Ubuntu
> kernels.
> d. This happens on different host SSDs and file-system combinations.
> e. This only happens on LZ4. LZ4HC doesn't trigger the issue.
> f. This only happens when mounting the image natively by the kernel.
> Using fuse with erofsfuse is fine.

I think it's a weird issue with inplace decompression because you said
it depends on the hardware.  In addition, with your dataset sadly I
cannot reproduce on my local server (Xeon(R) CPU E5-2682 v4).

What is the difference between these two machines? just different CPU or
they have some other difference like different compliers?

Thanks,
Gao Xiang
