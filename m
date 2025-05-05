Return-Path: <linux-erofs+bounces-273-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5548AA8CC5
	for <lists+linux-erofs@lfdr.de>; Mon,  5 May 2025 09:05:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZrXbt1bfjz2yf9;
	Mon,  5 May 2025 17:05:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::d32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746428730;
	cv=none; b=Fapj35y07nZQXcT/JBEeRrsOEnfIftdPxajb1BZivfYSSJ/VEB8J1ZAftMimAskKg8xMKDfWNtzwxLm7oX6kniYmlrLoaikWFqutJ+zHl9NA8CIS66S74w8/EJ06tHevWiDD0vIUYAVJHPJF1XbkXGYkgDjhp2fvSJQ+vQf03K9xlITRoZHNwrcMNpT/BpFMeO8yJvZEK9ADbPqqTvVjG2Bd0YLNvz7lh81uTg4a2Sb6mhR/lo1/NCFxkZ4wdF6v2kreBuB4YLQUobYfoNcWboEjeDoY8a+C0PFaxKObYguf3J2TOz8N/ltzfTT5+mgdfMjltKHPMLXw9908tST3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746428730; c=relaxed/relaxed;
	bh=JGaaJUIIwtR1DVaio2jXTpHdWP2TwJjQThPkJN2qE+Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YDiL1D9hGtFhhr4pTKv8ENrj14DBFESWkcGLMHIySyxiWk0IRQNcudm/ocXX4vYopPE2sw5cOJVjnS29sgtowp2eBVgDZ2jx+l16TYb/gIAdxsSfo0Ndj8+TDcoRsAIhI9jFjQ6ndYbjkXrlJDh307pBy3V1YIUYVorZ9dYIEbDMrx7UtRuWIhIyes1fUdfI1AFJcNj7Ntxe21nwfqsgO4nhJ/YtaPMYlZYBTsOrDZ65NaaPsulQX2hknAriF4wIZDBsUJra/bh03eAn+mQfXTeiSQdrvReB0uzXdPz/OVcEvAKHoUNQsG+cdXcMOoNUzT56oU4GAba930M33/koIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OBV9PRqD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::d32; helo=mail-io1-xd32.google.com; envelope-from=justindunce42@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OBV9PRqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d32; helo=mail-io1-xd32.google.com; envelope-from=justindunce42@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZrXbr2z2vz2yMt
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 May 2025 17:05:27 +1000 (AEST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-85e751cffbeso363217139f.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 May 2025 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746428723; x=1747033523; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGaaJUIIwtR1DVaio2jXTpHdWP2TwJjQThPkJN2qE+Y=;
        b=OBV9PRqDk/BZO8a37E98j0OWspX6nT7JwBHHsE8i+RBll6opmW9Bu42OrFMO0tsoZc
         Fug4YkDscM8pGdpM1k/C5ewV/CjLjH3OoRss3UrzBGoworj3BKqjskzlp3OmSQrhM7K3
         tQQ7Jz0hyYeUxJHfGnmpybxBIxVuIYQG9JefbrxLV5SQrW+SXfFpwMKFGc0YtiF7tYxN
         B/CV3aWJ8Zqyr1oK06MTCX5XpGUm231H4MuUud7D6KDuP2XApgXaf/K2qR1ExWT23sll
         47co3mqrP50LFZ4yMqvvOk0hu0iHxnEapn0LzpIvlyroWBzmzRAoQzumv4jCmFRXZtxL
         27Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746428723; x=1747033523;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGaaJUIIwtR1DVaio2jXTpHdWP2TwJjQThPkJN2qE+Y=;
        b=mD43U84PGgJWD8DHSjaOxPXx0tKYsxgxWRes7D0iZxLSiBaZhmNuWG6Hl1/uWYcd7N
         Ipaxx3j6OCb9PDgwTR9HKodY9Fqvkag2rCYcokegFu0AvyQM7dBYNVTC3zR1P+lRWWF8
         K9sZ6CrBHiEYWo9IOQH0G0Pt3saeHOs1X2intkE4B7mQU9Ac8ci+fu8lYgVgtPF+4ir4
         KfTUz8agzIFaigEtzw5Bt6KT2QrqRqa11u6MR0CVv6wMHqGgS6QGMhxUZgLbjpshgElf
         P/P50Q/nLJ2CaGFv9+M+Zdea8pWh7rgWz1nwaOYGDx6EHVcovBgz8t2dlCVTQU/uQQs/
         imkg==
X-Gm-Message-State: AOJu0YzDpznapNoCn1ygWQSQNP9hpRQD6GJtwMa+uGql5Xr/lx4v5FGr
	ytIutTVPL5Seq8hHdaufqO86hD9hR7ssfdyOIDZy8V6auxSONUBbY4G0JhaKWY/3OFOeA09HxKQ
	agRr2WFsLK4+yX1cZL6CxlSir034cNGJd
X-Gm-Gg: ASbGncvcp7Tcl0Lxvc6guKP9+g6SnQtXHw8PhVYbIaLOaBKXNOcfo6wBkVergJg2XdA
	hemag3m/BkYv412VWPLdItyVvfVTwrkrB3ygflUKLw/R2wTYDDld2rkdvLTdOROuQTWYbfdoD1+
	jz/aXAFGPS2vhSyAjz3b2oe7I=
X-Google-Smtp-Source: AGHT+IFnuL9l9Ldp8NNdVG6A+Kk7Zhc/eqS75bVEjIwjcgMySu036N++YjjDYWqrnRqZAwl8z5gjQLDwLT7UlMAl0yE=
X-Received: by 2002:a05:6602:2b0b:b0:85b:35b1:53b4 with SMTP id
 ca18e2360f4ac-86713bac130mr514908839f.12.1746428723464; Mon, 05 May 2025
 00:05:23 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: Justin Ding <justindunce42@gmail.com>
Date: Mon, 5 May 2025 14:05:12 +0700
X-Gm-Features: ATxdqUFTTK8bm9Jz1FEhQSkw-GHva-ci97UydShDemcLngHgRWitfctQ1NwV_DI
Message-ID: <CAHCY0fXs+fKxn6EgiLrus3=DJ+me=tP=j42DKt9ceY15KB18-A@mail.gmail.com>
Subject: =?UTF-8?B?6Z2i5a+557q357mB55qE5bu66K6uIOWmguS9leWBmuWHuuaYjuaZuueahOWBpeW6t+mAiQ==?=
	=?UTF-8?B?5oup?=
To: linux-erofs@lists.ozlabs.org, dennis.pausch@uni-marburg.de, 
	ppaul@csmcri.org, lmcbain@nacubo.org, lcping0926@126.com
Content-Type: multipart/alternative; boundary="000000000000b00d1a06345e1f96"
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--000000000000b00d1a06345e1f96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlveWQl++8nyoNCg0K5aaC5LuK77yM5LuO6aWu6aOf5Yiw6KGl5YWF5YmC44CB5bCP5bel
5YW35ZKM6ZS754K86K6h5YiS77yM5aSn6YeP55qE5YGl5bq35bu66K6u57q36Iez5rKT5p2l77yM
6K6p5Lq655ay5LqO6YCJ5oup4oCc5q2j56Gu4oCd55qE6YGT6Lev44CCDQoNCuaIkeS7rOivpeWm
guS9leaOjOaOp+iHquW3seeahOWBpeW6t+iAjOS4jemZt+WFpeWbsOWig+WRou+8nw0KDQrmnKzm
lofmjIflh7rluK7liqnkvaDnvKnlsI/pgInmi6nojIPlm7TnmoTlm5vnp43mlrnms5XjgIINCg0K
54K55Ye76ZO+5o6l77yM5oKo5bCG6I635b6X5a6d6LS155qE5L+h5oGv77yM5LiN5a656ZSZ6L+H
77yBDQoNCmh0dHBzOi8vdGlueXVybC5jb20vM3h1YW4temUtbWluZy16aGkNCg0K56Wd5L2g5ZKM
5L2g55qE5a625Lq65aW96L+Q77yBDQoNCg0KDQotLS0NCg0K5Lq65b+D5ZCR5ZaE77yM5pyq5p2l
5Y+v5pyfDQo=
--000000000000b00d1a06345e1f96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font-family:&quot;Times New R=
oman&quot;;font-size:medium"><span class=3D"gmail-auto-style1" style=3D"fon=
t-family:&quot;Microsoft YaHei&quot;"><strong>=E4=BD=A0=E5=A5=BD=E5=90=97=
=EF=BC=9F</strong></span><br class=3D"gmail-auto-style1" style=3D"font-fami=
ly:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D"fo=
nt-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1" st=
yle=3D"font-family:&quot;Microsoft YaHei&quot;">=E5=A6=82=E4=BB=8A=EF=BC=8C=
=E4=BB=8E=E9=A5=AE=E9=A3=9F=E5=88=B0=E8=A1=A5=E5=85=85=E5=89=82=E3=80=81=E5=
=B0=8F=E5=B7=A5=E5=85=B7=E5=92=8C=E9=94=BB=E7=82=BC=E8=AE=A1=E5=88=92=EF=BC=
=8C=E5=A4=A7=E9=87=8F=E7=9A=84=E5=81=A5=E5=BA=B7=E5=BB=BA=E8=AE=AE=E7=BA=B7=
=E8=87=B3=E6=B2=93=E6=9D=A5=EF=BC=8C=E8=AE=A9=E4=BA=BA=E7=96=B2=E4=BA=8E=E9=
=80=89=E6=8B=A9=E2=80=9C=E6=AD=A3=E7=A1=AE=E2=80=9D=E7=9A=84=E9=81=93=E8=B7=
=AF=E3=80=82</span><br class=3D"gmail-auto-style1" style=3D"font-family:&qu=
ot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D"font-fam=
ily:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1" style=3D=
"font-family:&quot;Microsoft YaHei&quot;">=E6=88=91=E4=BB=AC=E8=AF=A5=E5=A6=
=82=E4=BD=95=E6=8E=8C=E6=8E=A7=E8=87=AA=E5=B7=B1=E7=9A=84=E5=81=A5=E5=BA=B7=
=E8=80=8C=E4=B8=8D=E9=99=B7=E5=85=A5=E5=9B=B0=E5=A2=83=E5=91=A2=EF=BC=9F</s=
pan><br class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft Ya=
Hei&quot;"><br class=3D"gmail-auto-style1" style=3D"font-family:&quot;Micro=
soft YaHei&quot;"><span class=3D"gmail-auto-style1" style=3D"font-family:&q=
uot;Microsoft YaHei&quot;">=E6=9C=AC=E6=96=87=E6=8C=87=E5=87=BA=E5=B8=AE=E5=
=8A=A9=E4=BD=A0=E7=BC=A9=E5=B0=8F=E9=80=89=E6=8B=A9=E8=8C=83=E5=9B=B4=E7=9A=
=84=E5=9B=9B=E7=A7=8D=E6=96=B9=E6=B3=95=E3=80=82</span><br class=3D"gmail-a=
uto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><br class=3D"=
gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><span =
class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot=
;">=E7=82=B9=E5=87=BB=E9=93=BE=E6=8E=A5=EF=BC=8C=E6=82=A8=E5=B0=86=E8=8E=B7=
=E5=BE=97=E5=AE=9D=E8=B4=B5=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=B8=8D=E5=
=AE=B9=E9=94=99=E8=BF=87=EF=BC=81</span><br class=3D"gmail-auto-style1" sty=
le=3D"font-family:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-styl=
e1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-=
auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><a href=3D"h=
ttps://tinyurl.com/3xuan-ze-ming-zhi">https://tinyurl.com/3xuan-ze-ming-zhi=
</a></span></p><p style=3D"color:rgb(0,0,0);font-family:&quot;Times New Rom=
an&quot;;font-size:medium"><span class=3D"gmail-auto-style1" style=3D"font-=
family:&quot;Microsoft YaHei&quot;">=E7=A5=9D=E4=BD=A0=E5=92=8C=E4=BD=A0=E7=
=9A=84=E5=AE=B6=E4=BA=BA=E5=A5=BD=E8=BF=90=EF=BC=81</span><br class=3D"gmai=
l-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"></p><p cla=
ss=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;;f=
ont-size:medium;color:rgb(0,0,0)">=C2=A0</p><p class=3D"gmail-auto-style9" =
style=3D"font-size:11.5pt;color:rgb(91,102,116)">---</p><p class=3D"gmail-a=
uto-style14" style=3D"font-family:&quot;Microsoft YaHei&quot;;color:rgb(0,1=
23,255);font-size:medium">=E4=BA=BA=E5=BF=83=E5=90=91=E5=96=84=EF=BC=8C=E6=
=9C=AA=E6=9D=A5=E5=8F=AF=E6=9C=9F</p></div>

--000000000000b00d1a06345e1f96--

