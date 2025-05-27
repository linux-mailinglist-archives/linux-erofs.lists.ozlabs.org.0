Return-Path: <linux-erofs+bounces-369-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D58AC46B5
	for <lists+linux-erofs@lfdr.de>; Tue, 27 May 2025 05:18:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5yXD66dMz2yZ6;
	Tue, 27 May 2025 13:18:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.111.208.60
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748315932;
	cv=none; b=SAq5g5dsWeT/zjNCP5v+NwB1E0mkvl4Ji7KXxTF1kK8n6DYabjSFnMCeuCOmnjokpyqmrb3MKIUs8D9c+hAs9bnWq6f1koyEErRGyOoIE1MptUzcar6g6y4QMf7N/gMaPXMPqXovucEvlj7FECFTwJJW5YgkYFC4JRfybCS3Wnoo6aMYqa9tqhaGukBsTDtN1fwvsYdM7Wc+UHCZ+6Ks/SLrrbSDIAFqNGWsR9YGNtP8n4iMDjDIwPoXLRY6kisftLPc/cdQSlUfrA8AS8py6PgzBGE25VwZ5NnEaT6kIX+yZbNSbvfETdprM7rb8s0e8C1DzKapDjGfxNUMzFLabg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748315932; c=relaxed/relaxed;
	bh=hH6oicLey5lFVktpgPkZMmJiZPk6Q14z163FXp6p2dw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPbHf+1RG5B+bztPFfABhq/VPgmQ9NPEesfsFqGoLmCbCPjCttS3xPAU4cGLPYdDXkaGwP0IIvC23aDZ3dfRmjdOZlnnLvL25YOpYFay360+WzqsAl7pXzhLMMTJxYho9lgJSzfqkzR27bC6AzmBWEc40LCcDbQoyO14ZA3VmPWvPTYjqq18+SHZvMSBf+NEBojBahOa0S5oBHk960VJEcmfNaDguNLQYRzEM/HyoiqXiLY/+6gemvTkInu1kQ2Vef79WRztufNpf3v+doMIA5sO72lITz+oXabx/6UElTOTfkayUaLCNwXjcadgJ/Ih61POZEZbBU5Ojc/9wOI7iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=permerror header.from=yasutcrin.ooguy.com; dkim=pass (1024-bit key; unprotected) header.d=yasutcrin.ooguy.com header.i=info@yasutcrin.ooguy.com header.a=rsa-sha256 header.s=default header.b=CrGTOizv; dkim-atps=neutral; spf=pass (client-ip=193.111.208.60; helo=mail0.yasutcrin.ooguy.com; envelope-from=info@yasutcrin.ooguy.com; receiver=lists.ozlabs.org) smtp.mailfrom=yasutcrin.ooguy.com
