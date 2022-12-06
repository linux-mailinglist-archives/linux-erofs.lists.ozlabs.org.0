Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490E644560
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 15:13:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRMpF5xC1z3bY9
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 01:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mb/Ru5/q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mb/Ru5/q;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRMp86RRxz2xkx
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 01:13:20 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 58DA961773;
	Tue,  6 Dec 2022 14:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EF3C433C1;
	Tue,  6 Dec 2022 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670335997;
	bh=RqKUFOm6xgQtUE8V/nJGF8hXR7BXywwkkSZ7s9W50pU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mb/Ru5/qIdyiLedMDt6uvFXrogylyQlT73joXZLVAXX3BgKsCPmfWgtKtn6MO2FQ4
	 1lXjAXozPQBr/tM5/udqwsveqgjNjTTcMh8J/g/OoWHHw7/vSXc1USyBqL04rXMYZb
	 U+Vq5igoBdhxq8I35VGcXfJ/R7x/zle8k6p2hFURoY373AZigWfEoqMEI1ZocFIaqF
	 wn13SHXT6ybkxb63YBbmDDbmhT8BwGF5PGdLqO1ZJZO9t7IENzSGNyEqhljtjO1fOV
	 k1kKSmZuRE2joEw5LT0yyXqKlHL4HzPOE3FnXR7ZAG27jFOypR9e3pntJsWDiJfaKk
	 BwGohDeL9v4cA==
Message-ID: <8b35a625-d5ea-7093-01a4-0e73c3bfe493@kernel.org>
Date: Tue, 6 Dec 2022 22:13:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: check the uniqueness of fsid in shared domain
 in advance
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, linux-erofs@lists.ozlabs.org
References: <20221125110822.3812942-1-houtao@huaweicloud.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221125110822.3812942-1-houtao@huaweicloud.com>
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/11/25 19:08, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When shared domain is enabled, doing mount twice with the same fsid and
> domain_id will trigger sysfs warning as shown below:
> 
>   sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
>   CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x38/0x49
>    dump_stack+0x10/0x12
>    sysfs_warn_dup.cold+0x17/0x27
>    sysfs_create_dir_ns+0xb8/0xd0
>    kobject_add_internal+0xb1/0x240
>    kobject_init_and_add+0x71/0xa0
>    erofs_register_sysfs+0x89/0x110
>    erofs_fc_fill_super+0x98c/0xaf0
>    vfs_get_super+0x7d/0x100
>    get_tree_nodev+0x16/0x20
>    erofs_fc_get_tree+0x20/0x30
>    vfs_get_tree+0x24/0xb0
>    path_mount+0x2fa/0xa90
>    do_mount+0x7c/0xa0
>    __x64_sys_mount+0x8b/0xe0
>    do_syscall_64+0x30/0x60
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
> data blob (aka fsid) is unique in the shared domain and
> erofs_register_sysfs() invoked by the second mount will fail due to the
> duplicated fsid in the shared domain and report warning.
> 
> It would be better to check the uniqueness of fsid before doing
> erofs_register_sysfs(), so adding a new flags parameter for
> erofs_fscache_register_cookie() and doing the uniqueness check if
> EROFS_REG_COOKIE_NEED_NOEXIST is enabled.
> 
> After the patch, the error in dmesg for the duplicated mount would be:
> 
>   erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY
> 
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
