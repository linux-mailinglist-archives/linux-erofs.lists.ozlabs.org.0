Return-Path: <linux-erofs+bounces-3510-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1QAHMAXNH2o2qAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3510-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 08:43:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E467634BD3
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 08:43:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3510-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3510-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVdSK5hPlz2yNn;
	Wed, 03 Jun 2026 16:43:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468993;
	cv=none; b=gqF2yDlobsQks9QlHEgVVUmPh+vJJbPtBQriwK4ta4ljPbCwo3nZfU7IhsIIulFinTxJrXdhcX7UP9llQWyTl4dHoWOYXvOJaXK5bxVJjzWjO8TFrZoH9XyQ8gLdDbRdDIB0Bq+SW43z/BELYwYN5gn7ciiUiEcY6t6Rg8xslUQ9SOeaD6463qnQZsdlASPsIZ5BjLLmPTFL+bL1GILussw1bDrYop7Xru5eLRTU//1vAEFLxuYzIcSv9KbzkBSsOWYhXhrUc6Tm1sasx8sUCqQwPmZ/USQ4XmvEX/qfY6zV+Rl5Q9U0743w1pLslOu8pT36QHOW8MRNtIFEENRWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468993; c=relaxed/relaxed;
	bh=BXLTeHlKrc/+j7C9QPbOJLUrs1rqjWUe2L1pYvC54MA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DX4r538wIPDSq7zJoM2s43c84hYj8SwFdRdHH2PTcGD8i7fxGJiVjTuXJftFSw4HSfG4RTTNdn8L9fCA/1H85vFlGs7n5hK2RXozdQUQitcxHXyPVJEiqe9QG2RArNE9L53I/Phcz9QkADdUZbO2IMGlkVXZV/Uu1x/DWNuSEFD1h4DuIAJKWamNsuQqObg6E8akG9f5Qv/zkpSdvkKQc74o0NtHRVf9qMjhA6/THS8iA8b8+PeQpCOUvXQfpTMZhAjljqawzM1LCx4lXIRaJFhiZR1sa/8vMwSL29rpv6Lkkpf18pjQkhahHu0R8xkXvgIyUw7RqEXQ+xIYczt/8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.161.71; helo=mail-oo1-f71.google.com; envelope-from=3-swfagkbagsbhitjuunajyyrm.pxxpundbnalxwcnwc.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVdSH4vYkz2xc2
	for <linux-erofs@lists.ozlabs.org>; Wed, 03 Jun 2026 16:43:10 +1000 (AEST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69d941fbbe1so12076269eaf.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2026 23:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468987; x=1781073787;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXLTeHlKrc/+j7C9QPbOJLUrs1rqjWUe2L1pYvC54MA=;
        b=kfsy85wVI3IxAsvz+bHsEoLnGVDbsERy7F6zn+m0aMJ5gifmMfSNVy0SjgGQGtuYXS
         Q3byoo14oBBjLyrlem9BBw+F2M3DGFoDnK9SE+WlwlPDubyFhWSluarWBr9YsCV5rR6i
         J8881dAZVNsrSElcIMYiG7n0FKdqcE6JlHr6qbIKcKFcUep1bpH0nvLaohv4pxL0Pu+C
         OiNj+KjrJuZrJsu6z7EEECeHlDj4nJ+/DvYnhkIgzpS5cCcLYGBbsTCiXB9njkkEbGxG
         4KH3xCgRD1oUV4rYhdbkdUPHKOikDRjO+h4Gs6LcZmVr+G3/9mTAPj2uDQUyEjhqzjjY
         qAOw==
X-Forwarded-Encrypted: i=1; AFNElJ/KTjxFiWX0MDBpCHganGkbrwBL7/Dadr5crgoE4RoSU4ovsoC99G0OVPxG7qHPiFmKMQgww4pJUsmL8Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3JC4XsmN6r1tPz6ApVw5m5TBpn2TySt/tJd4F5ggwM6QxR7r2
	gwKlPf/UpKs9GGW2ZF+7fPqMgu1VsF9ogrctpy/3QWLp9gA+bldx4tqT6JnG59ZBTBBJrv/RIeE
	3WW5EuZeZLtONfn7lV+WE21g1N47MHYfx6bd4GJwjRjlGj/icvmyscQqkPgE=
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
X-Received: by 2002:a05:6820:180c:b0:696:637e:4831 with SMTP id
 006d021491bc7-69e47f0669emr1446323eaf.25.1780468986990; Tue, 02 Jun 2026
 23:43:06 -0700 (PDT)
Date: Tue, 02 Jun 2026 23:43:06 -0700
In-Reply-To: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1fccfa.278b5b03.2bcf39.0048.GAE@google.com>
Subject: [syzbot ci] Re: fs: support freeze/thaw/mark_dead/sync with shared devices
From: syzbot ci <syzbot+ci2e0a11d6a5730bb0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, cem@kernel.org, clm@fb.com, 
	dsterba@suse.com, hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, xiang@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:brauner@kernel.org,m:cem@kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:hch@lst.de,m:jack@suse.cz,m:linux-block@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:tytso@mit.edu,m:viro@zeniv.linux.org.uk,m:xiang@kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3510-lists,linux-erofs=lfdr.de,ci2e0a11d6a5730bb0];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,appspotmail.com:email,syzbot.org:url,googlegroups.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E467634BD3

syzbot ci has tested the following series

