Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44620452927
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 05:33:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtY8j0qmvz2xrl
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 15:33:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Whv+SsCn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533;
 helo=mail-ed1-x533.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Whv+SsCn; dkim-atps=neutral
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtY8c49lGz2x9g
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 15:33:18 +1100 (AEDT)
Received: by mail-ed1-x533.google.com with SMTP id y13so6873550edd.13
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Nov 2021 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=eogqnbbtnw22ZqKV/+XmlN7VQ5C6QuDc+x/mEazbO1U=;
 b=Whv+SsCn/buDLvxT3MvzXCUi5e/qqlXIy3Fa1oEb3qBBBHLxxb1M+zNV/CZsQb/khd
 OmVXqniKRXSEY2n3E3QAnbkG4J4ehZ6K+bvcMgtOmYVCn2UZLcq0VtP4evA6PAL4kYUT
 8cKohiO2wcwSPAAmwP85Ty98ApgvGgpj02/xWW5BXUsFOehIgAYqLLqsIcAbgEcLo61S
 sM5bBmhD+vDESHZHpcxD76Efy319Cg3oQV7PSUTxdwvhsH0b1PNiAQH+uUF6dVOyUwZ8
 6FSdSGLjL+SQ3OFViiS3gAj7nBn9TJUJrieMi4KmSuci5AlApp3uVbFn8HLIkd6PimFG
 d/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=eogqnbbtnw22ZqKV/+XmlN7VQ5C6QuDc+x/mEazbO1U=;
 b=l1f4/nzFtmLyGuJQyvySdOjVlm4lIkZ/IVOCr5ubbXLfHHqo2fw+Lry5+dKOR+o12w
 oWqkRfTymBYlgnFzFBPDJH4ePAUWMztsyy7Ahfm9S62Bs8nPUqru17GTSRGrWLsdTefG
 4cZE6agHpiTVJqCmLdhKAZUuEq36yDFow/a3j2SfAyhO4TrGcKwxlDTLcmzwot+avhO0
 eaIfo5LIiLQdWUDfFIleioqgPyKfHwK45XidKaGh+822Z7DU3lyiGckRkisVdV6ItMdK
 kO6JHiPzrgQoYS4ZJsCl8BZ1lQvzoYc8CDFAjJc2mtYcsQutmQm0kmE/2IFAQrWmRenc
 Cy+A==
X-Gm-Message-State: AOAM533BuBRqaRDoncicbDZVnQVWHkV928hFvMW+MbBe/FUHkKSBrEze
 Lhc8cUShO6E1Sq4k0I9R+P8ukeQmf/FAzYrFLcM=
X-Google-Smtp-Source: ABdhPJxzFV0hNb33c6LMd8psSN/R5ea/gEwZmbrEpqVh5PPLhDNPX0LP/bgetJk/LwB38hTE312xPkwEzTQOEUz2y6E=
X-Received: by 2002:a17:906:2788:: with SMTP id
 j8mr5671675ejc.203.1637037189809; 
 Mon, 15 Nov 2021 20:33:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:6a04:0:0:0:0 with HTTP; Mon, 15 Nov 2021 20:33:09
 -0800 (PST)
In-Reply-To: <YZMqUNy1f4ji9ZbI@B-P7TQMD6M-0146.local>
References: <20211112160935.19394-1-jnhuang95@gmail.com>
 <YZMqUNy1f4ji9ZbI@B-P7TQMD6M-0146.local>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Tue, 16 Nov 2021 12:33:09 +0800
Message-ID: <CAJfKizqxkt4BYa26cmOgCD9OFOck_J0NZ8hxCQbVoyv0j4SMJg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] erofs: rename lz4_0pading to zero_padding
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000002ec9a605d0e06c63"
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
Cc: "yh@oppo.com" <yh@oppo.com>, "guanyuwei@oppo.com" <guanyuwei@oppo.com>,
 "guoweichao@oppo.com" <guoweichao@oppo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "zhangshiming@oppo.co" <zhangshiming@oppo.co>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000002ec9a605d0e06c63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2021=E5=B9=B411=E6=9C=8816=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C=EF=
=BC=8CGao Xiang <hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A

> Hi Jianan,
>
> On Sat, Nov 13, 2021 at 12:09:33AM +0800, Huang Jianan wrote:
> > From: Huang Jianan <huangjianan@oppo.com>
> >
> > Renaming lz4_0padding to zero_padding globally since LZMA and later
> > algorithms also need that.
> >
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>
> I'm fine with renaming the original on-disk feature from lz4_0padding
> to zero_padding... but could we leave `support_0padding' as-is?
>
> My own concern is
>  1) it seems 'support_zero_padding' is not much better than
>     'support_0padding' but it causes somewhat longer lines...
>
>  2) it causes somewhat backporting overhead but with no real
>     benefits...
>
> Otherwise it looks good to me. If you agree on this, I could
> update this patch manually at the time when I apply this (maybe
> about this weekend).
>
> Hi Xiang,

I modified this because considering that it starts with a number, there may
be problems with future expansion.

This may be overly worrying because we won=E2=80=99t use it as a  prefix of
variable name. So be free to use 'support_0padding'.

Thanks,
Jianan


> Thanks,
> Gao Xiang
>
>

--0000000000002ec9a605d0e06c63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2021=E5=B9=B411=E6=9C=8816=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C=EF=
=BC=8CGao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangka=
o@linux.alibaba.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Hi Jianan,<br>
<br>
On Sat, Nov 13, 2021 at 12:09:33AM +0800, Huang Jianan wrote:<br>
&gt; From: Huang Jianan &lt;<a href=3D"mailto:huangjianan@oppo.com">huangji=
anan@oppo.com</a>&gt;<br>
&gt; <br>
&gt; Renaming lz4_0padding to zero_padding globally since LZMA and later<br=
>
&gt; algorithms also need that.<br>
&gt; <br>
&gt; Signed-off-by: Huang Jianan &lt;<a href=3D"mailto:huangjianan@oppo.com=
">huangjianan@oppo.com</a>&gt;<br>
<br>
I&#39;m fine with renaming the original on-disk feature from lz4_0padding<b=
r>
to zero_padding... but could we leave `support_0padding&#39; as-is?<br>
<br>
My own concern is<br>
=C2=A01) it seems &#39;support_zero_padding&#39; is not much better than<br=
>
=C2=A0 =C2=A0 &#39;support_0padding&#39; but it causes somewhat longer line=
s...<br>
<br>
=C2=A02) it causes somewhat backporting overhead but with no real<br>
=C2=A0 =C2=A0 benefits...<br>
<br>
Otherwise it looks good to me. If you agree on this, I could<br>
update this patch manually at the time when I apply this (maybe<br>
about this weekend).<br>
<br></blockquote><div>Hi Xiang,</div><div><br></div><div>I modified this be=
cause considering that it starts with a number, there may be problems with =
future expansion.<br></div><div><br></div><div>This may be overly worrying =
because we won=E2=80=99t use it as a=C2=A0 prefix of variable name.  So be =
free to use &#39;support_0padding&#39;.</div><div><br></div><div>Thanks,</d=
iv><div>Jianan</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Gao Xiang<br>
<br>
</blockquote>

--0000000000002ec9a605d0e06c63--
