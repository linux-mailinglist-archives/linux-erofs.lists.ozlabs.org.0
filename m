Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9B420488
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 02:31:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HN1qc0DFcz2yNr
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Oct 2021 11:31:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dqasK4eu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::434;
 helo=mail-wr1-x434.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=dqasK4eu; dkim-atps=neutral
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HN1qX2DzRz2xtM
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Oct 2021 11:31:34 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id m22so22028781wrb.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 03 Oct 2021 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=g3xwmYtxgcpo7X3+9BS7QHQNUzqWAUEcAawK5Ecufd8=;
 b=dqasK4euLUXwzIW3gAFwFsE98uRZVUKJc38ezr+F6Rl6k7Ol4SIZjRxHnxVGvAVqRl
 Yz+EK4dikSNjtLVbHoVeR6Tcu6cgF5cz1GSnxPpIMhFyMPo/GhrFJ83ukM06w1To55Zd
 pboSo3NO94V7jau1oQWc2MhA1AqR2G13v0eNF3QG4WEXIsypT4mcI5peQ2Ii/81X6qtM
 +hHVCa5ptEiHL35l94wZ42S7UuIrWDh/9ZT9EKl3cuMINoOJkHTvQMsGk8IZw9LKqdVj
 EVEYvqHW+g0yEcq7bW/6YXIZf1UK0RKYe2mOAZt/92/a6bScYT1bF3oyLitqRUozWeGQ
 HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=g3xwmYtxgcpo7X3+9BS7QHQNUzqWAUEcAawK5Ecufd8=;
 b=5lpyue77XaCTW5XC8V2NrvzI0FngYqahsiaL+cgq7+Gdhm+cn1wttMuxeeV8m2VSIu
 Vvb34rj8L+GpU7+oM5etZknsIryhM5r3SmQjkQgBg0GrDz3fT6uDQ5AQRd90XIQKJOvh
 oYrPDlgpolp0Jiyp4v9Psj9fl/WAVGaUPdJDnJgyH8itxIGdmX5/xpfxtCF9KplL+MAo
 dBvB3Y9EveTpvu7jALTXxxFrr3VFjTuM+9nMhNINbhmr7oKVdcMCrz+6K+rwlwEDmPAk
 NbXmZwKtiBvfapJ4eFcOtHne3vSBZFu2Dnjk0qGIPAFZJ29htgXNaQkSO3MpXR66lrOi
 9cTg==
X-Gm-Message-State: AOAM532Z01mKXnXf7ayeSXg8rdfadFsu58/XM3WB9z+BWY3MSQ9zoge9
 EU1qJudvQogSZoz7OtT8ucdXbziX42s7vSOKRdPJJMnZ
X-Google-Smtp-Source: ABdhPJw508Y9AVKWOtKzp1qcukFW/P/yHlVgPgREi0ouBmo0tmwspPxrWJw4H89wiQYnDYnnTCzmh6i85yKwXpOZZiA=
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr10856548wrb.345.1633307489725; 
 Sun, 03 Oct 2021 17:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <8735pjoxbk.fsf@gmail.com>
 <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20211003043840.GA9546@hsiangkao-HP-ZHAN-66-Pro-G1>
From: David Michael <fedora.dm0@gmail.com>
Date: Sun, 3 Oct 2021 20:31:18 -0400
Message-ID: <CAEvUa7=pmF-NkUkx99D9E8xf2Cu9gjXxWd_H7r9UZiCgR-gbmQ@mail.gmail.com>
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

On Sun, Oct 3, 2021 at 12:38 AM Gao Xiang <xiang@kernel.org> wrote:
> Hi David,
>
> On Sat, Oct 02, 2021 at 06:50:55PM -0400, David Michael wrote:
> > Hi,
> >
> > I tried to make an SELinux-labeled EROFS image, and the image itself
> > seems to contain the labels from a hex dump, but the mounted files are
> > all unlabeled:
> >
> > # ls -lZ xml
> > total 8
> > drwxr-xr-x. 2 root root unconfined_u:object_r:var_t:s0         4096 Sep 29 21:43 dbus-1
> > drwxr-xr-x. 2 root root unconfined_u:object_r:fonts_cache_t:s0 4096 Sep 29 22:19 fontconfig
> > # mkfs.erofs test.img xml
> > mkfs.erofs 1.3-g4e183568-dirty
> >       c_version:           [1.3-g4e183568-dirty]
> >       c_dbg_lvl:           [       2]
> >       c_dry_run:           [       0]
> > # mount -o X-mount.mkdir test.img test
> > # ls -lZ test
> > total 8
> > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 78 Oct  2 18:37 dbus-1
> > drwxr-xr-x. 2 root root system_u:object_r:unlabeled_t:s0 48 Oct  2 18:37 fontconfig
> >
> > This is running on the current Fedora kernel 5.14.9-200.fc34.x86_64 with
> > the relevant config options:
> >
> > CONFIG_EROFS_FS=m
> > # CONFIG_EROFS_FS_DEBUG is not set
> > CONFIG_EROFS_FS_XATTR=y
> > CONFIG_EROFS_FS_POSIX_ACL=y
> > CONFIG_EROFS_FS_SECURITY=y
> > CONFIG_EROFS_FS_ZIP=y
> >
> > I tried the earliest kernel in Fedora 34 (5.11.12-300.fc34.x86_64), and
> > it also has the same issue.  However, the earliest kernel in Fedora 33
> > (5.8.15-301.fc33.x86_64) has the correct labels when the image is
> > mounted.  Is there a problem in the file system driver, or do I need to
> > do something different for newer kernels?
>
> Thanks for your report!
>
> I don't think there is any difference between 5.8 - 5.14 on EROFS selinux
> xattrs. And AFAIK some users already use EROFS selinux on Linux 5.10.
>
> Would you mind checking if Fedora kernels did something new for EROFS or
> something else on fc34? Can you check if the images work on upstream
> kernels?

The labels failed in the same way on every distro I tried: Fedora,
openSUSE (5.14.6-1.4.x86_64), Ubuntu (5.11.0-37-generic), and Gentoo
(5.14.8-gentoo-dist-hardened and 5.10.68-gentoo-dist-hardened).

I noticed that the labels appear correctly when the system is running
with SELinux disabled, but booting with it enabled results in
unlabeled_t labels on erofs mounts.

Thanks.

David
