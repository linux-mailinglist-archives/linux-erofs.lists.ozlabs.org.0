Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E59FD4F0
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2024 14:25:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YKR7P2D40z308V
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Dec 2024 00:25:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735305902;
	cv=none; b=on+VswqwhTqRW9iI+syIJarxW+X2ogfnwpirq7SrH1p6gmh3B+VtUOHWyla3natze2RnzzhkmKtx3DfHHC+dw+CBtIfmI6iqGrn44XpWEAm8iCI6ETY2CweMpD/jLw2l5eQkmtH4cKqkXT2UmPSiWf7J+cNT3M8bNKKK/YL8gnOMieMkAnQaXhYe5CJApRENrfvs2z4fLDnbUCBkrIEskgpcUe5vLnkAPZBVP7yOrIuWDkN4p1EdyQ+DZaP9Px6Z/HiOj2e862F7SqaPKAPQG7AyeV3NIHcoWq/qQwquH4bzLJ4hxCBlfe0K118Ft6Atfxo2eI5yubFIyXYltZjayA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735305902; c=relaxed/relaxed;
	bh=x4vDcVNJ2F16V9xkPHDZGvxWHJgKJICk0Unhuh84p8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BTD3Y4IXZ3rcwxjBHCJM1RzAghtwVLJoUwLNor8psYDSs1sYNqQ3rHiYkc/ZeU8tHh9OnnFGiOahjypZVw+pwsIy8VpD2NuSTGb+QkeoeHFSB86jMkP4IcXapNMFl5+6x2paqlRzuASm4eVAGXL7NoeIY4y0weY3uVVrQot9k3rQpntCB4lUtkfROKK7fnresVjP3hWWyCqp9Y1kPjf6ybBAKnWfzL6YoLhezH07xwZmkycMRhQcNocEUp4MBUtVRD/YCg80r+k0VPWrHCByDuZf2H6WI7sUgJxHXJ/h9fqu6ain3p5zSET+gkucrGXEbvh3z9E8adbMnQtGzX/HLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D91G9yi/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D91G9yi/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YKR7H6dLBz2xbQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Dec 2024 00:24:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735305892; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x4vDcVNJ2F16V9xkPHDZGvxWHJgKJICk0Unhuh84p8w=;
	b=D91G9yi/Kui/V0NNjXFw1xcCoX4yrejxHGX+lB39mbFpVJldap+xRNxUjTaQmgEV8QohDKNbgekjo7sO6HmqABiXQBktkLYBCQMtglNMhEOUrCaAmHp4tvLZI2Uz6e+rp85nwa8v01j9ibk6LdrlSrfLShfEH0i9L0+oT1DC6os=
Received: from 30.41.193.152(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMLO6hi_1735305889 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Dec 2024 21:24:50 +0800
Message-ID: <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
Date: Fri, 27 Dec 2024 21:24:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Hi Stefan,

On 2024/12/27 18:44, Stefan Kerkmann wrote:
> Hello,
> 
> I have debugged a kernel panic issue on my i.MX6Q board and might be running
> into a bug in erofs. The problem manifests in a crashed init process in user
> space. The process is either killed by a SIGILL as it attempts to execute a
> malformed instruction or SIGSEGV by dereferencing an invalid address.
> 
> Example of a crash:
> 
> [    5.896446] 8<--- cut here ---
> [    5.899614] init: unhandled page fault (11) at 0x000008ec, code 0x005
> [    5.906214] [000008ec] *pgd=00000000
> [    5.909925] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.6-00006-gfa286c4fa82b-dirty #96
> [    5.918604] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    5.925351] PC is at 0x76ef6bbe
> [    5.928698] LR is at 0x76efb619
> [    5.931988] pc : [<76ef6bbe>]    lr : [<76efb619>]    psr: 200f0030
> [    5.938500] sp : 7ee73b48  ip : ffffffff  fp : 004e0034
> [    5.943908] r10: 00000009  r9 : 76efb5cd  r8 : 004e0034
> [    5.949332] r7 : 7ee73b58  r6 : 00000000  r5 : 7ee73bb8  r4 : 76f08fd0
> [    5.955952] r3 : 00000000  r2 : 7ee73d7c  r1 : 00000009  r0 : 00000000
> [    5.962739] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
> [    5.970282] Control: 50c5387d  Table: 1612c04a  DAC: 00000055
> [    5.976193] Call trace:
> [    5.976264] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> So far I was able to gather the following clues:
> 
> 1. The crashes happen all the time and always have the same cause.
>    - Which corruption is triggered seems to be tied to the load on boot e.g., by
>      capturing many trace events I'll run into the SIGSEGV if I don't capture
>      SIGILL is triggered.
> 2. Any compressed erfos will trigger the bug.
>    - I have tested lz4, lzma and zstd, so the concrete compression algorithm shouldn't matter.
> 3. An uncompressed erofs didn't fail in my tests.
> 4. Mounting the erofs from an initramfs or my local machine works just fine.
>    - The sha256 sums of any binary match the expected values.
> 5. Forcing full file reads instead of partial reads prevents the memory corruption from happening.
>    - To force a full file read I "hacked" vfs_open to read to complete file via kernel_read_file
> 6. I couldn't reproduce the bug in a qemu setup (yet?)
>    - I tried to force partial reads by slowing down the emulated disk by setting bps=202400, that didn't trigger it
> 
>  From what I have gathered it looks like that partial reads of compressed files
> lead to memory corruption of the decompressed file in specific circumstances
> (which I lack the knowledge to debug). The modifications and .config of the
> kernel I'm using to debug can be found in this branch:
> https://github.com/KarlK90/linux/tree/debug/erofs.
> 
> This is my machine:
> 
> * ARM32 i.MX6Q SoC
>    - forced single core during debug by setting maxcpus=0
> * 1 GiB RAM (2/2G Split)
>    - memtest=10 shows no problem
> * 8GB eMMC (DDR54 Speed) with erofs rootfs
>    - erofs-util: 1.8.3
> * Kernel and DT loaded via TFTP from the bootloader
>    - kernel: mainline v6.12.6

