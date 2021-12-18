Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7F4797D6
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 01:36:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JG6Nn5bF7z306m
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 11:36:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JG6Nh6ky6z2ynx
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 11:36:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V-wiSqP_1639787780; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-wiSqP_1639787780) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 18 Dec 2021 08:36:22 +0800
Date: Sat, 18 Dec 2021 08:36:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v7 2/2] erofs-utils: lib: add API to iterate dirs in EROFS
Message-ID: <Yb0tBHPnP/XF6eKK@B-P7TQMD6M-0146.local>
References: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
 <20211217194720.3219630-1-zhangkelvin@google.com>
 <20211217194720.3219630-2-zhangkelvin@google.com>
 <CAOSmRzgMu1otsZomU3dfLdu=N4jJLKB=MBgp5viHLCg5fub68g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzgMu1otsZomU3dfLdu=N4jJLKB=MBgp5viHLCg5fub68g@mail.gmail.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Fri, Dec 17, 2021 at 02:54:09PM -0500, Kelvin Zhang wrote:
> Hi Gao,
>     I drafted a new patchset on top of the dev branch. Changes since v6:
> 
>     1. block buffer moved to the heap, due to stack size concerns when
> iterating recursively
>     2. Added a "recursive" option to input parameters
>     3. dname buffers are still on the heap, but allocation is done once per
> directory, instead of once for each directory entry.
>     4. Added a void* arg which will be forwarded to the callback function.
> 
> I ran scripts/checkpatch.pl . Hopefully this makes your life easier. Thanks
> for the reply!.
> 
> 

Many thanks for your reply! I plan to take the patches in the
experimental branch.

The reason was written in include/erofs/dir.h:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/include/erofs/dir.h?h=experimenta

 erofs_dir_context can be allocated on heap (in summary, by
 the caller) and chain together in order to avoid recursion
 totally later. I think it should benefit Android scenario to
 avoid stack overflow due to deep level as well.

Also Igor Eisberg sent a patch for a new get_pathname in the
erofs_dir_context reuse way:
 https://lore.kernel.org/linux-erofs/CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com/

I plan to polish and apply them as well.

Thanks,
Gao Xiang
