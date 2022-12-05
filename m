Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F96422E7
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 07:08:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NQY5G74cjz3bbJ
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 17:08:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LfjaavSd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LfjaavSd;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NQY576DrZz30jZ
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Dec 2022 17:08:27 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 020F960F6B;
	Mon,  5 Dec 2022 06:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BE9C433D6;
	Mon,  5 Dec 2022 06:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670220502;
	bh=MBMSBJL5AsBX91HrnTtFi4xKcM2a9ziyrH5ljP0SqYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfjaavSd1k0MARmf11xc2HGqdDc0XQ0bui88aT6/SJMQFU4ywVN915LjqijW8cDcR
	 ytB9joxPi0Z74/2l1g58304n2Bx54wjty3Swk0Z3Z499Bn2x2ILM8RmT9qvPrpGve6
	 dd0vj+3SSo4JRz+6el1wYTqmr6Tk0V0jevQMWCAni2IOgUbja5O+vp4sPkKcCs/HpQ
	 Y2Cc8B5uQ6ymp/1H5XmjDylK7UiH8fRlHwSYjEKuibNqrXMHHpuzOkNuJ+eLLvOJJf
	 zP+eBLJYbk23zVKSQHNud32nv0Oqd3zTJEXhYBaOAmgXDhI2KehYiHTNiuzRlagWVh
	 cjO9zMOOOOVYQ==
Date: Mon, 5 Dec 2022 14:08:15 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chen Zhongjin <chenzhongjin@huawei.com>, huyue2@coolpad.com
Subject: Re: [PATCH -next v3] erofs: Fix pcluster memleak when its block
 address is zero
Message-ID: <Y42Kz6sVkf+XqJRB@debian>
Mail-Followup-To: Chen Zhongjin <chenzhongjin@huawei.com>,
	huyue2@coolpad.com,
	syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com
References: <20221205034957.90362-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205034957.90362-1-chenzhongjin@huawei.com>
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
Cc: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

On Mon, Dec 05, 2022 at 11:49:57AM +0800, Chen Zhongjin wrote:
> syzkaller reported a memleak:
> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> 
> unreferenced object 0xffff88811009c7f8 (size 136):
>   ...
>   backtrace:
>     [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>     [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>     [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>     ...
> 
> syzkaller constructed a case: in z_erofs_register_pcluster(),
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
> zero although pcl is not a inline pcluster.
> 
> Then following path adds refcount for grp, but the refcount won't be put
> because pcl is inline.
> 
> z_erofs_readahead()
>   z_erofs_do_read_page() # for another page
>     z_erofs_collector_begin()
>       erofs_find_workgroup()
>         erofs_workgroup_get()
> 
> Since it's illegal for the block address of a pcluster to be zero, add
> check here to avoid registering the pcluster which would be leaked.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
> v1 -> v2:
> As Gao's advice, we should fail to register pcluster if m_pa is zero.
> Maked it this way and changed the commit message.
> 
> v2 -> v3:
> Slightly fix commit message and add -next tag.

I've updated the patch itself as below
(Since we only need to fail out for non-tailpacking cases, tailpacking
 inline inodes could still have m_pa < EROFS_BLKSIZ):

From f5e037e760d338ca0c116e507be663cb843d42f0 Mon Sep 17 00:00:00 2001
From: Chen Zhongjin <chenzhongjin@huawei.com>
Date: Mon, 5 Dec 2022 11:49:57 +0800
Subject: [PATCH] erofs: Fix pcluster memleak when its block address is zero

syzkaller reported a memleak:
https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed

unreferenced object 0xffff88811009c7f8 (size 136):
  ...
  backtrace:
    [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
    [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
    [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
    ...

syzkaller constructed a case: in z_erofs_register_pcluster(),
ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
zero although pcl is not a inline pcluster.

Then following path adds refcount for grp, but the refcount won't be put
because pcl is inline.

z_erofs_readahead()
  z_erofs_do_read_page() # for another page
    z_erofs_collector_begin()
      erofs_find_workgroup()
        erofs_workgroup_get()

Since it's illegal for the block address of a non-inlined pcluster to
be zero, add check here to avoid registering the pcluster which would
be leaked.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2584a62c9d28..fa7ac499a825 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -496,7 +496,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	struct erofs_workgroup *grp;
 	int err;
 
-	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
+	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
+	    (!ztailpacking && !(map->m_pa >> PAGE_SHIFT))) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-- 
2.30.2


