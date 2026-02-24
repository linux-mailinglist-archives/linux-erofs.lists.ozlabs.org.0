Return-Path: <linux-erofs+bounces-2382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IIKLyJXnWk2OgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 08:45:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ED18332C
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 08:45:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKqWs2Dpvz3cHS;
	Tue, 24 Feb 2026 18:45:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771919129;
	cv=none; b=UpTMKBsKOQSawWcS08WlC5ZLRhWhPG8yKm7SAsMOprNbOBgnMg3WLfkgJClk/EaS3KeiZjE6RWVOJPRrhRJW6BSPXTy9x4fPrAVYsphEmGnjcuNemEIRyj/IqOOIrOhfWME0kmn6uqiFBbqppp67XjmuXvTWXXJCFDojJL49aYUw7RAFOmNW5Weuv/eg73E1cMR5pFo5KzdaH7U73mu7KNqReo9ipbXugVjFSOjxnKkaHwVWc19T2Tawpo3w9qIxkX7yZ32dFSGcLIbUAYlGgkDD392gD780pZx9wzEWeufBc0Tm416rXZdENUNuIhReglgr3/QHn67AL18MJvcT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771919129; c=relaxed/relaxed;
	bh=giRHMw6UEHWyh9rgcC/SYRDody9Xyn0U0QsWZfMGUrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m/aQlNMaGCTYYF2q2FLICNBJNK2QTVU3UmVyyhILv2kA3zEEE9HVgV+EYZv8CfDc1b2xA3USWPymeADqPSG8kIqg5theXZa/x+cCYLzBg+xEpmfu8dIQwfyxCXRccE95Nwnw5TDBC5mjI3aBjd24k+fKf5KgE9K1auRAkSCKigL59qf3fi2DNNo/eJyI0jdh1gE5jf/t7ikxcQgBEcN2YJG87jUKZ6fGwnTt+1ZwP8urRYSNZS9Dj451FQt6UNJyFHnff82aPI1BuCMF9TtcsnGD3zJgFxL7v2a9d51rLchbbT875tNPbo/bz4qct4D6+G9WVrd177CALCZPeUjmAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.161.72; helo=mail-oo1-f72.google.com; envelope-from=3ffedaqkbais7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.161.72; helo=mail-oo1-f72.google.com; envelope-from=3ffedaqkbais7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKqWq4PK0z3cHC
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 18:45:27 +1100 (AEDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679deba5e9fso5832620eaf.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Feb 2026 23:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771919125; x=1772523925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giRHMw6UEHWyh9rgcC/SYRDody9Xyn0U0QsWZfMGUrg=;
        b=A74QGtetv90QrtOOv43tUy+YYk9np/3u3JuBw2FqqBi1ufIk4wKFCH2obZ3nmzVhiG
         4GHmkCLYj4e5ENzqamOyxiSrDO1Q7bb465RizVdwxqPKgLK4Ig8tBDktIhseQyA9rjRU
         QvOO4buKWZqZVQauu16e8neNVAmNpR9FbF4t7ebW4goZ0LmHWDbXY70Mvu2XojPB233K
         pV4T49KV1LwIniQOJDKJZlCqcpxjKDk+lJKu1hxwRmPwoUUyNPpPNT7VCV6u3EUONHkM
         73JuurHP+sNe/ll2wc0RTILCjjYhNqAJVIhomGp8X6lBrqMECWJ9F6kSXWt4u61EsLdZ
         NAog==
X-Forwarded-Encrypted: i=1; AJvYcCVTfDLZDrq7oq7fh+uLlV9TeBVe3oztxuE2FizhGiPUKkA44eQgP12EnBsEuzcADXD7G54+u30LMzREEQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCLsw11l4t5oYTy4OeLpqRKwL9lZT7SPDvsWiTDifBYoUu59RR
	VYiSVFQdMOzrYHdhQAOMTnWauMpSE7lFtHh9QcoN+BeJlZvt+tsLWT19cmXXxWz/3xfEGmPmtrc
	VR27CJzI6ttEs6fhLxTWYtokNO8WIUDNSdrNCPVyrLIoU5hZ4QlainfvPJhg=
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
X-Received: by 2002:a05:6820:4810:b0:678:256e:d739 with SMTP id
 006d021491bc7-679c4470cebmr5046312eaf.29.1771919124880; Mon, 23 Feb 2026
 23:45:24 -0800 (PST)
Date: Mon, 23 Feb 2026 23:45:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699d5714.050a0220.cdd3c.03e7.GAE@google.com>
Subject: [syzbot] [erofs?] KASAN: use-after-free Read in z_erofs_transform_plain
 (2)
From: syzbot <syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, guochunhai@vivo.com, 
	jefflexu@linux.alibaba.com, lihongbo22@huawei.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2382-lists,linux-erofs=lfdr.de,d988dc155e740d76a331];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:dhavale@google.com,m:guochunhai@vivo.com,m:jefflexu@linux.alibaba.com,m:lihongbo22@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:xiang@kernel.org,m:zbestahu@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,vivo.com,linux.alibaba.com,huawei.com,lists.ozlabs.org,vger.kernel.org,googlegroups.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[storage.googleapis.com:query timed out];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,goo.gl:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 0C2ED18332C
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    8bf22c33e7a1 Merge tag 'net-7.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178f7ffa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=d988dc155e740d76a331
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157fb95a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102a9722580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/010f0532c934/disk-8bf22c33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed0946db3f63/vmlinux-8bf22c33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef1efd866885/bzImage-8bf22c33.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ca3875f86433/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1450c73a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_to_page include/linux/highmem.h:552 [inline]
BUG: KASAN: slab-out-of-bounds in z_erofs_transform_plain+0x33c/0xa00 fs/erofs/decompressor.c:309
Read of size 4096 at addr ffff88803f175800 by task kworker/u9:2/5851

