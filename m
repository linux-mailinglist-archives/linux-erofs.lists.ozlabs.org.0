Return-Path: <linux-erofs+bounces-2248-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLbZAHHngGleCAMAu9opvQ
	(envelope-from <linux-erofs+bounces-2248-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Feb 2026 19:05:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864FCFE9B
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Feb 2026 19:05:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4ZKT590sz309N;
	Tue, 03 Feb 2026 05:05:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.79
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770055533;
	cv=none; b=dYc9o57XDwi5/owXSzSH1Xi3DbtYHC0Bt5Ga+HUltxul3ebSzzY/umAsO7PAnFjRS7FuDyIafXArIqUuKOAZWkb8fwIEv57tAW8HptaOIBmOeVBli1vpqXacrTR/LsQD0P08jMtLJ268dK14dWP6se2FKjQFBO74auoHVriye93/AHwzJN4WGa7Gxn9KWW2VijRDpMd9GL809g8LPGfB6kOGw7RZZi/TSDfinwYJ5A5+k7sySFUgouTUeKVh+g8OOZVm/gUDaElzmOdzwpnY2eVUx+1pzyR2Bs+7UkPUuS8FX5uhmb7FQbyl8/25lPFJY2HVDMldP63mHR4SliPGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770055533; c=relaxed/relaxed;
	bh=2CYBvIOK9TzJ05c6sx0DJ6AmLW4gBCAz8kSfM8FzVRQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l4Rtrv7TsmDl46j1YylBub5X1oOi7jGSaS2HhLgblOk5ThoVOeXfGLaRuppzotJE+d2Gxe8+JuXkIXQju6qrT1ECrjp3p8J0IziBaTF9+uR8xK+otT+Qjw37NUGA/hZq7bnqYDC/GAgiHNhyD2zbceE+VUTmCk4oLzSekEhLUQisI3YvDP6BmBmBolBSu+ydIk/1RRW6UkVZob7wyJ2xTLRRYkME7kxD6YCdCVDes8dH0mZeWzO9aRhEqRy60PtyXSSPv1HZaVo5U3mHVqDPqkSW6bmFJ/UPp3fFRq2lx8DCpnjhbbG0/0hocw0UNrgE5RwytFtBZQcPVh9CvRMQNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.160.79; helo=mail-oa1-f79.google.com; envelope-from=3aoeaaqkbai09fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.160.79; helo=mail-oa1-f79.google.com; envelope-from=3aoeaaqkbai09fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4ZKR3psJz2xpn
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Feb 2026 05:05:31 +1100 (AEDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-4042a16a369so10404985fac.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Feb 2026 10:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055528; x=1770660328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CYBvIOK9TzJ05c6sx0DJ6AmLW4gBCAz8kSfM8FzVRQ=;
        b=nj/MsZ+dROuFiCrcFNoAcAcsf0+u3FyZ3p4SpCbEs9uX4+fYh/0NrLo8X0W8xDNVUF
         jMRAPrC6xkpps+Cj7C/NJmChJfuZvI1Iy7IBsN/TszKvaZuL/AJZ/DbjdoygawEg+MpD
         NIIGWE7GBu32kvg8GFIM/J4GUhuZUfHmn3/vE1+8AqVRKJ0yV3ePlHJygrYl3zlaMPV7
         eihRXo1Aqmm7b+/cvbUO4NFk1u2UFbBBsMJzkfuy2lozU2qjSyuibeArxfLdct01WpYr
         zg4jsJLYRTjShMSiAp2UDUGcbh/TQMmnSe1bUA3/vOWEALwt7RYFrOK2r7oT6M7p4gkM
         VBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBZ/ir/517RCFLZFjHKLrZ+BP6cst+I7fwca+WqpDekZi1qiGtxP0K+oZTXcwXUSA0pMDSxsr8guAhuw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVRX+rZWmSXI6g9UYtQ0kpHbBC+P8BhdPMf3NSzNS5W/hfSAtW
	cWJ9mOviFKGzwv3gcGXURcVDVOz06DjA5d1LMwsh8lfFeUKEeuWZ4TqjFbNCwua7OQkHtE1e2dR
	ovu7V2tAliic1Lc2yhNlU0mSvUKVkb7YGy92xwt2mwswBeV2kgP9a+toPxjI=
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
X-Received: by 2002:a05:6820:814:b0:659:9a49:90a6 with SMTP id
 006d021491bc7-6630f03f81bmr5615195eaf.37.1770055528278; Mon, 02 Feb 2026
 10:05:28 -0800 (PST)
Date: Mon, 02 Feb 2026 10:05:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6980e768.050a0220.16b13.00a7.GAE@google.com>
Subject: [syzbot] [erofs?] WARNING in erofs_iget (2)
From: syzbot <syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, guochunhai@vivo.com, 
	jefflexu@linux.alibaba.com, lihongbo22@huawei.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1b94612779ae7173];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2248-lists,linux-erofs=lfdr.de,c2dd47dc153320cc4692];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,vivo.com,linux.alibaba.com,huawei.com,lists.ozlabs.org,vger.kernel.org,googlegroups.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:dhavale@google.com,m:guochunhai@vivo.com,m:jefflexu@linux.alibaba.com,m:lihongbo22@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:xiang@kernel.org,m:zbestahu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,appspotmail.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,storage.googleapis.com:url,googlegroups.com:email];
	REDIRECTOR_URL(0.00)[goo.gl];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 1864FCFE9B
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    33a647c659ff Add linux-next specific files for 20260129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1404f93a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b94612779ae7173
dashboard link: https://syzkaller.appspot.com/bug?extid=c2dd47dc153320cc4692
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f2a45a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e5db2a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d0ce0a8fecd/disk-33a647c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4369620c4390/vmlinux-33a647c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18ae695e8dfc/bzImage-33a647c6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d92cbdf601af/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1102045a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com

