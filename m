Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68385B431
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 08:47:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dv+m056K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfBMn5lHxz3cR4
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:47:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dv+m056K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfBMg6fPjz2xcw
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 18:47:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708415257; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bnMt8FcyxluEOoMRGW7COyabNWUHt06Ggj96huHAMzk=;
	b=Dv+m056K7ohLEwApewjt1ejee7ePVjDBGAg2VMJufiDCddtplb4OUXuJjOwJF/E2hihAH5VNBAcIlPrXnGuRix/sbIyw2A5nzrAtJFFmHejhfPwusIPRBO4wpO7XdrA/nq5YcA8G7Xdp/Hrs5Rs4CNbijcKyF4BqYTdVKJwTDc4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0w6wCb_1708415254;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0w6wCb_1708415254)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:47:35 +0800
Message-ID: <9eb94a85-2d52-4f2c-8b9e-fde419717bd1@linux.alibaba.com>
Date: Tue, 20 Feb 2024 15:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (3)
To: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org, netdev@vger.kernel.org
References: <0000000000001123250611cb110a@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0000000000001123250611cb110a@google.com>
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

(+add -netdev)

On 2024/2/20 15:22, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> le Layout Driver Registering...

...

> [   29.540501][    T1] null_blk: disk nullb0 created
> [   29.545733][    T1] null_blk: module loaded
> [   29.551941][    T1] Guest personality initialized and is inactive
> [   29.560955][    T1] VMCI host device registered (name=vmci, major=10, minor=118)
> [   29.569840][    T1] Initialized host personality
> [   29.575750][    T1] usbcore: registered new interface driver rtsx_usb
> [   29.585633][    T1] usbcore: registered new interface driver viperboard
> [   29.594432][    T1] usbcore: registered new interface driver dln2
> [   29.602202][    T1] usbcore: registered new interface driver pn533_usb
> [   29.616932][    T1] nfcsim 0.2 initialized
> [   29.622086][    T1] usbcore: registered new interface driver port100
> [   29.629914][    T1] usbcore: registered new interface driver nfcmrvl
> [   29.648231][    T1] Loading iSCSI transport class v2.0-870.
> [   29.684669][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
> [   29.731303][    T1] scsi host0: Virtio SCSI HBA
> [   30.283396][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [   30.301725][   T72] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> [   30.344813][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [   30.362347][    T1] db_root: cannot open: /etc/target
> [   30.395006][    T1] =====================================================
> [   30.395260][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid_or_report+0x19e/0x490
> [   30.395432][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
> [   30.395596][    T1]  stack_depot_save_flags+0x3e7/0x7b0
> [   30.395700][    T1]  stack_depot_save+0x12/0x20
> [   30.395793][    T1]  ref_tracker_alloc+0x215/0x700
> [   30.395890][    T1]  netdev_queue_update_kobjects+0x256/0x870
> [   30.396031][    T1]  netdev_register_kobject+0x41e/0x520

It seems it got some similar boot-failure issue:
https://lore.kernel.org/r/00000000000036e27e0610890a65@google.com
https://lore.kernel.org/r/000000000000bacd1706107232cd@google.com

before I tend to verify a resolved duplicated report:
https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d

Thanks,
Gao Xiang

> [   30.396149][    T1]  register_netdevice+0x198f/0x2170
> [   30.396264][    T1]  bond_create+0x138/0x2a0
> [   30.396406][    T1]  bonding_init+0x1a7/0x2d0
> [   30.396505][    T1]  do_one_initcall+0x216/0x960
> [   30.396640][    T1]  do_initcall_level+0x140/0x350
> [   30.396748][    T1]  do_initcalls+0xf0/0x1d0
> [   30.396848][    T1]  do_basic_setup+0x22/0x30
> [   30.396959][    T1]  kernel_init_freeable+0x300/0x4b0
> [   30.397071][    T1]  kernel_init+0x2f/0x7e0
> [   30.397189][    T1]  ret_from_fork+0x66/0x80
> [   30.397216][    T1]  ret_from_fork_asm+0x11/0x20
> [   30.397216][    T1]
> [   30.397216][    T1] Uninit was created at:
> [   30.397216][    T1]  free_unref_page_prepare+0xc1/0xad0
> [   30.397216][    T1]  free_unref_page+0x58/0x6d0
> [   30.397216][    T1]  __free_pages+0xb1/0x1f0
> [   30.397216][    T1]  thread_stack_free_rcu+0x97/0xb0
> [   30.397216][    T1]  rcu_core+0xa3c/0x1df0
> [   30.397216][    T1]  rcu_core_si+0x12/0x20
> [   30.397216][    T1]  __do_softirq+0x1b7/0x7c3
> [   30.397216][    T1]
> [   30.397216][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-syzkaller-gb401b621758e #0
> [   30.397216][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> [   30.397216][    T1] =====================================================
> [   30.397216][    T1] Disabling lock debugging due to kernel taint
> [   30.397216][    T1] Kernel panic - not syncing: kmsan.panic set ...
> [   30.397216][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B              6.8.0-rc5-syzkaller-gb401b621758e #0
> [   30.397216][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> [   30.397216][    T1] Call Trace:
> [   30.397216][    T1]  <TASK>
> [   30.397216][    T1]  dump_stack_lvl+0x1bf/0x240
> [   30.397216][    T1]  dump_stack+0x1e/0x20
> [   30.397216][    T1]  panic+0x4de/0xc90
> [   30.397216][    T1]  kmsan_report+0x2d0/0x2d0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? __msan_warning+0x96/0x110
> [   30.397216][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
> [   30.397216][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
> [   30.397216][    T1]  ? stack_depot_save+0x12/0x20
> [   30.397216][    T1]  ? ref_tracker_alloc+0x215/0x700
> [   30.397216][    T1]  ? netdev_queue_update_kobjects+0x256/0x870
> [   30.397216][    T1]  ? netdev_register_kobject+0x41e/0x520
> [   30.397216][    T1]  ? register_netdevice+0x198f/0x2170
> [   30.397216][    T1]  ? bond_create+0x138/0x2a0
> [   30.397216][    T1]  ? bonding_init+0x1a7/0x2d0
> [   30.397216][    T1]  ? do_one_initcall+0x216/0x960
> [   30.397216][    T1]  ? do_initcall_level+0x140/0x350
> [   30.397216][    T1]  ? do_initcalls+0xf0/0x1d0
> [   30.397216][    T1]  ? do_basic_setup+0x22/0x30
> [   30.397216][    T1]  ? kernel_init_freeable+0x300/0x4b0
> [   30.397216][    T1]  ? kernel_init+0x2f/0x7e0
> [   30.397216][    T1]  ? ret_from_fork+0x66/0x80
> [   30.397216][    T1]  ? ret_from_fork_asm+0x11/0x20
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
> [   30.397216][    T1]  ? filter_irq_stacks+0x60/0x1a0
> [   30.397216][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  __msan_warning+0x96/0x110
> [   30.397216][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
> [   30.397216][    T1]  stack_depot_save_flags+0x3e7/0x7b0
> [   30.397216][    T1]  stack_depot_save+0x12/0x20
> [   30.397216][    T1]  ref_tracker_alloc+0x215/0x700
> [   30.397216][    T1]  ? netdev_queue_update_kobjects+0x256/0x870
> [   30.397216][    T1]  ? netdev_register_kobject+0x41e/0x520
> [   30.397216][    T1]  ? register_netdevice+0x198f/0x2170
> [   30.397216][    T1]  ? bond_create+0x138/0x2a0
> [   30.397216][    T1]  ? bonding_init+0x1a7/0x2d0
> [   30.397216][    T1]  ? do_one_initcall+0x216/0x960
> [   30.397216][    T1]  ? do_initcall_level+0x140/0x350
> [   30.397216][    T1]  ? do_initcalls+0xf0/0x1d0
> [   30.397216][    T1]  ? do_basic_setup+0x22/0x30
> [   30.397216][    T1]  ? kernel_init_freeable+0x300/0x4b0
> [   30.397216][    T1]  ? kernel_init+0x2f/0x7e0
> [   30.397216][    T1]  ? ret_from_fork+0x66/0x80
> [   30.397216][    T1]  ? ret_from_fork_asm+0x11/0x20
> [   30.397216][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
> [   30.397216][    T1]  netdev_queue_update_kobjects+0x256/0x870
> [   30.397216][    T1]  netdev_register_kobject+0x41e/0x520
> [   30.397216][    T1]  register_netdevice+0x198f/0x2170
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  bond_create+0x138/0x2a0
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  bonding_init+0x1a7/0x2d0
> [   30.397216][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   30.397216][    T1]  do_one_initcall+0x216/0x960
> [   30.397216][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   30.397216][    T1]  ? kmsan_get_metadata+0xb0/0x1c0
> [   30.397216][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.397216][    T1]  ? filter_irq_stacks+0x60/0x1a0
> [   30.397216][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
> [   30.407722][    T1]  ? skip_spaces+0x8f/0xc0
> [   30.407722][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.407922][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.407922][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.407922][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.407922][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.407922][    T1]  ? parse_args+0x1511/0x15e0
> [   30.407922][    T1]  ? kmsan_get_metadata+0x146/0x1c0
> [   30.407922][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
> [   30.407922][    T1]  ? spi_dln2_driver_init+0x40/0x40
> [   30.408958][    T1]  do_initcall_level+0x140/0x350
> [   30.408958][    T1]  do_initcalls+0xf0/0x1d0
> [   30.408958][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
> [   30.408958][    T1]  do_basic_setup+0x22/0x30
> [   30.408958][    T1]  kernel_init_freeable+0x300/0x4b0
> [   30.408958][    T1]  ? rest_init+0x260/0x260
> [   30.408958][    T1]  kernel_init+0x2f/0x7e0
> [   30.408958][    T1]  ? rest_init+0x260/0x260
> [   30.408958][    T1]  ret_from_fork+0x66/0x80
> [   30.409978][    T1]  ? rest_init+0x260/0x260
> [   30.409978][    T1]  ret_from_fork_asm+0x11/0x20
> [   30.409978][    T1]  </TASK>
> [   30.409978][    T1] Kernel Offset: disabled
> 
> 
> syzkaller build log:
> go env (err=<nil>)
> GO111MODULE='auto'
> GOARCH='amd64'
> GOBIN=''
> GOCACHE='/syzkaller/.cache/go-build'
> GOENV='/syzkaller/.config/go/env'
> GOEXE=''
> GOEXPERIMENT=''
> GOFLAGS=''
> GOHOSTARCH='amd64'
> GOHOSTOS='linux'
> GOINSECURE=''
> GOMODCACHE='/syzkaller/jobs-2/linux/gopath/pkg/mod'
> GONOPROXY=''
> GONOSUMDB=''
> GOOS='linux'
> GOPATH='/syzkaller/jobs-2/linux/gopath'
> GOPRIVATE=''
> GOPROXY='https://proxy.golang.org,direct'
> GOROOT='/usr/local/go'
> GOSUMDB='sum.golang.org'
> GOTMPDIR=''
> GOTOOLCHAIN='auto'
> GOTOOLDIR='/usr/local/go/pkg/tool/linux_amd64'
> GOVCS=''
> GOVERSION='go1.21.4'
> GCCGO='gccgo'
> GOAMD64='v1'
> AR='ar'
> CC='gcc'
> CXX='g++'
> CGO_ENABLED='1'
> GOMOD='/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod'
> GOWORK=''
> CGO_CFLAGS='-O2 -g'
> CGO_CPPFLAGS=''
> CGO_CXXFLAGS='-O2 -g'
> CGO_FFLAGS='-O2 -g'
> CGO_LDFLAGS='-O2 -g'
> PKG_CONFIG='pkg-config'
> GOGCCFLAGS='-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=/tmp/go-build1804868575=/tmp/go-build -gno-record-gcc-switches'
> 
> git status (err=<nil>)
> HEAD detached at 373b66cd2
> nothing to commit, working tree clean
> 
> 
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:32: run command via tools/syz-env for best compatibility, see:
> Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
> go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> bin/syz-sysgen
> touch .descriptions
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
> GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20240130-131205'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
> mkdir -p ./bin/linux_amd64
> gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
> 	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
> 	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"373b66cd2ba1fd05c72d0bbe16141fb287fe2eb3\"
> 
> 
> Error text is too large and was truncated, full error text is at:
> https://syzkaller.appspot.com/x/error.txt?x=12579b34180000
> 
> 
> Tested on:
> 
> commit:         b401b621 Linux 6.8-rc5
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d33318d4e4a0d226
> dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
