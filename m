Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2D43C8BF
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 13:42:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfRd54K8mz2yNC
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 22:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nRmTXYPi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b;
 helo=mail-wm1-x32b.google.com; envelope-from=t.i.ivanov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=nRmTXYPi; dkim-atps=neutral
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfRcy0dQ9z2xvL
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 22:42:25 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id
 o4-20020a1c7504000000b0032cab7473caso2760953wmc.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1eL7UnY7qCAHccCXPtrg/Z3j6a/rOOcpZgm33kSkpMw=;
 b=nRmTXYPiJy93T3rBh00M1utsHFstoUzm62JMQ+PuKmB95mmj1DE6MXgY3drcYgnUMO
 I7Ft3YY2SX+boMJfgPTps5TVjwS9xA4YkS0ZvdSGfqtqLqQZRQQg5FIwtKhmmS8l886X
 bThvXPz81zC6cH7idiUhC1LAQ/TAguhdFpGKyD5AL32EAnzqPFXUPhItUJiBp2gnbpd6
 NxL6ppRFLzPIF+DRYikr99Fcnjuxuxglj2NfBbwrf7x0CciRgGNq0sNW3/oe7oRkst1n
 xhTT9B3lgyfUHIyBnZECf7r8t8S3KOVL/i7zg0BFJ1+WJcxj0LmF/oj6df0MEKYk/r4u
 S68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1eL7UnY7qCAHccCXPtrg/Z3j6a/rOOcpZgm33kSkpMw=;
 b=4PRG6vk5enPPv1BT8O+Hw9cSKfmwOe/8aLu3zJVsmoxLtdtvlySm/WdE2BE6BCWosw
 L4tAt1cxS5r1ar5z/iXNixGZ1YMc3Yc1GWd2kfS5Nmka+3wri0MPYVZsSRdLe6xA+pl6
 diMCD4nQ3hKA/isjprzhXk6LlavKfetU+JvUBbBSJsLOBkdA+79nSWVMPbp2Tgut+YmK
 SiJbATtsvIK+VD61OHgbOrGI+OeUHVOltdBfyTAuNdWCkeDkHBxg7w144AlvM8aSCC3B
 BizeFfdEJu4gu3C70m/44xGycMQuOzw35f7MqxbRXrDQ6aolLg+LDV4Uh/YhVnl9Vooy
 DT+w==
X-Gm-Message-State: AOAM530XAn45W+OzKSuo/S9P1stSWgDYWEeybWYQA4lju0chjfMoBq/B
 uDVse7T5MQtj2v84c6nJ2+FmhKYju3/Bvho1soeaqagW4Xw=
X-Google-Smtp-Source: ABdhPJzGtPKC15YO4tCN/X2YmX8Pdj850l4Km3Gy96D6/jdeJPzu9XVtr9aUu0JvkjD5z1GfGaHJGUaU6wEVkEBldTo=
X-Received: by 2002:a1c:1b50:: with SMTP id b77mr5106818wmb.23.1635334941174; 
 Wed, 27 Oct 2021 04:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv4OrXs9-4o0JvCdSus=WBjPqUbm+YES_QrsuXkv13dt7SKjQ@mail.gmail.com>
 <YXk3kK1+NLu2h9o1@B-P7TQMD6M-0146.local>
In-Reply-To: <YXk3kK1+NLu2h9o1@B-P7TQMD6M-0146.local>
From: Todor Ivanov <t.i.ivanov@gmail.com>
Date: Wed, 27 Oct 2021 14:41:54 +0300
Message-ID: <CAOv4OrXqGNZMT9=jPVVxUgrcdnRtJnTk3gnufA6cKeoWDkQNvQ@mail.gmail.com>
Subject: Re: Question about mkfs.erofs and reproducible builds
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="00000000000041f0ca05cf541640"
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

--00000000000041f0ca05cf541640
Content-Type: text/plain; charset="UTF-8"

    Hi, Gao,

    This is how I installed mkfs.erofs on debian10:

apt-get install pkg-config liblz4-dev gawk
wget
http://ftp.debian.org/debian/pool/main/e/erofs-utils/erofs-utils_1.3.orig.tar.gz
tar xvzpf erofs-utils_1.3.orig.tar.gz
cd erofs-utils-1.3/
./autogen.sh
./configure
make
make install