VFS_WARN_ON_INODE(strlen(link) != linklen): inode:ffff8880591b5fc8 fs:erofs mode:120777 opflags:0x8 flags:0x0 state:0x1 count:1
------------[ cut here ]------------
1
WARNING: ./include/linux/fs.h:953 at inode_set_cached_link include/linux/fs.h:953 [inline], CPU#1: syz-executor/5938
WARNING: ./include/linux/fs.h:953 at erofs_fill_symlink fs/erofs/inode.c:25 [inline], CPU#1: syz-executor/5938
WARNING: ./include/linux/fs.h:953 at erofs_read_inode fs/erofs/inode.c:160 [inline], CPU#1: syz-executor/5938
WARNING: ./include/linux/fs.h:953 at erofs_fill_inode fs/erofs/inode.c:216 [inline], CPU#1: syz-executor/5938
WARNING: ./include/linux/fs.h:953 at erofs_iget+0x1f4d/0x2b10 fs/erofs/inode.c:285, CPU#1: syz-executor/5938
Modules linked in:
CPU: 1 UID: 0 PID: 5938 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:inode_set_cached_link include/linux/fs.h:953 [inline]
RIP: 0010:erofs_fill_symlink fs/erofs/inode.c:25 [inline]
RIP: 0010:erofs_read_inode fs/erofs/inode.c:160 [inline]
RIP: 0010:erofs_fill_inode fs/erofs/inode.c:216 [inline]
RIP: 0010:erofs_iget+0x1f4d/0x2b10 fs/erofs/inode.c:285
Code: 0f 8c 65 e2 ff ff 48 89 df e8 ff 10 e3 fd e9 58 e2 ff ff e8 d5 af 79 fd 48 8b 7c 24 10 48 c7 c6 e0 7f 1e 8c e8 c4 a7 fd fd 90 <0f> 0b 90 e9 3c fe ff ff e8 b6 af 79 fd 48 8b 7c 24 10 48 c7 c6 60
RSP: 0018:ffffc900043bf780 EFLAGS: 00010246
RAX: 8b808a9eaf282f00 RBX: 0000000000000017 RCX: 8b808a9eaf282f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900043bf9a0 R08: ffffc900043bf367 R09: 1ffff92000877e6c
R10: dffffc0000000000 R11: fffff52000877e6d R12: 0000000000000027
R13: 1ffff1100b236c03 R14: 0000000000000027 R15: ffff888027ca6d80
FS:  0000555581765500(0000) GS:ffff8881253a4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581790aa8 CR3: 000000007f6b8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 erofs_lookup+0x186/0x320 fs/erofs/namei.c:214
 __lookup_slow+0x2b7/0x410 fs/namei.c:1916
 lookup_slow+0x53/0x70 fs/namei.c:1933
 walk_component fs/namei.c:2279 [inline]
 lookup_last fs/namei.c:2780 [inline]
 path_lookupat+0x3f5/0x8c0 fs/namei.c:2804
 filename_lookup+0x256/0x5d0 fs/namei.c:2833
 user_path_at+0x40/0x160 fs/namei.c:3612
 ksys_umount fs/namespace.c:2052 [inline]
 __do_sys_umount fs/namespace.c:2060 [inline]
 __se_sys_umount fs/namespace.c:2058 [inline]
 __x64_sys_umount+0xf6/0x170 fs/namespace.c:2058
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f995879c117
Code: a2 c7 05 7c 94 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcc0f75bd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f995879c117
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcc0f75c90
RBP: 00007ffcc0f75c90 R08: 00007ffcc0f76c90 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcc0f76d80
R13: 00007f995880471f R14: 00005555817654e8 R15: 00007ffcc0f78f40
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

