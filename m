Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2486B0F1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 23:18:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pCtV22QvzDqMN
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 07:18:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c43; helo=mail-yw1-xc43.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mpfU+aun"; 
 dkim-atps=neutral
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pCtR3skBzDqZ1
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 07:18:23 +1000 (AEST)
Received: by mail-yw1-xc43.google.com with SMTP id z63so9557141ywz.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JXBYkz3gaY6dRxPu0ATlnWC9h0Q4pIaGIKSYz5hup0g=;
 b=mpfU+aunDsGI+sqBp9J6r0wqJzkMSgdghl5MlyedSydPVMhpsCpxBnLrROGgCxtlrQ
 MRo4tRQh1briUl7RODL/vd3YaPTIl0cxLNebUVFNGAblo1QB77eVYjNjrkAuT8gQ/jOk
 BRU6Apo75RQNFdPdItIpNmRTl2e6DHUk+q+epieRsHVoJecLaKiiSToxhgiYKd7XJumC
 gauvA5DDy6/5+LBUSE11ci1A4Kt+B0UfaxONxl1LJ+HISErQaX3Cr3sZwY9DerNBhdpL
 Bo+b4rAZLOExhD8GM32MN5zzT1p2iBCFhRNPSE3ZzSiBjqH5/6G8fxp85/4fBOm9a+dW
 Pf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JXBYkz3gaY6dRxPu0ATlnWC9h0Q4pIaGIKSYz5hup0g=;
 b=QevABRAF/tWo8gh+AG/xvADK3s11J2vd7+7UnrACVhnp5FvRyrbbKL757wjvnPzj2v
 Efp6YYXzkpZ0NIfoqkUnWW8/lIj8fjxdREF0jH2fYwfjPIGlqikGT5l9L4gW1ZwIlf/Q
 Gx+KAXXgjQrfYGyQk+tL/cRt3lX3Nbi0ZHtMp/lUVXRlxXti7ccTnTAjz6KUSAH7exjK
 DzHqNroKR7HW+RiG03KGS5shnwcscjg0Gxd/98pOORL5YfYB2CVz80t9wgNVt4RMu0vk
 QcussivVK3TlHIcTslzUbvtOz8cnJb43O1+xytykZInKSQuB42npxNZubm9UaP9hN1In
 iPIg==
X-Gm-Message-State: APjAAAVGVxGT4x9W6ku/vPj0zyKbFt0ZhHeaf+7DfjcfUkirnqO25fv7
 voJcyUXV/FKxYsD9PEyHIyLc1lTCbGiyBNvR8K42G4CnHzxBwA==
X-Google-Smtp-Source: APXvYqyJN86Y/mXVKThaUms8P/exIm2h2KUD1bNBEcTUaBjMJ8kaNSt6s+YbTT9yCI0Sf0xZ54L5S/xfbo+sKiH/LNY=
X-Received: by 2002:a0d:dd01:: with SMTP id g1mr21362866ywe.482.1563311898680; 
 Tue, 16 Jul 2019 14:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <1563295663-312-1-git-send-email-karen.palacio.1994@gmail.com>
 <20190716190358.GB20227@kroah.com>
In-Reply-To: <20190716190358.GB20227@kroah.com>
From: Karen Palacio <karen.palacio.1994@gmail.com>
Date: Tue, 16 Jul 2019 18:18:07 -0300
Message-ID: <CALQQ+L=jLMQ8Z3YMV0YH4ihrJiVQ8xZGs6RoHLrJ2hKX+kk68Q@mail.gmail.com>
Subject: Re: [PATCH] staging: erofs: fix typo
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="00000000000064e204058dd2ea40"
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, yucha0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000064e204058dd2ea40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>I can not take patches without any changelog text, sorry.
Oops, fixed and re-sent as v2. My bad!
Thanks,
Karen Palacio.

El mar., 16 jul. 2019 a las 16:04, Greg KH (<gregkh@linuxfoundation.org>)
escribi=C3=B3:

> On Tue, Jul 16, 2019 at 01:47:43PM -0300, Karen Palacio wrote:
> > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> > ---
> >  drivers/staging/erofs/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I can not take patches without any changelog text, sorry.
>

--00000000000064e204058dd2ea40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;I can not take patches without any changelog text, sor=
ry.<div class=3D"gmail-yj6qo"></div>Oops, fixed and re-sent as v2. My bad!<=
br>Thanks,<br>Karen Palacio.</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">El mar., 16 jul. 2019 a las 16:04, Greg KH (&=
lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org=
</a>&gt;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Jul 16, 2019 at 01:47:43PM -0300, Karen Palacio wrote:<b=
r>
&gt; Signed-off-by: Karen Palacio &lt;<a href=3D"mailto:karen.palacio.1994@=
gmail.com" target=3D"_blank">karen.palacio.1994@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/Kconfig | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
I can not take patches without any changelog text, sorry.<br>
</blockquote></div>

--00000000000064e204058dd2ea40--
