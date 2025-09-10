Return-Path: <linux-erofs+bounces-1007-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85033B50D8B
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 07:49:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM8rc258Dz3clB;
	Wed, 10 Sep 2025 15:49:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757483344;
	cv=none; b=U/pWUOtfP6kZjfkMwIjuXQMFm8gHhmjgUxg72FHKbEeRHepMCbJWx0o1CLrghhxuvNINXkvcrucV0/sNpmzBGpVSpqltWblYRrf8jzJ4n0OVq4+Hc1wo1aQlaiy0y4olZgiysZ76q46+I5iVUPxRB+luSwD9FJfCcXBgWh6nfLPojeB9/nYzF/TYq5/U1QbF8rYNdi9NxQG36wpi/YLfk3sKm8RC6s1rAau7spHeAt8NfqrTYdbSr0yr1v/rToJ7dzWZWrVDQsMipzQoiV6cB+rAorV9Fq0jDyPhxRF0aElDNfdGSH0zqg4G3j+U2oBVc3kbjQOiIfRA8V3Fq6lNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757483344; c=relaxed/relaxed;
	bh=AvkM4tX7wnfRZhBx+l+cfpCbJcwrqXnaymViqKU+aGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go1O4xOpJEkPQRvYEkN9FSwDlCwHASgxHDjIzKNuN3/sqCRTC7XpNfjJpbdvRv+Mrvf27Z5JYBxg+TuO8kKc5ExBDVPS60xuXYY+fwk6WWHdyQq8LctqIfbzYAxvdrYvQ6MHav2a5v6Z2mkiut8FQtk6lQvUxYn/sRwSnKdYgIPri5NrrG0v1+ctjjVxLD5uUmRjxuCxZx45MyxaKlHpPD0gKErR2pCRvNN3ro0PGf4W+ep96w/hOVZqAp7JR2EQyO8cWDqfkg23gF5j7SPe12rvnKlIHvY1WDKYXg9fZT5/RkJQ9UXEsOP13cVLXJ7adwxtisiRXhVsKfsxEzDmZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gOPxTjrJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gOPxTjrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM8rZ3Grsz3ck2
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 15:49:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757483337; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AvkM4tX7wnfRZhBx+l+cfpCbJcwrqXnaymViqKU+aGg=;
	b=gOPxTjrJbAQlDYc36KM7TGf7HE1OjoJ2mbeUadwQvhT52FMOiKEhL+3W5robxvxumtmkafdbiuB3wEFC6VjemN4GkSNvECJ+1ZzgnGNCyuWO0A1VbMfDZqJDX6fzzDXO40T8g3QnhYTgJORzT05OrG51YOdO8clugQ8T/Vxw8rk=
