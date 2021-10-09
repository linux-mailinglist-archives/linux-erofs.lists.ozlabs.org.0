Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAE427AA1
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 15:32:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRQvp1Yg4z308C
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 00:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YFfTDqYy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430;
 helo=mail-wr1-x430.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=YFfTDqYy; dkim-atps=neutral
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRQvg2QpQz2xX5
 for <linux-erofs@lists.ozlabs.org>; Sun, 10 Oct 2021 00:31:58 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id e3so5088873wrc.11
 for <linux-erofs@lists.ozlabs.org>; Sat, 09 Oct 2021 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=PLcVwzL/v3sHYf6FMuOdsg5GMfeQ3Bq5/LO3kzLUM6g=;
 b=YFfTDqYy0RgcmqzeNan5y/ItVC4FtDLMmsCjryjLQ1QokD9XE4iW5M+UFUtt0IgziJ
 +F6ABLYESwaEBJugh1IYzt7YoTJWdKfbIi0pym/wZt67O7SBT8BT/itRB2davz4Vtf7T
 HbDYIOTSdjnhMpXeW3VvSHRajR9yv02R7xY9/xvG3TMqxqchZID7xsaqFfcebNdzZqmf
 2ToXEnvEEzYTdqJgcjnc0k25PMJG5UEwlgek/QUgsBBOla4kNSDOf2Jc58EZM6/8ylNZ
 ZmmqURJo+eBMs7H9hT034VDBtc9rPuwab7JZkcnSxwotSrMd9Qab3b93+r8aGiQY2p1J
 /vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=PLcVwzL/v3sHYf6FMuOdsg5GMfeQ3Bq5/LO3kzLUM6g=;
 b=s+wO1XYyTY18Oz4L6rcxp/7S+zQHW9ZhXO9ZALjrdKx2bE2/PuXGTxWIBtL/XANjhT
 CRikrdJxHXhDeE2adBtXuw+UScC8GV6iBbvg9lWbFnUiVbuJsefZAznywOsVdiWhBJSQ
 ku4wg5LzOwfqUe7a7+isVvhmdtpo+w9g6Noy8A2Qb0z3NOGkxdSeM+Qfw+mtxJ/cMuN5
 nds7GjowjZD/FTGjYMaYDZI7aw0OSjwhf8sTFyIM5yRVKOWQWrTHGKPV4kJo2FXr89Zi
 iEL6mMHNAwUkHc4VYZLPmLumhlR4Nzx9SQTnNTXOizrU45NRFLdmDWtRJSuaf8YK1zjj
 rkWA==
X-Gm-Message-State: AOAM532+fvATN2nzmErPqlEDZG1brSOOL1QeWgsy0R2FNZdWTdzaJk1Q
 Gj1d4onlhElQzKNuNe07T2rp26jt5qkxsJ+YFwj8UMWi
X-Google-Smtp-Source: ABdhPJy4nm0HLWZpYDFIibcbrdQPSfmVW6ZKjB/OcxNWLyNgp6ZifDqLoBph9BLQxjcaX9+iPYQT2xjVyil0AuVKEW0=
X-Received: by 2002:a05:6000:1864:: with SMTP id
 d4mr11373017wri.345.1633786315322; 
 Sat, 09 Oct 2021 06:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <8735pjoxbk.fsf@gmail.com>
 <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
 <20211004014449.GA16617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211004041011.GB16617@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20211004041011.GB16617@hsiangkao-HP-ZHAN-66-Pro-G1>
From: David Michael <fedora.dm0@gmail.com>
Date: Sat, 9 Oct 2021 09:31:43 -0400
Message-ID: <CAEvUa7kOFa_HM0GmFFZ7QQezByK8zyQXGdqwSoJCJPoAUbOkrw@mail.gmail.com>
Subject: Re: SELinux labels not defined
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 4, 2021 at 12:10 AM Gao Xiang <xiang@kernel.org> wrote:
> On Mon, Oct 04, 2021 at 09:44:49AM +0800, Gao Xiang wrote:
> > On Sun, Oct 03, 2021 at 08:31:18PM -0400, David Michael wrote:
> > > On Sun, Oct 3, 2021 at 12:38 AM Gao Xiang <xiang@kernel.org> wrote:
> > > > Hi David,
> > > >
> > > > On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> > > > > Hi,
> > > > >
> > > > > I tried to make an SELinux-labeled EROFS image, and the image itself
> > > > > seems to contain the labels from a hex dump, but the mounted files are
> > > > > all unlabeled:
> > > > >
> > > > > # ls -lZ xml
> > > > > total 8
> > > > > drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> > > > > drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> > > > > # mkfs.erofs test.img xml
> > > > > mkfs.erofs 1.3-g4e183568-dirty
> > > > >       c_version:           [1.3-g4e183568-dirty]
> > > > >       c_dbg_lvl:           [       2]
> > > > >       c_dry_run:           [       0]
> > > > > # mount -o X-mount.mkdir test.img test
> > > > > # ls -lZ test
> > > > > total 8
> > > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> > > > > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> > > > >
> > > > > This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> > > > > the relevant config options:
> > > > >
> > > > > CONFIG_EROFS_FS=m
> > > > > # CONFIG_EROFS_FS_DEBUG is not set
> > > > > CONFIG_EROFS_FS_XATTR=y
> > > > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > > > CONFIG_EROFS_FS_SECURITY=y
> > > > > CONFIG_EROFS_FS_ZIP=y
> > > > >
> > > > > I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> > > > > it also has the same issue.  However, the earliest kernel in Fedora 33
> > > > > (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> > > > > mounted.  Is there a problem in the file system driver, or do I need to
> > > > > do something different for newer kernels?
> > > >
> > > > Thanks for your report!
> > > >
> > > > I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
> > > > xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.
> > > >
> > > > Would you mind checking if Fedora kernels did something new for EROFS or
> > > > something else on fc34? Can you check if the images work on upstream
> > > > kernels?
> > >
> > > The labels failed in the same way on every distro I tried: Fedora,
> > > openSUSE (5.14.6-1.4.x86_64), Ubuntu (5.11.0-37-generic), and Gentoo
> > > (5.14.8-gentoo-dist-hardened and 5.10.68-gentoo-dist-hardened).
> > >
> > > I noticed that the labels appear correctly when the system is running
> > > with SELinux disabled, but booting with it enabled results in
> > > unlabeled_t labels on erofs mounts.
> >
> > May I ask what "getfattr -m security.selinux" returns for these files if
> > the issue happens?
> >
> > I have no idea what's wrong with the recent versions. I'll dig info it
> > further. But it needs some extra time.
>
> I found SECURITY_FS_USE_XATTR was not set due to lack of proper
> sepolicy. I've sent out a patch to refpolicy to address this:
> https://lore.kernel.org/selinux-refpolicy/20211004035901.5428-1-xiang@kernel.org/

Sorry for the late reply, I finally got the time to build systems with
this patch to test, and I can confirm this fixes the issue I was
seeing.

Thanks.

David
