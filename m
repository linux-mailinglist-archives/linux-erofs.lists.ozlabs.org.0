Return-Path: <linux-erofs+bounces-1027-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52171B561CD
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Sep 2025 17:29:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cPFZW5X4sz2yrt;
	Sun, 14 Sep 2025 01:29:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.240.164.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757777347;
	cv=none; b=RGcHsZhqOnl20MZnUDvLRCCPG0VbMQftBDJGnQgcDw7vhPLRp5VETbQuS7PXJHP5mlTTXN8p+wfDAJiitbL3YJ4tNJE+7XsQzTxJbLPUKx1D+lgLyVNoL+f5l6t0W+NwSq8B/jvNaBuJPo4lzHCMPIOgVJp9xyG4IkuU9dbIKdoOjrv3OBwabBMhUu+2jENm80yrS4cg+RWHkqZP9txhz6Uyssvtb87wTaIl5hYeMLCnIQkNzG8oCiCICjKGW0HW3tw8PLo7b9gpJFM+R1X6rrqqMhMX6Kh2wFXQsUV4UR5uoMRp3B9lnZAXRDvlGVoDp/EUvnRz9ev3UetgjVkXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757777347; c=relaxed/relaxed;
	bh=Cor1lDmXvLP7PYTwWUHtWiHquKlVF9dF3yITlHo71/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNpGdCBlNygPfS/bX7wIywRxQ8gbG8RgNIC/aOnkmq2DTTJlisCqX9wnr6vdYpT5eMHkr8WO0FQ7MPid3lVpzkrC3bmaheJr1RdXyP1GraMg1r2/TW9budx9TmjT+ZJ4v3C4TlzISTr/KqQPH2j36mV/BzJwILKKKUjUktIIb/us9qTEmix2s8P/I9Pu8/MuQhv0b5OHZmB9rOw2FQ6mb7daEKvUfY3weR5eiQC4HZHsBJIIHTk2xoX6Guquw/123A3ErdfeMAENXTZousDI9zOafm3q7A+UUIJvjlFVZKxgmeCgTMxdvwcC2yWNovKzF5v/sXgbhsrnzeSKQTDRrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ainsacoat.com; dkim=pass (2048-bit key; unprotected) header.d=ainsacoat.com header.i=@ainsacoat.com header.a=rsa-sha256 header.s=default header.b=MzYEtx1l; dkim-atps=neutral; spf=pass (client-ip=162.240.164.248; helo=vps-11577137.locatellisc.com.br; envelope-from=venta@ainsacoat.com; receiver=lists.ozlabs.org) smtp.mailfrom=ainsacoat.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ainsacoat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ainsacoat.com header.i=@ainsacoat.com header.a=rsa-sha256 header.s=default header.b=MzYEtx1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ainsacoat.com (client-ip=162.240.164.248; helo=vps-11577137.locatellisc.com.br; envelope-from=venta@ainsacoat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3961 seconds by postgrey-1.37 at boromir; Sun, 14 Sep 2025 01:29:05 AEST
Received: from vps-11577137.locatellisc.com.br (unknown [162.240.164.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cPFZT471Zz2xlR
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Sep 2025 01:29:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ainsacoat.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cor1lDmXvLP7PYTwWUHtWiHquKlVF9dF3yITlHo71/Y=; b=MzYEtx1l5RtdzkVe9RyG+wl5dc
	l0yqFJLyx2VN4DRqseQG1x/uhsKII9zY1SIQvuejqUR57woytmbJVs2zNx7KUrxmHVq/bMt47Y9tU
	YKjIQ4T+vRG/SHhgRWqaBvwRA1Adu1wgBEtNEkL9yv28XXJOkHGVOWCMJWqkWBQ3+Mz3n2j2uOLGM
	uIt0AEXFs6+nA4eVAXRIrHVfvgVbg28HiKLazEbAB+jvteUiFoVdtQL6CoxfPfbaavVrPG095VD2s
	NZhoJW7XHPjcyrENHJmjmM03yyz/f4DcC6JUZZ8XyvMGLYcGTwXc6DAXu7huX8ZAYvnNnbWrjar3X
	/qMoMyEw==;
Received: from [96.44.159.208] (port=54171 helo=96-44-159-208-host.colocrossing.com)
	by 162-240-164-248.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <venta@ainsacoat.com>)
	id 1uxR9Y-0000000023J-1Bvy
	for linux-erofs@lists.ozlabs.org;
	Sat, 13 Sep 2025 08:23:00 -0600
Reply-To: "Donald Nikcevic" <donald@abffundingltd.co.uk>,costa.lima@yandex.com
From: "Donald Nikcevic" <venta@ainsacoat.com>
To: linux-erofs@lists.ozlabs.org
Subject: We provide loans on any viable business/project
Date: 13 Sep 2025 10:22:59 -0400
Message-ID: <20250913102259.95DCD64A0C4D3CBD@ainsacoat.com>
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
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - 162-240-164-248.bluehost.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ainsacoat.com
X-Get-Message-Sender-Via: 162-240-164-248.bluehost.com: authenticated_id: venta@ainsacoat.com
X-Authenticated-Sender: 162-240-164-248.bluehost.com: venta@ainsacoat.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  1.2 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
	*      [Blocked - see <https://www.spamcop.net/bl.shtml?96.44.159.208>]
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  2.5 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html><head>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><div style=3D"color: rgb(0, 0, 0); text-transform: none; text-indent:=
 0px; letter-spacing: normal; font-family: Helvetica, Arial, sans-serif; fo=
nt-size: 16px; font-style: normal; font-weight: 400; word-spacing: 0px; whi=
te-space: normal; orphans: 2; widows: 2; background-color: rgb(255, 255, 25=
5); font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text=
-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-sty=
le: initial; text-decoration-color: initial;">
<div style=3D'color: rgb(34, 34, 34); text-transform: none; text-indent: 0p=
x; letter-spacing: normal; font-family: "Helvetica Neue", Helvetica, Arial,=
 sans-serif; font-size: 16px; font-style: normal; font-weight: 400; word-sp=
acing: 0px; white-space: normal; orphans: 2; widows: 2; background-color: r=
gb(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: norma=
l; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text=
-decoration-style: initial; text-decoration-color:=20
initial;'><div><span style=3D"font-family: Helvetica, Arial, sans-serif;">G=
reetings,</span></div></div>
<div id=3D"m_-8322306967151023904ydpf7641210yahoo_quoted_6424776780" style=
=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px; letter-=
spacing: normal; font-family: Arial, Helvetica, sans-serif; font-size: smal=
l; font-style: normal; font-weight: 400; word-spacing: 0px; white-space: no=
rmal; orphans: 2; widows: 2; background-color: rgb(255, 255, 255); font-var=
iant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-widt=
h: 0px; text-decoration-thickness: initial;=20
text-decoration-style: initial; text-decoration-color: initial;"><div style=
=3D'color: rgb(38, 40, 42); font-family: "Helvetica Neue", Helvetica, Arial=
, sans-serif; font-size: 13px;'><div><div id=3D"m_-8322306967151023904ydpf7=
641210yiv8256323869"><div style=3D'font-family: "Helvetica Neue", Helvetica=
, Arial, sans-serif; font-size: 16px;'><div dir=3D"ltr"><div><div style=3D"=
color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-serif; font-size: =
16px;"><br></div>
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-seri=
f; font-size: 16px;" dir=3D"ltr">I am an Investment Broker with high profil=
e investment company based in United Kingdom. We provide HARD LOAN FUNDING =
for any VIABLE project/business seeking Financing.</div><div style=3D"color=
: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-serif; font-size: 16px;=
" dir=3D"ltr"><br></div><div style=3D"color: rgb(0, 0, 0); font-family: Hel=
vetica, Arial, sans-serif; font-size: 16px;" dir=3D"ltr">
<div><div><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial,=
 sans-serif; font-size: 16px;">* * Loan Interest Rate:&nbsp; 2% annually.</=
div><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-=
serif; font-size: 16px;">* * Moratorium / Grace Period: (12 Months Grace Pe=
riod) /One (1) Years.</div><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica, Arial, sans-serif; font-size: 16px;">* &#8288;* Loan Funding Max=
imum Duration: (10 Years).</div></div></div></div>
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-seri=
f; font-size: 16px;"><br></div><div style=3D"color: rgb(0, 0, 0); font-fami=
ly: Helvetica, Arial, sans-serif; font-size: 16px;">Let us know if you have=
 a viable start up or already existing business/project that requires fundi=
ng or expansion. kindly reply and forward your project/business plan for ou=
r management review.</div><div style=3D"color: rgb(0, 0, 0); font-family: H=
elvetica, Arial, sans-serif; font-size: 16px;"><br>
</div><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, san=
s-serif; font-size: 16px;">Thank you</div><div style=3D"color: rgb(0, 0, 0)=
; font-family: Helvetica, Arial, sans-serif; font-size: 16px;"><br></div><d=
iv style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-serif;=
 font-size: 16px;">Best Regards,<br><br>Donald Nikcevic<br></div><div style=
=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-serif; font-si=
ze: 16px;">------------------------</div>
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-seri=
f; font-size: 16px;" dir=3D"ltr">Investment Broker</div><div style=3D"color=
: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-serif; font-size: 16px;=
">Addax Port Office<br></div><div style=3D"color: rgb(0, 0, 0); font-family=
: Helvetica, Arial, sans-serif; font-size: 16px;">United Kingdom</div></div=
></div></div></div></div></div></div></div></body></html>

