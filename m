Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C92924204C6
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 03:45:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HN3SF56TQz2yPy
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 12:45:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OFvCvkVw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OFvCvkVw; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HN3S964JWz2xsv
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Oct 2021 12:44:57 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B6961213;
 Mon,  4 Oct 2021 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633311894;
 bh=7MLf82cnCrWjvZoI2IydA44BZpD2FoqdQ188ptvqxkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OFvCvkVw69+3YWLHhK5QAo3XgZ/JkugzKySfP7s2drfe30Xwnilber7BG5+JWeWvF
 rOOHD2ECCRYjNKHbsCXiA4luo5PZnjmafZIC4lC12Bc77VqA1nZPumk5RlSuqCX7qo
 AIp8emi2sDFeDmTtdg25eqwRaCmLpOrx9kTjk48TbAG4sj7807N8HcxjxrFbcg1wU1
 7/3oIdLkySE7PxrGlU53IwE0iPa4lkKOSexKZmjoPxfUEzJLq+mn8bypQ7BvleW7iY
 rUIbUyAWRTZ2uxiUXHkBXI0k/JsorZf8GexITF8BtE21dpTn1p36rHIXeS3RsHYf37
 doSoWAKv9iZYQ==
Date: Mon, 4 Oct 2021 09:44:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: SELinux labels not defined
Message-ID: <20211004014449.GA16617@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: David Michael <fedora.dm0@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <8735pjoxbk.fsf@gmail.com>
 <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
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

On Sun, Oct 03, 2021 at 08:31:18PM -0400, David Michael wrote:
> On Sun, Oct 3, 2021 at 12:38 AM Gao Xiang <xiang@kernel.org> wrote:
> > Hi David,
> >
> > On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> > > Hi,
> > >
> > > I tried to make an SELinux-labeled EROFS image, and the image itself
> > > seems to contain the labels from a hex dump, but the mounted files are
> > > all unlabeled:
> > >
> > > # ls -lZ xml
> > > total 8
> > > drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> > > drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> > > # mkfs.erofs test.img xml
> > > mkfs.erofs 1.3-g4e183568-dirty
> > >       c_version:           [1.3-g4e183568-dirty]
> > >       c_dbg_lvl:           [       2]
> > >       c_dry_run:           [       0]
> > > # mount -o X-mount.mkdir test.img test
> > > # ls -lZ test
> > > total 8
> > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> > >
> > > This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> > > the relevant config options:
> > >
> > > CONFIG_EROFS_FS=m
> > > # CONFIG_EROFS_FS_DEBUG is not set
> > > CONFIG_EROFS_FS_XATTR=y
> > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > CONFIG_EROFS_FS_SECURITY=y
> > > CONFIG_EROFS_FS_ZIP=y
> > >
> > > I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> > > it also has the same issue.  However, the earliest kernel in Fedora 33
> > > (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> > > mounted.  Is there a problem in the file system driver, or do I need to
> > > do something different for newer kernels?
> >
> > Thanks for your report!
> >
> > I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
> > xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.
> >
> > Would you mind checking if Fedora kernels did something new for EROFS or
> > something else on fc34? Can you check if the images work on upstream
> > kernels?
> 
> The labels failed in the same way on every distro I tried: Fedora,
> openSUSE (5.14.6-1.4.x86_64), Ubuntu (5.11.0-37-generic), and Gentoo
> (5.14.8-gentoo-dist-hardened and 5.10.68-gentoo-dist-hardened).
> 
> I noticed that the labels appear correctly when the system is running
> with SELinux disabled, but booting with it enabled results in
> unlabeled_t labels on erofs mounts.

May I ask what "getfattr -m security.selinux" returns for these files if
the issue happens?

I have no idea what's wrong with the recent versions. I'll dig info it
further. But it needs some extra time.

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
