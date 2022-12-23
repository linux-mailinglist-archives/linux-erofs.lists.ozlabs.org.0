Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B536654C4D
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Dec 2022 06:55:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ndbxs5NZ0z3bZQ
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Dec 2022 16:55:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WqQoCr1E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=serges.malembe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WqQoCr1E;
	dkim-atps=neutral
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ndbxk3LJrz30Jy
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Dec 2022 16:55:20 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id o5so3693565wrm.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Dec 2022 21:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnWltqysrdQjTB12SHwmZ6ZGTEenGKaqcX0Z/Qdrz2Q=;
        b=WqQoCr1Ef5fto+kOvuwhO+rOw79qu4aJStVnx6l4f3bPCyn0toiEDOIcN5PI2tMEAr
         BJXMAizcguZakNRZSL/GU98BRTBGuOt3ac5dpfv04yWDkaE1FL6QnsBbLD+21lab+ad1
         3y6zxaKaomN2tDqoT1hnQ7ycH091lrKiMSQuVFKyx41d9Ebutp8UFMe4fabXELkqyJ2V
         dbmTKBZand7ALi/+suc4Uw+yJCWyLa+WcSNTke/QiyUTBFIfy2Et9L0x6EROG6HrMzs8
         71uFsrskiVtfhqG9jFqCkE2ADkK3xZ6PQhrBNhVVbW/5LZayGezvHUBgo8nUJJ1u/Gq0
         XSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnWltqysrdQjTB12SHwmZ6ZGTEenGKaqcX0Z/Qdrz2Q=;
        b=YTGMEvgx+yowyJCmZsSiiZqPHjPMyr1Byh/arF4qjJySpsvJjhv0OHnmDc9g7SlvDk
         1z4mC1VMYO2SFpIzFx36L2LFAFtX+YWiwzBR6RNo/TWZpaxFiWVz1vtvFc3GTEXvlkgA
         jXtxo2f75f/2O5PaM+nIxOkkotdpUAcigbyRUmPXboIYAaOE3otRIo91A9hPZIGLazuk
         DUN3hzQaP+IZBUdBQPU9cCevpwXZnmR88hA6T4SmH6FvgKeqljdz0zrBBtA83UGZXRLq
         IDFRgu48KElY6WbLs0mS7C7GDuSTqe56v3q2iuCtg3M6HQ+Sil7iiYZNQYyixLEQIvzN
         dR4w==
X-Gm-Message-State: AFqh2kqHMZnFUJcST/TRc8G1bOllsRiBIHPtCl381B12gGHOx2BxIDmd
	JWRfr+ICt1bqaVh6lg1UmakQQdl4Mbt7ow==
X-Google-Smtp-Source: AMrXdXu68J9V4mASeto673gUDKG2saCaqEWxTGFjs9dfVydK3XXHl3NQFuemmMkjvXzRCIoamM/FLA==
X-Received: by 2002:a05:6000:80b:b0:274:c846:4211 with SMTP id bt11-20020a056000080b00b00274c8464211mr265394wrb.54.1671774912182;
        Thu, 22 Dec 2022 21:55:12 -0800 (PST)
