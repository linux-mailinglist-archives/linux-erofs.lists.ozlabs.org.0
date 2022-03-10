Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F184D4725
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 13:40:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDpYd5JzKz3084
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 23:40:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDpYY07lZz2yxW
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 23:39:56 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V6oielf_1646915987; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6oielf_1646915987) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Mar 2022 20:39:49 +0800
Date: Thu, 10 Mar 2022 20:39:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Subject: Re: How to fix the bug in "WARNING: kobject bug in
 erofs_unregister_sysfs"?
Message-ID: <Yinxk7PZxu9KdKHI@B-P7TQMD6M-0146.local>
References: <CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com>
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
Cc: syzbot+045796dbe294d53147e6@syzkaller.appspotmail.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dongliang,

(+ cc Jianan.)

On Thu, Mar 10, 2022 at 06:15:20PM +0800, Dongliang Mu wrote:
> Hi kernel developers,
> 
> I am writing to kindly ask for some suggestions on fixing "WARNING:
> kobject bug in erofs_unregister_sysfs".
> 
> The underlying issue is in the following,
> 
> erofs_fc_get_tree
> -> get_tree_bdev
>   -> fill_super
>     -> erofs_fc_fill_super
>

Thanks for the report!
 
> When erofs_register_sysfs fails in the calling kobject_init_and_add,
> it just returned an error code and the parent function will call
> deactivate_locked_super to do clean up.

Yes, in that way we don't need to rewrite another error path (actually
once we had another duplicated error path but Al suggested the current
shape...)

> 
> In the following stack trace, it finally calls erofs_unregister_sysfs
> without knowing the execution status of erofs_register_sysfs, which
> leads to the kobject bug.
> 
>  erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
>  erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
>  generic_shutdown_super+0x14c/0x400 fs/super.c:465
>  kill_block_super+0x97/0xf0 fs/super.c:1397
>  erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
>  deactivate_locked_super+0x94/0x160 fs/super.c:335
>  get_tree_bdev+0x573/0x760 fs/super.c:1297
> 
> I am not sure how to fix this bug. Any suggestion is appreciated.

I think a simple way is to introduce a `sysfs_inited' boolean to
sbi to indicate that. Or some better suggestion is welcomed.

Thanks,
Gao Xiang

> 
> --
> My best regards to you.
> 
>      No System Is Safe!
>      Dongliang Mu
