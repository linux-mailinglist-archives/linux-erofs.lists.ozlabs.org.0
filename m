Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5E6447B0
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 16:12:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRP630XY7z3fPD
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 02:12:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MIYdA8N3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MIYdA8N3;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRP0M1gjgz3fgd
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 02:07:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6C661786;
	Tue,  6 Dec 2022 15:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA27C43148;
	Tue,  6 Dec 2022 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670339231;
	bh=Ob5V/tXbNKgT/KoriEtKPMuFGstfF4RJaAV5mgAFA/s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MIYdA8N3D4tUbrP7PFSPc4eF4CWQTrNDFGIiJNjLRkGsftrTKeK2fkL/Fe4UKLNHq
	 miyEydnH5QYTrljdLUQWHA7FXr0683GhQvYEksBSvU6sPgEYThnDbUJJIhVgD7aOWM
	 dCp5Ym4MCzQ3aTaGv8+hrj1umcpOru/jggGf1jKvGvkDEFkcelPiRUXLZclsqtSLjr
	 6DzOVAAZLl1ReZZB5ZPH+6zb1unNcKu62bI0QzU7PzEtu8Rz/tgTXezMadMolX/chM
	 HNfSIse9tUew1zmIk7ApHQajmpTNehjvvuydRPm1lySz5mHCt8PhPQFaHktj+tSV4T
	 +/VRNve91V2Dg==
Message-ID: <1022b823-b0a7-0afa-bb88-954182e372cf@kernel.org>
Date: Tue, 6 Dec 2022 23:07:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v3] erofs: Fix pcluster memleak when its block
 address is zero
Content-Language: en-US
To: Chen Zhongjin <chenzhongjin@huawei.com>, huyue2@coolpad.com,
 syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, jefflexu@linux.alibaba.com
References: <20221205034957.90362-1-chenzhongjin@huawei.com>
 <Y42Kz6sVkf+XqJRB@debian>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y42Kz6sVkf+XqJRB@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/12/5 14:08, Gao Xiang wrote:
> Hi all,
> 
> On Mon, Dec 05, 2022 at 11:49:57AM +0800, Chen Zhongjin wrote:
>> syzkaller reported a memleak:
>> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
>>
>> unreferenced object 0xffff88811009c7f8 (size 136):
>>    ...
>>    backtrace:
>>      [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>>      [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>>      [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>>      ...
>>
>> syzkaller constructed a case: in z_erofs_register_pcluster(),
>> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
>> zero although pcl is not a inline pcluster.
>>
>> Then following path adds refcount for grp, but the refcount won't be put
>> because pcl is inline.
>>
>> z_erofs_readahead()
>>    z_erofs_do_read_page() # for another page
>>      z_erofs_collector_begin()
>>        erofs_find_workgroup()
>>          erofs_workgroup_get()
>>
>> Since it's illegal for the block address of a pcluster to be zero, add
>> check here to avoid registering the pcluster which would be leaked.
>>
>> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
>> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>> v1 -> v2:
>> As Gao's advice, we should fail to register pcluster if m_pa is zero.
>> Maked it this way and changed the commit message.
>>
>> v2 -> v3:
>> Slightly fix commit message and add -next tag.
> 
> I've updated the patch itself as below
> (Since we only need to fail out for non-tailpacking cases, tailpacking
>   inline inodes could still have m_pa < EROFS_BLKSIZ):
> 
>  From f5e037e760d338ca0c116e507be663cb843d42f0 Mon Sep 17 00:00:00 2001
> From: Chen Zhongjin <chenzhongjin@huawei.com>
> Date: Mon, 5 Dec 2022 11:49:57 +0800
> Subject: [PATCH] erofs: Fix pcluster memleak when its block address is zero
> 
> syzkaller reported a memleak:
> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> 
> unreferenced object 0xffff88811009c7f8 (size 136):
>    ...
>    backtrace:
>      [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>      [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>      [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>      ...
> 
> syzkaller constructed a case: in z_erofs_register_pcluster(),
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
> zero although pcl is not a inline pcluster.
> 
> Then following path adds refcount for grp, but the refcount won't be put
> because pcl is inline.
> 
> z_erofs_readahead()
>    z_erofs_do_read_page() # for another page
>      z_erofs_collector_begin()
>        erofs_find_workgroup()
>          erofs_workgroup_get()
> 
> Since it's illegal for the block address of a non-inlined pcluster to
> be zero, add check here to avoid registering the pcluster which would
> be leaked.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