CPU: 1 UID: 0 PID: 5851 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_to_page include/linux/highmem.h:552 [inline]
 z_erofs_transform_plain+0x33c/0xa00 fs/erofs/decompressor.c:309
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1297 [inline]
 z_erofs_decompress_queue+0x1af7/0x3740 fs/erofs/zdata.c:1410
 z_erofs_decompressqueue_work+0x88/0xe0 fs/erofs/zdata.c:1422
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88803f175900 pfn:0x3f175
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88803f175900 fffffffffffffffc 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xc40(GFP_NOFS), pid 6046, tgid 6046 (syz.1.18), ts 99298614076, free_ts 99297784595
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x28bb/0x2950 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2485
 alloc_frozen_pages_noprof mm/mempolicy.c:2556 [inline]
 alloc_pages_noprof+0xce/0x1e0 mm/mempolicy.c:2576
 __erofs_allocpage+0x1a0/0x270 fs/erofs/zutil.c:190
 z_erofs_fill_bio_vec fs/erofs/zdata.c:1560 [inline]
 z_erofs_submit_queue fs/erofs/zdata.c:1728 [inline]
 z_erofs_runqueue+0xb2f/0x20f0 fs/erofs/zdata.c:1808
 z_erofs_readahead+0x8ad/0xc10 fs/erofs/zdata.c:1936
 read_pages+0x193/0x5a0 mm/readahead.c:163
 page_cache_ra_unbounded+0x704/0x9b0 mm/readahead.c:304
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0x2b5/0x4b0 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2658 [inline]
 filemap_get_pages+0x832/0x1ea0 mm/filemap.c:2704
 filemap_read+0x44a/0x1240 mm/filemap.c:2800
 erofs_file_read_iter+0x249/0x2d0 fs/erofs/data.c:441
 __kernel_read+0x50d/0x9c0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
page last free pid 6046 tgid 6046 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xfe3/0x1170 mm/page_alloc.c:2978
 __folio_put+0x25d/0x310 mm/swap.c:112
 erofs_release_pages+0x1c9/0x270 fs/erofs/zutil.c:213
 z_erofs_decompressqueue_work fs/erofs/zdata.c:1423 [inline]
 z_erofs_decompress_kickoff+0x2aa/0x330 fs/erofs/zdata.c:1480
 z_erofs_submit_queue fs/erofs/zdata.c:1791 [inline]
 z_erofs_runqueue+0x1db8/0x20f0 fs/erofs/zdata.c:1808
 z_erofs_readahead+0x8ad/0xc10 fs/erofs/zdata.c:1936
 read_pages+0x193/0x5a0 mm/readahead.c:163
 page_cache_ra_unbounded+0x704/0x9b0 mm/readahead.c:304
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0x2b5/0x4b0 mm/readahead.c:538
 filemap_get_pages+0x47c/0x1ea0 mm/filemap.c:2690
 filemap_read+0x44a/0x1240 mm/filemap.c:2800
 erofs_file_read_iter+0x249/0x2d0 fs/erofs/data.c:441
 __kernel_read+0x50d/0x9c0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x12cf/0x1800 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x491/0x930 security/integrity/ima/ima_api.c:294

Memory state around the buggy address:
 ffff88803f175f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803f176000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803f176080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
                                     ^
 ffff88803f176100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803f176180: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


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

