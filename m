Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5059FD365
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2024 12:04:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YKN1223Sbz30DX
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2024 22:04:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735297459;
	cv=none; b=hReL9lQJPyDZIXO9szwA4lItcyIb98asDOw0dJNrFtJLHnqMYWdoSxZpecUe2Vir3RcD2jCxeK9Ub+umknoI7/6oEBoOA+7ayWuaShOS4mGcjuRggwb1Ur2y/ze7/LcQxYmevrXhDZR/Hm7NfjBixbdhXIfSlDvXlfi2P8xBKDv0BM5wa+Cr+1akjRfo9PxAXv4JJyIvx+cpaMpCa1O2cbtBime/M+D0i+AA8dqUFerY3mNzBbiy1tUXL5P1wTEqee6y2RqyIDETOrxbz7dz7lNl9umjqsf5Tv6FUht3XDxufk25oU/NcSv4OXhleExn1MirG+JPpcdYwzPcCBEXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735297459; c=relaxed/relaxed;
	bh=zmm/pTdTwwFTUWzDZFw/UgIATDHoNIzmxvCfYp1IQuk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=RRdIKof9tiPVOZVXCb3t2YgAh7HCo9RKBMoYc7W7LVLJDV193AUFcdE2vacMR6I6XTH+PX+ubcvHQI1Pqf9A7ucwuBddv5XI7W097S75rjnXxXSh1NEuOIblOeGcafh0rvf4chGEXmefeLWLFLuFgPEJigoXrq6aaXU8LvEPMI7W8W+j8k2gUQ3nl4+peAoL1YQ+6ih93YYcCLA7pJtWRRO1gX6tzpk4vzpklKW+McYeLi2xjE3BujOIgN5cMqCcldxoA/wzzqC8fdLYySYYC5O3qE/WvN9StVKHrmm3ZQVO9/CWdDYa2gXtrqCgDY0cAmcr8tHIptaSEZUbC348tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1171 seconds by postgrey-1.37 at boromir; Fri, 27 Dec 2024 22:04:17 AEDT
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YKN0x2s1bz2xCd
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Dec 2024 22:04:17 +1100 (AEDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tR7pa-0001pc-NI
	for linux-erofs@lists.ozlabs.org; Fri, 27 Dec 2024 11:44:34 +0100
Message-ID: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
Date: Fri, 27 Dec 2024 11:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
To: linux-erofs@lists.ozlabs.org
Subject: [bug report] data corruption of init process
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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

Hello,

I have debugged a kernel panic issue on my i.MX6Q board and might be running
into a bug in erofs. The problem manifests in a crashed init process in user
space. The process is either killed by a SIGILL as it attempts to execute a
malformed instruction or SIGSEGV by dereferencing an invalid address.

Example of a crash:

[    5.896446] 8<--- cut here ---
[    5.899614] init: unhandled page fault (11) at 0x000008ec, code 0x005
[    5.906214] [000008ec] *pgd=00000000
[    5.909925] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.6-00006-gfa286c4fa82b-dirty #96
[    5.918604] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    5.925351] PC is at 0x76ef6bbe
[    5.928698] LR is at 0x76efb619
[    5.931988] pc : [<76ef6bbe>]    lr : [<76efb619>]    psr: 200f0030
[    5.938500] sp : 7ee73b48  ip : ffffffff  fp : 004e0034
[    5.943908] r10: 00000009  r9 : 76efb5cd  r8 : 004e0034
[    5.949332] r7 : 7ee73b58  r6 : 00000000  r5 : 7ee73bb8  r4 : 76f08fd0
[    5.955952] r3 : 00000000  r2 : 7ee73d7c  r1 : 00000009  r0 : 00000000
[    5.962739] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
[    5.970282] Control: 50c5387d  Table: 1612c04a  DAC: 00000055
[    5.976193] Call trace:
[    5.976264] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

So far I was able to gather the following clues:

1. The crashes happen all the time and always have the same cause. 
  - Which corruption is triggered seems to be tied to the load on boot e.g., by
    capturing many trace events I'll run into the SIGSEGV if I don't capture
    SIGILL is triggered.
2. Any compressed erfos will trigger the bug. 
  - I have tested lz4, lzma and zstd, so the concrete compression algorithm shouldn't matter.