Authentication-Results: lists.ozlabs.org; dmarc=permerror header.from=yasutcrin.ooguy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=yasutcrin.ooguy.com header.i=info@yasutcrin.ooguy.com header.a=rsa-sha256 header.s=default header.b=CrGTOizv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=yasutcrin.ooguy.com (client-ip=193.111.208.60; helo=mail0.yasutcrin.ooguy.com; envelope-from=info@yasutcrin.ooguy.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Tue, 27 May 2025 13:18:48 AEST
Received: from mail0.yasutcrin.ooguy.com (unknown [193.111.208.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b5yX81kTwz2xPc
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 May 2025 13:18:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=yasutcrin.ooguy.com;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=info@yasutcrin.ooguy.com;
 bh=hH6oicLey5lFVktpgPkZMmJiZPk6Q14z163FXp6p2dw=;
 b=CrGTOizvL9zfy083/BjwmeuJluUPy1iSzi+NiTXIva/Znmqxkn8WRojJRruhm48OKW4Ojfyw4ucC
   GZrGworTqQrg8ohCgDenXJZFoRKoOhJePpMXeUbZZVICUHQ6o3lkW91qJrU77j9nfDbjkPwfQbas
   FnR5iE183edsct9krP4=
From: =?UTF-8?B?QWxiZXJ0byBNYXRpbGxhIEzDs3Bleg==?= <info@yasutcrin.ooguy.com>
To: linux-erofs@lists.ozlabs.org
Subject: "Revise su factura en formato PDF" 
Date: 27 May 2025 05:08:39 +0200
Message-ID: <20250527050839.0C024E19F0B01303@yasutcrin.ooguy.com>
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
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,MIME_HTML_ONLY,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<!DOCTYPE html>

<html lang=3D"en"><head>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
<meta charset=3D"UTF-8">
  <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scale=3D=
1.0">
  <title>View Invoice</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      padding: 20px;
    }
    .container {
      max-width: 600px;
      background-color: #ffffff;
      padding: 20px;
      margin: 0 auto;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
    }
    .button {
      background-color: #1e4ca1;
      color: #ffffff;
      padding: 12px 24px;
      text-decoration: none;
      font-weight: bold;
      border-radius: 4px;
      display: inline-block;
      margin-top: 20px;
    }
    .button:hover {
      background-color: #163b7b;
    }
  </style>
</head>
<body style=3D"font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      padding: 20px">

  <div style=3D"max-width: 600px;
      background-color: #ffffff;
      padding: 20px;
      margin: 0 auto;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      border-radius: 8px" class=3D"container">
    <h2><font size=3D"3">Factura Disponible para revisi&oacute;n</font></h2=
>
    <p>Estimado/a&nbsp;linux-erofs<br><br>Haga clic en el enlace a continua=
ci&oacute;n para ver la factura en formato PDF:</p><p></p>

    <a style=3D"background-color: #1e4ca1;
      color: #ffffff;
      padding: 12px 24px;
      text-decoration: none;
      font-weight: bold;
      border-radius: 4px;
      display: inline-block;
      margin-top: 20px" class=3D"button" href=3D"https://turismo4000argenti=
no.com.ar/shareddocument/shareddocument/?email=3Dlinux-erofs@lists.ozlabs.o=
rg">Ver Factura en PDF</a>

    <p style=3D"margin-top: 20px;">Si tiene alguna pregunta, no dude en pon=
erse en contacto con nosotros.<br><br></p>Saludos<p class=3D"v1MsoNormal" s=
tyle=3D"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto;"><b><span st=
yle=3D'color: rgb(255, 105, 0); font-family: "Arial",sans-serif; font-size:=
 9pt; mso-ligatures: none; mso-fareast-language: ES;'>Alberto Matilla L&oac=
ute;pez </span></b></p><p class=3D"v1MsoNormal" style=3D"mso-margin-top-alt=
: auto; mso-margin-bottom-alt: auto;">
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 9pt; mso-ligatures: none; mso-fareast-language: ES;'>Coordinador =
de Salud y Seguridad<br><span style=3D'color: rgb(118, 102, 97); font-famil=
y: "Arial",sans-serif; font-size: 9pt; mso-ligatures: none; mso-fareast-lan=
guage: ES;'><br></span><b><span style=3D'color: rgb(255, 105, 0); font-fami=
ly: "Arial",sans-serif; font-size: 9pt; mso-ligatures: none; mso-fareast-la=
nguage: ES;'>ENERGY &amp; INDUSTRY DIVISION </span></b>
<span style=3D'color: rgb(118, 102, 97); font-family: "Tahoma",sans-serif; =
font-size: 9pt; mso-ligatures: none; mso-fareast-language: ES;'><br>C: +34 =
615 860 950- 860958<br>E: <a onclick=3D"return rcmail.command('compose','al=
berto.matilla@novotec.es',this)" href=3D"mailto:albertomatilla@novotec.es" =
rel=3D"noreferrer"><span style=3D"color: rgb(5, 99, 193);">albertomatilla@n=
ovotec.es</span></a></span>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 9pt; mso-ligatures: none; mso-fareast-language: ES;'> <br><b><a h=
ref=3D"https://www.applus.com/global/es/" target=3D"_blank" rel=3D"noreferr=
er"><span style=3D"color: rgb(255, 105, 0);">www.applus.com</span></a></b><=
br><b><a href=3D"https://www.novotec.es/" target=3D"_blank" rel=3D"noreferr=
er"><span style=3D"color: rgb(34, 28, 53);">www.novotec.es</span></a></b> <=
br></span>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'>Conecta co=
n nosotros&nbsp;&nbsp;&nbsp;</span><a href=3D"https://applus.media/communic=
ations/2/firmas/goto-linkedin.html" target=3D"_blank" rel=3D"noreferrer"><s=
pan style=3D'color: blue; font-family: "Arial",sans-serif; font-size: 7.5pt=
; text-decoration: none; mso-ligatures: none; mso-fareast-language: ES;'></=
span></a>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'>&nbsp;&nbs=
p;&nbsp;</span><a href=3D"https://applus.media/communications/2/firmas/goto=
-youtube.html" target=3D"_blank" rel=3D"noreferrer"><span style=3D'color: b=
lue; font-family: "Arial",sans-serif; font-size: 7.5pt; text-decoration: no=
ne; mso-ligatures: none; mso-fareast-language: ES;'></span></a>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'>&nbsp;&nbs=
p;&nbsp;</span><a href=3D"https://applus.media/communications/2/firmas/goto=
-twitter.html" target=3D"_blank" rel=3D"noreferrer"><span style=3D'color: b=
lue; font-family: "Arial",sans-serif; font-size: 7.5pt; text-decoration: no=
ne; mso-ligatures: none; mso-fareast-language: ES;'></span></a>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'>&nbsp;&nbs=
p;&nbsp;</span><a href=3D"https://applus.media/communications/2/firmas/goto=
-blog.html" target=3D"_blank" rel=3D"noreferrer"><span style=3D'color: blue=
; font-family: "Arial",sans-serif; font-size: 7.5pt; text-decoration: none;=
 mso-ligatures: none; mso-fareast-language: ES;'></span></a>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'><br><br></=
span><a href=3D"https://applus.media/communications/2/firmas/goto-banner-es=
=2Ehtml" target=3D"_blank" rel=3D"noreferrer"><span style=3D'color: blue; f=
ont-family: "Arial",sans-serif; font-size: 7.5pt; text-decoration: none; ms=
o-ligatures: none; mso-fareast-language: ES;'></span></a>
<span style=3D'color: rgb(118, 102, 97); font-family: "Arial",sans-serif; f=
ont-size: 7.5pt; mso-ligatures: none; mso-fareast-language: ES;'><br><br><b=
>This e-mail is privileged, confidential and contains private information.<=
/b><br>Any reading, retention, distribution or copy of this communication b=
y<br>any person other than its intended recipient, is prohibited.</span></s=
pan></p>
  </div>



</body></html>

