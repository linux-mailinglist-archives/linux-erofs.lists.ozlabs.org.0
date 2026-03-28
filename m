Return-Path: <linux-erofs+bounces-3061-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBVaOc8cyGkShAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3061-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:24:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6A34F88D
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:24:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjmB25Jv3z2ySc;
	Sun, 29 Mar 2026 05:24:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.255.12.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774722250;
	cv=none; b=NJKXSEi2/90wCHxUfBMKCEFMfMqW56lC0rFFDxz3rUIS6bPLebcikjhUHhhSkZoV/7XcH4O0kWAMGGiyTd/g/Zj8vAYvnjjfmf/YKcvUhNJ5bD6hWpRI1UX744qNIQET2srmJjKmbSW0HRezk7aCWzyTu9LR991OQTFvgaHh0Lfaxc22snlLgTQvvmhURQv3G5UGrA02iIwkQO9tAn3SYTGSvyYIsnEnptXJ1D1jdXpCqRZlREc5K2xqDEAh8B3Vp52vJS7KZFO+VYgi3aiWPfKjIqjSocCm7B+J3IwSVNVZubLz5nP8jdLT883+6VmonVhffeUfscX5rcocXEPFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774722250; c=relaxed/relaxed;
	bh=CnwLiOiEwGodP5DTt0UILplopV/lgZmVDsfGPJfHItk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=SD3ZcZT0OZOvHfR3VMphUVm8jznedE8O1e2Qk5I0/kJSPIPmK9p5D4AGPtBUkhu4FKrQ8i5iny5jEmsdofa3xAOfj4nJpY6zY6uphevmoYJwdO9fbQXfrv2RLtLLL+pwL7QVjDUPeIZGDYxtScouIAB+Daw3+0s/7h8qAifr2qWynD51hAry/sBl20c8DDxD9naC6PCd3Jns1p4Ib4BPUHkAZ2ZLgKCH059c14v/UMkEVg2CLNcSZftM8MUlptPw8Vb6/yGD9ztYEemDnl6AgcLsrLl3LtNJQUurM7sLEkSX9gjFe/AbayfVhn2/GPZ7HRErq4KPtFTWWxy0dM2sNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=2jHfjvyK; dkim-atps=neutral; spf=pass (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org) smtp.mailfrom=manguebit.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=2jHfjvyK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.org (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 194 seconds by postgrey-1.37 at boromir; Sun, 29 Mar 2026 05:24:09 AEDT
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjmB12ZMwz2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 05:24:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CnwLiOiEwGodP5DTt0UILplopV/lgZmVDsfGPJfHItk=; b=2jHfjvyKT+by9pRtne1C0sXftl
	B1JxRLn5wUBbUpPMcqJoPIr9tWW0nS+2N8BWa8oBWll9oafhx/7wZIZeJ/1M2sq5WtHRmEadrQU8S
	ysWK4eH9Ql78kPnakUOvXOHZrSAvuxuh0MVUVhp1G756hLSr7h3tzMrw4DW4ZBsgEeNuMapoa8H5o
	bxLJ007k2++KxeDFs4OQpuvU1kvHSGkO+Zyb8e0wYi1CCoPPSVkE9bnmyJTr/V2mmXqpLyv5218zo
	xEV/35PmzhrBrQ1U1QP4NCa40FLWZwdztKjEyiXKVu9v8YAtTOxj74NxlO3KceT5QO2WCB7olrLjy
	KsSmy25g==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YKM-00000001nhL-1HSW;
	Sat, 28 Mar 2026 15:24:06 -0300
Message-ID: <9ba3ab4745fda6aaec36910ad4089e84@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Leon
 Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne
 <marc.dionne@auristor.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov
 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: Re: [PATCH 03/26] netfs: fix VM_BUG_ON_FOLIO() issue in
 netfs_write_begin() call
In-Reply-To: <20260326104544.509518-4-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-4-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:24:06 -0300
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
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3061-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Slava.Dubeyko@ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,ibm.com];
	FORGED_SENDER(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:dkim,manguebit.org:email,manguebit.org:mid,linux.dev:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B4E6A34F88D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The multiple runs of generic/013 test-case is capable
> to reproduce a kernel BUG at mm/filemap.c:1504 with
> probability of 30%.
>
> while true; do
>   sudo ./check generic/013
> done
>
> [ 9849.452376] page: refcount:3 mapcount:0 mapping:00000000e58ff252 index:0x10781 pfn:0x1c322
> [ 9849.452412] memcg:ffff8881a1915800
> [ 9849.452417] aops:ceph_aops ino:1000058db9e dentry name(?):"f9XXXXXX"
> [ 9849.452432] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [ 9849.452441] raw: 0017ffffc0000000 0000000000000000 dead000000000122 ffff88816110d248
> [ 9849.452445] raw: 0000000000010781 0000000000000000 00000003ffffffff ffff8881a1915800
> [ 9849.452447] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
> [ 9849.452474] ------------[ cut here ]------------
> [ 9849.452476] kernel BUG at mm/filemap.c:1504!
> [ 9849.478635] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [ 9849.481772] CPU: 2 UID: 0 PID: 84223 Comm: fsstress Not tainted 7.0.0-rc1+ #18 PREEMPT(full)
> [ 9849.482881] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/1
> 0/2025
> [ 9849.484539] RIP: 0010:folio_unlock+0x85/0xa0
> [ 9849.485076] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc
> cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
> [ 9849.493818] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
> [ 9849.495740] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
> [ 9849.498678] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 9849.500559] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
> [ 9849.501097] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
> [ 9849.502108] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
> [ 9849.502516] FS:  00007e36cbe94740(0000) GS:ffff88824a899000(0000) knlGS:0000000000000000
> [ 9849.502996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9849.503810] CR2: 000000c0002b0000 CR3: 000000011bbf6004 CR4: 0000000000772ef0
> [ 9849.504459] PKRU: 55555554
> [ 9849.504626] Call Trace:
> [ 9849.505242]  <TASK>
> [ 9849.505379]  netfs_write_begin+0x7c8/0x10a0
> [ 9849.505877]  ? __kasan_check_read+0x11/0x20
> [ 9849.506384]  ? __pfx_netfs_write_begin+0x10/0x10
> [ 9849.507178]  ceph_write_begin+0x8c/0x1c0
> [ 9849.507934]  generic_perform_write+0x391/0x8f0
> [ 9849.508503]  ? __pfx_generic_perform_write+0x10/0x10
> [ 9849.509062]  ? file_update_time_flags+0x19a/0x4b0
> [ 9849.509581]  ? ceph_get_caps+0x63/0xf0
> [ 9849.510259]  ? ceph_get_caps+0x63/0xf0
> [ 9849.510530]  ceph_write_iter+0xe79/0x1ae0
> [ 9849.511282]  ? __pfx_ceph_write_iter+0x10/0x10
> [ 9849.511839]  ? lock_acquire+0x1ad/0x310
> [ 9849.512334]  ? ksys_write+0xf9/0x230
> [ 9849.512582]  ? lock_is_held_type+0xaa/0x140
> [ 9849.513128]  vfs_write+0x512/0x1110
> [ 9849.513634]  ? __fget_files+0x33/0x350
> [ 9849.513893]  ? __pfx_vfs_write+0x10/0x10
> [ 9849.514143]  ? mutex_lock_nested+0x1b/0x30
> [ 9849.514394]  ksys_write+0xf9/0x230
> [ 9849.514621]  ? __pfx_ksys_write+0x10/0x10
> [ 9849.514887]  ? do_syscall_64+0x25e/0x1520
> [ 9849.515122]  ? __kasan_check_read+0x11/0x20
> [ 9849.515366]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.515655]  __x64_sys_write+0x72/0xd0
> [ 9849.515885]  ? trace_hardirqs_on+0x24/0x1c0
> [ 9849.516130]  x64_sys_call+0x22f/0x2390
> [ 9849.516341]  do_syscall_64+0x12b/0x1520
> [ 9849.516545]  ? do_syscall_64+0x27c/0x1520
> [ 9849.516783]  ? do_syscall_64+0x27c/0x1520
> [ 9849.517003]  ? lock_release+0x318/0x480
> [ 9849.517220]  ? __x64_sys_io_getevents+0x143/0x2d0
> [ 9849.517479]  ? percpu_ref_put_many.constprop.0+0x8f/0x210
> [ 9849.517779]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.518073]  ? do_syscall_64+0x25e/0x1520
> [ 9849.518291]  ? __kasan_check_read+0x11/0x20
> [ 9849.518519]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.518799]  ? do_syscall_64+0x27c/0x1520
> [ 9849.519024]  ? local_clock_noinstr+0xf/0x120
> [ 9849.519262]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.519544]  ? do_syscall_64+0x25e/0x1520
> [ 9849.519781]  ? __kasan_check_read+0x11/0x20
> [ 9849.520008]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.520273]  ? do_syscall_64+0x27c/0x1520
> [ 9849.520491]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.520767]  ? irqentry_exit+0x10c/0x6c0
> [ 9849.520984]  ? trace_hardirqs_off+0x86/0x1b0
> [ 9849.521224]  ? exc_page_fault+0xab/0x130
> [ 9849.521472]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.521766] RIP: 0033:0x7e36cbd14907
> [ 9849.521989] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [ 9849.523057] RSP: 002b:00007ffff2d2a968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 9849.523484] RAX: ffffffffffffffda RBX: 000000000000e549 RCX: 00007e36cbd14907
> [ 9849.523885] RDX: 000000000000e549 RSI: 00005bd797ec6370 RDI: 0000000000000004
> [ 9849.524277] RBP: 0000000000000004 R08: 0000000000000047 R09: 00005bd797ec6370
> [ 9849.524652] R10: 0000000000000078 R11: 0000000000000246 R12: 0000000000000049
> [ 9849.525062] R13: 0000000010781a37 R14: 00005bd797ec6370 R15: 0000000000000000
> [ 9849.525447]  </TASK>
> [ 9849.525574] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irqbypass ghash_clmulni_intel aesni_intel input_leds rapl mac_hid psmouse vga16fb serio_raw vgastate floppy i2c_piix4 bochs qemu_fw_cfg i2c_smbus pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> [ 9849.529150] ---[ end trace 0000000000000000 ]---
> [ 9849.529502] RIP: 0010:folio_unlock+0x85/0xa0
> [ 9849.530813] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
> [ 9849.534986] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
> [ 9849.536198] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
> [ 9849.537718] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 9849.539321] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
> [ 9849.540862] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
> [ 9849.542438] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
> [ 9849.543996] FS:  00007e36cbe94740(0000) GS:ffff88824b899000(0000) knlGS:0000000000000000
> [ 9849.545854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9849.547092] CR2: 00007e36cb3ff000 CR3: 000000011bbf6006 CR4: 0000000000772ef0
> [ 9849.548679] PKRU: 55555554
>
> The race sequence:
> 1. Read completes -> netfs_read_collection() runs
> 2. netfs_wake_rreq_flag(rreq, NETFS_RREQ_IN_PROGRESS, ...)
> 3. netfs_wait_for_read() returns -EFAULT to netfs_write_begin()
> 4. The netfs_unlock_abandoned_read_pages() unlocks the folio
> 5. netfs_write_begin() calls folio_unlock(folio) -> VM_BUG_ON_FOLIO()
>
> The key reason of the issue that netfs_unlock_abandoned_read_pages()
> doesn't check the flag NETFS_RREQ_NO_UNLOCK_FOLIO and executes
> folio_unlock() unconditionally. This patch implements in
> netfs_unlock_abandoned_read_pages() logic similar to
> netfs_unlock_read_folio().
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/read_retry.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