3. An uncompressed erofs didn't fail in my tests.
4. Mounting the erofs from an initramfs or my local machine works just fine.
  - The sha256 sums of any binary match the expected values.
5. Forcing full file reads instead of partial reads prevents the memory corruption from happening.
  - To force a full file read I "hacked" vfs_open to read to complete file via kernel_read_file
6. I couldn't reproduce the bug in a qemu setup (yet?)
  - I tried to force partial reads by slowing down the emulated disk by setting bps=202400, that didn't trigger it

From what I have gathered it looks like that partial reads of compressed files
lead to memory corruption of the decompressed file in specific circumstances
(which I lack the knowledge to debug). The modifications and .config of the
kernel I'm using to debug can be found in this branch:
https://github.com/KarlK90/linux/tree/debug/erofs.

This is my machine:

* ARM32 i.MX6Q SoC
  - forced single core during debug by setting maxcpus=0
* 1 GiB RAM (2/2G Split)
  - memtest=10 shows no problem
* 8GB eMMC (DDR54 Speed) with erofs rootfs
  - erofs-util: 1.8.3
* Kernel and DT loaded via TFTP from the bootloader
  - kernel: mainline v6.12.6

Here are some longer snippets of the augmented debug output:

Good case (forced full file reads):

[    5.350567] Run /sbin/init as init process
[    5.354822]   with arguments:
[    5.357978]     /sbin/init
[    5.360881]   with environment:
[    5.364139]     HOME=/
[    5.366616]     TERM=linux
[    5.373230] vfs_open: /usr/lib/systemd/systemd
[    5.382033] erofs: (device mmcblk3p3): lz4        : src c1002000 dst: c1000000 in: 4096b (eec708e7) out: 8859b (3bfdda11)
[    5.393476] erofs: (device mmcblk3p3): lz4        : src c1005000 dst: c100429b in: 4096b (76037b0d) out: 5168b (79840434)
[    5.411541] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c10066cb in: 4096b (4cac566d) out: 6376b (dfcc8264)
[    5.422948] erofs: (device mmcblk3p3): lz4        : src c100a000 dst: c1008fb3 in: 4096b (74af795c) out: 4651b (46c58dd7)
[    5.434316] erofs: (device mmcblk3p3): lz4        : src c100d000 dst: c100c1de in: 4096b (d65a3a49) out: 5360b (4364e0fc)
[    5.445764] erofs: (device mmcblk3p3): lz4        : src c100f000 dst: c100e6ce in: 4096b (db73bb75) out: 4606b (c0a54f50)
[    5.457156] erofs: (device mmcblk3p3): lz4        : src c1011000 dst: c10108cc in: 4096b (be653c3d) out: 4536b (10b3a4d0)
[    5.468599] erofs: (device mmcblk3p3): lz4        : src c1013000 dst: c1012a84 in: 4096b (8cd3cff3) out: 4285b (541c02fb)
[    5.480043] erofs: (device mmcblk3p3): lz4        : src c1015000 dst: c1014b41 in: 4096b (b885e4f7) out: 4789b (af1820d3)
[    5.491505] erofs: (device mmcblk3p3): lz4        : src c1018000 dst: c1016df6 in: 4096b (3b4e9357) out: 6216b (6a149c5)
[    5.502895] erofs: (device mmcblk3p3): lz4        : src c101c000 dst: c101a63e in: 4096b (a3bdbd0e) out: 8015b (63d1fbc1)
[    5.514353] erofs: (device mmcblk3p3): lz4        : src c101f000 dst: c101e58d in: 4096b (480285a7) out: 6603b (822f8de0)
[    5.525774] erofs: (device mmcblk3p3): lz4        : src c0b41000 dst: c1020f58 in: 1839b (4f637f42) out: 5780b (55fe911f)
[    5.538186] vfs_open: hash of /usr/lib/systemd/systemd: 0x0610c635
[    5.547236] vfs_open: /usr/lib/ld-linux-armhf.so.3
[    5.557957] erofs: (device mmcblk3p3): lz4        : src c1025000 dst: c1024000 in: 4096b (e4b39a2) out: 4907b (aa05f0a3)
[    5.569267] erofs: (device mmcblk3p3): lz4        : src c1027000 dst: c102632b in: 4096b (717fc925) out: 4246b (c0f62dca)
[    5.580659] erofs: (device mmcblk3p3): lz4        : src c1029000 dst: c10283c1 in: 4096b (8030d189) out: 4292b (1df48c5f)
[    5.592080] erofs: (device mmcblk3p3): lz4        : src c102b000 dst: c102a485 in: 4096b (4aac6f77) out: 4289b (7dbbff69)
[    5.603468] erofs: (device mmcblk3p3): lz4        : src c102d000 dst: c102c546 in: 4096b (e286b2b) out: 4207b (ec8e3f58)
[    5.614912] erofs: (device mmcblk3p3): lz4        : src c102f000 dst: c102e5b5 in: 4096b (e698fd35) out: 4291b (fcf580f8)
[    5.626289] erofs: (device mmcblk3p3): lz4        : src c1031000 dst: c1030678 in: 4096b (4859aa8f) out: 4297b (ab8a8574)
[    5.637684] erofs: (device mmcblk3p3): lz4        : src c1033000 dst: c1032741 in: 4096b (997436a4) out: 4218b (be0817b8)
[    5.649048] erofs: (device mmcblk3p3): lz4        : src c1035000 dst: c10347bb in: 4096b (112a3fda) out: 4271b (293ce253)
[    5.660486] erofs: (device mmcblk3p3): lz4        : src c1037000 dst: c103686a in: 4096b (fa3410b9) out: 4673b (7f7a9871)
[    5.672005] erofs: (device mmcblk3p3): lz4        : src c1039000 dst: c1038aab in: 4096b (634b03ca) out: 4477b (cf289eb)
[    5.683341] erofs: (device mmcblk3p3): lz4        : src c103b000 dst: c103ac28 in: 4096b (326e1ba0) out: 4254b (998b1f98)
[    5.694724] erofs: (device mmcblk3p3): lz4        : src c103d000 dst: c103ccc6 in: 4096b (3c5b4505) out: 4175b (3bf4f1a9)
[    5.706147] erofs: (device mmcblk3p3): lz4        : src c103f000 dst: c103ed15 in: 4096b (8e87c14d) out: 4288b (6a251e64)
[    5.717571] erofs: (device mmcblk3p3): lz4        : src c1041000 dst: c1040dd5 in: 4096b (31a2e179) out: 4257b (3e19e451)
[    5.729186] erofs: (device mmcblk3p3): lz4        : src c0b41000 dst: c1042e76 in: 4096b (65fa2fbe) out: 4460b (ebe0126c)
[    5.756228] erofs: (device mmcblk3p3): lz4        : src c1046000 dst: c1044fe2 in: 4096b (37a8bad1) out: 4349b (c125197)
[    5.767502] erofs: (device mmcblk3p3): lz4        : src c1049000 dst: c10480df in: 4096b (8d172a42) out: 4353b (1503ff28)
[    5.778859] erofs: (device mmcblk3p3): lz4        : src c104b000 dst: c104a1e0 in: 4096b (1ef07e2b) out: 4869b (c3bf758b)
[    5.790237] erofs: (device mmcblk3p3): lz4        : src c104d000 dst: c104c4e5 in: 4096b (f4462dc1) out: 5484b (9b35c90f)
[    5.801635] erofs: (device mmcblk3p3): lz4        : src c1050000 dst: c104ea51 in: 4096b (2ac6b4d5) out: 5985b (94cc0d29)
[    5.813049] erofs: (device mmcblk3p3): lz4        : src c1053000 dst: c10521b2 in: 4096b (90757c3c) out: 6356b (58df129b)
[    5.824504] erofs: (device mmcblk3p3): lz4        : src c1056000 dst: c1054a86 in: 4096b (971b791e) out: 6045b (3a6bbefa)
[    5.836079] erofs: (device mmcblk3p3): lz4        : src c105a000 dst: c1058223 in: 4096b (9804bc65) out: 10510b (2a60a723)
[    5.847541] erofs: (device mmcblk3p3): lz4        : src 836cea35 dst: c105cb31 in: 1483b (5c99618c) out: 4759b (b53e5caa)
[    5.860666] vfs_open: hash of /usr/lib/ld-linux-armhf.so.3: 0xf1fe4854

