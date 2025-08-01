Return-Path: <linux-erofs+bounces-749-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1464AB186E7
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 19:49:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bttkY5fL3z3bmc;
	Sat,  2 Aug 2025 03:49:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=191.252.27.238
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754070581;
	cv=none; b=ViTWA4YMmH+pMxZBNzDzqZo8FmTWmpViRxdIYDuYLH7xnhOmGk+rej1NYTOW+BS/LJd7B0ZsG0W0W8LBydE3GXdsTnUl1XSknciiYKAgU2N9BEProl9QabMKsrbAm8IKmNG1iSySd/7lcRD83ZpxErGJCZgZ/vv4Z5+Rpuvl3vyxINSlxuoqc+/I1l4VOCtw21WKDl+3Q9njcRDv96Y6yTGRGmfEOtrqIDZ3tZw4ymufHGzth62LcMWghoIyWODsyiQLyCdItML1gHnu9BW4YvJy3PhTlrUiU41cBWdFtTPtouzgAFxZ/eK0uR7JijkVyijG9f5eXf0HnS2ZzJvhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754070581; c=relaxed/relaxed;
	bh=XZTDp7b9CyDerRJtUz8cxEW/8UbWPrQuvTAA6VYAcbY=;
	h=Date:From:To:Subject:Mime-Version:Content-Type:Message-ID; b=o06Ihw3E4RmHqlVrWUoW4C+75jI9jDj64rq/ubLCV+6OuQAnDzjDY9Xl7KUoF5dD3VYsU0BE8g5ugF9fXxJ2r6kwI9YYniZcUxr53CA7t9kerHSQjolrNCXTT9Yb0fpTBLXdZNQz5lruGlOVpU/XigkvmjyRHETLlEalYleRznRwIXaHy68xjtlyXV1bbOa1sf3a+iIb16xsCi+E8xnLWK/UzD9CQdNHV5YHI8WqzUqsYEOgL4dEwnZIzmAZTcRlbxTgekQdNhB6FUjwsHwpG6MyTcQeUw5bwj8cQ6R3WvZ2p32rev9E3iyTt52V7AvS2WURnohMibzzpWpecKkGTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=rhotelcentral.emktlw-02.com; dkim=pass (1024-bit key; unprotected) header.d=emktlw-02.com header.i=@emktlw-02.com header.a=rsa-sha256 header.s=emktlw header.b=t+Ay1zxm; dkim-atps=neutral; spf=pass (client-ip=191.252.27.238; helo=mail27238.delibird-emkt0003.lwdlv.com.br; envelope-from=199841@rhotelcentral.emktlw-02.com; receiver=lists.ozlabs.org) smtp.mailfrom=rhotelcentral.emktlw-02.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=rhotelcentral.emktlw-02.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=emktlw-02.com header.i=@emktlw-02.com header.a=rsa-sha256 header.s=emktlw header.b=t+Ay1zxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rhotelcentral.emktlw-02.com (client-ip=191.252.27.238; helo=mail27238.delibird-emkt0003.lwdlv.com.br; envelope-from=199841@rhotelcentral.emktlw-02.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Sat, 02 Aug 2025 03:49:39 AEST
Received: from mail27238.delibird-emkt0003.lwdlv.com.br (mail27238.delibird-emkt0003.lwdlv.com.br [191.252.27.238])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bttkW1jkdz3bmC
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Aug 2025 03:49:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=emktlw; d=emktlw-02.com;
 h=Date:From:Reply-To:To:Subject:Mime-Version:Content-Type:List-Unsubscribe:
 Message-ID;
 bh=XZTDp7b9CyDerRJtUz8cxEW/8UbWPrQuvTAA6VYAcbY=;
 b=t+Ay1zxmrZqQ6Pbrg1JQAPj1ESLqCUB65OzX/49vRjHxSStCc/I1jgkf8wv+IUOLtZXxUnfSj2s2
   BfPfIAa7rLCGqfQz4rCM4rt77GN9SNFV4A2+CY2mc6BZJtNLRwCKvntPm/qM7JiV00xmGsVKTLhz
   znvKABT9bPT4HX+786g=
Received: from localhost (191.252.190.5) by mail27238.delibird-emkt0003.lwdlv.com.br id hhjv1u2n8lgb for <linux-erofs@lists.ozlabs.org>; Fri, 1 Aug 2025 14:39:12 -0300 (envelope-from <199841@rhotelcentral.emktlw-02.com>)
Date: Fri, 1 Aug 2025 14:39:12 -0300
From: ReclameAQUI <reservas@rhotelcentral.emktlw-02.com>
Reply-To: reservas@hotelcentral-ro.com.br
To: linux-erofs@lists.ozlabs.org
Subject: ReclameAQUI
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
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_688cfbb2c55f6_1f8333fe2697396743236512";
 charset=UTF-8
List-Unsubscribe: <mailto:6351-7ud-7-7-bcdb6b06dcba0fca7bf901823d8dc437ca85eaf7@unsubscribes.mktnaweb.com>,
 <http://emailmarketing.locaweb.com.br/accounts/199841/unsubscribes/7/8141?emkt_c=1754059914&emkt_v=bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw&envelope_id=7>
Precedence: bulk
x-account-id: 199841
x-contact-id: 8141
x-envelope-id: 7
x-message-id: 7
x-locaweb-id: HV1mAT7WLYfREaYCQzUSbyHfPMIA4X-sYSIaIdeEx8vhBy6icq87ocxm-w7oThqxcZdjvud1xevSZAfpH5oSnEwRT4GGlR1RGpeWUO45GZuhVaP33tWCHAIPE88UDIb7ht9nWKKnpj1WzAxVNO1X9Zhb4Nv8w5apoB2cB40tnneAbuL20E1unYIAx4SDxGwj
x-locaweb-id2: NTI2NTYzNmM2MTZkNjU0MTUxNTU0OTIwM2M3MjY1NzM2NTcyNzY2MTczNDA3MjY4NmY3NDY1NmM2MzY1NmU3NDcyNjE2YzJlNjU2ZDZiNzQ2Yzc3MmQzMDMyMmU2MzZmNmQzZQ==
Feedback-ID: 199841:7:c:emktlw
Message-ID: <0.8.0.AC.1DC030B315E05F2.7C3EE@mail27238.delibird-emkt0003.lwdlv.com.br>
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,MIME_QP_LONG_LINE,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


----==_mimepart_688cfbb2c55f6_1f8333fe2697396743236512
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ReclameAQUI=0D
Prezado(a),=0D
Informamos que recebemos uma reclama=C3=A7=C3=A3o registrada por um de se=
us clientes atrav=C3=A9s da plataforma=C2=A0Reclame Aqui.=0D
Pedimos que verifique os detalhes da reclama=C3=A7=C3=A3o o quanto antes =
para tomar as provid=C3=AAncias necess=C3=A1rias e evitar maiores contrat=
empos. Confira os detalhes abaixo:=0D
ACESSE A RECLAMA=C3=87=C3=83O=0D
Data:=C2=A00108/2025=0D
Hor=C3=A1rio:=C2=A014:35:11=0D
Protocolo de registro:=C2=A0614430455-6000519-2025=0D
Solicitamos a especial gentileza de analisar o teor da reclama=C3=A7=C3=A3=
o e fazer sua r=C3=A9plica em at=C3=A9 24 horas.=0D
Se voc=C3=AA n=C3=A3o deseja mais receber nossos e-mails, cancele sua ins=
cri=C3=A7=C3=A3o atrav=C3=A9s do link %{link}=

----==_mimepart_688cfbb2c55f6_1f8333fe2697396743236512
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www=
.w3.org/TR/REC-html40/loose.dtd">=0D
<html xmlns=3D"http://www.w3.org/1999/xhtml">=0D
<head>=0D
	<title></title>=0D
	<meta content=3D"text/html; charset=3Dwindows-1252" http-equiv=3D"Conten=
t-Type" /><meta name=3D"GENERATOR" content=3D"MSHTML 11.00.10570.1001" />=
=0D
</head>=0D
<body>=0D
<div style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; FONT-FAMILY: Arial=
, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: non=
e; FONT-WEIGHT: 400; COLOR: rgb(44,54,58); PADDING-BOTTOM: 15px; FONT-STY=
LE: normal; TEXT-ALIGN: center; PADDING-TOP: 15px; PADDING-LEFT: 15px; OR=
PHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; PADDING-RIGHT: 15px; BACKGRO=
UND-COLOR: rgb(242,242,242); TEXT-INDENT: 0px; font-variant-ligatures: no=
rmal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-dec=
oration-thickness: initial; text-decoration-style: initial; text-decorati=
on-color: initial"><span style=3D"BOX-SIZING: border-box; FONT-SIZE: 28px=
; FONT-FAMILY: &quot;Arial Black&quot;, sans-serif; FONT-WEIGHT: bold; FO=
NT-STYLE: italic"><strong style=3D"BOX-SIZING: border-box; FONT-WEIGHT: b=
older"><span style=3D"BOX-SIZING: border-box; COLOR: rgb(163,200,0)">Recl=
ame</span><span style=3D"BOX-SIZING: border-box; COLOR: rgb(0,122,61)">AQ=
UI</span></strong></span></div>=0D
=0D
<div style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; FONT-FAMILY: Arial=
, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: non=
e; FONT-WEIGHT: 400; COLOR: rgb(51,51,51); PADDING-BOTTOM: 20px; FONT-STY=
LE: normal; TEXT-ALIGN: left; PADDING-TOP: 20px; PADDING-LEFT: 20px; ORPH=
ANS: 2; WIDOWS: 2; LETTER-SPACING: normal; PADDING-RIGHT: 20px; TEXT-INDE=
NT: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-decor=
ation-style: initial; text-decoration-color: initial">=0D
<p style=3D"BOX-SIZING: border-box; FONT-SIZE: 16px; MARGIN: 0px">Prezado=
(a),</p>=0D
=0D
<p style=3D"BOX-SIZING: border-box; FONT-SIZE: 16px; MARGIN-TOP: 0px">Inf=
ormamos que recebemos uma reclama=C3=A7=C3=A3o registrada por um de seus =
clientes atrav=C3=A9s da plataforma<span>&nbsp;</span><strong style=3D"BO=
X-SIZING: border-box; FONT-WEIGHT: bolder">Reclame Aqui</strong>.</p>=0D
=0D
<p style=3D"BOX-SIZING: border-box; FONT-SIZE: 16px; MARGIN-TOP: 0px">Ped=
imos que verifique os detalhes da reclama=C3=A7=C3=A3o o quanto antes par=
a tomar as provid=C3=AAncias necess=C3=A1rias e evitar maiores contratemp=
os. Confira os detalhes abaixo:</p>=0D
=0D
<p style=3D"BOX-SIZING: border-box; TEXT-ALIGN: center; MARGIN: 20px 0px"=
><a href=3D"https://emailmarketing.locaweb.com.br/accounts/199841/message=
s/7/clicks/8141/7?envelope_id=3D7" rel=3D"noreferrer" style=3D"BOX-SIZING=
: border-box; FONT-SIZE: 16px; TEXT-DECORATION: none; FONT-WEIGHT: bold; =
COLOR: rgb(255,255,255); PADDING-BOTTOM: 12px; PADDING-TOP: 12px; PADDING=
-LEFT: 25px; DISPLAY: inline-block; PADDING-RIGHT: 25px; BACKGROUND-COLOR=
: rgb(0,122,61); border-radius: 5px" target=3D"_blank">ACESSE A RECLAMA=C3=
=87=C3=83O</a></p>=0D
=0D
<ul style=3D"LIST-STYLE-TYPE: none; BOX-SIZING: border-box; FONT-SIZE: 16=
px; MARGIN-TOP: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT:=
 0px; PADDING-RIGHT: 0px">=0D
	<li style=3D"BOX-SIZING: border-box"><strong style=3D"BOX-SIZING: border=
-box; FONT-WEIGHT: bolder">Data:</strong><span>&nbsp;01</span>08/2025</li=
>=0D
	<li style=3D"BOX-SIZING: border-box"><strong style=3D"BOX-SIZING: border=
-box; FONT-WEIGHT: bolder">Hor=C3=A1rio:</strong><span>&nbsp;14</span>:35=
:11</li>=0D
	<li style=3D"BOX-SIZING: border-box"><strong style=3D"BOX-SIZING: border=
-box; FONT-WEIGHT: bolder">Protocolo de registro:</strong><span>&nbsp;</s=
pan>614430455-6000519-2025</li>=0D
</ul>=0D
=0D
<p style=3D"BOX-SIZING: border-box; FONT-SIZE: 16px; MARGIN-TOP: 0px">Sol=
icitamos a especial gentileza de analisar o teor da reclama=C3=A7=C3=A3o =
e fazer sua r=C3=A9plica em at=C3=A9 24 horas.</p>=0D
</div>=0D
<div style=3D"text-align:center;"><p><span style=3D"color:#ffffff;"><span=
 style=3D"font-family:arial,helvetica,sans-serif;">Se voc=C3=AA n=C3=A3o =
deseja mais receber nossos e-mails, </span></span><span style=3D"font-fam=
ily:arial,helvetica,sans-serif;"><a href=3D"http://emailmarketing.locaweb=
.com.br/accounts/199841/unsubscribes/7/8141?emkt_c=3D1754059914&amp;emkt_v=3D=
bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw&amp;envelope_id=3D7"><span style=3D"color:#ffffff;">cancele a su=
a inscri=C3=A7=C3=A3o.</span></a></span></p></div><img src=3D"http://emai=
lmarketing.locaweb.com.br/accounts/199841/messages/7/openings/8141?envelo=
pe_id=3D7" width=3D"1" height=3D"1" border=3D"0" alt=3D"" /></body>=0D
</html>=0D

----==_mimepart_688cfbb2c55f6_1f8333fe2697396743236512--