Can you tell me where do I clone it from and if build instructions are
different?

Kind regards,
Todor

On Wed, Oct 27, 2021 at 2:27 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi Todor,
>
> On Wed, Oct 27, 2021 at 02:11:24PM +0300, Todor Ivanov wrote:
> >         Hello,
> >
> >         We are trying to replace squashfs with erofs and face an issue
> with
> > reproducing the build from one and the same source folder. The source
> > folder is "/etc" actually taken from an offline ubuntu 20.04 image and
> > mounted as read-only.
> >         I managed to narrow down the scope and it turns out that the
> issue
> > is when you have a file starting with "." (dot) in this folder. I.e.:
> >
> > etc/.anyfilename
> >
> > If I remove this file the erofs image of "etc" is reproducible (-T and -U
> > are used as well)
> >
> > The issue is somehow related to the other 76 subfolders of etc and this
> > file starting with dot. For example if I create such .anyfilename in usr
> or
> > var, there is no issue. Also if I create this file under
> > etc/xdg/.anyfilename, this is fine as well.
> > I also tried with etc from debian10 and the result is the same. Removing
> > any file that starts with dot directly under etc, makes the erofs build
> > reproducible.
> > Do you have any advice on this?
>
> In principle filenames starting with '.' won't impact anything about
> reproducible builds...
>
> Let me investigate it now... But may I ask which erofs-utils version
> is used? Does it still happen on the latest dev branch?
>
> Thanks,
> Gao Xiang
>
> >
> > Regards,
> > Todor
>

--00000000000041f0ca05cf541640
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>=C2=A0=C2=A0=C2=A0 Hi, Gao,</div><di=
v><br></div><div>=C2=A0=C2=A0=C2=A0 This is how I installed mkfs.erofs on d=
ebian10:</div><div><br></div><div>apt-get install pkg-config liblz4-dev gaw=
k<br>wget <a href=3D"http://ftp.debian.org/debian/pool/main/e/erofs-utils/e=
rofs-utils_1.3.orig.tar.gz">http://ftp.debian.org/debian/pool/main/e/erofs-=
utils/erofs-utils_1.3.orig.tar.gz</a><br>tar xvzpf erofs-utils_1.3.orig.tar=
.gz <br>cd erofs-utils-1.3/<br>./autogen.sh <br>./configure <br>make<br>mak=
e install<br></div><div><br></div><div>Can you tell me where do I clone it =
from and if build instructions are different?</div><div><br></div><div>Kind=
 regards,</div><div>Todor<br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 27, 2021 at 2:27 PM Gao Xian=
g &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibab=
a.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hi Todor,<br>
<br>
On Wed, Oct 27, 2021 at 02:11:24PM +0300, Todor Ivanov wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hello,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We are trying to replace squashfs wit=
h erofs and face an issue with<br>
&gt; reproducing the build from one and the same source folder. The source<=
br>
&gt; folder is &quot;/etc&quot; actually taken from an offline ubuntu 20.04=
 image and<br>
&gt; mounted as read-only.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I managed to narrow down the scope an=
d it turns out that the issue<br>
&gt; is when you have a file starting with &quot;.&quot; (dot) in this fold=
er. I.e.:<br>
&gt; <br>
&gt; etc/.anyfilename<br>
&gt; <br>
&gt; If I remove this file the erofs image of &quot;etc&quot; is reproducib=
le (-T and -U<br>
&gt; are used as well)<br>
&gt; <br>
&gt; The issue is somehow related to the other 76 subfolders of etc and thi=
s<br>
&gt; file starting with dot. For example if I create such .anyfilename in u=
sr or<br>
&gt; var, there is no issue. Also if I create this file under<br>
&gt; etc/xdg/.anyfilename, this is fine as well.<br>
&gt; I also tried with etc from debian10 and the result is the same. Removi=
ng<br>
&gt; any file that starts with dot directly under etc, makes the erofs buil=
d<br>
&gt; reproducible.<br>
&gt; Do you have any advice on this?<br>
<br>
In principle filenames starting with &#39;.&#39; won&#39;t impact anything =
about<br>
reproducible builds...<br>
<br>
Let me investigate it now... But may I ask which erofs-utils version<br>
is used? Does it still happen on the latest dev branch?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Todor<br>
</blockquote></div></div>

--00000000000041f0ca05cf541640--
