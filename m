Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8166F7E93
	for <lists+linux-erofs@lfdr.de>; Fri,  5 May 2023 10:19:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QCNs52QWXz3bjY
	for <lists+linux-erofs@lfdr.de>; Fri,  5 May 2023 18:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rv6YF5JE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=daan.j.demeyer@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=rv6YF5JE;
	dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QCNry2z7Mz3bjY
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 May 2023 18:19:45 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52867360efcso950102a12.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 05 May 2023 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683274782; x=1685866782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7Gro5Z7ePx/3jIof8yZe4Ayp9HGHMH4N1e/SpF5Zds=;
        b=rv6YF5JENX0S1KBMvFE8zi2i9SSWXdINh9mbqcYBDxYmKxku2zhG3UgLIxUnROgwWW
         grPGVaUGqKA0+FWgA9smQ+maBwhp9PNo/+SyH8XE4PYpzAc33lOtYMM7S5TnFUzlrIK7
         Ixu8aNpXXBMAk3xU+K5LSuliFn7ofvpPkRpqFBgEGjtDnevoZElMlGjD3WZKCUKE17LX
         L+qR2iU0GXVDSL2qtigl9pO2ePum4vBDu8tVzuEo4HHyZqTGA3NVNJn6R3RKfv0qLCI8
         UWgXR4+56XeJo6GXQJCVc9Ba6LZXVA3gp8o5PruxBSjCZexQuEc/iBcv6PxRgAU3E/bC
         8i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683274782; x=1685866782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7Gro5Z7ePx/3jIof8yZe4Ayp9HGHMH4N1e/SpF5Zds=;
        b=Nmgu5zNw3siOpxWm1vmdGYw3b94s+SNzMj53QD+0mCqPgSHYUj022pt7JWFr6XaQ8o
         T/jGxpiN8jNx8N0jnQImp3Hg5Vf+LtGB+zP58C83lFje6iyxFdguJu3VSIJHGCGvs5AA
         AwSvAotXcCZ4wJLzu/LrRxM2f7412Vq3sBr7tFN0O7YSU+Djvom2x2/ND1DrW5t4DxWR
         u5q/bHEXui9Zy1qnu+FgOKPoEAVc+cPDRPaCEvjAfO1INLkGvNxTtn9M5M0lt6UHQ+gX
         Qt6PUSu36O2i8fTUMFawKcHaWjpIX4BeGr90D6oloon06sYikRmsb+jlhnfLdIMWGy1V
         8k4w==
X-Gm-Message-State: AC+VfDyHwDkukN3nQFRTjpSHE9IZPWjyCHFFLY0jNgvY9BW1tPikuoNC
	W6eg74mzORSKV06VfDCaOfX9dvitDJO928Xz5misLCGjDJqhWiUm
X-Google-Smtp-Source: ACHHUZ67ruy8/nHOtmtYfQDKwKiZk7VE9rTv3CfDZ8XUaiOZQBje7sRqJnTuBC+w2UMbovJLgDbo2YeSHgDoUXpwcQ0=
X-Received: by 2002:a17:90b:230c:b0:24e:4d53:a9e6 with SMTP id
 mt12-20020a17090b230c00b0024e4d53a9e6mr599084pjb.35.1683274782392; Fri, 05
 May 2023 01:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8sHc=vxhp_+98Om7C83zOyXmdAkAxeoOrnffgwqkPntvO2fw@mail.gmail.com>
 <86f08d9c-ea37-6012-fbb9-c2e2710c00f1@linux.alibaba.com> <CAO8sHc=7FHA8vEnHHOySnOCDQ9HvWbCEC3nVqyG6J=OJEfz38Q@mail.gmail.com>
 <3e0474fc-2d24-8c47-9f0f-40b6709d6e74@linux.alibaba.com>
In-Reply-To: <3e0474fc-2d24-8c47-9f0f-40b6709d6e74@linux.alibaba.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Fri, 5 May 2023 10:19:31 +0200
Message-ID: <CAO8sHcmFF5KrB5GkXvCcueNHzZcyksWsGTJjjxSE=uo+=xRVFg@mail.gmail.com>
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

