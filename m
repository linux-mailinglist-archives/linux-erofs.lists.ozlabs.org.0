Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C66194791D5
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 17:48:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFw024pTTz3cGn
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 03:48:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=W2ZyEsQd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d2b;
 helo=mail-io1-xd2b.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=W2ZyEsQd; dkim-atps=neutral
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFvzy4YXkz3bjB
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 03:47:56 +1100 (AEDT)
Received: by mail-io1-xd2b.google.com with SMTP id x6so3717137iol.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=I2SuSY0pTrRtYdR+v3L/VhQ+yHjSc1uK6+iRAzRyeFo=;
 b=W2ZyEsQdpuO8nNBWlajWJBIxsMFBRpadfqRqbSg6X6A4e4Uyov+VMMiosdyv18LoeO
 /9JyjOiCEUE41RxEvcO1HMe1as8z0cOWf1+CLmURqegnbjYjgyhYOlA/DixF5wX5OFh9
 WrMIRWu7S2BYQj9P+NCwfXsn1kfUSyaN9i2e2jUgPOpCqhEhbJ8iTU6jiy3Cj3fNZEIA
 FkE7JHvR5Ee7BuxkYR9olmeLhZVZYw7ilbSrgGuq5WJ3jEMyXDb2egYI8NxsBWsehdvj
 0J7FwajgiENvMQzm0zfQ7z6kHFeQk2kH4khx9AkEa/FeowXYeBfHK0ovOo3K7EHvT9jH
 5xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=I2SuSY0pTrRtYdR+v3L/VhQ+yHjSc1uK6+iRAzRyeFo=;
 b=yuJUAG9nLRp4NXbj9jl+OYZJ67DM4Ajd5SIBYJsyQZgNv9r1nSUfz3Yfmd1x8c+FE7
 1yEz1WPrXWUDz31ThoKSgWs9YyNouzOfULJqj+XU9laM9r4b7dWOU4Ruu1FNAqKkoNjz
 27CGk1U7UPNBurlzfHZRYCBRupSvW01VL1I6co6ixyty18mQXknfPP4+d/mG59W/XgBE
 coDUkhlEJEdxw2sSRgrtVUAoq4BlVsqFGnu44y/5UvgRr4zBsHe2fC822naA6DHDJfVy
 +u/CuPaeMI/asYP2qI2oxOjjEuxLSgFhRw3DxqH6vpLEH7nc5QOq8601gSTFCjQmm7Tm
 Y0UA==
X-Gm-Message-State: AOAM53203nkf0b81TDvEM3ZIHtMz9ntp8qZWkEHj5xxPHlOHTD84ghD3
 a8QOej6Rn+FFVU/c29zj0pPFaaPjPVBT2ElzxyOb/vDGNj8=
X-Google-Smtp-Source: ABdhPJwAVYYj2rZ/4z9ZYMWfFjql8KZ8OxMzrmxsO0AoVBUFHZRrAghbPLExqlDbYXBqEXW4z2NNDurTUkzuFPut5zg=
X-Received: by 2002:a02:c60b:: with SMTP id i11mr2519219jan.15.1639759673373; 
 Fri, 17 Dec 2021 08:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com>
 <CABjEcnEnYhCSXvbhtas4J-vgBker-U1+FqjJ=Hvz-MOp--kJrw@mail.gmail.com>
In-Reply-To: <CABjEcnEnYhCSXvbhtas4J-vgBker-U1+FqjJ=Hvz-MOp--kJrw@mail.gmail.com>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 17 Dec 2021 18:47:44 +0200
Message-ID: <CABjEcnF0iv5OaZt-tG9ExNohNG21kppMH6Se37RN4hWKkkMTNw@mail.gmail.com>
Subject: Re: erofs-utils: lib: add API to get pathname of EROFS inode
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000d934ce05d35a4cc6"
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

--000000000000d934ce05d35a4cc6
Content-Type: text/plain; charset="UTF-8"

For reference, description of how this method works:
The target inode's nid is saved in a custom context that's used for the
rest of the path search. Buffer offset (pos) is set to 0.
The function starts a recursive traversal from the root node, always
altering the offset in the buffer for the next inode in path (without
writing yet).
Recursion continues until the target nid is reached, then:
1. The inode's name is written to the buffer at the last remembered offset,
in the form of: '/' + <inode name> + NUL
2. A custom return code EROFS_PATHNAME_FOUND is returned which causes the
whole recursion to stop
3. Parent inode writes the node's name in the form: '/' + <dir inode name>,
then also returns EROFS_PATHNAME_FOUND.
This is repeated per recursion level, until the first callback has returned.
Demo of the buffer changes (? = undefined data in the buffer, $ = null byte
that marks end-of-string):

