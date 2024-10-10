Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E4997B3F
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 05:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728530887;
	bh=OBR59+bzAVU2qFzYGNO2vNvD0D2JUJCCrxKB5dw2GSo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XeOtWe+rPp8l/BhMLOz3HVvYy5pMRjqrO32dO/abzqqFEU+rbj1dV5Is+p47V2gZg
	 AVM6F0fuf5nCNu6+sgKZkMdps6bONWA5U3pCEj1MlvnmblQcV2XEBf/Qu4BBSGPYNQ
	 b5CYm9TvoOjdbNJz+DhJ5cp55EbYRFvmNHcRnU4MZR589lYNSAOamzE7k+UG7Y0fES
	 3/QE6DNILmRv3tGAalThK1bjrzsXhTXh8T7GEl4fJGBiVmc21wQ3EHIlEMhMug2U2q
	 W/T/pUwMqKR5OVH5tL3f/G13MNTYdWLKrEEBYGfAg4y0XhhiOSDHiICRPEMRDeSppJ
	 kyaTQqBUHeTEw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPFZb2Kx5z3bkL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 14:28:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728530886;
	cv=none; b=Eev1OI/uNPlv3voYzbeJG33AHWmw6uwqYtT12L6MvVjwX9vELFUH+L7uVORjuIeafLGhYFBDKCGmhv+BxDnvBAsu0cCkCq2f24y/KbtGszn1h7ucMrioylg9uDOnula+QVsFZb1zHk2T70mffg12dQGZmzgPY9LJ+LikqaRuU3qUTA84dFsjX96r7c14TmzWNoNZ1e0HhTjzrX54CmTsP1Jk2fvWGxvqjbgZ+dEDdZBdTsqqO2HG97fE6wWn3KnILpbK2i+7e/LWouJlQX/E5guOBz90WHR8jsc+yD3J/eJ11Dd2ffDWAr5YdG4vfDsYXQDjEozYR9aL+OUKkXudAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728530886; c=relaxed/relaxed;
	bh=OBR59+bzAVU2qFzYGNO2vNvD0D2JUJCCrxKB5dw2GSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g167nMe7s4ILXMHLUPJFGfR3ZrEAOIrgVGO4CPRpUrIF5Id2zz7mMYj8rpHdvPSX02BJMsI/TXHQheFyNlyrBC+MsOYA4nxDrHR9UM5SzxWvmtdtfnneecXhq2RAKbYKUgmFrwFwiYEVXMvNwIdiGSRstwySiv0pISNogSoN4g82aTo2Mr/3o2UQFClCvP0YKFwZfhIZn7VSioOs8w1wDLh5wlBp4R7ZTq1c8nmLcV58OmloVOD99ZPobdi1/1JuMUf8K3x6ov53t28JGDb3ij+ZolGO3NZroiOIoejqXyIglVC/YDnH4mJ2/WFqa4Y/vTdjn1kMj6KCKLh2k6uJeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1160 seconds by postgrey-1.37 at boromir; Thu, 10 Oct 2024 14:28:02 AEDT
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPFZV6Dtvz2xy6
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 14:27:59 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPF3G00dnz1HK3D;
	Thu, 10 Oct 2024 11:04:25 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E027140392;
	Thu, 10 Oct 2024 11:08:32 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:08:31 +0800
Message-ID: <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
Date: Thu, 10 Oct 2024 11:08:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi!

This patchset involves some general cachefiles workflows and the on-
demand loading process. For example, the eighth patch fixes a memory
ordering issue in cachefiles, and the fifth patch includes some cleanup.
These all related to changes in the general cachefiles workflow, and I
think these deserve some attention.

Additionally, although the current EROFS on-demand loading mode based on
cachefiles interaction might be considered for switching to the fanotify
mode in the future, I believe the code based on the current cachefiles
on-demand loading mode still requires maintenance. The first few patches
here are bugfixes specifically for that.

Therefore, I would greatly appreciate it if anyone could take some time
to review these patches. So friendly ping.

Thanks,
Zizhi Wo


在 2024/8/21 10:42, Zizhi Wo 写道:
> Hi!
> 
> We recently discovered some bugs through self-discovery and testing in
> erofs ondemand loading mode, and this patchset is mainly used to fix
> them. These patches are relatively simple changes, and I would be excited
> to discuss them together with everyone. Below is a brief introduction to
> each patch:
> 
> Patch 1: Fix for wrong block_number calculated in ondemand write.
> 
> Patch 2: Fix for wrong length return value in ondemand write.
> 
> Patch 3: Fix missing position update in ondemand write, for scenarios
> involving read-ahead, invoking the write syscall.
> 
> Patch 4: Previously, the last redundant data was cleared during the umount
> phase. This patch remove unnecessary data in advance.
> 
> Patch 5: Code clean up for cachefiles_commit_tmpfile().
> 
> Patch 6: Modify error return value in cachefiles_daemon_secctx().
> 
> Patch 7: Fix object->file Null-pointer-dereference problem.
> 
> Patch 8: Fix for memory out of order in fscache_create_volume().
> 
> 
> Zizhi Wo (8):
>    cachefiles: Fix incorrect block calculations in
>      __cachefiles_prepare_write()
>    cachefiles: Fix incorrect length return value in
>      cachefiles_ondemand_fd_write_iter()
>    cachefiles: Fix missing pos updates in
>      cachefiles_ondemand_fd_write_iter()
>    cachefiles: Clear invalid cache data in advance
>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>    cachefiles: Modify inappropriate error return value in
>      cachefiles_daemon_secctx()
>    cachefiles: Fix NULL pointer dereference in object->file
>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
> 
>   fs/cachefiles/daemon.c    |  2 +-
>   fs/cachefiles/interface.c |  3 +++
>   fs/cachefiles/io.c        | 10 +++++-----
>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>   fs/netfs/fscache_volume.c |  3 +--
>   6 files changed, 52 insertions(+), 27 deletions(-)
> 
