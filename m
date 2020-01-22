Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C01144AA2
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2020 04:58:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482WpT6HqrzDqQZ
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2020 14:58:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::235;
 helo=mail-lj1-x235.google.com; envelope-from=saumya.iisc@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kCGlK9ex; dkim-atps=neutral
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482WpN0RTfzDqQD
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2020 14:58:01 +1100 (AEDT)
Received: by mail-lj1-x235.google.com with SMTP id m26so5132406ljc.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2020 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dyhDSSSW14MiAu4fZim9QCY7gS3qDefw0xYHH/nUSrg=;
 b=kCGlK9exH4JHJzUuGZ/PTXc9hUoduusen+8FS0k5bhPX5pVe71S5WgGKF+4AtsTWJj
 6vNeAcYH2ATkNJ6WZ3o6w030OJvh9GSXkkKVkZssQ/+YOxx7VELDsWhdFbPrIb0dph+E
 znIAnpSQNjSkn/+tpf0xM4sHSNP9EOHgot/1mbHtbgDIOVM4v1yt9yMvlrIEg4qceK4D
 N1baKz00t5uadQFFoiV7EzQFVfJqCuz8cRiWjKqXQ1LjEPnDFHa9lqy5p1MVpnHPZpbp
 fDARluVrpSdZimBuvk+RFy1PNMQS4ZwA9tjn0/RAyZqTuSx9r4+6z/YLH6W67njllSLb
 zOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dyhDSSSW14MiAu4fZim9QCY7gS3qDefw0xYHH/nUSrg=;
 b=e3otjgDHi77/ACxDy8LWxtvZNX+w7Hv+YgF7PLGHbf+pgaUdl9qqDq332BCu58eV3x
 7Y9eNEhT06HOdOOU+MVfhQSQ876RPpSofCDUwhyDCvTNDWjxxOH54uceCL4H5pwiqsPm
 gepm05n8ROhy/H1O1a3TNf/zSc+hRgJbyLWbLDA8Wm7JXDFxz2psuuZhed+MW54nWKBv
 LWdH5ZBwcYBknzdK39eWNuN4wKk9KvCMr7TO5AKAeqTcAM6igs8StFx7nR8e8ez4/5+u
 feUtBZhBapPwqlF65ColPshuz2ZPUuX+g4jfVV6J8VmuRodU54J1KSgiW58Zs1wOcrh4
 d6Cg==
X-Gm-Message-State: APjAAAVXjOHwxxehbCSZzkSZlHKl2ls7wrdNe7ggOOkFJXPEvhhMqZ0R
 5cOoCLy9G/dywD2TNWbeAfR3cWuOyxfTml6JHIM=
X-Google-Smtp-Source: APXvYqxh6L1hdWhFxu2ceoNwzfLrtoHdo3RY4xJ/9z+zvy1n50xOQ/RwZvIf2kucxOiXJgEthlAMVV+Dn9UvKCYDoVA=
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr18137006ljc.43.1579665477091; 
 Tue, 21 Jan 2020 19:57:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Saumya Panda <saumya.iisc@gmail.com>
Date: Wed, 22 Jan 2020 09:27:45 +0530
Message-ID: <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000a0466a059cb28771"
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

--000000000000a0466a059cb28771
Content-Type: text/plain; charset="UTF-8"

Hi Gao,
  Thanks for the info. After I enabled the said configuration, I am now
able to read the files after mount. But I am seeing Squashfs has better
compression ratio compared to Erofs (more than 60% than that of Erofs). Am
I missing something? I used lz4hc while making the Erofs image.

ls -l enwik*
-rw-r--r-- 1 saumya users  61280256 Jan 21 03:22 enwik8.erofs.img
-rw-r--r-- 1 saumya users  37355520 Jan 21 03:34 enwik8.sqsh
-rw-r--r-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img
-rw-r--r-- 1 saumya users 331481088 Jan 21 03:35 enwik9.sqsh

