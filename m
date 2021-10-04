Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B60420526
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 06:10:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HN6gx2wJgz2yPd
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 15:10:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QUi+fijT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QUi+fijT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HN6gt5tZgz2yL7
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Oct 2021 15:10:18 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53ADE61213;
 Mon,  4 Oct 2021 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633320616;
 bh=ZCSiU1TjPHA2Ig9/1k132+N1fGOcs39Ce5Wdd4tJiHQ=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=QUi+fijT2ES/oEZuSc1qATbkOrPsSo+lqbIA+0SnFJZAlvjtfDONMw0JflYWfKDPN
 1Aimx8SU6thCQdIPd6yGdiWLCF2kn+lVTv4xf6DWg63yyeMKXixdSIfviIvm0e5WHp
 At9UFdfmZTlqDs2KE/hFMAj2z4EAJ1pkJZssSUyZALy9XJyUycS9fsP1elgxseGxXo
 Zozh58UUxzokV9eibC7lXsIyP1Dc3Dbbw8zzg3Ride7Vf64qQa97sa7QWgaXUfZELx
 IT3SltALPqN8od9sCT37LJsVboS+WjjPR/ysyZ/zxbjnEUy0Emleng4Sg93uwoEzqN
 sDFYUY8iCjM0A==
Date: Mon, 4 Oct 2021 12:10:11 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Michael <fedora.dm0@gmail.com>, linux-erofs@lists.ozlabs.org
Subject: Re: SELinux labels not defined
Message-ID: <20211004041011.GB16617@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: David Michael <fedora.dm0@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <8735pjoxbk.fsf@gmail.com>
 <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
 <20211004014449.GA16617@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004014449.GA16617@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Mon, Oct 04, 2021 at 09:44:49AM +0800, Gao Xiang wrote:
> On Sun, Oct 03, 2021 at 08:31:18PM -0400, David Michael wrote:
> > On Sun, Oct 3, 2021 at 12:38 AM Gao Xiang <xiang@kernel.org> wrote:
> > > Hi David,
> > >
> > > On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> > > > Hi,
> > > >
> > > > I tried to make an SELinux-labeled EROFS image, and the image itself
> > > > seems to contain the labels from a hex dump, but the mounted files are
> > > > all unlabeled:
> > > >
> > > > # ls -lZ xml
> > > > total 8
> > > > drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> > > > drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> > > > # mkfs.erofs test.img xml
> > > > mkfs.erofs 1.3-g4e183568-dirty
> > > >       c_version:           [1.3-g4e183568-dirty]
> > > >       c_dbg_lvl:           [       2]
> > > >       c_dry_run:           [       0]
> > > > # mount -o X-mount.mkdir test.img test
> > > > # ls -lZ test
> > > > total 8
> > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> > > >
> > > > This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> > > > the relevant config options:
> > > >
> > > > CONFIG_EROFS_FS=m
> > > > # CONFIG_EROFS_FS_DEBUG is not set
> > > > CONFIG_EROFS_FS_XATTR=y
> > > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > > CONFIG_EROFS_FS_SECURITY=y
> > > > CONFIG_EROFS_FS_ZIP=y
> > > >
> > > > I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> > > > it also has the same issue.  However, the earliest kernel in Fedora 33
> > > > (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> > > > mounted.  Is there a problem in the file system driver, or do I need to
> > > > do something different for newer kernels?
> > >
> > > Thanks for your report!
> > >
> > > I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
> > > xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.
> > >
> > > Would you mind checking if Fedora kernels did something new for EROFS or
> > > something else on fc34? Can you check if the images work on upstream
> > > kernels?
> > 
> > The labels failed in the same way on every distro I tried: Fedora,
> > openSUSE (5.14.6-1.4.x86_64), Ubuntu (5.11.0-37-generic), and Gentoo
> > (5.14.8-gentoo-dist-hardened and 5.10.68-gentoo-dist-hardened).
> > 
> > I noticed that the labels appear correctly when the system is running
> > with SELinux disabled, but booting with it enabled results in
> > unlabeled_t labels on erofs mounts.
> 
> May I ask what "getfattr -m security.selinux" returns for these files if
> the issue happens?
> 
> I have no idea what's wrong with the recent versions. I'll dig info it
> further. But it needs some extra time.

I found SECURITY_FS_USE_XATTR was not set due to lack of proper
sepolicy. I've sent out a patch to refpolicy to address this:
https://lore.kernel.org/selinux-refpolicy/20211004035901.5428-1-xiang@kernel.org/

Actually Android has its own sepolicy and doesn't use refpolicy
above. We updated it several years ago. But refpolicy seems not.

As for why Fedora 33 works, I have no clue yet (don't have much
time on digging this.)

Thanks,
Gao Xiang
