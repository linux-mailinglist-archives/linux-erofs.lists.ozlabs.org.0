Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF976C1EA
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 22:10:31 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ppKc1Jl4zDqT7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 06:10:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c42; helo=mail-yw1-xc42.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u/nVuSmo"; 
 dkim-atps=neutral
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ppKV5GQmzDqRf
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 06:10:22 +1000 (AEST)
Received: by mail-yw1-xc42.google.com with SMTP id f187so11249781ywa.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Vcy10At8Ad3NgUZ3y78FJibCfIUHbsk6wi3NDGTmzA=;
 b=u/nVuSmoh6mR9TTGTm2wuounm9GBtZmri/kWMmgFPvna4BXeRmqabuLUuD4a8udd9z
 8uqatPsbLh3MpEsUXkXggqUOMCeH+2KHGDryDZxwT4gR8CBlrmIBhRTBx69CaG9FeGnD
 ptSaVophJOw5jdIdFRE5nnkYZJgjouefIPBp63OGjvxFCGQM+qDFQkygSqn9gD1aZvRM
 nAQlgIBFa9vNa7eHWaMcpXc3kI87eDiGnsPEKHrSxbPZ1xaQw8ok0EKXjBoDZOwD0gz3
 B4rN1XaztIkt01w7CzIFaustfxPxqYcW3hxpSw3jECx0O/xoTBb5c96bPE52qtIuZHoC
 OZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Vcy10At8Ad3NgUZ3y78FJibCfIUHbsk6wi3NDGTmzA=;
 b=HfA+Hue5gpKPB1l2Jc99u9v6LVr9bbgX89ML2+ltDoOG+M6aRpj3I+sox/PsLd73ki
 HkHhmsCmfsOIUCuyWhr0aQxiI41vUdEngWHWZI6Dsu7lPvxglnzsHRE5FsQxHI5FEOwa
 Nbvg7mcQa/lsmKEv8ao3qNNMM1OwxNc6RCrtoCg8WwPQ5wNfkH6IlJKcYuJJ4HbLr+wn
 Duw6eeazHHtJ5X7CdDL8zsYy1k9NkoESM2J4ckLkylHUBMID48s9ZHnJd+leQEwG7vhb
 ieqbMRbEJaA/ZZ1ADmERlWYgKO2ECcBYTYjHJLu8dO495JW2zVF5zhNSnY9hzYJg1kZs
 Oa9g==
X-Gm-Message-State: APjAAAUVWHELowEAM8i9vm2dFonlfwWlIPIrmKKW+InrZQ/rKqLoYlIa
 I4NhwK0eh158LHUcK/6dk+rdJc53OVPXgOSPHEw=
X-Google-Smtp-Source: APXvYqyh+e9Dws9BP9s2NS57T9j6NInNfQP0WBkBgcayYGm7QK6vAfUlYoX52SuSf0EUz5mF6eNlicTeRYbRRqaFH+s=
X-Received: by 2002:a81:3305:: with SMTP id z5mr25721277ywz.319.1563394218743; 
 Wed, 17 Jul 2019 13:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <1563311783-12754-1-git-send-email-karen.palacio.1994@gmail.com>
 <20190716215026.GA18144@kroah.com>
In-Reply-To: <20190716215026.GA18144@kroah.com>
From: Karen Palacio <karen.palacio.1994@gmail.com>
Date: Wed, 17 Jul 2019 17:10:07 -0300
Message-ID: <CALQQ+LktdVPR4kjcfwggYQyW+R8C_4UOgzbTX_DCW5v7Pxg2fA@mail.gmail.com>
Subject: Re: [PATCH] v2: staging: erofs: fix typo
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000000d5b70058de6151f"
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

--0000000000000d5b70058de6151f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure thing!
Thanks so much for the patience.

El mar., 16 jul. 2019 a las 18:50, Greg KH (<gregkh@linuxfoundation.org>)
escribi=C3=B3:

> On Tue, Jul 16, 2019 at 06:16:23PM -0300, Karen Palacio wrote:
> > Fix typo in Kconfig
> > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
>
> I need a blank line before the signed-off-by line :(
>
> 3rd try?
>

--0000000000000d5b70058de6151f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sure thing! <br>Thanks so much for the patience.</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El mar., 1=
6 jul. 2019 a las 18:50, Greg KH (&lt;<a href=3D"mailto:gregkh@linuxfoundat=
ion.org">gregkh@linuxfoundation.org</a>&gt;) escribi=C3=B3:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Tue, Jul 16, 2019 at 06:16:2=
3PM -0300, Karen Palacio wrote:<br>
&gt; Fix typo in Kconfig<br>
&gt; Signed-off-by: Karen Palacio &lt;<a href=3D"mailto:karen.palacio.1994@=
gmail.com" target=3D"_blank">karen.palacio.1994@gmail.com</a>&gt;<br>
<br>
I need a blank line before the signed-off-by line :(<br>
<br>
3rd try?<br>
</blockquote></div>

--0000000000000d5b70058de6151f--
