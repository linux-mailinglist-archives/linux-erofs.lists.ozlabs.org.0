Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4C91A2C1
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 11:36:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ddBO+Fzg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8tjf33B2z3cb6
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 19:36:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ddBO+Fzg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8tjS3j08z2xqq
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 19:35:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719480949; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZfyuSInmAoJg7FWQr7xbkTVuXFG18RmIFNpt7mFWr4k=;
	b=ddBO+FzgY1tji/1KQMFEtx8SNhRzCjax/ZvDE71iwyURr8zAEM1BYNOs/deMFrsM1Fhg+qkey2DMCh8dxBCzA7JAvbSPFpVwnCf5p4ATqKzk7xKjJxK2+kMk8Y2A80trjdEfEWjEhWypex6Pm/ZaX0wUGyNLz418naJPzr7JOq4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9MRR1R_1719480947;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9MRR1R_1719480947)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 17:35:48 +0800
Message-ID: <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
Date: Thu, 27 Jun 2024 17:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: Hongbo Li <lihongbo22@huawei.com>, gregkh@linuxfoundation.org
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/27 17:11, Hongbo Li wrote:
> When I run nydus on linux 6.6.35, the erofs crashed with the following
> messages:
> 
> ```
> [ 2120.070101] RIP: 0010:erofs_map_dev+0x147/0x1e0 [erofs]
> [ 2120.070188] Code: e8 4e bd 6d dc 8b 43 28 4c 89 ef 8d 70 ff e8 f0 ee 69 dc 48 85 c0 0f 84 83 00 00 00 41 80 7d 44 00 75 31 48 8b 50 10 4c 89 e7 <48> 8b 12 48 89 53 08 48 8b 50 18 48 89 53 10 48 8b 50 20 48 89 53
> [ 2120.070288] RSP: 0018:ffff982a48adb9d8 EFLAGS: 00010246
> [ 2120.070357] RAX: ffff8c2607e2f040 RBX: ffff982a48adba38 RCX: 0000000000000000
> [ 2120.070431] RDX: 0000000000000000 RSI: ffff8c25d17c7dc8 RDI: ffff8c354725e198
> [ 2120.070522] RBP: ffff8c35466cf800 R08: ffff8c2607e2f040 R09: ffff8c354725e188
> [ 2120.070631] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8c354725e198
> [ 2120.070741] R13: ffff8c354725e180 R14: ffff8c25d14d01c0 R15: 0000000000001000
> [ 2120.070853] FS:  000000c000a00090(0000) GS:ffff8c34ffe00000(0000) knlGS:0000000000000000
> [ 2120.070965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2120.071054] CR2: 0000000000000000 CR3: 00000001067dc005 CR4: 00000000001706f0
> [ 2120.071163] Call Trace:
> [ 2120.071245]  <TASK>
> [ 2120.071325]  ? __die+0x24/0x70
> [ 2120.071413]  ? page_fault_oops+0x82/0x150
> [ 2120.071499]  ? fixup_exception+0x26/0x350
> [ 2120.071585]  ? exc_page_fault+0x69/0x150
> [ 2120.071671]  ? asm_exc_page_fault+0x26/0x30
> [ 2120.071759]  ? erofs_map_dev+0x147/0x1e0 [erofs]
> [ 2120.071853]  ? erofs_map_dev+0x130/0x1e0 [erofs]
> [ 2120.071946]  erofs_fscache_data_read_slice+0xe7/0x390 [erofs]
> [ 2120.072044]  ? xas_create+0x160/0x1b0
> [ 2120.072130]  ? __kmem_cache_alloc_node+0x18c/0x2c0
> [ 2120.072219]  ? erofs_fscache_readahead+0x49/0x110 [erofs]
> [ 2120.072314]  ? xas_load+0xe/0x50
> [ 2120.072397]  erofs_fscache_readahead+0xe0/0x110 [erofs]
> [ 2120.072492]  read_pages+0x5a/0x220
> [ 2120.072579]  page_cache_ra_order+0x1f0/0x2f0
> [ 2120.072667]  filemap_get_pages+0xef/0x290
> [ 2120.072755]  filemap_read+0xcb/0x310
> [ 2120.072841]  ? ovl_open+0x9e/0xf0 [overlay]
> [ 2120.072942]  ? ima_file_check+0x57/0x80
> [ 2120.073028]  ? mntput_no_expire+0x4a/0x250
> [ 2120.073116]  do_iter_readv_writev+0x12d/0x140
> [ 2120.073204]  do_iter_read+0xfd/0x190
> [ 2120.073288]  ovl_read_iter+0x1c3/0x210 [overlay]
> [ 2120.073384]  vfs_read+0x1c7/0x300
> [ 2120.073471]  ksys_read+0x63/0xe0
> [ 2120.073555]  do_syscall_64+0x37/0x90
> [ 2120.073640]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 2120.073729] RIP: 0033:0x403ace
> ```
> 
> The reason is the same with 8bd90b6ae7856("erofs: fix NULL dereference of dif->bdev_handle in fscache mode") in mainline. So we should backport this
> patch into stable linux-6.6.y to avoid this bug.

Yes, commit 8bd90b6ae785 should be backported to
Linux 6.6.y LTS immediately.

Thanks,
Gao Xiang
