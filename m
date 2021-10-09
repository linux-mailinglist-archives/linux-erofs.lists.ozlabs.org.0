Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D6427AAF
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 15:49:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRRHV1f7Xz308C
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 00:49:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRRHP1X3Wz2yP7
 for <linux-erofs@lists.ozlabs.org>; Sun, 10 Oct 2021 00:49:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R931e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0Ur7ySr0_1633787319; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ur7ySr0_1633787319) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 09 Oct 2021 21:48:41 +0800
Date: Sat, 9 Oct 2021 21:48:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: SELinux labels not defined
Message-ID: <YWGdt7Pt7kNlUmWa@B-P7TQMD6M-0146.local>
References: <8735pjoxbk.fsf@gmail.com>
 <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
 <20211004014449.GA16617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211004041011.GB16617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7kOFa_HM0GmFFZ7QQezByK8zyQXGdqwSoJCJPoAUbOkrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvUa7kOFa_HM0GmFFZ7QQezByK8zyQXGdqwSoJCJPoAUbOkrw@mail.gmail.com>
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

On Sat, Oct 09, 2021 at 09:31:43AM -0400, David Michael wrote:
> On Mon, Oct 4, 2021 at 12:10 AM Gao Xiang <xiang@kernel.org> wrote:
> > On Mon, Oct 04, 2021 at 09:44:49AM +0800, Gao Xiang wrote:
> > > On Sun, Oct 03, 2021 at 08:31:18PM -0400, David Michael wrote:
> > > > On Sun, Oct 3, 2021 at 12:38 AM Gao Xiang <xiang@kernel.org> wrote:
> > > > > Hi David,
> > > > >
> > > > > On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I tried to make an SELinux-labeled EROFS image, and the image itself
> > > > > > seems to contain the labels from a hex dump, but the mounted files are
> > > > > > all unlabeled:
> > > > > >
> > > > > > # ls -lZ xml
> > > > > > total 8
> > > > > > drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> > > > > > drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> > > > > > # mkfs.erofs test.img xml
> > > > > > mkfs.erofs 1.3-g4e183568-dirty
> > > > > >       c_version:           [1.3-g4e183568-dirty]
> > > > > >       c_dbg_lvl:           [       2]
> > > > > >       c_dry_run:           [       0]
> > > > > > # mount -o X-mount.mkdir test.img test
> > > > > > # ls -lZ test
> > > > > > total 8
> > > > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> > > > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> > > > > >
> > > > > > This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> > > > > > the relevant config options:
> > > > > >
> > > > > > CONFIG_EROFS_FS=m
> > > > > > # CONFIG_EROFS_FS_DEBUG is not set
> > > > > > CONFIG_EROFS_FS_XATTR=y
> > > > > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > > > > CONFIG_EROFS_FS_SECURITY=y
> > > > > > CONFIG_EROFS_FS_ZIP=y
> > > > > >
> > > > > > I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> > > > > > it also has the same issue.  However, the earliest kernel in Fedora 33
> > > > > > (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> > > > > > mounted.  Is there a problem in the file system driver, or do I need to
> > > > > > do something different for newer kernels?
> > > > >
> > > > > Thanks for your report!
> > > > >
> > > > > I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
> > > > > xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.
> > > > >
> > > > > Would you mind checking if Fedora kernels did something new for EROFS or
> > > > > something else on fc34? Can you check if the images work on upstream
> > > > > kernels?
> > > >
> > > > The labels failed in the same way on every distro I tried: Fedora,
> > > > openSUSE (5.14.6-1.4.x86_64), Ubuntu (5.11.0-37-generic), and Gentoo
> > > > (5.14.8-gentoo-dist-hardened and 5.10.68-gentoo-dist-hardened).
> > > >
> > > > I noticed that the labels appear correctly when the system is running
> > > > with SELinux disabled, but booting with it enabled results in
> > > > unlabeled_t labels on erofs mounts.
> > >
> > > May I ask what "getfattr -m security.selinux" returns for these files if
> > > the issue happens?
> > >
> > > I have no idea what's wrong with the recent versions. I'll dig info it
> > > further. But it needs some extra time.
> >
> > I found SECURITY_FS_USE_XATTR was not set due to lack of proper
> > sepolicy. I've sent out a patch to refpolicy to address this:
> > https://lore.kernel.org/selinux-refpolicy/20211004035901.5428-1-xiang@kernel.org/
> 
> Sorry for the late reply, I finally got the time to build systems with
> this patch to test, and I can confirm this fixes the issue I was
> seeing.

Thanks for the confirmation! ;) (I should update it earlier...)

Thanks,
Gao XIang

> 
> Thanks.
> 
> David