Received: from [41.79.219.151] ([41.79.219.151])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d58e8000000b0022e57e66824sm2560001wrd.99.2022.12.22.21.55.11
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Dec 2022 21:55:11 -0800 (PST)
Date: Thu, 22 Dec 2022 21:55:11 -0800 (PST)
X-Google-Original-Date: 23 Dec 2022 06:55:09 +0100
From: Christiane Spuri <serges.malembe@gmail.com>
X-Google-Original-From: "Christiane Spuri" <portefaix.n.jeanine32@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [Attn] For your attention linux-erofs@lists.ozlabs.org on 23/12/2022 06:54:46
Message-ID: <20221223065446.6494D969C8BA118B@gmail.com>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Christiane Spuri <spurijeaninechristiane@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<HTML><HEAD><TITLE></TITLE>
<META content=3DIE=3Dedge http-equiv=3DX-UA-Compatible>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17514"></HEAD>
<BODY style=3D"MARGIN: 0.4em">
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>H=
ello linux-erofs@lists.ozlabs.org<BR><BR><SPAN style=3D"LINE-HEIGHT: 106%; =
FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14pt; mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN-US" lang=3DEN-US>
<SPAN style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZ=
E: 14pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN=
-US>350 KG OF RAW GOLD BARS AVAILABLE FOR INVESTMENT PURPOSES</SPAN><SPAN s=
tyle=3D"mso-bidi-font-family: Calibri; mso-ansi-language: EN-US; mso-ascii-=
font-family: Calibri; mso-hansi-font-family: Calibri" lang=3DEN-US><?xml:na=
mespace prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office" /><o:=
p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>
I am seeking a Bank Manager, an Entrepreneur or any competent Person who ca=
n participate in the retrieval of Three Hundred and Fifty Kilograms (350 KG=
) of Raw Gold Bars, which has been abandoned by our deceased client, for se=
veral years, at the Bank Security Department, for safe keeping, in his Bank=
, in Belgium.</SPAN><SPAN style=3D"mso-bidi-font-family: Calibri; mso-ansi-=
language: EN-US; mso-ascii-font-family: Calibri; mso-hansi-font-family: Cal=
ibri" lang=3DEN-US><o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>P=
lease note that this transaction is risk free for all participants and will=
 be completed in less than 10 business days.</SPAN><SPAN style=3D"mso-bidi-=
font-family: Calibri; mso-ansi-language: EN-US; mso-ascii-font-family: Cali=
bri; mso-hansi-font-family: Calibri" lang=3DEN-US><o:p></o:p>
</SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>F=
inally, I am really sorry for having contacted you in this way, since we do=
 not know each other, and we never ever had any relationship in the past.</=
SPAN>
<SPAN style=3D"mso-bidi-font-family: Calibri; mso-ansi-language: EN-US; mso=
-ascii-font-family: Calibri; mso-hansi-font-family: Calibri" lang=3DEN-US><=
o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>B=
ut, as you know, the Internet has become today the easiest and best way to =
reach people and companies all around the world, in order to exchange new i=
deas, business&#8217;s opportunities and many other things. </SPAN>
<SPAN style=3D"mso-bidi-font-family: Calibri; mso-ansi-language: EN-US; mso=
-ascii-font-family: Calibri; mso-hansi-font-family: Calibri" lang=3DEN-US><=
o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>T=
herefore, kindly contact me for more details, if you have required skills f=
or this kind of transaction.</SPAN><SPAN style=3D"mso-bidi-font-family: Cal=
ibri; mso-ansi-language: EN-US; mso-ascii-font-family: Calibri; mso-hansi-f=
ont-family: Calibri" lang=3DEN-US><o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>T=
hank you for your attention</SPAN><SPAN style=3D"mso-bidi-font-family: Cali=
bri; mso-ansi-language: EN-US; mso-ascii-font-family: Calibri; mso-hansi-fo=
nt-family: Calibri" lang=3DEN-US><o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>C=
hristiane.</SPAN><SPAN style=3D"mso-bidi-font-family: Calibri; mso-ansi-lan=
guage: EN-US; mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibr=
i" lang=3DEN-US><o:p></o:p></SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal><SPAN=
 style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif'; FONT-SIZE: 14=
pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" lang=3DEN-US>D=
irector of<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>IT Department in =
a Law Firm, France.</SPAN></P>
<P style=3D"LINE-HEIGHT: 106%; MARGIN: 0cm 0cm 8pt" class=3DMsoNormal></SPA=
N></SPAN><SPAN style=3D"LINE-HEIGHT: 106%; FONT-FAMILY: 'Centaur', 'serif';=
 FONT-SIZE: 14pt; mso-bidi-font-family: Calibri; mso-ansi-language: EN-US" =
lang=3DEN-US>Sent on <FONT face=3D"">23/12/2022 06:54:46</FONT><BR><BR></SP=
AN><SPAN style=3D"mso-bidi-font-family: Calibri; mso-ansi-language: EN-US; =
mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibri" lang=3DEN-U=
S><o:p></o:p></SPAN></P>
<P></P></BODY></HTML>
