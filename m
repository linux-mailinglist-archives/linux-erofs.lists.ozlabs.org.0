Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59821851CF
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 19:14:29 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463dQp0dxgzDqhH
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 03:14:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zf5eK0xi"; 
 dkim-atps=neutral
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463dQg32DwzDqd2
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 03:14:17 +1000 (AEST)
Received: by mail-ed1-x52c.google.com with SMTP id x19so81178261eda.12
 for <linux-erofs@lists.ozlabs.org>; Wed, 07 Aug 2019 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X/aRN+9Z9UIr/kYJ5hJ3++PDCHAAozlpM2CsyhsaZuE=;
 b=Zf5eK0xiz81UxAX7h36JvdiNSEBW7GecUyyIl9QESX7JJlJA89C0XnyH5xkDRo0CDQ
 XWENgn2Ffut+07k/A+mpsiltjtDy2IXTXlwY+9rUe4/7WuqgcpSlF3J5F6d2t7n+3+Pw
 3nrJV9VS0AuldLAI5LfBkR3PztPFuG8um9DX2VZXIFDCAmZeftnFt384hzwLdWEBlCgJ
 Ldb/hdojOhw43Q2icgA7m9uVEw5vN8ZpAYP/qyU8LLg6FXD3jIOSr8cclxI7iJy89qDp
 Zos25uoIyOr37NoZl42Bs8FR9G2a87ukeW62k7OurAeHbRRISOK6k4mZtIm1d2+7/XNb
 CyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X/aRN+9Z9UIr/kYJ5hJ3++PDCHAAozlpM2CsyhsaZuE=;
 b=S8nZMkusHn1rnrtg88fagZvXU4aWgDKtU4NyA9Flrl9I08O4F5Yq8zeb1ShQn/63Hy
 ESMIcMHjygWoUyN4lJiEFb511DJAgm03V8IbeCeMcD20oCoCBr659QAHLOOk1JduyOS3
 0QxpMf9WyA+kJ5vYTc6XFbxvwmA9fVE1cNL4M16VlzvQiJE0CgBHmJxA6wlb45TC0Big
 7xajLtaCAPlm3FfBoIJxNNkZkJVngG2XKag0NxLMdgGI9o93rAELld+Ye/wOxbErtEq6
 B4WkZo2m7zELSkyZrN+8Z9aicEUKzJl2ech+BMX+7+XGP4Zdpvr698AguRt7bY5X5NiB
 +03w==
X-Gm-Message-State: APjAAAVk9ix0OE5BSzVlGcjKiFSXKqLV/C/R09Gk0i7J02ySNn4yR1+O
 hva9qym5ByULeM4KIi8rL62C41XYxfpWLKZCqAI=
X-Google-Smtp-Source: APXvYqxEZG/Vo7zFfgs7jbBTs4cHnQBVpzP2/TYFwDJVpoJTem+dZwDMwQQjnE/2MG2AQ1uDIvjYwAqcrkBNNEbzAj4=
X-Received: by 2002:a17:906:4048:: with SMTP id
 y8mr9626160ejj.35.1565198053867; 
 Wed, 07 Aug 2019 10:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGu0czRhmT7vSnFB-9pnJS=fhZp7RFL2ZwYfbc1RK-p5ddQ6tw@mail.gmail.com>
 <20190806160524.GA26612@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190806160524.GA26612@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 7 Aug 2019 22:44:01 +0530
Message-ID: <CAGu0czTjLixYux78ORnQEhx=VnMt_N_PaBAu1zbWAKXJTfo6Lw@mail.gmail.com>
Subject: Re: Test case suite for erofs.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="00000000000001058f058f8a123b"
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

--00000000000001058f058f8a123b
Content-Type: text/plain; charset="UTF-8"

Thanks for the comprehensive answer Gao !
So we can use this channel to post Test cases that we think are needed for
erofs.

--Pratik.

On Tue, Aug 6, 2019 at 9:35 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Tue, Aug 06, 2019 at 08:18:42PM +0530, Pratik Shinde wrote:
> > Hello Maintainers,
> >
> > I wanted to ask if there is any plan for writing a test case suite for
> > erofs. If not, how do you think is the idea of having a dedicated test
> case
> > suite, so as to maintain quality of fs?
> > Let me know your thoughts.
>
> Currently we have a modified ro-fsstress for EROFS to do fuzzer tests,
> and we have dedicated constructed images to do all regression tests.
>
> Yes, I personally think that is not enough (thus we have a large beta
> users as a supplement) and we asked squashfs maintainers for their tools
> last year but without any luck.
>
> new xfstest testcases for read-only filesystems developped by another
> HUAWEI
> team is also available at
> https://www.spinics.net/lists/fstests/msg11398.html
> but without further progress till now...
>
> It's better to develop more testcases for EROFS, and we can put forward
> xfstest as well. :)
>
> Thanks,
> Gao Xiang
>
> >
> > -Pratik
>

--00000000000001058f058f8a123b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for the comprehensive answer Gao !</div><div>S=
o we can use this channel to post Test cases that we think are needed for e=
rofs.</div><div><br></div><div>--Pratik.<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 6, 2019 at 9:=
35 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangkao@aol.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Pratik,<br>
<br>
On Tue, Aug 06, 2019 at 08:18:42PM +0530, Pratik Shinde wrote:<br>
&gt; Hello Maintainers,<br>
&gt; <br>
&gt; I wanted to ask if there is any plan for writing a test case suite for=
<br>
&gt; erofs. If not, how do you think is the idea of having a dedicated test=
 case<br>
&gt; suite, so as to maintain quality of fs?<br>
&gt; Let me know your thoughts.<br>
<br>
Currently we have a modified ro-fsstress for EROFS to do fuzzer tests,<br>
and we have dedicated constructed images to do all regression tests.<br>
<br>
Yes, I personally think that is not enough (thus we have a large beta<br>
users as a supplement) and we asked squashfs maintainers for their tools<br=
>
last year but without any luck.<br>
<br>
new xfstest testcases for read-only filesystems developped by another HUAWE=
I<br>
team is also available at <a href=3D"https://www.spinics.net/lists/fstests/=
msg11398.html" rel=3D"noreferrer" target=3D"_blank">https://www.spinics.net=
/lists/fstests/msg11398.html</a><br>
but without further progress till now...<br>
<br>
It&#39;s better to develop more testcases for EROFS, and we can put forward=
<br>
xfstest as well. :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; -Pratik<br>
</blockquote></div>

--00000000000001058f058f8a123b--
