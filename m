Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05605538E5A
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 12:02:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LC79M4hDRz2xnN
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 20:01:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LC79D2mQyz2xnN
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 20:01:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEuy2nJ_1653991300;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEuy2nJ_1653991300)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 18:01:42 +0800
Date: Tue, 31 May 2022 18:01:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Paul Spooren <mail@aparcar.org>
Subject: Re: Worse performance than SquashFS for small filesystems
Message-ID: <YpXnhI8gBlSgHEBW@B-P7TQMD6M-0146.local>
References: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
 <YpVao8WX3B6HPWt7@debian>
 <14612283-0BA7-490B-A89C-D4CF82565178@aparcar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14612283-0BA7-490B-A89C-D4CF82565178@aparcar.org>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Paul,

On Tue, May 31, 2022 at 10:58:01AM +0200, Paul Spooren wrote:
> Hi,
> 
> Thank you for the quick response!
> 
> > On 31. May 2022, at 02:00, Gao Xiang <xiang@kernel.org> wrote:
> > 
> > On Mon, May 30, 2022 at 08:41:34PM +0200, Paul Spooren wrote:
> >> Hi,
> >> 
> >> I’m an OpenWrt developer and we work on an operation system for routers and overall network facing embedded devices. Since storage is often limited on our targeted devices we use SquashFS to compress everything, total image sizes are less than 10 MegaBytes.
> >> 
> >> Reading about erofs I’m very keen to adopt it for our case, however giving it a first try the storage performance seems to be significantly _worse_ than the default SquashFS implementation. Since you ran benchmarks in the past, could you give me advise if I’m missing anything?
> > 
> > What the meaning of `performance'? I don't think the size of images
> > mean runtime performance anyway.
> 
> Performance as in looking at how well it performs on minimizing the space requirement.

Originally, EROFS had a goal to have a better runtime performance with
minimal memory overhead (with some inplace techniques).

Strictly speaking, if you'd like to minimize the storage space, there
are many FUSE fses which can do this, but such fses doesn't consider
more about memory footprints or runtime I/O amplification and that's
what EROFS addresses exactly.

But yeah, we tend to perform a generic in-kernel fses, I think we can
do in this way (saving more space without impact runtime performance)
with our best effort.

> 
> > 
> >> 
> >> For the test I used erofs-utils as of a134ce7c39a5427343029e97a62665157bef9bc3 (2022-05-17) and compressed the x86/64 root filesystem of a standard OpenWrt image[1]. I’m seeing a difference of one MegaByte which is about 30% worse in this context.
> >> 
> >> My test:
> >> 
> >> $ ./staging_dir/host/bin/mkfs.erofs -zlzma erofs.root ./build_dir/target-x86_64_musl/root-x86
> > 
> > Have you try with
> > 
> > -zlzma -C 65536 -Eztailpacking
> > 
> > by default, EROFS uses 4k compression rather than Squashfs 128k.
> 
> That indeed improves the total size, I’m now down to 3.6MB (vs 3.3MB for squashfs).

Good to hear that.

> 
> > 
> >> mkfs.erofs 1.4
> >> <W> erofs: EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
> >> <W> erofs: Note that it may take more time since the compressor is still single-threaded for now.
> >> Build completed.
> >> 
> >> $ mksquashfs -comp xz ./build_dir/target-x86_64_musl/root-x86 squashfs.root
> >> 
> >> $ ls -lh *.root
> >> -rw-r--r-- 1 ubuntu ubuntu 4.3M May 30 20:27 erofs.root
> >> -rw-r--r-- 1 ubuntu ubuntu 3.3M May 30 20:28 squashfs.root
> > 
> > Even EROFS now supports big pcluster and ztailpacking features,
> > Squashfs supports a feature called fragments which compresses
> > several tails of files in a fragment. It's obviously beneficial
> > to the final size of images but it can read unrelated data of
> > other files even such files are very small.
> > 
> > You can try a big file with EROFS and Squashfs, and you can
> > see the difference.
> > 
> > Btw, MicroLZMA is still an experimental feature for now, due to 
> > three reasons:
> > - XZ utils hasn't release a stable version for now, which I think
> >   Lasse will release a stable version this year;
> > 
> > - EROFS has a finalized on-disk MircoLZMA support since Linux 5.16,
> >   so users can mount MicroLZMA since 5.16.  Yet currently EROFS is
> >   not quite optimized for such slow algorithm, since it needs a
> >   completely different strategy from LZ4.  I'm working on that
> >   together with folio work;
> > 
> > - We need a similiar `fragment' feature to catch squashfs under a
> >   lot of files.
> 
> Is that feature likely to be implemented for EROFS or is that out of scope?

As far as I know, Yue Hu has some interest working on this. But that is
not a promise anyway, I can seek time working on this as well.

> 
> > 
> >> 
> >> Is erofs just not meant for such small storages?
> > 
> > If you care more about the size of images, I personally prefer to
> > squashfs for now until we handle all the things above.
> 
> Sure, I didn’t plan to migrate things over to EROFS just like that but it looks like a good candidate in the future!

Yeah, I think anyway openwrt can support it as an alternative fs, but
anyway, if you pursue extreme storage saving, the solution may vary
endlessly and could be much complicated (and definitely impact runtime
performance.)

But we can do in this way further if it seems simply like fragments.

> 
> Thank you and everyone involved for working on EROFS!
> 

Thanks,
Gao Xing

> Best,
> Paul Spooren
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> >> 
> >> Thanks for all further comments!
> >> 
> >> Best,
> >> Paul
> >> 
> >> [1]: https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-rootfs.tar.gz
