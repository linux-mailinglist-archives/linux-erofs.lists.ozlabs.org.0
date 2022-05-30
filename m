Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76C53877A
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 20:44:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBkpM6jspz3bl4
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 04:44:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aparcar.org (client-ip=2001:4b98:dc4:8::240; helo=mslow1.mail.gandi.net; envelope-from=mail@aparcar.org; receiver=<UNKNOWN>)
X-Greylist: delayed 133 seconds by postgrey-1.36 at boromir; Tue, 31 May 2022 04:44:05 AEST
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBkpF4p3zz3015
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 04:44:05 +1000 (AEST)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 92248C948C
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 18:41:53 +0000 (UTC)
Received: from smtpclient.apple (ip5f5ab6fa.dynamic.kabel-deutschland.de [95.90.182.250])
	(Authenticated sender: mail@aparcar.org)
	by mail.gandi.net (Postfix) with ESMTPSA id 5D26F40003
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 18:41:35 +0000 (UTC)
From: Paul Spooren <mail@aparcar.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Worse performance than SquashFS for small filesystems
Message-Id: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
Date: Mon, 30 May 2022 20:41:34 +0200
To: linux-erofs@lists.ozlabs.org
X-Mailer: Apple Mail (2.3696.100.31)
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

I=E2=80=99m an OpenWrt developer and we work on an operation system for =
routers and overall network facing embedded devices. Since storage is =
often limited on our targeted devices we use SquashFS to compress =
everything, total image sizes are less than 10 MegaBytes.

Reading about erofs I=E2=80=99m very keen to adopt it for our case, =
however giving it a first try the storage performance seems to be =
significantly _worse_ than the default SquashFS implementation. Since =
you ran benchmarks in the past, could you give me advise if I=E2=80=99m =
missing anything?

For the test I used erofs-utils as of =
a134ce7c39a5427343029e97a62665157bef9bc3 (2022-05-17) and compressed the =
x86/64 root filesystem of a standard OpenWrt image[1]. I=E2=80=99m =
seeing a difference of one MegaByte which is about 30% worse in this =
context.

My test:

$ ./staging_dir/host/bin/mkfs.erofs -zlzma erofs.root =
./build_dir/target-x86_64_musl/root-x86
mkfs.erofs 1.4
<W> erofs: EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: Note that it may take more time since the compressor is still =
single-threaded for now.
Build completed.

$ mksquashfs -comp xz ./build_dir/target-x86_64_musl/root-x86 =
squashfs.root

$ ls -lh *.root
-rw-r--r-- 1 ubuntu ubuntu 4.3M May 30 20:27 erofs.root
-rw-r--r-- 1 ubuntu ubuntu 3.3M May 30 20:28 squashfs.root

Is erofs just not meant for such small storages?

Thanks for all further comments!

Best,
Paul

[1]: =
https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-root=
fs.tar.gz
