Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F787FABF
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 10:32:12 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wVvmd0WV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TzRMF62dJz3dHD
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Mar 2024 20:32:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wVvmd0WV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TzRM56H0kz3bnv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Mar 2024 20:31:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710840715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=M56M6/tlYBudho8RWYV9cKxoIDl7JKIudMftfxIMEug=;
	b=wVvmd0WVFIX8xuw3ws//AJYZBKi2MGS4Di8fDr3bG4wWRX4Ojbp7fEqLvN9chArcWDUiEy8SM2N+6kM54zmpd9h4d1VMvFi6+TJbqirRFvEwWuVNzMxuwp/1vxbMJR+A4Qau7q0K2fWACU/2v0fMGZQQWHn28WV7wdC02/DmXC8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2shPPF_1710840712;
Received: from 30.97.48.212(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2shPPF_1710840712)
          by smtp.aliyun-inc.com;
          Tue, 19 Mar 2024 17:31:53 +0800
Message-ID: <4b007533-8d7b-40e7-9f06-52304b46cb8b@linux.alibaba.com>
Date: Tue, 19 Mar 2024 17:31:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (3)
To: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

another try with the current upstream.

On 2024/2/20 15:22, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> le Layout Driver Registering...
> [   21.855653][    T1] Key type cifs.spnego registered
> [   21.862292][    T1] Key type cifs.idmap registered
> [   21.872039][    T1] ntfs: driver 2.1.32 [Flags: R/W].
> [   21.878069][    T1] ntfs3: Max link count 4000
> [   21.882711][    T1] ntfs3: Enabled Linux POSIX ACLs support
> [   21.888528][    T1] ntfs3: Read-only LZX/Xpress compression included
> [   21.895581][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
> [   21.902312][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> [   21.908626][    T1] QNX4 filesystem 0.2.3 registered.
> [   21.914220][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
> [   21.921782][    T1] fuse: init (API version 7.39)
> [   21.933923][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
> [   21.943462][    T1] orangefs_init: module version upstream loaded
> [   21.951611][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
> [   21.993328][    T1] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
> [   22.010587][    T1] 9p: Installing v9fs 9p2000 file system support
> [   22.019170][    T1] NILFS version 2 loaded
> [   22.023764][    T1] befs: version: 0.9.3
> [   22.029409][    T1] ocfs2: Registered cluster interface o2cb
> [   22.037323][    T1] ocfs2: Registered cluster interface user
> [   22.046089][    T1] OCFS2 User DLM kernel interface loaded
> [   22.066046][    T1] gfs2: GFS2 installed
> [   22.107156][    T1] ceph: loaded (mds proto 32)
> [   26.347423][    T1] NET: Registered PF_ALG protocol family
> [   26.353728][    T1] xor: automatically using best checksumming function   avx
> [   26.361905][    T1] async_tx: api initialized (async)
> [   26.367588][    T1] Key type asymmetric registered
> [   26.372680][    T1] Asymmetric key parser 'x509' registered
> [   26.378760][    T1] Asymmetric key parser 'pkcs8' registered
> [   26.385472][    T1] Key type pkcs7_test registered
> [   26.391779][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
> [   26.402387][    T1] io scheduler mq-deadline registered
> [   26.408181][    T1] io scheduler kyber registered
> [   26.413686][    T1] io scheduler bfq registered
> [   26.431031][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   26.451191][    T1] ACPI: button: Power Button [PWRF]
> [   26.459719][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> [   26.470238][    T1] ACPI: button: Sleep Button [SLPF]
> [   26.470487][  T145] kworker/u4:6 (145) used greatest stack depth: 11288 bytes left
> [   26.501185][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [   26.590018][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> [   26.596923][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> [   26.684933][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
> [   26.691887][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> [   26.769222][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> [   26.775072][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
> [   26.834501][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
> [   26.964774][  T227] kworker/u4:4 (227) used greatest stack depth: 11000 bytes left
> [   27.025559][  T254] kworker/u4:4 (254) used greatest stack depth: 10880 bytes left
> [   27.967136][    T1] N_HDLC line discipline registered with maxframe=4096
> [   27.975904][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [   27.992699][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   28.026200][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   28.059406][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> [   28.089449][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> [   28.140541][    T1] Non-volatile memory driver v1.3
> [   28.170442][    T1] Linux agpgart interface v0.103
> [   28.189648][    T1] ACPI: bus type drm_connector registered
> [   28.207115][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
> [   28.229973][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
> [   28.724393][    T1] Console: switching to colour frame buffer device 128x48
> [   28.875767][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
> [   28.884404][    T1] usbcore: registered new interface driver udl
> [   29.061297][    T1] brd: module loaded
> [   29.244400][    T1] loop: module loaded
> [   29.512400][    T1] zram: Added device: zram0
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
