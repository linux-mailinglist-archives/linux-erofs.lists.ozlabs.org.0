Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38268BF138
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 01:20:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiCoEdOJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VYvQ00GDWz3cRs
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 09:20:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiCoEdOJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VYvPs27HDz30W9
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 May 2024 09:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715123997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e0zrxwPcAb6kwy18tLfS3CmdjXGu2j+7ybZ31BCE1es=;
	b=qiCoEdOJ9kv4VhbwYhDX70xPsoN1I84vneWpwkBibPFFwxl8bpOfIHJSJlVSPuR/SDDjhWZe4dMwJrhtQZDiL70YSzjI3bs/tmsoNN6nLDLyTHxRJgzyL90YSLQPAJ6cDHCqlUsFZffTYxDaq0ly0OS2k5Kpy7p2va3qGLkEsYw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W61IPVB_1715123993;
Received: from 30.25.231.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W61IPVB_1715123993)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 07:19:55 +0800
Message-ID: <aca15d22-e2f9-4d09-b022-f290d9c902c9@linux.alibaba.com>
Date: Wed, 8 May 2024 07:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.8 26/52] erofs: reliably distinguish block based
 and fscache mode
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240507230800.392128-1-sashal@kernel.org>
 <20240507230800.392128-26-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240507230800.392128-26-sashal@kernel.org>
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
Cc: Christian Brauner <brauner@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/5/8 07:06, Sasha Levin wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> [ Upstream commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 ]
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>   <TASK>
>   erofs_kill_sb+0x81/0x90
>   deactivate_locked_super+0x35/0x80
>   get_tree_bdev+0x136/0x1e0
>   vfs_get_tree+0x2c/0xf0
>   do_new_mount+0x190/0x2f0
>   [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Please help drop this patch for now too, you should backport
the dependency commit
07abe43a28b2 ("erofs: get rid of erofs_fs_context") in advance.

Otherwise it doesn't work and break the functionality.

Thanks,
Gao Xiang

