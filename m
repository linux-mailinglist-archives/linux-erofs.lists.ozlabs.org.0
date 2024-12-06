Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D49E6698
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 06:05:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4K2r0fYNz30YZ
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 16:05:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733461538;
	cv=none; b=WJcLG/d1xu8cfgsgH95duV32NZEUXlOoqNDPi/t0BzmFv6O7JXDKlgRUABdEZoYie0FheB60ndLeegraP/1EOU7Q3mZzGh5fSQGKq88/Bpzopyvb/g5IFwJXpQ69caPAxjwa//ksFJNhKEPY4sN8X4WT2OMlkCBMcBlR/TyOftNr69CQbtMq28mXuy/RmZyPAHPOgK1mXszrujA7hD48hStslvIMpCf/TmyaA4TyUWPovu3oO/QidqZ3/5Ng0kA8Rk5jddMI0A6BaS5Rs7lbZJRXCxIks2fr8Dra/XzwJ3cox6SJ+YMtgQRmnHamtb527FH/7ekLnraUbKS86pFiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733461538; c=relaxed/relaxed;
	bh=alr+nsykfse7nqlTaoZFhL1JgmiA21V65sy1aH12FMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+yLRpCXAavJZEEih2rRgY+SWotAogpbYqfuztKMxjMm06AAVVN+Hmgg+Ru8ir3wS9j6q7V7fqUm9vmkNnlHPbTMnfYseoV37Cde/qcyD7c85LgEKajuwIPxeMTEK4U1LKlrBXIqog6klyz8lFORdu74CpyICSGr9TpujMDij20HGsjjLniKQPAjJ9pmJf85I3ecIMkuWr3Zj85AQWfEopO/lzRLt/EpTOV6473LKCWb4u3AS6AUHK7h4Ysvx1XedN/OayEgaOie8MtaC6s1XJQMWHoE5nw5nqusrb7pM6rFqQXNgXqyl6QGxKH3cAYFsqj8YkjF0A1MsWdvZH8SIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CiulZnvj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CiulZnvj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4K2l01Lzz2y8d
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 16:05:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733461523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=alr+nsykfse7nqlTaoZFhL1JgmiA21V65sy1aH12FMk=;
	b=CiulZnvjjR8/73cQFM/BHycJ+nSm49qQ5GCpxeP7nLX6bpRmtt623L/XVJZy1zxSAdcfdlbwLcu8AO2tzt+Jrp4ad8oLzohJ01NnqvSRT40ZrHlSIy0czlTQQmq1chicWnn0lqR9OA+toOBXXQQqCRli1EqfHr/B1UMVF68MJtk=
Received: from 30.221.130.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKvP.Zi_1733461521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 13:05:22 +0800
Message-ID: <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
Date: Fri, 6 Dec 2024 13:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org, xiangyu.chen@windriver.com
References: <2024120228-mocker-refinance-e073@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024120228-mocker-refinance-e073@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Christian Brauner <brauner@kernel.org>, stable-commits@vger.kernel.org, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi XiangYu,

Just noticed that. Why it's needed for Linux 6.1 LTS?
Just see my reply, I think 6.1 LTS is not impacted:
https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/

Also, it seems some dependenies are missing, just
backporting this commit will break EROFS.

Hi Greg,

Please help drop this patch from 6.1 queue before more
explanations, thanks!

Thanks,
Gao Xiang

On 2024/12/2 19:48, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>      erofs: reliably distinguish block based and fscache mode
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       erofs-reliably-distinguish-block-based-and-fscache-mode.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
>  From 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Fri, 19 Apr 2024 20:36:11 +0800
> Subject: erofs: reliably distinguish block based and fscache mode
> 
> From: Christian Brauner <brauner@kernel.org>
> 
> commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 upstream.
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
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   fs/erofs/super.c |    8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -892,7 +892,7 @@ static int erofs_init_fs_context(struct
>    */
>   static void erofs_kill_sb(struct super_block *sb)
>   {
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
>   	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>   
> @@ -902,15 +902,11 @@ static void erofs_kill_sb(struct super_b
>   		return;
>   	}
>   
> -	if (erofs_is_fscache_mode(sb))
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>   		kill_anon_super(sb);
>   	else
>   		kill_block_super(sb);
>   
> -	sbi = EROFS_SB(sb);
> -	if (!sbi)
> -		return;
> -
>   	erofs_free_dev_context(sbi->devs);
>   	fs_put_dax(sbi->dax_dev, NULL);
>   	erofs_fscache_unregister_fs(sb);
> 
> 
> Patches currently in stable-queue which might be from brauner@kernel.org are
> 
> queue-6.1/cachefiles-fix-missing-pos-updates-in-cachefiles_ond.patch
> queue-6.1/hfsplus-don-t-query-the-device-logical-block-size-mu.patch
> queue-6.1/netfs-fscache-add-a-memory-barrier-for-fscache_volum.patch
> queue-6.1/fs-inode-prevent-dump_mapping-accessing-invalid-dent.patch
> queue-6.1/initramfs-avoid-filename-buffer-overrun.patch
> queue-6.1/erofs-reliably-distinguish-block-based-and-fscache-mode.patch
> queue-6.1/fs_parser-update-mount_api-doc-to-match-function-sig.patch
> queue-6.1/selftests-mount_setattr-fix-failures-on-64k-page_siz.patch

