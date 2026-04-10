Return-Path: <linux-erofs+bounces-3258-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D4mOo+12GnnhAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3258-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:32:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB93D41F3
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:32:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsVQz30F6z2yZ6;
	Fri, 10 Apr 2026 18:32:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775809931;
	cv=none; b=S37xIODbEd6Z7JgPB69l6Wb++OdGrA2m+8RxKA087lZAlIIFG6fkZtXK2nuuPGdNcDNXPkO+Vo6CilaMgj4/BWOAfLtLwTrHZBbMbORCP1E8EZ3TR3S+skPEywSB3HMKsi8llqIMDlKNDtXDLY0IOIcN0Q8nio5yDOkuwUoiS+CocN81ptYODMtxWw++UTDPTORQdR8/Y2Ljv90rXTA71mdzRottoACW8wumHQASf+oMAHkyugc2kKbHfwVmOCH44hEWDrBGFfQ2w9FTgwSAL57go9avmBc4ttd6fpblIMXBYr4bgECguZc2jyWnu7KQYzS8kj/sssPzBjMVW9rhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775809931; c=relaxed/relaxed;
	bh=dPyMPxvi4nhRYlpYveFJVjwjJ1NTzMM36cxhGxW8zMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L35ORlnpwX8K4AB17bWA3jSGsRKUDSZ663iDYk1PNEKSt9133Nu8Am8KdywQ7AQWiw4fxg3QJaLcWuWw2GnsbyIJDbchwTmdSrIrEfgpKv0YS2jCWSv29l7wtnq2tuDFHSL/YDd1YUCC/F5FUV/QQak5ZjWcMDesMI31byv1pNbxeLtUtZZt7eoDNREWitBVnCv/rGn6jPSNXy/q1j2GmEt0MWGY0RKmb4zmdzI4qKMB1quTRRvvSLyXmnIBzdw4wJadtCyuFy9Pkjmu/RejHXhgLuS73Li8TxUWnXNcHLFYg3lwGmudKVV5ExvvK6Ewf3Ba3h2qRliNyzN3wqm1NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rqtA91cm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rqtA91cm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsVQx1jqhz2xTh
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 18:32:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775809923; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dPyMPxvi4nhRYlpYveFJVjwjJ1NTzMM36cxhGxW8zMM=;
	b=rqtA91cm71fISaKtI311pezjWmtsDtXGjitGZJv8rSuilYtg9emLV3bd0SfczJ7MyiRmiuMqe4tu5IVplDjf/VJ7O73gwWy0/i5hJ4jSrl/4BAp4dDMyZAnkVsLfZ1+6xRiUOfznhM35q+hdk8zeKxfadyuZcDRFxV5Y8I8z5Hs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0kiVXy_1775809921;
