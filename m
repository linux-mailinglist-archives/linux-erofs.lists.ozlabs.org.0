Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE435AD5F2
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 17:14:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLsWK572Kz300l
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 01:14:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gy66a6AZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gy66a6AZ;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLsWH45dNz2xfm
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 01:14:35 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BE96DB811E0;
	Mon,  5 Sep 2022 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE3C433C1;
	Mon,  5 Sep 2022 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662390870;
	bh=CP4NcXDfCymQFvUZRnFGWcms/v7Hz+fmcT03tOXmkiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gy66a6AZYzpOdaqzupomz3qx4JCM+cE1iAPogPai1oyAvfMtl5IP+1KCgOMuFyL9f
	 O4lgmpBdLCe6YrtNCpoHV1V9pPS4xlY9MFw/lZnNXRG7v+Jn53Lz3+0eKI0JhDe6Sl
	 bjjdMG3jAVE1SH62Y8+epSUV4Omo0HLQkrwXmgx1sBxnhIb51OfFhoLcyjHGdiPOEn
	 Ip+XDgX5jtQyz4gpVhqmMVm3xh2e76zsbVsMtJpYdnMAGgnhUpZCK+QhgoOFkr1JLl
	 a2Bx0UKJBVrjnJIeaxSvUXC83FJUemak9Xy7j62FG7WNe6MZqwlghAx34S+G53YwuC
	 DRwaqnj7pJohw==
Message-ID: <977a4e45-43e7-485e-fb31-7fd0754f888d@kernel.org>
Date: Mon, 5 Sep 2022 23:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: fix pcluster use-after-free on UP platforms
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/9/2 12:57, Gao Xiang wrote:
> During stress testing with CONFIG_SMP disabled, KASAN reports as below:
> 
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_lock+0xe5/0xc30
> Read of size 8 at addr ffff8881094223f8 by task stress/7789
> [ 3482.258885]
> CPU: 0 PID: 7789 Comm: stress Not tainted 6.0.0-rc1-00002-g0d53d2e882f9 #3
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
>   <TASK>
> ..
>   __mutex_lock+0xe5/0xc30
> ..
>   z_erofs_do_read_page+0x8ce/0x1560
> ..
>   z_erofs_readahead+0x31c/0x580
> ..
> Freed by task 7787
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x20/0x30
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x10c/0x190
>   kmem_cache_free+0xed/0x380
>   rcu_core+0x3d5/0xc90
>   __do_softirq+0x12d/0x389
> [ 3482.295630]
> Last potentially related work creation:
>   kasan_save_stack+0x1e/0x40
>   __kasan_record_aux_stack+0x97/0xb0
>   call_rcu+0x3d/0x3f0
>   erofs_shrink_workstation+0x11f/0x210
>   erofs_shrink_scan+0xdc/0x170
>   shrink_slab.constprop.0+0x296/0x530
>   drop_slab+0x1c/0x70
>   drop_caches_sysctl_handler+0x70/0x80
>   proc_sys_call_handler+0x20a/0x2f0
>   vfs_write+0x555/0x6c0
>   ksys_write+0xbe/0x160
>   do_syscall_64+0x3b/0x90
> 
> The root cause is that erofs_workgroup_unfreeze() doesn't reset
> to orig_val thus it causes a race that the pcluster reuses unexpectedly
> before freeing.
> 
> Since UP platforms are quite rare now, such path becomes unnecessary.
> Let's drop such specific-designed path directly instead.
> 
> Fixes: 73f5c66df3e2 ("staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
