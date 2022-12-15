Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8464DCD7
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 15:24:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXvcx6fNvz3bct
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Dec 2022 01:24:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXvcr4Yrzz307T
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Dec 2022 01:24:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VXNPfd2_1671114258;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXNPfd2_1671114258)
          by smtp.aliyun-inc.com;
          Thu, 15 Dec 2022 22:24:20 +0800
Date: Thu, 15 Dec 2022 22:24:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Message-ID: <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
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
Cc: linux-kernel@vger.kernel.org, joneslee@google.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tudor,

On Thu, Dec 15, 2022 at 02:58:10PM +0200, Tudor Ambarus wrote:
> Hi, Gao, Chao, Yue, Jeffle, all,
> 
> Syzbot reported a bug at [1] that is reproducible in upstream kernel
> since
>   commit 47e4937a4a7c ("erofs: move erofs out of staging")
> 
> and up to (inclusively)
>   commit 2bfab9c0edac ("erofs: record the longest decompressed size in this
> round")
> 
> The first commit that makes this bug go away is:
>   commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters
> (fully-referenced)")
> Although, this commit looks like new support and not like an explicit
> bug fix.
> 
> I'd like to fix the lts kernels. I'm happy to try any suggestions or do
> some tests. Please let me know if the bug rings a bell.

Thanks for your report.  I will try to seek time to look at this this
weekend.  But just from your description, I guess that there could be
something wrong on several compressed extents pointing to the same
blocks (i.e. the same pcluster).  But prior to commit 267f2492c8f7, such
image is always considered as corrupted images.

Anyway, I will look into that and see if there could be alternative ways
to fix this rather than backport the whole multi-reference pcluster
feature.  Yet I think no need to worry since such image is pretty
crafted and should be used as normal images.

Thanks,
Gao Xiang

> 
> Thanks,
> ta
> 
> [1]
> https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a