> On 2023/5/2 18:03, Daan De Meyer wrote:
> >> On 2023/5/1 22:09, Daan De Meyer wrote:
> >>> Hi,
> >>>
> >>> I've been looking into erofs as an initramfs replacement by using
> >>> root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.
> >>
> >> Sorry, I'm on vacation now.
> >>
> >> May I ask what's your detailed use cases?  Sure, you could use
> >> /dev/ram0 as a replacement, but currently it still takes double
> >> memory compared with initramfs since ramdisk doesn't support FSDAX
> >> for now (by enabling FSDAX, it won't take double memory at all.)
> >
> > I'm experimenting with larger initramfses and running into memory
> > bottlenecks since the entire compressed cpio has to be decompressed
> > into memory. I was hoping to use erofs as a replacement that could stay
> > compressed, where only the files that are actually accessed are
> > decompressed at runtime.
>
> Sorry for late reply.
>
> Okay, that makes sense, although FSDAX cannot be used as this way since
> decompressed data is needed for mmapped accesses.

Can you clarify why using a ramdisk would take double the memory if FSDAX
is not used?

> >
> >> Actually I think ramdisk FSDAX is useful and I might sync up this on
> >> the following LSF/MM/BPF 2023.
> >>
> >>> However, by using a ramdisk instead of the usual compressed cpio, I
> >>> would lose the feature where the kernel merges multiple individual
> >>> cpios together into a single tmpfs filesystem. Looking at the
> >>> documentation for erofs, I noticed that erofs already seems to support
> >>> merging multiple erofs filesystems on separate block devices using the
> >>> device= cmdline option. Would it be possible to extend this so that
> >> Here `device=` is actually used to refer to seperate blobs with the
> >> merged metadata.  For example, you could have
> >>
> >>     device=/dev/ram1 original tar1
> >>     device=/dev/ram2 original tar2
> >>     /dev/ram0        merged metadata for tar1 + tar2.
> >>
> >> which means, if you'd like to merge multiple EROFS filesystems, you
> >> might need another step to build a merged metadata in advance in order
> >> to merges multiple individual tarballs together, which could be built
> >> when applying images or booting (by using a special bootloader with
> >> such functionality.)
> >
> > Ahh, I misunderstood the device= option then.
> >
> >> EROFS doesn't support stacking multiple fses runtimely since it seems
> >> a duplicated feature of overlayfs (you could consider using overlayfs
> >> honestly.)
> >
> > I would love to use overlayfs, but there's no way to specify to the kernel that
> > the initrd should be set up as an overlayfs of a set of ram disks. It would be
> > interesting if I could put multiple filesystems in the initrd and the
> > kernel would
> > notice and automatically set up an overlayfs of them.
>
> I didn't use overlayfs as this way so I'm not sure as well.  Yet as a wild
> guess, you could specify a ramdisk with a customized init to stack
> overlayfs like this in the userspace?  Not sure though...

This approach generally works, but if you want to enforce all mounted
filesystems to be dm-verity protected, you now need to add verity data
for all these filesystems to the initramfs. That's why we're looking
for a solution where the kernel sets up the filesystem mount of the
ramdisk which is special cased and doesn't require verity data to be
present. Anyway, the overlayfs issue is not something for erofs to
solve. If at all desirable, it should probably be filesystem
independent where the kernel just looks for multiple filesystems in
the initrd buffer and sets up an overlay mount using each found
filesystem.

Cheers,

Daan De Meyer


On Fri, 5 May 2023 at 07:05, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/5/2 18:03, Daan De Meyer wrote:
> >> On 2023/5/1 22:09, Daan De Meyer wrote:
> >>> Hi,
> >>>
> >>> I've been looking into erofs as an initramfs replacement by using
> >>> root=/dev/ram0 to tell the kernel to load the initramfs as a ramdisk.
> >>
> >> Sorry, I'm on vacation now.
> >>
> >> May I ask what's your detailed use cases?  Sure, you could use
> >> /dev/ram0 as a replacement, but currently it still takes double
> >> memory compared with initramfs since ramdisk doesn't support FSDAX
> >> for now (by enabling FSDAX, it won't take double memory at all.)
> >
> > I'm experimenting with larger initramfses and running into memory
> > bottlenecks since the entire compressed cpio has to be decompressed
> > into memory. I was hoping to use erofs as a replacement that could stay
> > compressed, where only the files that are actually accessed are
> > decompressed at runtime.
>
> Sorry for late reply.
>
> Okay, that makes sense, although FSDAX cannot be used as this way since
> decompressed data is needed for mmapped accesses.
>
> >
> >> Actually I think ramdisk FSDAX is useful and I might sync up this on
> >> the following LSF/MM/BPF 2023.
> >>
> >>> However, by using a ramdisk instead of the usual compressed cpio, I
> >>> would lose the feature where the kernel merges multiple individual
> >>> cpios together into a single tmpfs filesystem. Looking at the
> >>> documentation for erofs, I noticed that erofs already seems to support
> >>> merging multiple erofs filesystems on separate block devices using the
> >>> device= cmdline option. Would it be possible to extend this so that
> >> Here `device=` is actually used to refer to seperate blobs with the
> >> merged metadata.  For example, you could have
> >>
> >>     device=/dev/ram1 original tar1
> >>     device=/dev/ram2 original tar2
> >>     /dev/ram0        merged metadata for tar1 + tar2.
> >>
> >> which means, if you'd like to merge multiple EROFS filesystems, you
> >> might need another step to build a merged metadata in advance in order
> >> to merges multiple individual tarballs together, which could be built
> >> when applying images or booting (by using a special bootloader with
> >> such functionality.)
> >
> > Ahh, I misunderstood the device= option then.
> >
> >> EROFS doesn't support stacking multiple fses runtimely since it seems
> >> a duplicated feature of overlayfs (you could consider using overlayfs
> >> honestly.)
> >
> > I would love to use overlayfs, but there's no way to specify to the kernel that
> > the initrd should be set up as an overlayfs of a set of ram disks. It would be
> > interesting if I could put multiple filesystems in the initrd and the
> > kernel would
> > notice and automatically set up an overlayfs of them.
>
> I didn't use overlayfs as this way so I'm not sure as well.  Yet as a wild
> guess, you could specify a ramdisk with a customized init to stack
> overlayfs like this in the userspace?  Not sure though...
>
> Thanks,
> Gao Xiang
