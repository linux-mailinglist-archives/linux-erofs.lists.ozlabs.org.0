Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 272369E313A
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2024 03:13:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y31JT4c7Dz30VK
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2024 13:12:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733278376;
	cv=none; b=B7Rap8budpNNkIR0DF1teQv0tAeUK+xD82X85EmgjioO8NVU8Rtzqxceln649jTqH2lO0rystPLm96xuQgUzX8HpaFD05zuqUw/ib8QkHZQz70NQwOpessAR2hJfC+K+UY698QFbTpIvx+K1Ac+Vt5jHo1G0nJUnLVMEkz+IP+ZVJUl5dgMLn5PYjzDCmsBgsH8e6eGzY2i+kSzVBV4ge44XsR9biWTb09GEaVPHtDoi4vQg2jddgZvlhUTvlNCNPJ0LlGeg0SLcESNveTKVjpRBMV/I5a11jhM+YahEzWt/IRyFhede9wFhjhS8P0a5yjIHkL9ViyeHXu84uabXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733278376; c=relaxed/relaxed;
	bh=g5gsjhvOhFxzwq83Lz4lsBhAQcZ8kfOOYigLnb8TSiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlEqJL/EhWer4LN6jwdIYYyUfP9shMjH6mvzcnWbv25u1W9i93pcmZr8yaMWArvsZE39nZZWf7aPIhvESP1A0vtvcbL7hIM1rbSAeNYjsa9ovmW4JwIyZKtg4qOFeaOVFZTJj0PtxSh8Cy2NhFvm7x1X2OOxK/7KMmw8SVN3D4cZSOhnwstZBGAtA8Z7Nbk0Hhjz45n0FF8WksDpFKA9eYSBrzuE4lk432wlcYZ4Tv2ZYYZmTeX+qI9i56Kn0+gwXz733/6Lah+TtdqGIIUaz3qRixPBGBckUPkL5C3jIk4i5byBdV2OjODl345hcFqn/k50Y+OSRIRdkpPCyt5VJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DmzHCaeF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DmzHCaeF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y31JM0KVTz30TQ
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Dec 2024 13:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733278358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g5gsjhvOhFxzwq83Lz4lsBhAQcZ8kfOOYigLnb8TSiA=;
	b=DmzHCaeFekAtL3SInADq/9pKA28hm/NSgpqQfWiZ+U3wE1YxvGsPC2D7WD3s0FJfulzaACjD+Ur0pRRg4puxT0oHZarCtrlyockr5a9wgmIqDABWG5hkRDB9ah9MTVRBb/XvIgmHA1iynpRS/95KAYV533jqF3e1+rVLEM6lpUk=
Received: from 30.221.130.89(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKoKN8w_1733278356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 10:12:36 +0800
Message-ID: <b0454659-630e-44a4-b309-f6d9cd0fbc63@linux.alibaba.com>
Date: Wed, 4 Dec 2024 10:12:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Max Kellermann <max.kellermann@ionos.com>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
 <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
 <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
 <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/3 22:00, Max Kellermann wrote:
> On Tue, Dec 3, 2024 at 2:30 PM Max Kellermann <max.kellermann@ionos.com> wrote:
>> __builtin_return_address(1) instantly crashes the kernel
> 
> I was able to capture the __builtin_return_address crash on a serial
> console (this has nothing to do with the PSI memstall bug):

Ok.. so __builtin_return_address(1) doesn't actually work?

Thanks,
Gao Xiang

> 
> [16438.331677] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [16438.338693] #PF: supervisor read access in kernel mode
> [16438.343866] #PF: error_code(0x0000) - not-present page
> [16438.349038] PGD 0 P4D 0
> [16438.351588] Oops: Oops: 0000 [#1] SMP PTI
> [16438.355625] CPU: 18 UID: 2147486501 PID: 23486 Comm: less Not
> tainted 6.11.10-cm4all4-hp+ #291
> [16438.364297] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
> Gen10, BIOS U30 09/05/2019
> [16438.372880] RIP: 0010:psi_memstall_enter+0x7f/0xa0
> [16438.377708] Code: 89 df 80 8b 19 05 00 00 01 48 8b 45 08 48 89 83
> c0 08 00 00 48 8b 45 00 48 8b 40 08 48 89 83 c8 08 00 00 48 8b 45 00
> 48 8b 00 <48> 8b 40 08 48 89 83 d0 08 00 00 e8 d1 fe ff ff 4c 89 e7 e8
> 29 28
> [16438.396609] RSP: 0000:ffff9ee683bc7bd0 EFLAGS: 00010002
> [16438.401869] RAX: 0000000000000000 RBX: ffff90c70c291740 RCX: 0000000000000001
> [16438.409052] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff90c70c291740
> [16438.416234] RBP: ffff9ee683bc7be0 R08: 000000000007cec1 R09: 0000000000000007
> [16438.423418] R10: ffff90c727d83678 R11: 0000000000000000 R12: ffff9124bd0ae000
> [16438.430600] R13: 0000000000000014 R14: ffff9ee683bc7ce8 R15: 0000000000000000
> [16438.437785] FS:  00007ff15f1f4740(0000) GS:ffff9124bd080000(0000)
> knlGS:0000000000000000
> [16438.445929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16438.451714] CR2: 0000000000000008 CR3: 000000010c54a002 CR4: 00000000007706f0
> [16438.458896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [16438.466079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [16438.473263] PKRU: 55555554
> [16438.475984] Call Trace:
> [16438.478446]  <TASK>
> [16438.480557]  ? __die+0x1f/0x60
> [16438.483636]  ? page_fault_oops+0x15c/0x450
> [16438.487761]  ? exc_page_fault+0x5e/0x100
> [16438.491710]  ? asm_exc_page_fault+0x22/0x30
> [16438.495923]  ? psi_memstall_enter+0x7f/0xa0
> [16438.500135]  read_pages+0x205/0x220
> [16438.503647]  ? free_unref_page+0x2c1/0x420
> [16438.507771]  page_cache_ra_order+0x1d3/0x2b0
> [16438.512069]  filemap_fault+0x548/0xba0
> [16438.515845]  __do_fault+0x32/0x90
> [16438.519182]  do_fault+0x2a1/0x4a0
> [16438.522519]  __handle_mm_fault+0x337/0x1ca0
> [16438.526730]  handle_mm_fault+0x128/0x260
> [16438.530677]  do_user_addr_fault+0x1d8/0x5b0
> [16438.534889]  exc_page_fault+0x5e/0x100
> [16438.538663]  asm_exc_page_fault+0x22/0x30
> [16438.542697] RIP: 0033:0x55ebb60829a0
> [16438.546298] Code: Unable to access opcode bytes at 0x55ebb6082976.
> [16438.552519] RSP: 002b:00007fffd2a03658 EFLAGS: 00010246
> [16438.557779] RAX: 0000000000000016 RBX: 000055ebdb88b410 RCX: 000055ebdb88b410
> [16438.564963] RDX: 0000000000000ee4 RSI: 000055ec5b0b1e30 RDI: 000055ebdb88b910
> [16438.572147] RBP: 0000000000000010 R08: 00000000ffffffff R09: 0000000000000000
> [16438.579331] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000046
> [16438.586514] R13: 000055ebb6099e6c R14: 000055ebb6099c93 R15: 00007fffd2a03706
> [16438.593697]  </TASK>
> [16438.595895] Modules linked in:
> [16438.598970] CR2: 0000000000000008
> [16438.602307] ---[ end trace 0000000000000000 ]---

