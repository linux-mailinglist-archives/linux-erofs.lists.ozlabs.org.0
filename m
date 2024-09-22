Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A897E06F
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2024 09:24:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBHh40rV1z2yTy
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2024 17:24:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726989887;
	cv=none; b=WPzB7kR98v30yQUQgAyN4xp77JTaCuv7DsJ4GtuGazmahKCAtXDCBLiZbwg4h2+dm0RN6oB794POFoerXmzwQvLQHqrNUO/0DigVnbO7XUDddLLQ36B+rRu0DpRiZaQ0Mou9axSmPs1Pql3X6UGHEL0D/dNgR0JCp8vm20ImDDkuEdvr5FdDJXbQ2/Mb7BslyGSy8qbrgO+bf4nlkqfsmk7AUtm45hO64aHVW1pn7qWM0G9qIJadM4BS3dyRhKQpQ6fVEWSMQb6Egf1MhuIv1V4AlPmETIfCZKqoW5jcNLJusfmeue3Vr0Gm2saL4YObGhfOV3ZrgEs3W88Zy/xAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726989887; c=relaxed/relaxed;
	bh=9VaWuJVbKYEm0A/vC6T40wZ3zCbvZJas9ORWvhnhkfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFtilZrXCyvNtin2iY461NCciKwfq5XCWa5qNmYjW22TivT9I/T2fciEbrLYfW/PSC2B2NM64L0WpAc7ev2DWiZ3p+cEGKpFR7+YOA4F8wJqFqmsV2+xdskCr656tI+HKXvcfZvPoxnerwxVhdH2HXEjZXg//BUekRHfBJrXTH2sOWs5YVoAndc+S7fDWyXaZugqdFa0B9G87ou/Eyi1BhsUXCAdE4Z9Or63ie9M5vxY8PwQDtZysBVM9F7svkv7BlX8UFVA1U+BDssMbRBmJtHKXv6imbLU3CVjbYkDZO0LqvemJ8fJAz7DtusNt7uS7Fgp1HCMvid+PG9gEFT0Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com; dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=d2m+VrM4; dkim-atps=neutral; spf=pass (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=fred.lotter@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=d2m+VrM4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=fred.lotter@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBHgx4DP9z2xpv
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 17:24:43 +1000 (AEST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DE243F5AA
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726989876;
	bh=9VaWuJVbKYEm0A/vC6T40wZ3zCbvZJas9ORWvhnhkfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=d2m+VrM4sJscYOjLNqzrVsLCZlhTtNMl9fCuGGcAVegNYyS89xzyYknwmefyJ3wvr
	 wqgQJixiDnkLyA+9MyVcyORWsssa274q4qf6gYfd/DpJMzcrYWwJxKiuqNsk0EHblX
	 KRKzVgPVKI1E5OE3jqRiYD6VcUA5rTlcfB+7gehMFGQ3yymRAPzgiJH/e8bFVP2Bf9
	 tZ5F+9H738Iq9kB5gjVg7XSVlfFxm0/rWFbTKaxGXRa+m8kwrPwVrOqRHhhvqMMikE
	 2QQdnbLIrC4FSdLfZCrVflnfRY0UWeppp3rhygMzhWATLyvVdDvCzAmc3wQaOvbewR
	 Rj71AiUJUpGMg==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c353d32ea0so53161796d6.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 00:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726989875; x=1727594675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VaWuJVbKYEm0A/vC6T40wZ3zCbvZJas9ORWvhnhkfM=;
        b=VntYatZLmhsOhAXIn/VIEEIvncYtcgD5qWrl/KOccEEr6UYmWlmA3vUM05rNGN1bXR
         PiU6F1ynsDIE1d8oCNdJ9T3zXSXakEK/7gV4j2dvVYqj2Otn2yNlnZNlmc8is/qOtZuz
         qFS269vkEi2bV3ALL9qbtOslqUwfBzUOFfhH3UTjYkLuXYogah/s00/z971NbkSc/PMk
         1l7/iDhdnRIBPAU2JXYFKTr9EKix+EpzVbbUuCPio0Kh3h237Ooxno5UF04mVKAwJn4f
         FgJwGpSuxzyFdi7QVPoegDTt5bPDlKXlzBIzD/P3B00kAYzZjp2hEibnBGD4im63vv26
         A5Jw==
X-Gm-Message-State: AOJu0YzylSC537H1T5dt5viezK5HhcLE8/yIU7JsTcgKLxBdQtzQgFqC
	4r5Tgndf/y+q86soBrQHUzjAxHrGaDKlKDtMWsiFlHvJKw1P6WIBLBnU/6NotMd2bdztkWI8gtL
	LBNzFibXhwxscxnUxA5xINH8NahcPrBRJjj+m7HWSJcDUcpFJNX3PmGI7FvPx6uAiSre6iV/ctW
	BsbOaiQNHVQw5nepRFRc0BMr91tm0r7aN2u+Yeb+R6adJLI/5HS8b5Rz/HGt3RO6o=
X-Received: by 2002:a05:6214:3d0c:b0:6c5:1616:b5c5 with SMTP id 6a1803df08f44-6c7bc6a179fmr102772766d6.15.1726989875170;
        Sun, 22 Sep 2024 00:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUEu/1VxVdYbE1y8SjaEvqh7YqqGLEhAc1Mr+U7qZJwSDcczBKJCDKeHwEqsOqjARFG0O3aFca0cmLP432aP4=
X-Received: by 2002:a05:6214:3d0c:b0:6c5:1616:b5c5 with SMTP id
 6a1803df08f44-6c7bc6a179fmr102772626d6.15.1726989874761; Sun, 22 Sep 2024
 00:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+yndwhjTkF_D1QZ3UDLggAXXGen_fLr6rLvBVS8tYw3ViH+8Q@mail.gmail.com>
 <e8f84ef3-0c4e-4341-b562-d9e8c2624e4b@linux.alibaba.com>
In-Reply-To: <e8f84ef3-0c4e-4341-b562-d9e8c2624e4b@linux.alibaba.com>
From: Fred Lotter <fred.lotter@canonical.com>
Date: Sun, 22 Sep 2024 09:24:23 +0200
Message-ID: <CA+yndwgoF3S3k9FUY01kjAc6VyBxfVz6wiBs3M+RkhdXk+pzrQ@mail.gmail.com>
Subject: Re: Help with EROFS for specific test scenario
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000042f320622b02a73"
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

--000000000000042f320622b02a73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao,

On Sat, Sep 21, 2024 at 1:02=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com>
wrote:

>
> Hi Fred,
>
> On 2024/9/21 00:11, Fred Lotter wrote:
> > Hi,
> >
> > In the context of this page:
> > https://erofs.docs.kernel.org/en/latest/merging.html <
> https://erofs.docs.kernel.org/en/latest/merging.html>
> >
> > I am trying to experiment with EROFS where I want to try something craz=
y
> like the following setup:
> >
> > /dev/mmcblk0p3:
> > |
> > EROFS root image
> > |
> > --------
> > |
> > EROFS second image
> > |
> > --------
> >
> > I wanted to have a primate root EROFS filesystem written at the start o=
f
> a partition. Then I would like to "append" files to the immutable root
> EROFS filesystem, by adding a concatenated EROFS filesystem after the roo=
t
> filesystem, with an external device reference pointing to the root EROFS
> filesystem.
>
> Thanks for your question.
>

Thank you for your quick assistance. My final round of questions hopefully!


>
> >
> > My idea in my head was then to boot the Linux kernel with something lik=
e:
> >
> > root=3D/dev/mmcblk0p3 rootfstype=3Derofs
> rootoptions=3Ddevice=3D/dev/mmcblk0p3,offset=3D<root size>
> >
> > 1. Is it possible to have the "blobdevice" point to a complete EROFS
> filesystem?
>
> If there are two partitions, currently EROFS kernel runtime supports
> your requirement in practice, for example:
>
>   /dev/mmcblk0p3:
>   |
>   EROFS root image
>   |
>   -------- /dev/mmcblk0p4:
>   |
>   EROFS second image
>   |
>   --------
>
> You could boot with:
> root=3D/dev/mmcblk0p4 rootfstype=3Derofs rootoptions=3Ddevice=3D/dev/mmcb=
lk0p3
>
> to get the incremental filesystem and use:
>
> root=3D/dev/mmcblk0p3 rootfstype=3Derofs
>
> to boot the original filesystem.
>
> The two images are both usable for booting.
>

This is still an interesting case for me, even if it has to be two explicit
partitions.

In the case of the external device pointing to a complete EROFS filesystem.

Quoting from the documentation:
"There are no centralized inode and directory tables because they are not
quite friendly for image incremental
updates, metadata flexibility, and extensibility. It=E2=80=99s up to users =
whether
inodes or directories are arranged one
by one or not."

Does this mean with the current kernel implementation that the super erofs
filesystem (containing a link to the
external erofs) can point to the original erofs filesystem, and only
discover its contents at runtime? This would
allow me to mkfs.erofs a super erofs filesystem, without knowing anything
about the external device content
at creation time?


>
> The `offset` option is only supported by the loop device, and parsed by
> util-linux `mount` command, as in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/block/loop.c?h=3Dv6.11#n52
>
> So if you'd like to use the same partition, I guess it's still possible
> as long as you have a minimal initramfs to generate a special loop
> device with a specific offset, like:
>
> losetup -ooffset=3D<root size> /dev/loop0 /dev/mmcblk0p3
> mount -odevice=3D/dev/mmcblk0p3 /dev/loop0 /
>
> for example.  I'm not sure if it meets your requirement.
>
> In short, the on-disk format supports your requirement, and
> kernel runtime supports your requirement too, but just with
> two independent devices (or loop devices with `offset`).
>
> I'm not sure EROFS modules needs to support `offset`
> semantics since other filesystems don't support this too.
>
> >
> > 2. If yes, is there userspace support for creating this setup?
>
> Unfortunately, currently mkfs.erofs incremental build doesn't
> support this mode, but it can be implemented in the next
> erofs-utils 1.9 version.
>

Is this a feature you plan to add in v1.9 in any case?


>
> Thanks,
> Gao Xiang
>
> >
> > Kind Regards,
> > Fred
> >


I read some discussions on erofs verification:
https://lore.kernel.org/lkml/Y69UjZP4dNYdbXW0@sol.localdomain/T/

My impression is that dm-verity should work for EROFS filesystems today, in
the same way it works with Squashfs.

However, I guess this would not work if the erofs super block device has a
device table pointing to external block devices (erofs)?


>
> >
> >
> >
>
>

--000000000000042f320622b02a73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Gao,</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 21, 2024 at 1:02=E2=80=
=AFAM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangka=
o@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
Hi Fred,<br>
<br>
On 2024/9/21 00:11, Fred Lotter wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; In the context of this page:<br>
&gt; <a href=3D"https://erofs.docs.kernel.org/en/latest/merging.html" rel=
=3D"noreferrer" target=3D"_blank">https://erofs.docs.kernel.org/en/latest/m=
erging.html</a> &lt;<a href=3D"https://erofs.docs.kernel.org/en/latest/merg=
ing.html" rel=3D"noreferrer" target=3D"_blank">https://erofs.docs.kernel.or=
g/en/latest/merging.html</a>&gt;<br>
&gt; <br>
&gt; I am trying to experiment with EROFS where I want to try something cra=
zy like the following setup:<br>
&gt; <br>
&gt; /dev/mmcblk0p3:<br>
&gt; |<br>
&gt; EROFS root image<br>
&gt; |<br>
&gt; --------<br>
&gt; |<br>
&gt; EROFS second image<br>
&gt; |<br>
&gt; --------<br>
&gt; <br>
&gt; I wanted to have a primate root EROFS filesystem written at the start =
of a partition. Then I would like to &quot;append&quot; files to the=C2=A0i=
mmutable root EROFS filesystem, by adding a concatenated EROFS filesystem a=
fter the root filesystem, with an external device reference pointing to the=
 root EROFS filesystem.<br>
<br>
Thanks for your question.<br></blockquote><div><br></div><div>Thank you for=
 your quick assistance. My final round of questions=C2=A0hopefully!</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; My idea in my head was then to boot the Linux kernel with something li=
ke:<br>
&gt; <br>
&gt; root=3D/dev/mmcblk0p3 rootfstype=3Derofs rootoptions=3Ddevice=3D/dev/m=
mcblk0p3,offset=3D&lt;root size&gt;<br>
&gt; <br>
&gt; 1. Is it possible to have the &quot;blobdevice&quot; point to a comple=
te EROFS filesystem?<br>
<br>
If there are two partitions, currently EROFS kernel runtime supports<br>
your requirement in practice, for example:<br>
<br>
=C2=A0 /dev/mmcblk0p3:<br>
=C2=A0 |<br>
=C2=A0 EROFS root image<br>
=C2=A0 |<br>
=C2=A0 -------- /dev/mmcblk0p4:<br>
=C2=A0 |<br>
=C2=A0 EROFS second image<br>
=C2=A0 |<br>
=C2=A0 --------<br>
<br>
You could boot with:<br>
root=3D/dev/mmcblk0p4 rootfstype=3Derofs rootoptions=3Ddevice=3D/dev/mmcblk=
0p3<br>
<br>
to get the incremental filesystem and use:<br>
<br>
root=3D/dev/mmcblk0p3 rootfstype=3Derofs<br>
<br>
to boot the original filesystem.<br>
<br>
The two images are both usable for booting.<br></blockquote><div><br></div>=
<div>This is still an interesting case for me, even if it has to be two exp=
licit partitions.</div><div><br></div><div>In the case of the external devi=
ce pointing to a complete EROFS filesystem.<br><br>Quoting from the documen=
tation:<br>&quot;There are no centralized inode and directory tables becaus=
e they are not quite friendly for image incremental</div><div>updates, meta=
data flexibility, and extensibility. It=E2=80=99s up to users whether inode=
s or directories are arranged one</div><div>by one or not.&quot;<br><br>Doe=
s this mean with the current kernel implementation that the super erofs fil=
esystem (containing a link to the</div><div>external erofs) can point to th=
e original erofs filesystem, and only discover its contents at runtime? Thi=
s would</div><div>allow me to mkfs.erofs a super erofs filesystem, without =
knowing anything about the external device content</div><div>at creation ti=
me?</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
The `offset` option is only supported by the loop device, and parsed by<br>
util-linux `mount` command, as in:<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/drivers/block/loop.c?h=3Dv6.11#n52" rel=3D"noreferrer" target=3D"_b=
lank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/block/loop.c?h=3Dv6.11#n52</a><br>
<br>
So if you&#39;d like to use the same partition, I guess it&#39;s still poss=
ible<br>
as long as you have a minimal initramfs to generate a special loop<br>
device with a specific offset, like:<br>
<br>
losetup -ooffset=3D&lt;root size&gt; /dev/loop0 /dev/mmcblk0p3<br>
mount -odevice=3D/dev/mmcblk0p3 /dev/loop0 /<br>
<br>
for example.=C2=A0 I&#39;m not sure if it meets your requirement.<br>
<br>
In short, the on-disk format supports your requirement, and<br>
kernel runtime supports your requirement too, but just with<br>
two independent devices (or loop devices with `offset`).<br>
<br>
I&#39;m not sure EROFS modules needs to support `offset`<br>
semantics since other filesystems don&#39;t support this too.<br>
<br>
&gt; <br>
&gt; 2. If yes, is there userspace support for creating this setup?<br>
<br>
Unfortunately, currently mkfs.erofs incremental build doesn&#39;t<br>
support this mode, but it can be implemented in the next<br>
erofs-utils 1.9 version.<br></blockquote><div><br></div><div>Is this a feat=
ure you plan to add in v1.9 in any case?</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt; Fred<br>
&gt;</blockquote><div><br></div><div>I read some discussions on erofs verif=
ication:</div><div><a href=3D"https://lore.kernel.org/lkml/Y69UjZP4dNYdbXW0=
@sol.localdomain/T/">https://lore.kernel.org/lkml/Y69UjZP4dNYdbXW0@sol.loca=
ldomain/T/</a><br></div><div><br></div><div>My impression is that dm-verity=
 should work for EROFS filesystems today, in the same way it works with Squ=
ashfs.</div><div><br></div><div>However, I guess this would not work if the=
 erofs super block device has a device table pointing to external block dev=
ices (erofs)?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"> <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000042f320622b02a73--
