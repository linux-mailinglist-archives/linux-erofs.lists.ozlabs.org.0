Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B92B6F4093
	for <lists+linux-erofs@lfdr.de>; Tue,  2 May 2023 12:03:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q9bJ770BQz3c6v
	for <lists+linux-erofs@lfdr.de>; Tue,  2 May 2023 20:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fpCUgbwx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=daan.j.demeyer@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fpCUgbwx;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q9bJ02szCz3brd
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 May 2023 20:03:27 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24df161f84bso1733188a91.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 May 2023 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683021804; x=1685613804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o128J1IRyn+o3anqxq7UQayyzEJ/ChqdqpgZ6UdQ4Fo=;
        b=fpCUgbwxr8YxaX4KlxVi4PusfRI7bWppnDrRyubOQZUtJlHej8EUo6ymbdPajmBtbe
         wG/2WCggb26x/eKTVfJqyQSwh8pVjfCayG/LUunGghOr9UNKRO5uELT9qhoC9xrNrxq1
         IL+F7sYhd6G/CODi4t7zDYXdzBpRe7yAPgDVDN37syeAOHbhc2CSWcplqwITGm5qS1aL
         kZUhyS/PLArIgi5xEl8gIYYmZ8AVOlMhICDQOYKBnBkgmSba0+wtuhiAO5KNIAGfxkWe
         B2CQ09zDFo2O1gLD4jlT/9sdv1Z+iIuHB1N+REkIleE4BRcuRDJWAkEzVt0MUMtjiD2l
         emKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021804; x=1685613804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o128J1IRyn+o3anqxq7UQayyzEJ/ChqdqpgZ6UdQ4Fo=;
        b=KePIjjr2cS/ajM99vHW8Wrq1qsjH4inmRzoQ8ov3xrMfCEbOio+Xan/SepuX4oVVwk
         AW/GQSehiI4sojb2TNnZb+bZzaiXFo8SFmbIJkIQN8vSDhNKXOoXyhonTSxKAr7caUQf
         QwUqJoXIMStVw6xKBfxxlahEplHE0g93Ys0rJt5CE2uCiKzcogmajKQ9GU50ho/2zqqd
         IyiUoZrRsZeyzlq8jZ5T6IMxwxQRTds05Ov/uo1XgbR5rnPPzftneegvR1EmopY53rHm
         EOdTsMdxOVsezTh4p/ZhRjbYkK0k65NPh5YptaPe17SJGQpqQkpP+x6Dwtuq5Fh5XrGm
         M1aw==
X-Gm-Message-State: AC+VfDwVv0rx2cKxjIfkDBbH91QJLqRevvysvJwClU+6nYt6anQ99Y+r
	9nUzIzp5uwLvTBTx8Hw73Zn1L0hEfeif2u2yuss=
X-Google-Smtp-Source: ACHHUZ6GQDuc7R0VGJnsruX1dGwsPiwJSAlvJR72VEeDmMQV2N7fJqSiMFsgIYHrPoY57w9AkVVgZCWqgn8BPxJJS3s=
X-Received: by 2002:a17:90a:8d0a:b0:24e:396:aa5e with SMTP id
 c10-20020a17090a8d0a00b0024e0396aa5emr5694812pjo.23.1683021804360; Tue, 02
 May 2023 03:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
 <86f08d9c-ea37-6012-fbb9-c2e2710c00f1@linux.alibaba.com>
In-Reply-To: <86f08d9c-ea37-6012-fbb9-c2e2710c00f1@linux.alibaba.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Tue, 2 May 2023 12:03:13 +0200
Message-ID: <CAO8sHc=7FHA8vEnHHOySnOCDQ9HvWbCEC3nVqyG6J=OJEfz38Q@mail.gmail.com>
Subject: Re: Merging multiple erofs file systems on the same block device
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> On 2023/5/1 22:09, Daan De Meyer wrote:
> > Hi,
> >
> > I've been looking into erofs as an initramfs replacement by using
> > root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.
>
> Sorry, I'm on vacation now.
>
> May I ask what's your detailed use cases?  Sure, you could use
> /dev/ram0 as a replacement, but currently it still takes double
> memory compared with initramfs since ramdisk doesn't support FSDAX
> for now (by enabling FSDAX, it won't take double memory at all.)

I'm experimenting with larger initramfses and running into memory
bottlenecks since the entire compressed cpio has to be decompressed
into memory. I was hoping to use erofs as a replacement that could stay
compressed, where only the files that are actually accessed are
decompressed at runtime.

> Actually I think ramdisk FSDAX is useful and I might sync up this on
> the following LSF/MM/BPF 2023.
>
> > However, by using a ramdisk instead of the usual compressed cpio, I
> > would lose the feature where the kernel merges multiple individual
> > cpios together into a single tmpfs filesystem. Looking at the
> > documentation for erofs, I noticed that erofs already seems to support
> > merging multiple erofs filesystems on separate block devices using the
> > device= cmdline option. Would it be possible to extend this so that
> Here `device=` is actually used to refer to seperate blobs with the
> merged metadata.  For example, you could have
>
>    device=/dev/ram1 original tar1
>    device=/dev/ram2 original tar2
>    /dev/ram0        merged metadata for tar1 + tar2.
>
> which means, if you'd like to merge multiple EROFS filesystems, you
> might need another step to build a merged metadata in advance in order
> to merges multiple individual tarballs together, which could be built
> when applying images or booting (by using a special bootloader with
> such functionality.)

Ahh, I misunderstood the device= option then.

> EROFS doesn't support stacking multiple fses runtimely since it seems
> a duplicated feature of overlayfs (you could consider using overlayfs
> honestly.)

I would love to use overlayfs, but there's no way to specify to the kernel that
the initrd should be set up as an overlayfs of a set of ram disks. It would be
interesting if I could put multiple filesystems in the initrd and the
kernel would
notice and automatically set up an overlayfs of them.

> > multiple erofs filesystems that follow each other on the same block
> > device can also be merged? This would allow me to pass multiple erofs
> > filesystems to the kernel via initrd=, which would get concatenated
> > together into a single buffer, which the kernel would write to a
> > ramdisk (using root=/dev/ram0) which the kernel would then have erofs
> > mount to /dev/root. erofs would notice that there's multiple erofs
> > filesystems on the ramdisk and overlay them together (perhaps only if
> > a cmdline option is enabled).
>
> Recently, A merged EROFS filesystem with a single block device can
> be passed but you might still need a step to build a merged fs tree
> before mounting.  Such feature is used to build a metadata and
> reuse original tar blobs.
>
> >
> > Does this make sense at all?
>
> Hopefully it helps.
