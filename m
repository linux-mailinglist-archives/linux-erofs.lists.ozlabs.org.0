Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC34A2C2C
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 07:48:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm4fK5ss8z30QX
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 17:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=k0OctlTZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d2f;
 helo=mail-io1-xd2f.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=k0OctlTZ; dkim-atps=neutral
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm4fC0c14z2xrj
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 17:48:17 +1100 (AEDT)
Received: by mail-io1-xd2f.google.com with SMTP id y84so10502747iof.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 22:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ARAoUYQ2GdIZXCApybOGuK6R8vjTLULFpogwzncldVc=;
 b=k0OctlTZ2vqz9PAwqrQBYqRFwF9COJIsk0GR1vMQjmTM9/7wztDIoqtshtNI1m1w6T
 vQT0M2kaWEy+zs0Zx2MzouHtpcSpwyXeSvIGqzT589ZXOjkgltTVUbfuE9U7K0JXKIet
 k61ExadCjoHm2HrDpFXCB9fYtR5ZHpx5aclO69AOp3kyfzZF0fLVHr+XDwOGhZIX0mam
 UN//LZn9qpHL9RG87kCj3GW+Jky+7q4L6KCrVRfXh9IUYAL4PZX32XF2mo1hr/4q1M18
 /viVhJLb8bCWiVAfo3kkD3kLuH5uZ97Aph0ISOmh7JqpkBtZttKdvYuL5R87uP4zlU+G
 pM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ARAoUYQ2GdIZXCApybOGuK6R8vjTLULFpogwzncldVc=;
 b=UU25VMdqs9GsYvrE7dM/n2oHelavHjZS/vluqPkU3tCQoWM9hltmp7OZYBbj/SwlQi
 F2WDgYJzptCGwkk9X5rc3GnSrOmXgGUseW0FwariCt6wBkp1Pr8m+0UqxXeW6pRvp0uO
 dqwka3lbz5p72NNdOAJUINhZs7j/qZQC56iqPFXmPDNRuwJ4Oqr2OBGDHb9DD626YOHI
 tjOPsc0pW7AXHUpEc5XEQSStEFgWfbWCn+GmYVgXDNe0MLdyyMeRUZvroxgBzdXnjZL+
 pHKGqU/fSrd4xd9PkDiNX158MQ2JISSdnPn9b3MxW+SxP/8LKaHdX1EW27i6BEFZ4HYe
 wqWA==
X-Gm-Message-State: AOAM532n1TTp+R92FLDtL0byukbUQhoMbBVT3lNjY/kyL07/TMDWCEzL
 M39vQkvJDH6rrspZmqvQdthoKGkvKsP1LRj5HmXMytMEI24=
X-Google-Smtp-Source: ABdhPJwMHzvuq4ffhrbFlsDt6O4NuqbELELb8w8ojMvhw6NjhUYL7nieyMux85FH2gh9lyLDUGU9RycmYSKOB8Tdnjk=
X-Received: by 2002:a05:6602:1345:: with SMTP id
 i5mr7102679iov.143.1643438893850; 
 Fri, 28 Jan 2022 22:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20220128132218.26-1-igoreisberg@gmail.com>
 <CABjEcnGhBLMd1wKC_hjQa8FuO6mFvmC3rxFCgi3fBr0omnymSQ@mail.gmail.com>
 <YfTXDoeqz0dNafhf@B-P7TQMD6M-0146> <YfTa/rxeiwycbAKp@B-P7TQMD6M-0146>
In-Reply-To: <YfTa/rxeiwycbAKp@B-P7TQMD6M-0146>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Sat, 29 Jan 2022 08:48:01 +0200
Message-ID: <CABjEcnEN8Uv-VtAV7Rmu=UEaM72ieE-YzEAygFcBKRQ9LX-SvQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000007a61e005d6b2ef0e"
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

--0000000000007a61e005d6b2ef0e
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Jan 2022, 08:13 Gao Xiang, <hsiangkao@linux.alibaba.com> wrote:

> On Sat, Jan 29, 2022 at 01:56:30PM +0800, Gao Xiang wrote:
> > On Sat, Jan 29, 2022 at 07:47:31AM +0200, Igor Eisberg wrote:
> > > Point regarding conclusive messages taken, will revert the relevant
> lines.
> >
> > Thank.
> >
> > > As for the time variable, all I did was to match it to the format as
> in the
> > > case of HAVE_UTIMENSAT, just above it.
> > > Although the variable isn't used further, inlining it is unreadable.
> > >
> >
> > Please don't. Otherwise, complier will complain
> > "mixed declarations and code"
>

Why would it? Declaration of const struct timespec times is inside
#ifdef...#else, while the declaration for const struct utimebuf time is
inside #else...#endif.
The compiler won't complain because after the preprocessor is done, the
compiler only gets one of them, never both. There is no "mixed declarations
and code" thanks to the preprocessor...

