Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB8538D4D
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 10:58:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LC5lv0BY0z3bkR
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 18:58:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aparcar.org (client-ip=217.70.178.231; helo=relay11.mail.gandi.net; envelope-from=mail@aparcar.org; receiver=<UNKNOWN>)
X-Greylist: delayed 51253 seconds by postgrey-1.36 at boromir; Tue, 31 May 2022 18:58:12 AEST
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LC5lm4LP5z302k
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 18:58:11 +1000 (AEST)
Received: from smtpclient.apple (ip5f5ab6fa.dynamic.kabel-deutschland.de [95.90.182.250])
	(Authenticated sender: mail@aparcar.org)
	by mail.gandi.net (Postfix) with ESMTPSA id CFD1E10001B;
	Tue, 31 May 2022 08:58:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: Worse performance than SquashFS for small filesystems
From: Paul Spooren <mail@aparcar.org>
In-Reply-To: <YpVao8WX3B6HPWt7@debian>
Date: Tue, 31 May 2022 10:58:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <14612283-0BA7-490B-A89C-D4CF82565178@aparcar.org>
References: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
 <YpVao8WX3B6HPWt7@debian>
To: Gao Xiang <xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

Thank you for the quick response!

> On 31. May 2022, at 02:00, Gao Xiang <xiang@kernel.org> wrote:
>=20
> On Mon, May 30, 2022 at 08:41:34PM +0200, Paul Spooren wrote:
>> Hi,
>>=20
>> I=E2=80=99m an OpenWrt developer and we work on an operation system =
for routers and overall network facing embedded devices. Since storage =
is often limited on our targeted devices we use SquashFS to compress =
everything, total image sizes are less than 10 MegaBytes.
>>=20
>> Reading about erofs I=E2=80=99m very keen to adopt it for our case, =
however giving it a first try the storage performance seems to be =
significantly _worse_ than the default SquashFS implementation. Since =
you ran benchmarks in the past, could you give me advise if I=E2=80=99m =
missing anything?
>=20
> What the meaning of `performance'? I don't think the size of images
> mean runtime performance anyway.

Performance as in looking at how well it performs on minimizing the =
space requirement.

>=20
>>=20
>> For the test I used erofs-utils as of =
a134ce7c39a5427343029e97a62665157bef9bc3 (2022-05-17) and compressed the =
x86/64 root filesystem of a standard OpenWrt image[1]. I=E2=80=99m =
seeing a difference of one MegaByte which is about 30% worse in this =
context.
>>=20
>> My test:
>>=20
>> $ ./staging_dir/host/bin/mkfs.erofs -zlzma erofs.root =
./build_dir/target-x86_64_musl/root-x86
>=20
> Have you try with
>=20
> -zlzma -C 65536 -Eztailpacking
>=20
> by default, EROFS uses 4k compression rather than Squashfs 128k.

That indeed improves the total size, I=E2=80=99m now down to 3.6MB (vs =
3.3MB for squashfs).

>=20
>> mkfs.erofs 1.4
>> <W> erofs: EXPERIMENTAL MicroLZMA feature in use. Use at your own =
risk!
>> <W> erofs: Note that it may take more time since the compressor is =
still single-threaded for now.
>> Build completed.
>>=20
>> $ mksquashfs -comp xz ./build_dir/target-x86_64_musl/root-x86 =
squashfs.root
>>=20
>> $ ls -lh *.root
>> -rw-r--r-- 1 ubuntu ubuntu 4.3M May 30 20:27 erofs.root
>> -rw-r--r-- 1 ubuntu ubuntu 3.3M May 30 20:28 squashfs.root
>=20
> Even EROFS now supports big pcluster and ztailpacking features,
> Squashfs supports a feature called fragments which compresses
> several tails of files in a fragment. It's obviously beneficial
> to the final size of images but it can read unrelated data of
> other files even such files are very small.
>=20
> You can try a big file with EROFS and Squashfs, and you can
> see the difference.
>=20
> Btw, MicroLZMA is still an experimental feature for now, due to=20
> three reasons:
> - XZ utils hasn't release a stable version for now, which I think
>   Lasse will release a stable version this year;
>=20
> - EROFS has a finalized on-disk MircoLZMA support since Linux 5.16,
>   so users can mount MicroLZMA since 5.16.  Yet currently EROFS is
>   not quite optimized for such slow algorithm, since it needs a
>   completely different strategy from LZ4.  I'm working on that
>   together with folio work;
>=20
> - We need a similiar `fragment' feature to catch squashfs under a
>   lot of files.

Is that feature likely to be implemented for EROFS or is that out of =
scope?

>=20
>>=20
>> Is erofs just not meant for such small storages?
>=20
> If you care more about the size of images, I personally prefer to
> squashfs for now until we handle all the things above.

Sure, I didn=E2=80=99t plan to migrate things over to EROFS just like =
that but it looks like a good candidate in the future!

Thank you and everyone involved for working on EROFS!

Best,
Paul Spooren

>=20
> Thanks,
> Gao Xiang
>=20
>>=20
>> Thanks for all further comments!
>>=20
>> Best,
>> Paul
>>=20
>> [1]: =
https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-root=
fs.tar.gz