On Mon, Jan 20, 2020 at 1:11 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Saumya,
>
> On Mon, Jan 20, 2020 at 12:25:15PM +0530, Saumya Panda wrote:
> > Hi Experts,
> >    I am testing EROFS in openSuse(Kernel: 5.4.7-1-default). I used the
> > enwik8 and enwik9 as source file (
> > https://cs.fit.edu/~mmahoney/compression/textdata.html) for compression.
> > But after I mount the erofs image, I am not able to read it (it is saying
> > operation not permitted). Simple "ls" command is not working. But if I
> > create EROFS image without compression flag, then after mount I am able
> to
> > read the files. Seems there is some problem during compression.
> >
> > I will appreciate if someone can help me out why this is happening.
>
> Could you please check if your opensuse kernel has been enabled
> the following configuration?
>
> CONFIG_EROFS_FS_ZIP=y
> CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
>
> By default, they should be enabled, but it seems not according to
> the following information you mentioned.
>
> Thanks,
> Gao Xiang
>
> >
> > Steps followed:
> > *Erofs image creation & mount: *
> > mkfs.erofs -zlz4hc enwik8.erofs.img enwik8/
> > mkfs.erofs 1.0
> >         c_version:           [     1.0]
> >         c_dbg_lvl:           [       0]
> >         c_dry_run:           [       0]
> > mount enwik8.erofs.img /mnt/enwik8/ -t erofs -o loop
> >
> > ls -l /mnt/enwik8/
> > ls: cannot access '/mnt/enwik8/enwik8': Operation not supported
> > total 0
> > -????????? ? ? ? ?            ? enwik8
> >
> > The problem seen for both lz4 & lz4hc.
> >
> > *Erofs image creation & mount without compression: *
> > mkfs.erofs  enwik8_nocomp.erofs.img enwik8/
> > mkfs.erofs 1.0
> >         c_version:           [     1.0]
> >         c_dbg_lvl:           [       0]
> >         c_dry_run:           [       0]
> >
> > mount enwik8_nocomp.erofs.img /mnt/enwik8_nocomp/ -t erofs -o loop
> >
> > ls -l /mnt/enwik8_nocomp/
> > total 97660
> > -rw-r--r-- 1 root root 100000000 Jan 20 01:27 enwik8
> >
> > *Original enwik8 file:*
> > ls -l enwik8
> > total 97660
> > -rw-r--r-- 1 root root 100000000 Jan 20 01:14 enwik8
> >
> > *Source code used for Lz4 and Erofs utils:*
> > https://github.com/hsiangkao/erofs-utils
> > https://github.com/lz4/lz4
> >
> > --
> > Thanks,
> > Saumya Prakash Panda
>


-- 
Thanks,
Saumya Prakash Panda

--000000000000a0466a059cb28771
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div>=C2=A0 Thanks for the info. After I=
 enabled the said configuration, I am now able to read the files after moun=
t. But I am seeing Squashfs has better compression ratio compared to Erofs =
(more than 60% than that of Erofs). Am I missing something? I used lz4hc wh=
ile making the Erofs image. <br></div><div><br></div><div>ls -l enwik*<br>-=
rw-r--r-- 1 saumya users =C2=A061280256 Jan 21 03:22 enwik8.erofs.img<br>-r=
w-r--r-- 1 saumya users =C2=A037355520 Jan 21 03:34 enwik8.sqsh<br>-rw-r--r=
-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img<br>-rw-r--r-- 1 s=
aumya users 331481088 Jan 21 03:35 enwik9.sqsh<br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 20, 202=
0 at 1:11 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangkao@a=
ol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Saumya,<br>
<br>
On Mon, Jan 20, 2020 at 12:25:15PM +0530, Saumya Panda wrote:<br>
&gt; Hi Experts,<br>
&gt;=C2=A0 =C2=A0 I am testing EROFS in openSuse(Kernel: 5.4.7-1-default). =
I used the<br>
&gt; enwik8 and enwik9 as source file (<br>
&gt; <a href=3D"https://cs.fit.edu/~mmahoney/compression/textdata.html" rel=
=3D"noreferrer" target=3D"_blank">https://cs.fit.edu/~mmahoney/compression/=
textdata.html</a>) for compression.<br>
&gt; But after I mount the erofs image, I am not able to read it (it is say=
ing<br>
&gt; operation not permitted). Simple &quot;ls&quot; command is not working=
. But if I<br>
&gt; create EROFS image without compression flag, then after mount I am abl=
e to<br>
&gt; read the files. Seems there is some problem during compression.<br>
&gt; <br>
&gt; I will appreciate if someone can help me out why this is happening.<br=
>
<br>
Could you please check if your opensuse kernel has been enabled<br>
the following configuration?<br>
<br>
CONFIG_EROFS_FS_ZIP=3Dy<br>
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=3D1<br>
<br>
By default, they should be enabled, but it seems not according to<br>
the following information you mentioned.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Steps followed:<br>
&gt; *Erofs image creation &amp; mount: *<br>
&gt; mkfs.erofs -zlz4hc enwik8.erofs.img enwik8/<br>
&gt; mkfs.erofs 1.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_version:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A01.0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_dbg_lvl:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A0 =C2=A00]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_dry_run:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A0 =C2=A00]<br>
&gt; mount enwik8.erofs.img /mnt/enwik8/ -t erofs -o loop<br>
&gt; <br>
&gt; ls -l /mnt/enwik8/<br>
&gt; ls: cannot access &#39;/mnt/enwik8/enwik8&#39;: Operation not supporte=
d<br>
&gt; total 0<br>
&gt; -????????? ? ? ? ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? enwik8<b=
r>
&gt; <br>
&gt; The problem seen for both lz4 &amp; lz4hc.<br>
&gt; <br>
&gt; *Erofs image creation &amp; mount without compression: *<br>
&gt; mkfs.erofs=C2=A0 enwik8_nocomp.erofs.img enwik8/<br>
&gt; mkfs.erofs 1.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_version:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A01.0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_dbg_lvl:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A0 =C2=A00]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_dry_run:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[=C2=A0 =C2=A0 =C2=A0 =C2=A00]<br>
&gt; <br>
&gt; mount enwik8_nocomp.erofs.img /mnt/enwik8_nocomp/ -t erofs -o loop<br>
&gt; <br>
&gt; ls -l /mnt/enwik8_nocomp/<br>
&gt; total 97660<br>
&gt; -rw-r--r-- 1 root root 100000000 Jan 20 01:27 enwik8<br>
&gt; <br>
&gt; *Original enwik8 file:*<br>
&gt; ls -l enwik8<br>
&gt; total 97660<br>
&gt; -rw-r--r-- 1 root root 100000000 Jan 20 01:14 enwik8<br>
&gt; <br>
&gt; *Source code used for Lz4 and Erofs utils:*<br>
&gt; <a href=3D"https://github.com/hsiangkao/erofs-utils" rel=3D"noreferrer=
" target=3D"_blank">https://github.com/hsiangkao/erofs-utils</a><br>
&gt; <a href=3D"https://github.com/lz4/lz4" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/lz4/lz4</a><br>
&gt; <br>
&gt; -- <br>
&gt; Thanks,<br>
&gt; Saumya Prakash Panda<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Thanks,<br>Saumya Prakash Panda<br><br></div>

--000000000000a0466a059cb28771--