[v1] fs: support freeze/thaw/mark_dead/sync with shared devices
https://lore.kernel.org/all/20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org
* [PATCH RFC 1/8] fs, block: move blk_mode_t and fop_flags_t into <linux/types.h>
* [PATCH RFC 2/8] fs: add a global device to super block hash table
* [PATCH RFC 3/8] fs: refuse to claim any frozen block device
* [PATCH RFC 4/8] xfs: port to fs_bdev_file_open_by_path()
* [PATCH RFC 5/8] btrfs: open via dedicated fs bdev helpers
* [PATCH RFC 6/8] ext4: open via dedicated fs bdev helpers
* [PATCH RFC 7/8] erofs: open via dedicated fs bdev helpers
* [PATCH RFC 8/8] super: make fs_holder_ops private

and found the following issue:
general protection fault in close_fs_devices

Full report is available here:
https://ci.syzbot.org/series/9511f00a-a3c2-44ab-9a0b-2d65de5bbd49

***

general protection fault in close_fs_devices

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/4af26755-5773-453e-807d-ee451d2fdec5/config
syz repro: https://ci.syzbot.org/findings/2d8d96f7-d133-47dc-b4ca-5c0c65e1b6c9/syz_repro

btrfs: Deprecated parameter 'usebackuproot'
BTRFS warning: 'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead
BTRFS: device fsid ed167579-eb65-4e76-9a50-61ac97e9b59d devid 1281 transid 8 /dev/loop1 (7:1) scanned by syz.1.18 (5863)
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000f8: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000007c0-0x00000000000007c7]
CPU: 1 UID: 0 PID: 5863 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:btrfs_close_bdev fs/btrfs/volumes.c:1140 [inline]
RIP: 0010:btrfs_close_one_device fs/btrfs/volumes.c:1161 [inline]
RIP: 0010:close_fs_devices+0x47c/0x860 fs/btrfs/volumes.c:1204
Code: 3c 08 00 74 08 48 89 ef e8 b1 95 38 fe 48 8b 6d 00 b8 c0 07 00 00 48 01 c5 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 ef e8 86 95 38 fe 48 8b 75 00 4c 89 ff e8
RSP: 0018:ffffc90004007a48 EFLAGS: 00010202
RAX: 00000000000000f8 RBX: 1ffff110368c440b RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000007c0 R08: ffff8881b462206f R09: 1ffff110368c440d
R10: dffffc0000000000 R11: ffffed10368c440e R12: ffff8881b4622000
R13: ffff8881b4622068 R14: ffff8881b4622058 R15: ffff8881707b7a00
FS:  00007f849d6ce6c0(0000) GS:ffff8882a9292000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f849c786a00 CR3: 00000001bbbcc000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 btrfs_close_devices+0xcd/0x570 fs/btrfs/volumes.c:1219
 btrfs_free_fs_info+0x4f/0x360 fs/btrfs/disk-io.c:1205
 deactivate_locked_super+0xbc/0x130 fs/super.c:477
 btrfs_get_tree_super fs/btrfs/super.c:-1 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
 btrfs_get_tree+0xca6/0x1910 fs/btrfs/super.c:2121
 vfs_get_tree+0x92/0x2a0 fs/super.c:1928
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3834
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4360
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f849c79e0ca
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f849d6cde58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f849d6cdee0 RCX: 00007f849c79e0ca
RDX: 00002000000055c0 RSI: 0000200000000340 RDI: 00007f849d6cdea0
RBP: 00002000000055c0 R08: 00007f849d6cdee0 R09: 0000000000000408
R10: 0000000000000408 R11: 0000000000000246 R12: 0000200000000340
R13: 00007f849d6cdea0 R14: 00000000000055f5 R15: 0000200000000380
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_close_bdev fs/btrfs/volumes.c:1140 [inline]
RIP: 0010:btrfs_close_one_device fs/btrfs/volumes.c:1161 [inline]
RIP: 0010:close_fs_devices+0x47c/0x860 fs/btrfs/volumes.c:1204
Code: 3c 08 00 74 08 48 89 ef e8 b1 95 38 fe 48 8b 6d 00 b8 c0 07 00 00 48 01 c5 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 ef e8 86 95 38 fe 48 8b 75 00 4c 89 ff e8
RSP: 0018:ffffc90004007a48 EFLAGS: 00010202

RAX: 00000000000000f8 RBX: 1ffff110368c440b RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000007c0 R08: ffff8881b462206f R09: 1ffff110368c440d
R10: dffffc0000000000 R11: ffffed10368c440e R12: ffff8881b4622000
R13: ffff8881b4622068 R14: ffff8881b4622058 R15: ffff8881707b7a00
FS:  00007f849d6ce6c0(0000) GS:ffff8882a9292000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557941c2b058 CR3: 00000001bbbcc000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	3c 08                	cmp    $0x8,%al
   2:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
   6:	89 ef                	mov    %ebp,%edi
   8:	e8 b1 95 38 fe       	call   0xfe3895be
   d:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  11:	b8 c0 07 00 00       	mov    $0x7c0,%eax
  16:	48 01 c5             	add    %rax,%rbp
  19:	48 89 e8             	mov    %rbp,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 86 95 38 fe       	call   0xfe3895be
  38:	48 8b 75 00          	mov    0x0(%rbp),%rsi
  3c:	4c 89 ff             	mov    %r15,%rdi
  3f:	e8                   	.byte 0xe8


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

