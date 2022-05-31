Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D78538931
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 02:00:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBsqh2T12z306F
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 10:00:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZiDVjTQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZiDVjTQ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBsqb0mQ4z2yyS
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 10:00:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F390F60FE2;
	Tue, 31 May 2022 00:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E52C385B8;
	Tue, 31 May 2022 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653955239;
	bh=6IqBmH5NrLRjFFdEOq2JFNYNt2yiP3m7LvxSRFgB/Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZiDVjTQTqHfCMpC12dpCw3oGef8Tz2IsKVOY6AxMZ+6wH2NsvU48PcSy/cr+PkU4
	 Hi0DfbInpsfAoXaieemw4/rre3u/FarppuGu7xXgHzN+eu2ML2Bz6O/gNlENXdx/A4
	 WFkUo6GGdmQaC7/9xtjatkyIawShj1dZJbV0jToCkRokPQbaCW6eKNFtRoSd265kPx
	 sqg+1N0HSFre0qKQFBs2cvFzVu9Y6y7tedqGjbJzSHpNoX1k//hcxxSKnEZdXezil3
	 r+sEVKNIRxMBwxVCzActQG9vV3qrqkr1sp241mZGyvacnBOAeZBeBtqwIOZPQE7EGX
	 lzsl4qCNY+uBA==
Date: Tue, 31 May 2022 08:00:35 +0800
From: Gao Xiang <xiang@kernel.org>
To: Paul Spooren <mail@aparcar.org>
Subject: Re: Worse performance than SquashFS for small filesystems
Message-ID: <YpVao8WX3B6HPWt7@debian>
Mail-Followup-To: Paul Spooren <mail@aparcar.org>,
	linux-erofs@lists.ozlabs.org
References: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B908083A-D162-4EC1-9E2C-23D49190BAA1@aparcar.org>
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

On Mon, May 30, 2022 at 08:41:34PM +0200, Paul Spooren wrote:
> Hi,
> 
> I’m an OpenWrt developer and we work on an operation system for routers and overall network facing embedded devices. Since storage is often limited on our targeted devices we use SquashFS to compress everything, total image sizes are less than 10 MegaBytes.
> 
> Reading about erofs I’m very keen to adopt it for our case, however giving it a first try the storage performance seems to be significantly _worse_ than the default SquashFS implementation. Since you ran benchmarks in the past, could you give me advise if I’m missing anything?

What the meaning of `performance'? I don't think the size of images
mean runtime performance anyway.

> 
> For the test I used erofs-utils as of a134ce7c39a5427343029e97a62665157bef9bc3 (2022-05-17) and compressed the x86/64 root filesystem of a standard OpenWrt image[1]. I’m seeing a difference of one MegaByte which is about 30% worse in this context.
> 
> My test:
> 
> $ ./staging_dir/host/bin/mkfs.erofs -zlzma erofs.root ./build_dir/target-x86_64_musl/root-x86

Have you try with

-zlzma -C 65536 -Eztailpacking

by default, EROFS uses 4k compression rather than Squashfs 128k.

> mkfs.erofs 1.4
> <W> erofs: EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
> <W> erofs: Note that it may take more time since the compressor is still single-threaded for now.
> Build completed.
> 
> $ mksquashfs -comp xz ./build_dir/target-x86_64_musl/root-x86 squashfs.root
> 
> $ ls -lh *.root
> -rw-r--r-- 1 ubuntu ubuntu 4.3M May 30 20:27 erofs.root
> -rw-r--r-- 1 ubuntu ubuntu 3.3M May 30 20:28 squashfs.root

Even EROFS now supports big pcluster and ztailpacking features,
Squashfs supports a feature called fragments which compresses
several tails of files in a fragment. It's obviously beneficial
to the final size of images but it can read unrelated data of
other files even such files are very small.

You can try a big file with EROFS and Squashfs, and you can
see the difference.

Btw, MicroLZMA is still an experimental feature for now, due to 
three reasons:
 - XZ utils hasn't release a stable version for now, which I think
   Lasse will release a stable version this year;

 - EROFS has a finalized on-disk MircoLZMA support since Linux 5.16,
   so users can mount MicroLZMA since 5.16.  Yet currently EROFS is
   not quite optimized for such slow algorithm, since it needs a
   completely different strategy from LZ4.  I'm working on that
   together with folio work;

 - We need a similiar `fragment' feature to catch squashfs under a
   lot of files.

> 
> Is erofs just not meant for such small storages?

If you care more about the size of images, I personally prefer to
squashfs for now until we handle all the things above.

Thanks,
Gao Xiang

> 
> Thanks for all further comments!
> 
> Best,
> Paul
> 
> [1]: https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-rootfs.tar.gz