Received: from 30.221.132.105(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0kiVXy_1775809921 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 16:32:01 +0800
Message-ID: <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
Date: Fri, 10 Apr 2026 16:31:59 +0800
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
Subject: Re: erofs pointer corruption and kernel crash
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: oxffffaa@gmail.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Sheng Yong <shengyong1@xiaomi.com>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3258-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@salutedevices.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 12BB93D41F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 2026/4/10 16:13, Arseniy Krasnov wrote:
> Hi,
> 
> We found unexpected behaviour of erofs:
> 
> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
> 'struct folio' as first argument, and there is loop inside this function,
> which updates 'private' field of provided folio:
> 
>    do {
>            orig = atomic_read((atomic_t *)&folio->private);
>            DBG_BUGON(orig <= 0);
>            v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>            v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>    } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
> 
> Now, we see that in some rare case, this function processes folio, where
> 'private' is pointer, and thus this loop will update some bits in this
> pointer. Then later kernel dereferences such pointer and crashes.
> 
> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 33cb0a7330d2..b1d8deffec4d 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   {
>       int orig, v;
>   
> +    if (((uintptr_t)folio->private) & 0xffff000000000000) {

No, if erofs_onlinefolio_end() is called, `folio->private`
shouldn't be a pointer, it's just a counter inside, and
storing a pointer is unexpected.

And since the folio is locked, it shouldn't call into
try_to_free_buffers().

Is it easy to reproduce? if yes, can you print other
values like `folio->mapping` and `folio->index` as
well?

I need more informations to find some clues.

Thanks,
Gao Xiang

> +        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE BEFORE %px\n", __func__, __LINE__, folio, folio->private);
> +        dump_stack();
> +    }
> +
>       do {
>           orig = atomic_read((atomic_t *)&folio->private);
>           DBG_BUGON(orig <= 0);
> @@ -245,6 +250,9 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>           v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>   
> +    if (((uintptr_t)folio->private) & 0xffff000000000000)
> +        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE SET %px\n", __func__, __LINE__, folio, folio->private);
> +
>       if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
>           return;
>       folio->private = 0;
> 
> 
> And it gives result:
> 
> [][  T639] [foliodbg] erofs_onlinefolio_end:242 EROFS FOLIO fffffdffc0030440 PRIVATE BEFORE ffff000002b32468
> [][  T639] CPU: 0 UID: 0 PID: 639 Comm: kworker/0:6H Tainted: G O 6.15.11-sdkernel #1 PREEMPT
> [][  T639] Tainted: [O]=OOT_MODULE
> [][  T639] Workqueue: kverityd verity_work
> [][  T639] Call trace:
> [][  T639]  show_stack+0x18/0x30 (C)
> [][  T639]  dump_stack_lvl+0x60/0x80
> [][  T639]  dump_stack+0x18/0x24
> [][  T639]  erofs_onlinefolio_end+0x124/0x130
> [][  T639]  z_erofs_decompress_queue+0x4b0/0x8c0
> [][  T639]  z_erofs_decompress_kickoff+0x88/0x150
> [][  T639]  z_erofs_endio+0x144/0x250
> [][  T639]  bio_endio+0x138/0x150
> [][  T639]  __dm_io_complete+0x1e0/0x2b0
> [][  T639]  clone_endio+0xd0/0x270
> [][  T639]  bio_endio+0x138/0x150
> [][  T639]  verity_finish_io+0x64/0xf0
> [][  T639]  verity_work+0x30/0x40
> [][  T639]  process_one_work+0x180/0x2e0
> [][  T639]  worker_thread+0x2c4/0x3f0
> [][  T639]  kthread+0x12c/0x210
> [][  T639]  ret_from_fork+0x10/0x20
> [][  T639]
> [][  T639] [foliodbg] erofs_onlinefolio_end:254 EROFS FOLIO fffffdffc0030440 PRIVATE SET ffff000022b32467
> [][   T39] Unable to handle kernel paging request at virtual address ffff000022b32467
> [][   T39] Mem abort info:
> [][   T39]   ESR = 0x0000000096000006
> [][   T39]   EC = 0x25: DABT (current EL), IL = 32 bits
> [][   T39]   SET = 0, FnV = 0
> [][   T39]   EA = 0, S1PTW = 0
> [][   T39]   FSC = 0x06: level 2 translation fault
> [][   T39] Data abort info:
> [][   T39]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> [][   T39]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [][   T39]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [][   T39] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000001e36000
> [][   T39] [ffff000022b32467] pgd=1800000007fff403, p4d=1800000007fff403, pud=1800000007ffe403, pmd=0000000000000000
> [][   T39] Internal error: Oops: 0000000096000006 [#1]  SMP
> [][   T39] Modules linked in: vlsicomm(O)
> [][   T39] CPU: 1 UID: 0 PID: 39 Comm: kswapd0 Tainted: G O 6.15.11-sdkernel #1 PREEMPT
> [][   T39] Tainted: [O]=OOT_MODULE
> [][   T39] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [][   T39] pc : drop_buffers.constprop.0+0x34/0x120
> [][   T39] lr : try_to_free_buffers+0xd0/0x100
> [][   T39] sp : ffff80008105b780
> [][   T39] x29: ffff80008105b780 x28: 0000000000000000 x27: fffffdffc0030448
> [][   T39] x26: ffff80008105b8a0 x25: ffff80008105b868 x24: 0000000000000001
> [][   T39] x23: fffffdffc0030440 x22: ffff80008105b7b0 x21: fffffdffc0030440
> [][   T39] x20: ffff000022b32467 x19: ffff000022b32467 x18: 0000000000000000
> [][   T39] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000d69f4cc0
> [][   T39] x14: ffff0000000c5dc0 x13: 0000000000000000 x12: ffff800080d59b58
> [][   T39] x11: 00000000000000c0 x10: 0000000000000000 x9 : 0000000000000000
> [][   T39] x8 : ffff80008105b7d0 x7 : 0000000000000000 x6 : 000000000000003f
> [][   T39] x5 : 0000000000000000 x4 : fffffdffc0030440 x3 : 1ff0000000004001
> [][   T39] x2 : 1ff0000000004001 x1 : ffff80008105b7b0 x0 : fffffdffc0030440
> [][   T39] Call trace:
> [][   T39]  drop_buffers.constprop.0+0x34/0x120 (P)
> [][   T39]  try_to_free_buffers+0xd0/0x100
> [][   T39]  filemap_release_folio+0x94/0xc0
> [][   T39]  shrink_folio_list+0x8c8/0xc40
> [][   T39]  shrink_lruvec+0x740/0xb80
> [][   T39]  shrink_node+0x2b8/0x9a0
> [][   T39]  balance_pgdat+0x3b8/0x760
> [][   T39]  kswapd+0x220/0x3b0
> [][   T39]  kthread+0x12c/0x210
> [][   T39]  ret_from_fork+0x10/0x20
> [][   T39] Code: 14000004 f9400673 eb13029f 54000180 (f9400262)
> [][   T39] ---[ end trace 0000000000000000 ]---
> [][   T39] Kernel panic - not syncing: Oops: Fatal exception
> [][   T39] SMP: stopping secondary CPUs
> [][   T39] Kernel Offset: disabled
> [][   T39] CPU features: 0x0000,00000000,01000000,0200420b
> [][   T39] Memory Limit: none
> [][   T39] Rebooting in 5 seconds..
> 
> So 'erofs_onlinefolio_end()' takes some folio with 'private' field contains
> some pointer (0xffff000002b32468), "corrupts" this pointer (result will be
> 0xffff000022b32467 - at least we see that 0x20000000 was ORed to original
> pointer and this is (1 << EROFS_ONLINEFOLIO_DIRTY)), and then kernel crashes.
> We guess it is not valid case when such folio is passed as argument to
> 'erofs_onlinefolio_end()'.
> 
> We have the following erofs configuration in buildroot:
> 
> BR2_TARGET_ROOTFS_EROFS=y
> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
> BR2_TARGET_ROOTFS_EROFS_FRAGMENTS=y
> BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE=65536
> 
> 
> 
> May be You know how to fix it or some ideas? Because we are new at erofs and need to discover and
> learn its source code.
> 
> Thanks