Bad case:

[    5.348323] Run /sbin/init as init process
[    5.352588]   with arguments:
[    5.355645]     /sbin/init
[    5.358551]   with environment:
[    5.361822]     HOME=/
[    5.364324]     TERM=linux
[    5.370845] vfs_open: /usr/lib/systemd/systemd
[    5.377861] erofs: (device mmcblk3p3): lz4        : src c1002000 dst: c1000000 in: 4096b (eec708e7) out: 8859b (3bfdda11)
[    5.389340] erofs: (device mmcblk3p3): lz4        : src c1005000 dst: c100429b in: 4096b (76037b0d) out: 5168b (79840434)
[    5.400891] erofs: (device mmcblk3p3): lz4 partial: src 83e3d000 dst: 810fb6cb in: 4096b (45bf72c3) out: 2357b (6e052dd5)
[    5.419977] vfs_open: /usr/lib/ld-linux-armhf.so.3
[    5.426854] erofs: (device mmcblk3p3): lz4        : src c1007000 dst: c1006000 in: 4096b (e4b39a2) out: 4907b (aa05f0a3)
[    5.438199] erofs: (device mmcblk3p3): lz4        : src c1009000 dst: c100832b in: 4096b (717fc925) out: 4246b (c0f62dca)
[    5.451237] erofs: (device mmcblk3p3): lz4        : src 83e3d000 dst: c100a6cb in: 4096b (45bf72c3) out: 6376b (dfcc8264)
[    5.462706] erofs: (device mmcblk3p3): lz4        : src c100d000 dst: c100c3c1 in: 4096b (8030d189) out: 4292b (1df48c5f)
[    5.474078] erofs: (device mmcblk3p3): lz4 partial: src 83fe9000 dst: 810f7485 in: 4096b (17ce8f99) out: 2939b (a1ab12cf)
[    5.487190] erofs: (device mmcblk3p3): lz4        : src c1010000 dst: c100efb3 in: 4096b (74af795c) out: 4651b (46c58dd7)
[    5.498593] erofs: (device mmcblk3p3): lz4        : src c1013000 dst: c10121de in: 4096b (d65a3a49) out: 5360b (4364e0fc)
[    5.510263] erofs: (device mmcblk3p3): lz4        : src c1015000 dst: c10146ce in: 4096b (db73bb75) out: 4606b (c0a54f50)
[    5.521662] erofs: (device mmcblk3p3): lz4        : src c1017000 dst: c10168cc in: 4096b (be653c3d) out: 4536b (10b3a4d0)
[    5.533076] erofs: (device mmcblk3p3): lz4        : src c1019000 dst: c1018a84 in: 4096b (8cd3cff3) out: 4285b (541c02fb)
[    5.546051] erofs: (device mmcblk3p3): lz4        : src c101b000 dst: c101ab41 in: 4096b (b885e4f7) out: 4789b (af1820d3)
[    5.557492] erofs: (device mmcblk3p3): lz4        : src c101e000 dst: c101cdf6 in: 4096b (3b4e9357) out: 6216b (6a149c5)
[    5.568954] erofs: (device mmcblk3p3): lz4        : src c1022000 dst: c102063e in: 4096b (a3bdbd0e) out: 8015b (63d1fbc1)
[    5.580412] erofs: (device mmcblk3p3): lz4        : src c1025000 dst: c102458d in: 4096b (480285a7) out: 6603b (822f8de0)
[    5.591833] erofs: (device mmcblk3p3): lz4        : src c0b11000 dst: c1026f58 in: 1839b (4f637f42) out: 5780b (55fe911f)
[    5.606916] erofs: (device mmcblk3p3): lz4        : src 83691000 dst: c102acc6 in: 4096b (cd2f4c7c) out: 4175b (3bf4f1a9)
[    5.618445] erofs: (device mmcblk3p3): lz4        : src c102d000 dst: c102cd15 in: 4096b (8e87c14d) out: 4288b (6a251e64)
[    5.638278] erofs: (device mmcblk3p3): lz4        : src c102f000 dst: c102edd5 in: 4096b (31a2e179) out: 4257b (3e19e451)
[    5.649650] erofs: (device mmcblk3p3): lz4        : src c0b11000 dst: c1030e76 in: 4096b (65fa2fbe) out: 4460b (ebe0126c)
[    5.661024] erofs: (device mmcblk3p3): lz4        : src c1034000 dst: c1032fe2 in: 4096b (37a8bad1) out: 4349b (c125197)
[    5.672301] erofs: (device mmcblk3p3): lz4        : src c1037000 dst: c10360df in: 4096b (8d172a42) out: 4353b (1503ff28)
[    5.683651] erofs: (device mmcblk3p3): lz4        : src c1039000 dst: c10381e0 in: 4096b (1ef07e2b) out: 4869b (c3bf758b)
[    5.695026] erofs: (device mmcblk3p3): lz4        : src c103b000 dst: c103a4e5 in: 4096b (f4462dc1) out: 5484b (9b35c90f)
[    5.706424] erofs: (device mmcblk3p3): lz4        : src c103e000 dst: c103ca51 in: 4096b (2ac6b4d5) out: 5985b (94cc0d29)
[    5.717848] erofs: (device mmcblk3p3): lz4        : src c1041000 dst: c10401b2 in: 4096b (90757c3c) out: 6356b (58df129b)
[    5.729267] erofs: (device mmcblk3p3): lz4        : src c1044000 dst: c1042a86 in: 4096b (971b791e) out: 6045b (3a6bbefa)
[    5.740762] erofs: (device mmcblk3p3): lz4        : src c1048000 dst: c1046223 in: 4096b (9804bc65) out: 10510b (2a60a723)
[    5.752186] erofs: (device mmcblk3p3): lz4        : src 83692a35 dst: c104ab31 in: 1483b (5c99618c) out: 4759b (b53e5caa)
[    5.764897] erofs: (device mmcblk3p3): lz4        : src 83fe9000 dst: c104c485 in: 4096b (17ce8f99) out: 4289b (7dbbff69)
[    5.783592] erofs: (device mmcblk3p3): lz4 partial: src 83691000 dst: 810cacc6 in: 4096b (cd2f4c7c) out: 826b (21762da4)
[    5.805222] erofs: (device mmcblk3p3): lz4        : src c104f000 dst: c104e546 in: 4096b (e286b2b) out: 4207b (ec8e3f58)
[    5.816904] erofs: (device mmcblk3p3): lz4        : src c1051000 dst: c10505b5 in: 4096b (e698fd35) out: 4291b (fcf580f8)
[    5.828288] erofs: (device mmcblk3p3): lz4        : src c1053000 dst: c1052678 in: 4096b (4859aa8f) out: 4297b (ab8a8574)
[    5.839655] erofs: (device mmcblk3p3): lz4        : src c1055000 dst: c1054741 in: 4096b (997436a4) out: 4218b (be0817b8)
[    5.851028] erofs: (device mmcblk3p3): lz4        : src c1057000 dst: c10567bb in: 4096b (112a3fda) out: 4271b (293ce253)
[    5.862394] erofs: (device mmcblk3p3): lz4        : src c1059000 dst: c105886a in: 4096b (fa3410b9) out: 4673b (7f7a9871)
[    5.873757] erofs: (device mmcblk3p3): lz4        : src c105b000 dst: c105aaab in: 4096b (634b03ca) out: 4477b (cf289eb)
[    5.885028] erofs: (device mmcblk3p3): lz4        : src 83692000 dst: c105cc28 in: 4096b (163cdf49) out: 4254b (998b1f98)
[    5.896446] 8<--- cut here ---
[    5.899614] init: unhandled page fault (11) at 0x000008ec, code 0x005
[    5.906214] [000008ec] *pgd=00000000
[    5.909925] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.6-00006-gfa286c4fa82b-dirty #96
[    5.918604] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    5.925351] PC is at 0x76ef6bbe
[    5.928698] LR is at 0x76efb619
[    5.931988] pc : [<76ef6bbe>]    lr : [<76efb619>]    psr: 200f0030
[    5.938500] sp : 7ee73b48  ip : ffffffff  fp : 004e0034
[    5.943908] r10: 00000009  r9 : 76efb5cd  r8 : 004e0034
[    5.949332] r7 : 7ee73b58  r6 : 00000000  r5 : 7ee73bb8  r4 : 76f08fd0
[    5.955952] r3 : 00000000  r2 : 7ee73d7c  r1 : 00000009  r0 : 00000000
[    5.962739] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
[    5.970282] Control: 50c5387d  Table: 1612c04a  DAC: 00000055
[    5.976193] Call trace:
[    5.976264] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

I'm not sure how to proceed from here or if anybody has some clues what the root cause might be?

Best regards,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

