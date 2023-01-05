Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BA65E834
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 10:50:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NnhXh4QNDz3bNs
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 20:50:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.6; helo=out199-6.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NnhXc1Bdjz2yg5
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Jan 2023 20:50:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VYvX.gW_1672912199;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYvX.gW_1672912199)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 17:50:00 +0800
Message-ID: <f126fc95-fdbe-cc2e-5efb-ab704d13bd41@linux.alibaba.com>
Date: Thu, 5 Jan 2023 17:49:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
To: syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000c0a08805f07291a0@google.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000c0a08805f07291a0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 2022/12/23 06:55, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15aa58f7880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=827916bd156c2ec6

I wasn't able to build the kernel with this kernel config, it shows:
"...
FATAL: modpost: vmlinux.o is truncated. sechdrs[i].sh_offset=1399394064 > sizeof(*hrd)=64
make[2]: *** [Module.symvers] Error 1
make[1]: *** [modpost] Error 2
make: *** [__sub-make] Error 2
"

Not sure what happened, and it seems some other person also reported
before:
https://lore.kernel.org/r/CAAGKmqL9k87xw68zwH9ZM7fQFFsgMnA7V=RB+tQ-M2WS6CZg4A@mail.gmail.com/


> dashboard link: https://syzkaller.appspot.com/bug?extid=c3729cda01706a04fb98
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bdd020480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c53ab3880000

Then I tried this C reproducer with my own kernel config and
it didn't show any strange.


> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0c8a5f06ceb3/disk-f9ff5644.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be222e852ae2/vmlinux-f9ff5644.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d9f42a53b05e/bzImage-f9ff5644.xz

Finally I tried the original kernel image, and it printed some other
random bug when booting system and then reboot, like:

[   36.991123][    T1] ==================================================================
[   36.991800][    T1] BUG: KASAN: slab-out-of-bounds in copy_array+0x96/0x100
[   36.992438][    T1] Write of size 32 at addr ffff888018c34640 by task systemd/1
[   36.993032][    T1]
[   36.993249][    T1] CPU: 2 PID: 1 Comm: systemd Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
[   36.993980][    T1] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   36.994520][    T1] Call Trace:
[   36.994806][    T1]  <TASK>
[   36.995060][    T1]  dump_stack_lvl+0xd1/0x138
[   36.995488][    T1]  print_report+0x15e/0x45d
[   36.995891][    T1]  ? __phys_addr+0xc8/0x140
[   36.996293][    T1]  ? copy_array+0x96/0x100
[   36.996677][    T1]  kasan_report+0xbf/0x1f0
[   36.997063][    T1]  ? copy_array+0x96/0x100
[   36.997448][    T1]  kasan_check_range+0x141/0x190
[   36.997865][    T1]  memcpy+0x3d/0x60
[   36.998196][    T1]  copy_array+0x96/0x100
[   36.998561][    T1]  copy_verifier_state+0xa9/0xc60
[   36.998985][    T1]  ? bpf_log+0x270/0x270
[   36.999343][    T1]  ? check_buffer_access.constprop.0+0x2e0/0x2e0
[   36.999867][    T1]  pop_stack+0x8c/0x2f0
[   37.000223][    T1]  do_check_common+0x5663/0xbca0
[   37.000654][    T1]  ? _raw_spin_unlock_irqrestore+0x54/0x70
[   37.001152][    T1]  ? check_helper_call+0x8ef0/0x8ef0
[   37.001614][    T1]  ? kvfree+0x46/0x50
[   37.001963][    T1]  ? check_cfg+0x6aa/0xb20
[   37.002353][    T1]  bpf_check+0x7348/0xacc0
[   37.002751][    T1]  ? find_held_lock+0x2d/0x110
[   37.003168][    T1]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   37.003676][    T1]  ? bpf_get_btf_vmlinux+0x20/0x20
[   37.004104][    T1]  ? find_held_lock+0x2d/0x110
[   37.004524][    T1]  ? bpf_prog_load+0x1486/0x2230
[   37.004935][    T1]  ? lock_downgrade+0x6e0/0x6e0
[   37.005341][    T1]  ? __might_fault+0xd9/0x180
[   37.005747][    T1]  ? memset+0x24/0x50
[   37.006087][    T1]  ? bpf_obj_name_cpy+0x148/0x1a0
[   37.006541][    T1]  bpf_prog_load+0x1543/0x2230
[   37.006943][    T1]  ? __bpf_prog_put.constprop.0+0x220/0x220
[   37.007438][    T1]  ? find_held_lock+0x2d/0x110
[   37.007854][    T1]  ? __might_fault+0xd9/0x180
[   37.008261][    T1]  ? lock_downgrade+0x6e0/0x6e0
[   37.008673][    T1]  ? bpf_lsm_bpf+0x9/0x10
[   37.009055][    T1]  __sys_bpf+0x1436/0x4ff0
[   37.009434][    T1]  ? bpf_perf_link_attach+0x520/0x520
[   37.009875][    T1]  ? lock_downgrade+0x6e0/0x6e0
[   37.010299][    T1]  __x64_sys_bpf+0x79/0xc0
[   37.010678][    T1]  ? syscall_enter_from_user_mode+0x26/0xb0
[   37.011171][    T1]  do_syscall_64+0x39/0xb0
[   37.011561][    T1]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   37.012058][    T1] RIP: 0033:0x7fee6fa1c5a9
...

May I ask it can be reproducable on the latest -rc kernel?

Thanks,
Gao Xiang


> mounted in repro: https://storage.googleapis.com/syzbot-assets/7f2f76b76cd2/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 4386 at mm/page_alloc.c:3829 get_page_from_freeli
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
