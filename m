Return-Path: <linux-erofs+bounces-3257-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMq5BXCz2Gk8hAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3257-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:23:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB93D3FF5
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 10:23:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsVDW4WdBz2yZ6;
	Fri, 10 Apr 2026 18:23:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775809387;
	cv=none; b=ismXTrnFei2DyipN6tk3OUF8+r/LgW9Z6xytXImCYkXlfE23VdVPKc+kvcserZHQEHh25VBK1HXiW6uhod7u2SfINtXVNyRlUjvmtCqfALOoCgrdPQzinOMknrov/Wh1uKQ9cHvEh0XoIa1NId6EbnCJOxM2A0YcqQlJ4yehASKyBM6TsXgiMDjn8A/Z589MjKnqfh3XKL6i9c43htv28vthiZkqabziIhkBoOg4rVwSTO/gi9WdVdP8jEBINyOPFa5FCy/WLSqzifqOPpOJweazekkPLKsPrU9qkLu2AWk7PtREj36WyOP5CQo60SL7WOGZVdg+wSMMM40ssHjsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775809387; c=relaxed/relaxed;
	bh=3YjvK3khsXo5IRmJJATArtQ7PzxMudXTICvAedp2NLI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=Xplcy9g1aSZ9xDnJd+WhoXkEmnIIyO1JuonUK9pDtGIMSnsOILc5SqcIWDKbKJkEzNiAMwFqS9ku21zrwBVslK3CBKbkTgbvzhpaNMkLtBxJU8gNjOiQfWLPXYqxV8vz5N3fWTrYY4ITLfnbwaZgh9J8+eEJAh0X39WTAuKnwSYPyLaWB2va/cVLGbj98lKk/T/rqzGTqZu0VMti/fwbghLaoHLLr02oW6QIJclT8SrfHAGAJW6jOKSNkNshM5o2EOwDKQQtGuqNLmzycKgesWTHbk3vwq1UUYZpHooyrV4PQptpqKc4Tv722VdIUcIZJWnH4Cku4mR/hN6jWWd5WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=aikzJT1h; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=aikzJT1h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 546 seconds by postgrey-1.37 at boromir; Fri, 10 Apr 2026 18:23:04 AEST
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsVDS4SLQz2xTh
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 18:23:04 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id D07E1240014;
	Fri, 10 Apr 2026 11:13:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru D07E1240014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775808831;
	bh=3YjvK3khsXo5IRmJJATArtQ7PzxMudXTICvAedp2NLI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=aikzJT1hfmQKzmOtPSIWB2C/cjLUJmI/j5c1kgxW0ONB40ax83g7LchNMF4LcB07M
	 D0bR8ynLc9djggX4lU8UMH2roz3yVyUt7tV4L76+x9pX15IIjyx6DlwQVE/qLyHTGB
	 SsV7BR6sIHvagPVrsg/NnXetejN7tqC+WvzPBNx/IIxzwQCQM1U9Z3RVLrX/bTmvn5
	 Ww3bRfrOLmPbOZT3qeF2wIeMU7Tp5kl5jTVE5YQlglw+1U2biZNa0y+3vrt22/Q7gm
	 9w6t2SWsZSrGoDrfRytvI1TgbFGBYDYxZ7/WEkbZWj5B9Si9RQXE+Ih/mSFP25WFze
	 agiXUEqM7AIAw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Apr 2026 11:13:51 +0300 (MSK)
Message-ID: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
Date: Fri, 10 Apr 2026 11:13:46 +0300
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
Content-Language: ru
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Sheng Yong
	<shengyong1@xiaomi.com>
CC: <oxffffaa@gmail.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: erofs pointer corruption and kernel crash
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202160 [Apr 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/09 21:06:00 #28382314
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3257-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[salutedevices.com:dkim,salutedevices.com:mid]
X-Rspamd-Queue-Id: 7FCB93D3FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

We found unexpected behaviour of erofs:

There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
'struct folio' as first argument, and there is loop inside this function,
which updates 'private' field of provided folio:

  do {
          orig = atomic_read((atomic_t *)&folio->private);
          DBG_BUGON(orig <= 0);
          v = dirty << EROFS_ONLINEFOLIO_DIRTY;
          v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
  } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);

Now, we see that in some rare case, this function processes folio, where
'private' is pointer, and thus this loop will update some bits in this
pointer. Then later kernel dereferences such pointer and crashes.

To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 33cb0a7330d2..b1d8deffec4d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
     int orig, v;
 
+    if (((uintptr_t)folio->private) & 0xffff000000000000) {
+        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE BEFORE %px\n", __func__, __LINE__, folio, folio->private);
+        dump_stack();
+    }
+
     do {
         orig = atomic_read((atomic_t *)&folio->private);
         DBG_BUGON(orig <= 0);
@@ -245,6 +250,9 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
         v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
     } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
+    if (((uintptr_t)folio->private) & 0xffff000000000000)
+        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE SET %px\n", __func__, __LINE__, folio, folio->private);
+
     if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
         return;
     folio->private = 0;


And it gives result:

[][  T639] [foliodbg] erofs_onlinefolio_end:242 EROFS FOLIO fffffdffc0030440 PRIVATE BEFORE ffff000002b32468
[][  T639] CPU: 0 UID: 0 PID: 639 Comm: kworker/0:6H Tainted: G O 6.15.11-sdkernel #1 PREEMPT
[][  T639] Tainted: [O]=OOT_MODULE
[][  T639] Workqueue: kverityd verity_work
[][  T639] Call trace:
[][  T639]  show_stack+0x18/0x30 (C)
[][  T639]  dump_stack_lvl+0x60/0x80
[][  T639]  dump_stack+0x18/0x24
[][  T639]  erofs_onlinefolio_end+0x124/0x130
[][  T639]  z_erofs_decompress_queue+0x4b0/0x8c0
[][  T639]  z_erofs_decompress_kickoff+0x88/0x150
[][  T639]  z_erofs_endio+0x144/0x250
[][  T639]  bio_endio+0x138/0x150
[][  T639]  __dm_io_complete+0x1e0/0x2b0
[][  T639]  clone_endio+0xd0/0x270
[][  T639]  bio_endio+0x138/0x150
[][  T639]  verity_finish_io+0x64/0xf0
[][  T639]  verity_work+0x30/0x40
[][  T639]  process_one_work+0x180/0x2e0
[][  T639]  worker_thread+0x2c4/0x3f0
[][  T639]  kthread+0x12c/0x210
[][  T639]  ret_from_fork+0x10/0x20
[][  T639]
[][  T639] [foliodbg] erofs_onlinefolio_end:254 EROFS FOLIO fffffdffc0030440 PRIVATE SET ffff000022b32467
[][   T39] Unable to handle kernel paging request at virtual address ffff000022b32467
[][   T39] Mem abort info:
[][   T39]   ESR = 0x0000000096000006
[][   T39]   EC = 0x25: DABT (current EL), IL = 32 bits
[][   T39]   SET = 0, FnV = 0
[][   T39]   EA = 0, S1PTW = 0
[][   T39]   FSC = 0x06: level 2 translation fault
[][   T39] Data abort info:
[][   T39]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[][   T39]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[][   T39]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[][   T39] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000001e36000
[][   T39] [ffff000022b32467] pgd=1800000007fff403, p4d=1800000007fff403, pud=1800000007ffe403, pmd=0000000000000000
[][   T39] Internal error: Oops: 0000000096000006 [#1]  SMP
[][   T39] Modules linked in: vlsicomm(O)
[][   T39] CPU: 1 UID: 0 PID: 39 Comm: kswapd0 Tainted: G O 6.15.11-sdkernel #1 PREEMPT
[][   T39] Tainted: [O]=OOT_MODULE
[][   T39] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[][   T39] pc : drop_buffers.constprop.0+0x34/0x120
[][   T39] lr : try_to_free_buffers+0xd0/0x100
[][   T39] sp : ffff80008105b780
[][   T39] x29: ffff80008105b780 x28: 0000000000000000 x27: fffffdffc0030448
[][   T39] x26: ffff80008105b8a0 x25: ffff80008105b868 x24: 0000000000000001
[][   T39] x23: fffffdffc0030440 x22: ffff80008105b7b0 x21: fffffdffc0030440
[][   T39] x20: ffff000022b32467 x19: ffff000022b32467 x18: 0000000000000000
[][   T39] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000d69f4cc0
[][   T39] x14: ffff0000000c5dc0 x13: 0000000000000000 x12: ffff800080d59b58
[][   T39] x11: 00000000000000c0 x10: 0000000000000000 x9 : 0000000000000000
[][   T39] x8 : ffff80008105b7d0 x7 : 0000000000000000 x6 : 000000000000003f
[][   T39] x5 : 0000000000000000 x4 : fffffdffc0030440 x3 : 1ff0000000004001
[][   T39] x2 : 1ff0000000004001 x1 : ffff80008105b7b0 x0 : fffffdffc0030440
[][   T39] Call trace:
[][   T39]  drop_buffers.constprop.0+0x34/0x120 (P)
[][   T39]  try_to_free_buffers+0xd0/0x100
[][   T39]  filemap_release_folio+0x94/0xc0
[][   T39]  shrink_folio_list+0x8c8/0xc40
[][   T39]  shrink_lruvec+0x740/0xb80
[][   T39]  shrink_node+0x2b8/0x9a0
[][   T39]  balance_pgdat+0x3b8/0x760
[][   T39]  kswapd+0x220/0x3b0
[][   T39]  kthread+0x12c/0x210
[][   T39]  ret_from_fork+0x10/0x20
[][   T39] Code: 14000004 f9400673 eb13029f 54000180 (f9400262)
[][   T39] ---[ end trace 0000000000000000 ]---
[][   T39] Kernel panic - not syncing: Oops: Fatal exception
[][   T39] SMP: stopping secondary CPUs
[][   T39] Kernel Offset: disabled
[][   T39] CPU features: 0x0000,00000000,01000000,0200420b
[][   T39] Memory Limit: none
[][   T39] Rebooting in 5 seconds..

So 'erofs_onlinefolio_end()' takes some folio with 'private' field contains
some pointer (0xffff000002b32468), "corrupts" this pointer (result will be
0xffff000022b32467 - at least we see that 0x20000000 was ORed to original
pointer and this is (1 << EROFS_ONLINEFOLIO_DIRTY)), and then kernel crashes.
We guess it is not valid case when such folio is passed as argument to
'erofs_onlinefolio_end()'.

We have the following erofs configuration in buildroot:

BR2_TARGET_ROOTFS_EROFS=y
BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
BR2_TARGET_ROOTFS_EROFS_FRAGMENTS=y
BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE=65536



May be You know how to fix it or some ideas? Because we are new at erofs and need to discover and
learn its source code.

Thanks

