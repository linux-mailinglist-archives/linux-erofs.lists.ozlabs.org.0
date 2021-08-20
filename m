Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511AB3F2D1B
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 15:27:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grj9c1JtYz3cLP
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 23:27:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=buCDFAaT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=buCDFAaT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grj9Y1XcDz3bnK
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 23:27:29 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F07ED6044F;
 Fri, 20 Aug 2021 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629466046;
 bh=MnxoBdyT6zcvfDO1yfBM111h9bxczgdDq6BSVvhLPME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=buCDFAaTPaBVo9hsAP8wY0Ne6lYvvcwJGzeKsweMP73lmlQ95MpSSwUi9/NNC4Qo5
 apRi+wze0SMCiqjn5eldTvccOM7ABxTfR7HOxrhQfyFhchZU2yBRfhJUzLggRe2qnm
 DOSthOJWep0uj+t7fL8+MiC3uezUXggwVI5avGGz3bNK9fNgeLv2EA6ZH9PEtpcEn5
 MzeiMP1w9nsSHsmVknL/uXT/5gSVloxGyn7Zst3zlrIBQ/SwLzeRm1sfnGNilHe1WT
 9+N6C6EBvuocQC59uH4Yj/Bl5TGwHxK3DsnSZ6hPTUNUSTRxKef0k2iTTD7ABxvWAs
 W2Ep3DordFrfg==
Date: Fri, 20 Aug 2021 21:26:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: An issue with erofsfuse
Message-ID: <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Igor Eisberg <igoreisberg@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 20, 2021 at 04:16:20PM +0300, Igor Eisberg wrote:
> You're quicker than expected, thanks for answering.
> Not sure how to check if lz4 was builtin, but considering that erofsfuse is
> only about 34.5KB (stripped) I would guess not?
> Here's the output of erofsfuse -d (it prints this but never exists back to
> shell unless I do Ctrl+C):

Yeah, it will run erofsfuse in foreground, and you need to access the
erofs compressed files, and then check the printed result.

But I think there is a easier way to check if lz4 was linked, just type
ldd <your erofsfuse program>

if lz4 was linked, it will print some message like below:
	linux-vdso.so.1 (0x00007ffee176e000)
	libfuse.so.2 =&gt; /lib/x86_64-linux-gnu/libfuse.so.2 (0x00007f8e21f24000)
	liblz4.so.1 =&gt; /lib/x86_64-linux-gnu/liblz4.so.1 (0x00007f8e21f01000)
	libpthread.so.0 =&gt; /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f8e21ee0000)
	libc.so.6 =&gt; /lib/x86_64-linux-gnu/libc.so.6 (0x00007f8e21d1f000)
	libdl.so.2 =&gt; /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f8e21d1a000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f8e21f91000)

Thanks,
Gao Xiang

> 
> erofsfuse 1.3
> >
> > disk: product.img
> >
> > mountpoint: product-mnt
> >
> > dbglevel: 7
> >
> > FUSE library version: 2.9.9
> >
> > nullpath_ok: 0
> >
> > nopath: 0
> >
> > utime_omit_ok: 0
> >
> > unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
> >
> > INIT: 7.27
> >
> > flags=0x003ffffb
> >
> > max_readahead=0x00020000
> >
> > EROFS: erofsfuse_init() Line[23] Using FUSE protocol 7.27
> >
> >    INIT: 7.19
> >
> >    flags=0x00000011
> >
> >    max_readahead=0x00020000
> >
> >    max_write=0x00020000
> >
> >    max_background=0
> >
> >    congestion_threshold=0
> >
> >    unique: 1, success, outsize: 40
> >
> >
> On Fri, 20 Aug 2021 at 15:49, Gao Xiang <xiang@kernel.org> wrote:
> 
> > Hi Igor,
> >
> > On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:
> > > Hey there, getting straight to the point.
> > > Our team is using Debian 10, in which erofs mounting is not supported and
> > > we have no option of updating the kernel, nor do we have sudo permissions
> > > on this server.
> > >
> > > Our only choice is to use erofsfuse to mount an Android image
> > (compression
> > > was used on that image), for the sole purpose of extracting its contents
> > to
> > > another folder for processing.
> > > Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native
> > > mounting is supported), but on all of them I could not copy files which
> > are
> > > compressed from the mounted image to another location (ext4 file system).
> > >
> > > The error I'm getting is: "Operation not supported (95)"
> > >
> >
> > Thanks for your feedback.
> >
> > Could you check if lz4 was built-in when building erofsfuse? I guess
> > that is the reason (lack of lz4 support builtin).
> >
> > If not, could you add -d to erofsfuse when starting up?
> >
> > Thanks,
> > Gao Xiang
> >
> > > Notes:
> > > * Only extremely small (< 1 KB) files which are stored uncompressed are
> > > copied successfully.
> > > * Copying works perfectly when mounting the image with "sudo mount" on
> > the
> > > latest Kubuntu, so it has to be something with erofsfuse.
> > >
> > > Anything you can do to help resolve this?
> > >
> > > Best,
> > > Igor.
> >
