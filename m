Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07872D42A
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 00:09:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qg5Sc0Zs1z2ys7
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 08:09:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qg5SS39Wxz2y1X
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 08:09:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vl.Q..m_1686607744;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vl.Q..m_1686607744)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 06:09:05 +0800
Message-ID: <0598b7cd-d097-87e2-cd69-d4150e12c6a6@linux.alibaba.com>
Date: Tue, 13 Jun 2023 06:09:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: general protection fault in erofs_bread
To: Khagan Karimov <Khagan.karimov@utah.edu>,
 "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>,
 "huyue2@coolpad.com" <huyue2@coolpad.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DM5PR11MB00577D17A39E59923E92532FE954A@DM5PR11MB0057.namprd11.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <DM5PR11MB00577D17A39E59923E92532FE954A@DM5PR11MB0057.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Khagan,

On 2023/6/13 02:55, Khagan Karimov wrote:
> Good day,
> 
> Dear Maintainers,
> 
> I found the following bug:
> 
> Kernel branch: 6.3.0-next-20230426

Thanks for your efforts.

But could you please check the latest upstream or -next?

If I understand correctly, it's the same bug as:
https://lore.kernel.org/r/000000000000d03b0805fbe71d55@google.com

and it has been fixed upstream months ago.

Thanks,
Gao Xiang

> 
> Kernel config: https://drive.google.com/file/d/1KU1ivdc6axWGXqmaODg5wYNJZ4v7p75j/view?usp=sharing
> 
> C reproducer: https://drive.google.com/file/d/14qxiXna1l9BLxDH2Ozo6oebnhjbNi06e/view?usp=sharing
>   
> 
> loop4: detected capacity change from 0 to 16
> erofs: (device loop4): EXPERIMENTAL compressed fragments feature in use. Use at your own risk!
> erofs: (device loop4): EXPERIMENTAL global deduplication feature in use. Use at your own risk!
> general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
> CPU: 6 PID: 14033 Comm: syz-executor.4 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38
> Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00
> RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000
> RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca
> RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f
> R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000
> R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000
> FS:  00007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0
> Call Trace:
>   <TASK>
>   erofs_read_metadata+0xbb/0x490 fs/erofs/super.c:137
>   erofs_xattr_prefixes_init+0x3b1/0x590 fs/erofs/xattr.c:684
>   erofs_fc_fill_super+0x1732/0x2a70 fs/erofs/super.c:825
>   get_tree_bdev+0x44a/0x770 fs/super.c:1303
>   vfs_get_tree+0x8d/0x350 fs/super.c:1510
>   do_new_mount fs/namespace.c:3039 [inline]
>   path_mount+0x675/0x1e30 fs/namespace.c:3369
>   do_mount fs/namespace.c:3382 [inline]
>   __do_sys_mount fs/namespace.c:3591 [inline]
>   __se_sys_mount fs/namespace.c:3568 [inline]
>   __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f5337c9176e
> Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5338e32a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5337c9176e
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5338e32a60
> RBP: 00007f5338e32aa0 R08: 00007f5338e32aa0 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f5338e32a60 R15: 00000000200108a0
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38
> Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00
> RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000
> RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca
> RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f
> R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000
> R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000
> FS:  00007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0
> ----------------
> Code disassembly (best guess):
>     0:   48 c1 ea 03             shr    $0x3,%rdx
>     4:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>     8:   0f 85 17 06 00 00       jne    0x625
>     e:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>    15:   fc ff df
>    18:   4c 8b 23                mov    (%rbx),%r12
>    1b:   49 8d bc 24 ca 00 00    lea    0xca(%r12),%rdi
>    22:   00
>    23:   48 89 fa                mov    %rdi,%rdx
>    26:   48 c1 ea 03             shr    $0x3,%rdx
> * 2a:   0f b6 04 02             movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>    2e:   48 89 fa                mov    %rdi,%rdx
>    31:   83 e2 07                and    $0x7,%edx
>    34:   38 d0                   cmp    %dl,%al
>    36:   7f 08                   jg     0x40
>    38:   84 c0                   test   %al,%al
>    3a:   0f 85 84 05 00 00       jne    0x5c4
> 
> Thank you very much!
> 
> 
> Best Regards,
> 
>                              Khagan Karimov (He/His/Him)
> 
>                              Ph.D. student | Security Researcher
>        
>                              Kahlert School of Computing, The University of Utah
>                              
> 
>                              
>                                  
>                       