Thanks for your report!

Linux 6.12 is a relative new kernel version, however my own
stress test doesn't catch this issue.

I think it may be better to try the following stuffs:

  1) Can your i.MX6Q board be switched to 6.6 LTS kernels, since
     there are many products already using EROFS for 6.6 LTS, so
     I wonder if it can be reprodced with old kernels like 6.6
     too (If it can be easily tested, please help try).

  2) does your qemu test setup emulate ARM32 i.MX6Q SoC too?

  3) Can you share your generated rootfs image to me so I could
     debug?

  4) can you try to add the attached patch (writespace-damanged)
     to your debug kernel in addition to your debug patch and
     feed back the output?

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fa51437e1d99..e1d918e0e6c7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -272,6 +272,8 @@ void erofs_onlinefolio_split(struct folio *folio)
  void erofs_onlinefolio_end(struct folio *folio, int err)
  {
         int orig, v;
+       void *ptr;
+       u32 hash;

         do {
                 orig = atomic_read((atomic_t *)&folio->private);
@@ -281,6 +283,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
         if (v & ~EROFS_ONLINEFOLIO_EIO)
                 return;
         folio->private = 0;
+
+       ptr = kmap_local_folio(folio, 0);
+       hash = fnv_32_buf(ptr, PAGE_SIZE, FNV1_32_INIT);
+       erofs_info(NULL, "%px i_ino %lu, index %lu dst %px (%x)",
+                  folio, folio->mapping->host->i_ino, folio->index, ptr, hash);
         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
  }


> 
> Here are some longer snippets of the augmented debug output:
> 
> Good case (forced full file reads):
> 

...

> 
> Bad case:
> 
> [    5.348323] Run /sbin/init as init process
> [    5.352588]   with arguments:
> [    5.355645]     /sbin/init
> [    5.358551]   with environment:
> [    5.361822]     HOME=/
> [    5.364324]     TERM=linux
> [    5.370845] vfs_open: /usr/lib/systemd/systemd


Case 1:


  [    5.411541] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c10066cb in: 4096b (4cac566d) out: 6376b (dfcc8264)

=======


> [    5.400891] erofs: (device mmcblk3p3): lz4 partial: src 83e3d000 dst: 810fb6cb in: 4096b (45bf72c3) out: 2357b (6e052dd5)

...

> [    5.451237] erofs: (device mmcblk3p3): lz4        : src 83e3d000 dst: c100a6cb in: 4096b (45bf72c3) out: 6376b (dfcc8264)


Case 2:

> [    5.592080] erofs: (device mmcblk3p3): lz4        : src c102b000 dst: c102a485 in: 4096b (4aac6f77) out: 4289b (7dbbff69)

=======

> [    5.474078] erofs: (device mmcblk3p3): lz4 partial: src 83fe9000 dst: 810f7485 in: 4096b (17ce8f99) out: 2939b (a1ab12cf)

...

> [    5.764897] erofs: (device mmcblk3p3): lz4        : src 83fe9000 dst: c104c485 in: 4096b (17ce8f99) out: 4289b (7dbbff69)


Case 3:

> [    5.694724] erofs: (device mmcblk3p3): lz4        : src c103d000 dst: c103ccc6 in: 4096b (3c5b4505) out: 4175b (3bf4f1a9)

=======

> [    5.783592] erofs: (device mmcblk3p3): lz4 partial: src 83691000 dst: 810cacc6 in: 4096b (cd2f4c7c) out: 826b (21762da4)

...

> [    5.606916] erofs: (device mmcblk3p3): lz4        : src 83691000 dst: c102acc6 in: 4096b (cd2f4c7c) out: 4175b (3bf4f1a9)

The odd thing is that the full hash is always the
same (dfcc8264, 7dbbff69, 3bf4f1a9) but the input
hash is somewhat different between good and bad
cases.

Could you also change the following line too?
erofs_info(rq->sb, "lz4        : src %px dst: %px in: %ub (%x, %px, %lu) out: %ub (%x)", src + inputmargin, out, rq->inputsize, hash_in, rq->in[0],  rq->in[0]->index, rq->outputsize, hash_out);


Thanks,
Gao Xiang