>
> > and I don't want to initialize such structures at the beginning of any
> > block.
>

What exactly is "such structures"? I pointed you to an example where you
did just that with struct z_erofs_decompress_req rq variable, I'm just
following your code style, and this one stood out as unusual for your code
style. Please count how many anonymous struct initializations you have
across the whole erofs-utils project. I count only this one, and another in
lib/data.c. Everything else is initialized as named variables.


> Add some word.


I didn't understand that...

Actually, I'd like to add:
> if (!fsckcfg.extract_path)
>         return;
>
> at the beginning of erofsfsck_set_attributes() instead of
> using "if (!ret && fsckcfg.extract_path)" in the caller.
>

OK, but then we will have mixed declarations and code, because then we
won't be at the beginning of the block...


> So the HAVE_UTIMENSAT case needs to be resolved as well.
>
> Btw, I have no idea why it could become unreadable to you, first,
> it would avoid "mixed declarations and code" unless defining them at the
> beginning of blocks,


Again, there is nothing mixed here, because preprocessor.

and I don't like memset(.., 0, ) and set
> independently since memset generally is a library function (unless
> compliers do some built-in tricks) rather than a language feature.
>

Forgive me but I don't remember seeing any mention of memset in the whole
fsck.c file, so I have no idea why you're telling me this.


> Thanks,
> Gao Xiang


> >
> > Thanks,
> > Gao Xiang
>

--0000000000007a61e005d6b2ef0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Sat, 29 Jan 2022, 08:13 Gao Xiang, &lt;<a href=3D"mailt=
o:hsiangkao@linux.alibaba.com" target=3D"_blank" rel=3D"noreferrer">hsiangk=
ao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Sat, Jan 29, 2022 at 01:56:30PM +0800, Gao Xiang wrote:<br>
&gt; On Sat, Jan 29, 2022 at 07:47:31AM +0200, Igor Eisberg wrote:<br>
&gt; &gt; Point regarding conclusive messages taken, will revert the releva=
nt lines.<br>
&gt; <br>
&gt; Thank.<br>
&gt; <br>
&gt; &gt; As for the time variable, all I did was to match it to the format=
 as in the<br>
&gt; &gt; case of HAVE_UTIMENSAT, just above it.<br>
&gt; &gt; Although the variable isn&#39;t used further, inlining it is unre=
adable.<br>
&gt; &gt; <br>
&gt; <br>
&gt; Please don&#39;t. Otherwise, complier will complain<br>
&gt; &quot;mixed declarations and code&quot;<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Why would it? Declaration of co=
nst struct timespec times is inside #ifdef...#else, while the declaration f=
or const struct utimebuf time is inside #else...#endif.</div><div dir=3D"au=
to">The compiler won&#39;t complain because after the preprocessor is done,=
 the compiler only gets one of them, never both. There is no &quot;mixed de=
clarations and code&quot; thanks to the preprocessor...</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
&gt; <br>
&gt; and I don&#39;t want to initialize such structures at the beginning of=
 any<br>
&gt; block.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">What exactly is &quot;such structures&quot;? I pointed you to an=
 example where you did just that with struct z_erofs_decompress_req rq vari=
able, I&#39;m just following your code style, and this one stood out as unu=
sual for your code style. Please count how many anonymous struct initializa=
tions you have across the whole erofs-utils project. I count only this one,=
 and another in lib/data.c. Everything else is initialized as named variabl=
es.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
Add some word.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I didn&#39;t understand that...</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Actually, I&#39;d like to add:<br>
if (!fsckcfg.extract_path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
at the beginning of erofsfsck_set_attributes() instead of<br>
using &quot;if (!ret &amp;&amp; fsckcfg.extract_path)&quot; in the caller.<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">O=
K, but then we will have mixed declarations and code, because then we won&#=
39;t be at the beginning of the block...</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
So the HAVE_UTIMENSAT case needs to be resolved as well.<br>
<br>
Btw, I have no idea why it could become unreadable to you, first,<br>
it would avoid &quot;mixed declarations and code&quot; unless defining them=
 at the<br>
beginning of blocks,</blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Again, there is nothing mixed here, because preprocessor.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">and I don&#39;t like memset(.., 0, ) and s=
et<br>
independently since memset generally is a library function (unless<br>
compliers do some built-in tricks) rather than a language feature.<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Forgive m=
e but I don&#39;t remember seeing any mention of memset in the whole fsck.c=
 file, so I have no idea why you&#39;re telling me this.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
Thanks,<br>
Gao Xiang</blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
</blockquote></div></div></div>

--0000000000007a61e005d6b2ef0e--