?????????????????????????????????????????????????? (initial buffer)
?????????????????????????????/firmware$??????????? (target inode found,
write and break recursion)
??????????????????????/vendor/firmware$??????????? (1st parent dir inode)
?????????????/readonly/vendor/firmware$??????????? (2nd parent dir inode)
????????/adsp/readonly/vendor/firmware$??????????? (3rd parent dir inode)
????/mdm/adsp/readonly/vendor/firmware$??????????? (4th parent dir inode)
/rfs/mdm/adsp/readonly/vendor/firmware$??????????? (last parent dir inode,
function returns)

On Fri, 17 Dec 2021 at 16:20, Igor Eisberg <igoreisberg@gmail.com> wrote:

>
>
> On Fri, 17 Dec 2021 at 14:30, Igor Eisberg <igoreisberg@gmail.com> wrote:
>
>>
>>

--000000000000d934ce05d35a4cc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r">For reference, description of how this method works:<div>The target inod=
e&#39;s nid is saved in a custom context that&#39;s used for the rest of th=
e path search. Buffer offset (pos) is set to 0.</div><div>The function star=
ts a recursive traversal from the root node, always altering the offset in =
the buffer for the next inode in path (without writing yet).</div><div>Recu=
rsion=C2=A0continues until the target nid is reached, then:</div><div>1. Th=
e inode&#39;s name is written to the buffer at the last remembered offset, =
in the form of: &#39;/&#39; + &lt;inode name&gt;=C2=A0+ NUL</div><div>2. A =
custom return code EROFS_PATHNAME_FOUND is returned which causes the whole =
recursion to stop</div><div>3. Parent=C2=A0inode writes the node&#39;s name=
 in the form: &#39;/&#39; + &lt;dir inode name&gt;, then also returns EROFS=
_PATHNAME_FOUND.</div><div>This is repeated per recursion level, until the =
first callback has returned.</div><div>Demo of the buffer changes (? =3D un=
defined data in the buffer, $ =3D null byte that marks end-of-string):</div=
><div><br></div><div><div><font face=3D"monospace">????????????????????????=
?????????????????????????? (initial buffer)</font></div><div><font face=3D"=
monospace">?????????????????????????????/firmware$??????????? (target inode=
 found, write and break recursion)</font></div><div><font face=3D"monospace=
">??????????????????????/vendor/firmware$??????????? (1st parent dir inode)=
</font></div><div><font face=3D"monospace">?????????????/readonly/vendor/fi=
rmware$???????????=C2=A0</font><span style=3D"font-family:monospace">(2nd=
=C2=A0</span><span style=3D"font-family:monospace">parent</span><span style=
=3D"font-family:monospace">=C2=A0</span><span style=3D"font-family:monospac=
e">dir inode)</span></div><div><font face=3D"monospace">????????/adsp/reado=
nly/vendor/firmware$???????????=C2=A0</font><span style=3D"font-family:mono=
space">(3rd=C2=A0</span><span style=3D"font-family:monospace">parent</span>=
<span style=3D"font-family:monospace">=C2=A0</span><span style=3D"font-fami=
ly:monospace">dir inode)</span></div><div><font face=3D"monospace">????/mdm=
/adsp/readonly/vendor/firmware$???????????=C2=A0</font><span style=3D"font-=
family:monospace">(4th parent dir inode)</span></div><div><font face=3D"mon=
ospace">/rfs/mdm/adsp/readonly/vendor/firmware$???????????=C2=A0</font><spa=
n style=3D"font-family:monospace">(last parent dir inode, function returns)=
</span></div></div></div></div></div></div></div></div></div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
17 Dec 2021 at 16:20, Igor Eisberg &lt;<a href=3D"mailto:igoreisberg@gmail.=
com">igoreisberg@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Dec 2021 at 14:30=
, Igor Eisberg &lt;<a href=3D"mailto:igoreisberg@gmail.com" target=3D"_blan=
k">igoreisberg@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><br></div>
</blockquote></div>
</blockquote></div>

--000000000000d934ce05d35a4cc6--
