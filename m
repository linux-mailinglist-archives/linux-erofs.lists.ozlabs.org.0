Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12A706F8C
	for <lists+linux-erofs@lfdr.de>; Wed, 17 May 2023 19:35:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QM0d135trz3f7K
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 03:35:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.206; helo=mail-il1-f206.google.com; envelope-from=3axblzakbaeo4abwmxxq3m11up.s00sxq64q3o0z5qz5.o0y@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QM0cw1b9mz30Ky
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 03:35:42 +1000 (AEST)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-338280a9459so15923825ab.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 May 2023 10:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344939; x=1686936939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGQwNnU6wbVIzp4iz14/V7eAlLSmWR46eSYidn8u46M=;
        b=ExiBZvDMa9jgczSqGEJSxBoh4CzMBMV24/X/JUlSkFJHjuMGNDCkkgH5G+LnEvpAlG
         z4w/fgjLyTu+2cN7ogDquu8iBUWPB1Tk34SpBMFKXRALkB1Iy8lc+fxZyoKMumBgxgNG
         4u3K3TFr0jAOkcM/h3gvsagJrOH9iYCQ1QSzgvYdblMzjt3QX2KIpknyIrsrypS9H2d8
         DB6wDeynLC4KMACpkDeB1DlzdkwmmQ3hPIOwVuNT/tUfcY6SVI9JXCAKa8FkZYUE8BMm
         mfgmKnULNgKXPhvUU7Uj97O8vFK1EuqQP1ZSLLcDNsTkv6yuVIm3nJ8Uj5Abh1mWgI+9
         3YaQ==
X-Gm-Message-State: AC+VfDwsXAqodb5UykGK8yWZZrWo/y+dZ6fK0WdrO6TQuzlxNZ00IXvw
	M0uLqA7cEJA+b5c6OwFpWuKAimqiutwa63dcwzLAWR8lnctu
X-Google-Smtp-Source: ACHHUZ58ceKj+7ueId84yjPKsorg5yhzD02C/g+j09rM3UikJgHxnAJ+xNcfdIlsYtvlxz5rguc9H+GNuyPSaAVcRqmIEybzk9Pl
MIME-Version: 1.0
X-Received: by 2002:a92:d950:0:b0:331:8e32:a36b with SMTP id
 l16-20020a92d950000000b003318e32a36bmr1763043ilq.4.1684344939754; Wed, 17 May
 2023 10:35:39 -0700 (PDT)
Date: Wed, 17 May 2023 10:35:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d03b0805fbe71d55@google.com>
Subject: [syzbot] [erofs?] general protection fault in erofs_bread (2)
From: syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>
To: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot found the following issue on:

HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114aa029280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd834e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ef106280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4adf207e9d5e/disk-f1fcbaa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e7cce92f611/vmlinux-f1fcbaa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfd911b80f89/bzImage-f1fcbaa1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a2583fbaaf14/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com

erofs: (device loop0): EXPERIMENTAL global deduplication feature in use. Use at your own risk!
general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
CPU: 0 PID: 4995 Comm: syz-executor235 Not tainted 6.4.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38
Code: 48 c1 ea 03 80 3c 02 00 0f 85 15 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 82 05 00 00
RSP: 0018:ffffc900034b7980 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffc900034b7af8 RCX: 0000000000000000
RDX: 0000000000000019 RSI: ffffffff83c1ea5f RDI: 00000000000000ca
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f
R10: 000000000000000c R11: ffffffff81d50f12 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888019bd4000 R15: ffff888019bd4000
FS:  0000555555bf6300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc664ae0ca0 CR3: 0000000020cc6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 erofs_read_metadata+0xbb/0x490 fs/erofs/super.c:137
 erofs_xattr_prefixes_init+0x3b1/0x590 fs/erofs/xattr.c:684
 erofs_fc_fill_super+0x1734/0x2a80 fs/erofs/super.c:825
 get_tree_bdev+0x44a/0x770 fs/super.c:1303
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc664b09e5a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1310be98 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc664b09e5a
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 00007ffd1310bea0
RBP: 00007ffd1310bea0 R08: 00007ffd1310bee0 R09: 00000000000001d4
R10: 0000000001000801 R11: 0000000000000286 R12: 0000000000000005
R13: 0000555555bf62c0 R14: 00007ffd1310bee0 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38
Code: 48 c1 ea 03 80 3c 02 00 0f 85 15 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 82 05 00 00
RSP: 0018:ffffc900034b7980 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffc900034b7af8 RCX: 0000000000000000
RDX: 0000000000000019 RSI: ffffffff83c1ea5f RDI: 00000000000000ca
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f
R10: 000000000000000c R11: ffffffff81d50f12 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888019bd4000 R15: ffff888019bd4000
FS:  0000555555bf6300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0e8fdab10 CR3: 0000000020cc6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 15 06 00 00    	jne    0x623
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	4c 8b 23             	mov    (%rbx),%r12
  1b:	49 8d bc 24 ca 00 00 	lea    0xca(%r12),%rdi
  22:	00
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 82 05 00 00    	jne    0x5c2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
