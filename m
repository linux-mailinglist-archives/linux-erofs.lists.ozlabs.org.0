Return-Path: <linux-erofs+bounces-1472-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E53C999ED
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 00:43:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dL0ny2jt4z3bb2;
	Tue, 02 Dec 2025 10:43:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.134.221.251
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764632582;
	cv=none; b=mYp9qnLgY5+XnSWn+tAD44q2tjoYJYCn7eJI6onY2uCzkIFhv3qPy0+XzMsDbqez3R7KVlLa+hxvyTceaLTNVR7aNWGJcD6AEqKtr+0qbDynuVZWUr9VldwVb/1mqqFKk1ZkCpDKRKOj/ZBOr8+96oU0P7JF5Xzu+jBJUICSvZV9AfpLqquf8gMqPoLSe3aJAhAqtOwVXS5+c45HdXBJwHkYBvOpH9CuSFrdDaG7W1ABmdQgYNjl9LB6OLp40iiUItT++1UIa0tu1AMG5jckE1hbDgwcWCD07Y0S+C18wIT7BOTSmBcu2BEiP5wnQ2t0DapcTYIx9pa8bKEto66Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764632582; c=relaxed/relaxed;
	bh=spFIdXlBTfIaffK1Bcq/vdfvrsHjBWeK9MdfosDuIYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cMcegrUqL+cXoda25RFT+KCsXxLo3IXm9dA2X9dd50HyyohlfCvVvgkC02dMR1juaHkaItuOLK7srIkSfScRp5HlgSWNmYaTPntSq7gEYDbNMb8XP0DmMrcFZzseiCRgrNCT01dWQSd6LLHiUBQiExDyGyxrDCchDtgw/b+tP0/8qri6SB0TFz2KSSQ169BRFhA8eOd3x8LGv0BJSA+BOH/axuHnNzNX9lbJO4qx9aE2LTYjKhLPB5ja2lcakhkcAtcTffV3oyBFJ1aqzX9HtddQT02iH06K05oERUKMNSyfDJudgbvDm9hV3p9vMZ9PaNUnyktnOVkxS7SrAyeGlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=imvusa.us; spf=softfail (client-ip=213.134.221.251; helo=mail.olbox.org; envelope-from=info@imvusa.us; receiver=lists.ozlabs.org) smtp.mailfrom=imvusa.us
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=imvusa.us
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=imvusa.us (client-ip=213.134.221.251; helo=mail.olbox.org; envelope-from=info@imvusa.us; receiver=lists.ozlabs.org)
X-Greylist: delayed 463 seconds by postgrey-1.37 at boromir; Tue, 02 Dec 2025 10:43:01 AEDT
Received: from mail.olbox.org (mail.olbox.org [213.134.221.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dL0nx1Xb5z3bZf
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 10:43:00 +1100 (AEDT)
Received: from mail.olbox.org ([127.0.0.1])
	by localhost (mail.olbox.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t-bIlAAILZt for <linux-erofs@lists.ozlabs.org>;
	Tue,  2 Dec 2025 02:31:29 +0300 (MSK)
Received: from unn-37-19-213-130.datapacket.com (unknown [37.19.213.130])
	by mail.olbox.org (Postfix) with ESMTPSA id E5508297382
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Dec 2025 02:31:24 +0300 (MSK)
Reply-To: suzanne@imvusa.us
From: Suzanne <info@imvusa.us>
To: linux-erofs@lists.ozlabs.org
Subject: Seeking Long-Term Supplier Partnership
Date: 1 Dec 2025 15:31:20 -0800
Message-ID: <20251201153120.CD0453FC779F8392@imvusa.us>
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
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=3.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html><head>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><p>
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">Dear Sales Department,</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">My name is Suzanne Hobs, Procurement Offic=
er at IMV USA, based in Bellefontaine, Ohio. Our company is involved in sou=
rcing and distributing a wide range of products for the U.S. market.</span>=

<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">I came across your company and would like =
to learn more about what you manufacture and export. We are currently seeki=
ng reliable suppliers and are interested in exploring opportunities for a l=
ong-term business relationship as a regular buyer or distributor in Ohio.</=
span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">Could you please share details about your =
product range, export prices, and terms of supply? A catalog or brochure hi=
ghlighting your main offerings would be greatly appreciated.</span>
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-ser=
if; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0p=
x; float: none; display: inline !important; white-space: normal; orphans: 2=
; widows: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: =
normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-dec=
oration-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;"></span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">I look forward to your response and to the=
 possibility of working together.</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">Best regards,<br style=3D"box-sizing: bord=
er-box;"></span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">Suzanne Hobs</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">Procurement Officer | IMV USA</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">238 N Hayes St, Bellefontaine, OH 43311, U=
SA</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">&#128222; +1 (732) 705-1770</span>
<br style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; word-spacing: 0px;=
 white-space: normal; box-sizing: border-box; orphans: 2; widows: 2; backgr=
ound-color: rgb(255, 255, 255); font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: =
initial; text-decoration-style: initial;=20
text-decoration-color: initial;">
<span style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: Tahoma; font-siz=
e: 14px; font-style: normal; font-weight: 400; word-spacing: 0px; white-spa=
ce: normal; box-sizing: border-box; orphans: 2; widows: 2; background-color=
: rgb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; t=
ext-decoration-style: initial;=20
text-decoration-color: initial;">&#128231;<span>&nbsp;</span></span>
<a style=3D"text-align: left; color: rgb(0, 172, 255); text-transform: none=
; text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif=
; font-size: 14px; font-style: normal; font-weight: 400; text-decoration: n=
one; word-spacing: 0px; white-space: normal; box-sizing: border-box; orphan=
s: 2; widows: 2; background-color: rgb(255, 255, 255); font-variant-ligatur=
es: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px;" rel=
=3D"noreferrer">
<span style=3D"font-family: Tahoma; box-sizing: border-box;">suzanne@imvusa=
=2Eus</span></a></p></body></html>