Received: from 30.221.131.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WngsdNS_1757483333 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 13:48:53 +0800
Message-ID: <9b5913d7-a6fc-4d2c-b2d3-25b85ce6eb64@linux.alibaba.com>
Date: Wed, 10 Sep 2025 13:48:52 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix runtime warning on
 truncate_folio_batch_exceptionals()
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250910053339.739346-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250910053339.739346-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/10 13:33, Yuezhang Mo wrote:
> Commit 0e2f80afcfa6("fs/dax: ensure all pages are idle prior to
> filesystem unmount") introduced the WARN_ON_ONCE to capture whether
> the filesystem has removed all DAX entries or not and applied the
> fix to xfs and ext4.
> 
> Apply the missed fix on erofs to fix the runtime warning:
> 
> [  5.266254] ------------[ cut here ]------------
> [  5.266274] WARNING: CPU: 6 PID: 3109 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0xff/0x260
> [  5.266294] Modules linked in:
> [  5.266999] CPU: 6 UID: 0 PID: 3109 Comm: umount Tainted: G S                  6.16.0+ #6 PREEMPT(voluntary)
> [  5.267012] Tainted: [S]=CPU_OUT_OF_SPEC
> [  5.267017] Hardware name: Dell Inc. OptiPlex 5000/05WXFV, BIOS 1.5.1 08/24/2022
> [  5.267024] RIP: 0010:truncate_folio_batch_exceptionals+0xff/0x260
> [  5.267076] Code: 00 00 41 39 df 7f 11 eb 78 83 c3 01 49 83 c4 08 41 39 df 74 6c 48 63 f3 48 83 fe 1f 0f 83 3c 01 00 00 43 f6 44 26 08 01 74 df <0f> 0b 4a 8b 34 22 4c 89 ef 48 89 55 90 e8 ff 54 1f 00 48 8b 55 90
> [  5.267083] RSP: 0018:ffffc900013f36c8 EFLAGS: 00010202
> [  5.267095] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  5.267101] RDX: ffffc900013f3790 RSI: 0000000000000000 RDI: ffff8882a1407898
> [  5.267108] RBP: ffffc900013f3740 R08: 0000000000000000 R09: 0000000000000000
> [  5.267113] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  5.267119] R13: ffff8882a1407ab8 R14: ffffc900013f3888 R15: 0000000000000001
> [  5.267125] FS:  00007aaa8b437800(0000) GS:ffff88850025b000(0000) knlGS:0000000000000000
> [  5.267132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  5.267138] CR2: 00007aaa8b3aac10 CR3: 000000024f764000 CR4: 0000000000f52ef0
> [  5.267144] PKRU: 55555554
> [  5.267150] Call Trace:
> [  5.267154]  <TASK>
> [  5.267181]  truncate_inode_pages_range+0x118/0x5e0
> [  5.267193]  ? save_trace+0x54/0x390
> [  5.267296]  truncate_inode_pages_final+0x43/0x60
> [  5.267309]  evict+0x2a4/0x2c0
> [  5.267339]  dispose_list+0x39/0x80
> [  5.267352]  evict_inodes+0x150/0x1b0
> [  5.267376]  generic_shutdown_super+0x41/0x180
> [  5.267390]  kill_block_super+0x1b/0x50
> [  5.267402]  erofs_kill_sb+0x81/0x90 [erofs]
> [  5.267436]  deactivate_locked_super+0x32/0xb0
> [  5.267450]  deactivate_super+0x46/0x60
> [  5.267460]  cleanup_mnt+0xc3/0x170
> [  5.267475]  __cleanup_mnt+0x12/0x20
> [  5.267485]  task_work_run+0x5d/0xb0
> [  5.267499]  exit_to_user_mode_loop+0x144/0x170
> [  5.267512]  do_syscall_64+0x2b9/0x7c0
> [  5.267523]  ? __lock_acquire+0x665/0x2ce0
> [  5.267535]  ? __lock_acquire+0x665/0x2ce0
> [  5.267560]  ? lock_acquire+0xcd/0x300
> [  5.267573]  ? find_held_lock+0x31/0x90
> [  5.267582]  ? mntput_no_expire+0x97/0x4e0
> [  5.267606]  ? mntput_no_expire+0xa1/0x4e0
> [  5.267625]  ? mntput+0x24/0x50
> [  5.267634]  ? path_put+0x1e/0x30
> [  5.267647]  ? do_faccessat+0x120/0x2f0
> [  5.267677]  ? do_syscall_64+0x1a2/0x7c0
> [  5.267686]  ? from_kgid_munged+0x17/0x30
> [  5.267703]  ? from_kuid_munged+0x13/0x30
> [  5.267711]  ? __do_sys_getuid+0x3d/0x50
> [  5.267724]  ? do_syscall_64+0x1a2/0x7c0
> [  5.267732]  ? irqentry_exit+0x77/0xb0
> [  5.267743]  ? clear_bhb_loop+0x30/0x80
> [  5.267752]  ? clear_bhb_loop+0x30/0x80
> [  5.267765]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  5.267772] RIP: 0033:0x7aaa8b32a9fb
> [  5.267781] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e9 83 0d 00 f7 d8
> [  5.267787] RSP: 002b:00007ffd7c4c9468 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [  5.267796] RAX: 0000000000000000 RBX: 00005a61592a8b00 RCX: 00007aaa8b32a9fb
> [  5.267802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005a61592b2080
> [  5.267806] RBP: 00007ffd7c4c9540 R08: 00007aaa8b403b20 R09: 0000000000000020
> [  5.267812] R10: 0000000000000001 R11: 0000000000000246 R12: 00005a61592a8c00
> [  5.267817] R13: 0000000000000000 R14: 00005a61592b2080 R15: 00005a61592a8f10
> [  5.267849]  </TASK>
> [  5.267854] irq event stamp: 4721
> [  5.267859] hardirqs last  enabled at (4727): [<ffffffff814abf50>] __up_console_sem+0x90/0xa0
> [  5.267873] hardirqs last disabled at (4732): [<ffffffff814abf35>] __up_console_sem+0x75/0xa0
> [  5.267884] softirqs last  enabled at (3044): [<ffffffff8132adb3>] kernel_fpu_end+0x53/0x70
> [  5.267895] softirqs last disabled at (3042): [<ffffffff8132b5f4>] kernel_fpu_begin_mask+0xc4/0x120
> [  5.267905] ---[ end trace 0000000000000000 ]---
> 
> Fixes: bde708f1a65d ("fs/dax: always remove DAX page-cache entries when breaking layouts")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

