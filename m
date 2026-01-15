Return-Path: <linux-erofs+bounces-1885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD9FD23226
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 09:31:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsGRP6qm1z2xrC;
	Thu, 15 Jan 2026 19:31:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.81.113.75
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768465889;
	cv=none; b=iTXPmp8Px/Rn2pFfDayZOEuQx2kXigc3NG7CeUzDZxuriNh7dkrMLP4ODMIGx8bYpJdJ0triDBEWcYx5cA6/bxIkcTYYzeUM1RO/iPHcxbh/6P8p6nGK2WAdfwtQmE72ELfejnWMVsR5ZHYDAZkIizX73JkQvS2wnTyFRGTYKw1Hha+8n+lYlUDPQ2t6ZFkQkm7HrZKFPkC6eGwpcbvrc5XnXWhA3VN4oWdSGakJAe/i/O2dhlYmzFLB2AAaEqKmFYIwgbnvjJ6XnOc2k6gWNLfhNPjfaKjHoRRrShKuSowQJoHdAm7a/bTGOkkaBAc1s/YcMd4fwiwVGqBeF2CgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768465889; c=relaxed/relaxed;
	bh=iRthIH9Ldk58rs++b8+x+12fUKWpNUJ+TeFIWGcaR8M=;
	h=From:Subject:To:Content-Type:MIME-Version:Date:Message-Id; b=NaNGVhyWJMzjNRqqJETBgdD/CLa+7nn2gZ5EapT2ucsPI3B4m/mHvJtS/lsY8peIlw8gVF79+p+0oj6RJueEEhCJ98usIxEwSS9oXb4mJDWx74XCA2OGHRsOErQoPp1vUpXmMiwLv/eMepk1RQJWkop5xJxrZ8/veSkFwJxuM5nlImuuUKAJhqNfFuEQe0UtGFK+2QCI7Rp7fXnMjuqNsapLTbJQQJnj9Dq1Hu1AJVduxlWwdz3U1LHo2h1mwcby6H4ZxzYiJ4hkjDGzL5GJhWA4KH9P5HVG9tq+JJbXcOgd1FLZd25Hnb8/CUjpOZusrbU1lhGGleAHTxqkGazkcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=permerror header.from=juhuicheng17go.com; dkim=pass (1024-bit key; unprotected) header.d=juhuicheng17go.com header.i=newsletter@juhuicheng17go.com header.a=rsa-sha256 header.s=default header.b=Ygnkq/hU; dkim-atps=neutral; spf=pass (client-ip=185.81.113.75; helo=mail0.juhuicheng17go.com; envelope-from=newsletter@juhuicheng17go.com; receiver=lists.ozlabs.org) smtp.mailfrom=juhuicheng17go.com
Authentication-Results: lists.ozlabs.org; dmarc=permerror header.from=juhuicheng17go.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=juhuicheng17go.com header.i=newsletter@juhuicheng17go.com header.a=rsa-sha256 header.s=default header.b=Ygnkq/hU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=juhuicheng17go.com (client-ip=185.81.113.75; helo=mail0.juhuicheng17go.com; envelope-from=newsletter@juhuicheng17go.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 604 seconds by postgrey-1.37 at boromir; Thu, 15 Jan 2026 19:31:26 AEDT
Received: from mail0.juhuicheng17go.com (mail0.juhuicheng17go.com [185.81.113.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsGRL4kPHz2xqj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 19:31:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=juhuicheng17go.com;
 h=From:Subject:To:Content-Type:MIME-Version:Date:Message-Id;
 i=newsletter@juhuicheng17go.com;
 bh=iRthIH9Ldk58rs++b8+x+12fUKWpNUJ+TeFIWGcaR8M=;
 b=Ygnkq/hUAw+5AwxhYfaWPyW3kggWMeZE4qns0Ry6rdZpb3SC0JLtF5Q752m+vUmo7ayD9M3GYTz1
   rpxGHAqEG/rIBH9VnSZxa5ZRoHr0bKfV0yb61svifBysyhZMeRpdBWrptfTvMkelmt1qxRMn9Mr5
   WMHbOqVx4QFb17vHySw=
From: "Adobe Acrobat" <newsletter@juhuicheng17go.com>
Subject: You Received a New Document
To: <linux-erofs@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary="qqGD42md7Hd6gn=_dI0iK6o4ljY1O7I7uw"
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
Date: Thu, 15 Jan 2026 00:21:17 -0800
Message-Id: <20261501002117AC334222AA-A3E39FCF38@juhuicheng17go.com>
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,URIBL_BLACK
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  1.2 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
	*      [Blocked - see <https://www.spamcop.net/bl.shtml?185.81.113.75>]
	*  1.9 URIBL_ABUSE_SURBL Contains an URL listed in the ABUSE SURBL
	*      blocklist
	*      [URI: trackingservice.monday.com]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
	*      [URI: juhuicheng17go.com]
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
	*      [185.81.113.75 listed in wl.mailspike.net]
	*  0.0 HTML_MESSAGE BODY: HTML included in message
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This is a multi-part message in MIME format

--qqGD42md7Hd6gn=_dI0iK6o4ljY1O7I7uw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Edit images in PDFs.=20

See how https://trackingservice.monday.com/tracker/link?token=3DeyJhbG=
ciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGV=
neHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtY=
Tg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxW=
K6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=
=3D

|=20

Read online https://trackingservice.monday.com/tracker/link?token=3Dey=
JhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3R=
yaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5M=
WQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJ=
igxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9=
yZw=3D=3D

Hi linux-erofs@lists.ozlabs.org,
You still have a pending PDF document on our cloud. You're required to=
 access before the expiry date.

Open Document now =E2=80=BA https://trackingservice.monday.com/tracker=
/link?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI=
6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhM=
zEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F=
9NNMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGl=
zdHMub3psYWJzLm9yZw=3D=3D

Make your PDFs look their best. Crop a photo, resize an object, or rep=
lace an image altogether. It=E2=80=99s easy to make any edit you need =
=E2=80=94 without using the original file. Every fix is a quick fix wi=
th=20

Acrobat Pro DC https://trackingservice.monday.com/tracker/link?token=3D=
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL=
3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ=
5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2Nyp=
RJigxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzL=
m9yZw=3D=3D

=2E

Try it free https://trackingservice.monday.com/tracker/link?token=3Dey=
JhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3R=
yaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5M=
WQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJ=
igxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9=
yZw=3D=3D

Join the conversation

Twitter https://trackingservice.monday.com/tracker/link?token=3DeyJhbG=
ciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGV=
neHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtY=
Tg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxW=
K6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=
=3D

LinkedIn https://trackingservice.monday.com/tracker/link?token=3DeyJhb=
GciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaG=
VneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQt=
YTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigx=
WK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=
=3D=3D

Blog https://trackingservice.monday.com/tracker/link?token=3DeyJhbGciO=
iJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneH=
lwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4=
Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6j=
lpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D=


Adobe, the Adobe logo, Acrobat, and the Adobe PDF logo are either regi=
stered trademarks or trademarks of Adobe Systems Incorporated in the U=
nited States and/or other countries. All other trademarks are the prop=
erty of their respective owners.
=C2=A9 2025 AD0BE Systems Incorporated. All rights reserved.
This is a marketing email from AD0BE Systems Incorporated, 345 Park Av=
enue, San Jose, CA 95110 USA.=20

Click here https://trackingservice.monday.com/tracker/link?token=3DeyJ=
hbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3Ry=
aGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MW=
QtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJi=
gxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9y=
Zw=3D=3D

to unsubscribe.
Your privacy is important to us. Please review the=20

Privacy Policy https://trackingservice.monday.com/tracker/link?token=3D=
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL=
3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ=
5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2Nyp=
RJigxWK6jlpOHpGrFzE89lz2vgQ&r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzL=
m9yZw=3D=3D

=2E

--qqGD42md7Hd6gn=_dI0iK6o4ljY1O7I7uw
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-=
8">
  <META name=3D"viewport" content=3D"width=3Ddevice-width, initial-sca=
le=3D1"> <META name=3D"format-detection" content=3D"telephone=3Dno"><t=
itle>You Received a New Document</title>
 </head>
 <body style=3D"BACKGROUND-COLOR: #ffffff" bgColor=3D#ffffff> <P align=
=3Dleft><FONT size=3D3 face=3DArial>&nbsp;</P> <DIV gmail_quote_contai=
ner?> <DIV dir=3Dltr></FONT><table style=3D"FONT-SIZE: small; FONT-FAM=
ILY: Arial,Helvetica,sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0p=
x; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-=
STYLE: normal; BACKGROUND-COLOR: rgb(240,240,240); text-decoration-sty=
le: initial; text-decoration-color: initial; font-variant-ligatures: n=
ormal; font-variant-caps: normal" cellSpacing=3D0 cellPadding=3D0 widt=
h=3D"100%" bgColor=3D#f0f0f0 border=3D0> <tr><td style=3D"MARGIN: 0px"=
><table style=3D"WIDTH: 600px; BACKGROUND-COLOR: rgb(240,240,240)" cel=
lSpacing=3D0 cellPadding=3D0 width=3D600 align=3Dcenter bgColor=3D#f0f=
0f0 border=3D0> <tr><td style=3D"FONT-SIZE: 11px; FONT-FAMILY: Arial,H=
elvetica,sans-serif; COLOR: rgb(102,102,102); PADDING-BOTTOM: 8px; PAD=
DING-TOP: 12px; MARGIN: 0px; LINE-HEIGHT: 13px" align=3Dright><FONT si=
ze=3D3 face=3DArial>Edit images in PDFs.&nbsp;&nbsp;<A style=3D"COLOR:=
 rgb(20,115,230)" href=3D"https://trackingservice.monday.com/tracker/l=
ink?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6I=
mh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzE=
zYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9N=
NMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAb=
GlzdHMub3psYWJzLm9yZw=3D=3D" target=3D_blank data-saferedirecturl=3D""=
>See how</A>&nbsp;|&nbsp;&nbsp;<A style=3D"COLOR: rgb(20,115,230)" hre=
f=3D"https://trackingservice.monday.com/tracker/link?token=3DeyJhbGciO=
iJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneH=
lwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4=
Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6j=
lpOHpGrFzE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=
=3D=3D" target=3D_blank data-saferedirecturl=3D"">Read&nbsp;online</A>=
</FONT></TD></TR></TABLE></TD></tr><tr><td style=3D"MARGIN: 0px"><tabl=
e style=3D"WIDTH: 600px" cellSpacing=3D0 cellPadding=3D0 width=3D600 a=
lign=3Dcenter border=3D0> <tr><td style=3D"MARGIN: 0px"><table style=3D=
"WIDTH: 600px; BACKGROUND-COLOR: rgb(255,255,255)" cellSpacing=3D0 cel=
lPadding=3D0 width=3D600 align=3Dcenter bgColor=3D#ffffff border=3D0> =
<tr><td style=3D"MARGIN: 0px" vAlign=3Dtop><table cellSpacing=3D0 cell=
Padding=3D0 width=3D549 border=3D0> <tr><td style=3D"WIDTH: 30px; MARG=
IN: 0px" width=3D30><FONT size=3D3 face=3DArial>&nbsp;</FONT></td><td =
style=3D"FONT-SIZE: 14px; FONT-FAMILY: Arial,Helvetica,sans-serif; COL=
OR: rgb(51,51,51); PADDING-TOP: 25px; MARGIN: 0px; LINE-HEIGHT: 19px" =
vAlign=3Dmiddle width=3D34><FONT size=3D3 face=3DArial><IMG border=3D0=
 hspace=3D0 src=3D"https://i.gyazo.com/b5798eae82b438fc621a0965da19bc0=
c.png" width=3D32 height=3D33></FONT></td><td style=3D"WIDTH: 10px; MA=
RGIN: 0px" width=3D10><FONT size=3D3 face=3DArial>&nbsp;</FONT></td><t=
d style=3D"FONT-SIZE: 16px; FONT-FAMILY: Arial,Helvetica,sans-serif; C=
OLOR: rgb(51,51,51); PADDING-TOP: 25px; MARGIN: 0px; LINE-HEIGHT: 20px=
" vAlign=3Dtop><FONT size=3D3 face=3DArial><IMG style=3D"FONT-SIZE: 16=
px; MAX-WIDTH: 220px; FONT-FAMILY: Arial,Helvetica,sans-serif; VERTICA=
L-ALIGN: top; COLOR: rgb(51,51,51); DISPLAY: block; LINE-HEIGHT: 20px"=
 border=3D0 hspace=3D0 alt=3D"Adobe Acrobat Pro DC" src=3D"https://i.g=
yazo.com/562b798e7dabe1f8b14ac58021cb2866.png" width=3D220 height=3D30=
></FONT></TD></TR></TABLE></td><td style=3D"FONT-SIZE: 14px; FONT-FAMI=
LY: Arial,Helvetica,sans-serif; COLOR: rgb(255,255,255); MARGIN: 0px; =
LINE-HEIGHT: 19px" vAlign=3Dtop width=3D39 align=3Dright><FONT size=3D=
3 face=3DArial><IMG style=3D"VERTICAL-ALIGN: top; DISPLAY: inline-bloc=
k; BACKGROUND-COLOR: rgb(255,0,0)" border=3D0 hspace=3D0 alt=3DAdobe s=
rc=3D"https://i.gyazo.com/151ea396dc0847146aba9cc794a707c6.png" width=3D=
39 height=3D64></FONT></td><td style=3D"WIDTH: 12px; MARGIN: 0px" widt=
h=3D12><FONT size=3D3 face=3DArial>&nbsp;</FONT></TD></TR></TABLE><tab=
le style=3D"WIDTH: 600px; BACKGROUND-COLOR: rgb(255,255,255)" cellSpac=
ing=3D0 cellPadding=3D0 width=3D600 align=3Dcenter bgColor=3D#ffffff b=
order=3D0> <tr><td style=3D"WIDTH: 30px; MARGIN: 0px" width=3D30><FONT=
 size=3D3 face=3DArial>&nbsp;</FONT></td><td style=3D"FONT-SIZE: 34px;=
 FONT-FAMILY: 'Helvetica Neue Light','Helvetica Light',Helvetica,Verda=
na,Arial,sans-serif; FONT-WEIGHT: 100; COLOR: rgb(51,51,51); PADDING-B=
OTTOM: 22px; TEXT-ALIGN: center; PADDING-TOP: 22px; MARGIN: 0px; LINE-=
HEIGHT: 40px" align=3Dcenter><FONT size=3D3 face=3DArial>Hi linux-erof=
s@lists.ozlabs.org,<BR>You still have a pending PDF document on our cl=
oud. You're required to access before the expiry date.<BR><A style=3D"=
FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Arial,Helvetica,s=
ans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: non=
e; FONT-WEIGHT: 400; COLOR: rgb(20,115,230); FONT-STYLE: normal; BACKG=
ROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal" href=3D"https://trackingservice.=
monday.com/tracker/link?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e=
yJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImV=
tYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiO=
jE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;r=3Deu=
c1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D" target=3D_blank data-=
saferedirecturl=3D""><SPAN style=3D"FONT-SIZE: 16px"><SPAN style=3D"FO=
NT-SIZE: 17px"><SPAN style=3D"FONT-SIZE: 18px"><SPAN style=3D"FONT-SIZ=
E: 20px"><SPAN style=3D"FONT-SIZE: 21px"><SPAN style=3D"FONT-SIZE: 22p=
x"><SPAN style=3D"FONT-SIZE: 24px"><B>Open Document now =E2=80=BA</B><=
/SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></A><SPAN style=3D"FON=
T-SIZE: 35px"><SPAN style=3D"FONT-SIZE: 36px"><SPAN style=3D"FONT-SIZE=
: 37px"><SPAN style=3D"FONT-SIZE: 39px"><SPAN style=3D"FONT-SIZE: 40px=
"><SPAN style=3D"FONT-SIZE: 41px"><SPAN style=3D"FONT-SIZE: 43px">&nbs=
p;</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><BR></FONT></td><td=
 style=3D"WIDTH: 30px; MARGIN: 0px" width=3D30><FONT size=3D3 face=3DA=
rial>&nbsp;</FONT></TD></TR></TABLE><table style=3D"WIDTH: 600px; BACK=
GROUND-COLOR: rgb(255,255,255)" cellSpacing=3D0 cellPadding=3D0 width=3D=
600 align=3Dcenter bgColor=3D#ffffff border=3D0> <tr><td style=3D"FONT=
-SIZE: 16px; FONT-FAMILY: Arial,Helvetica,sans-serif; COLOR: rgb(20,11=
5,230); MARGIN: 0px; LINE-HEIGHT: 1px" vAlign=3Dtop><FONT size=3D3 fac=
e=3DArial><A style=3D"COLOR: rgb(20,115,230)"><BR></A></FONT></TD></TR=
></TABLE><table style=3D"WIDTH: 600px; BACKGROUND-COLOR: rgb(255,255,2=
55)" cellSpacing=3D0 cellPadding=3D0 width=3D600 align=3Dcenter bgColo=
r=3D#ffffff border=3D0> <tr><td style=3D"WIDTH: 30px; MARGIN: 0px"><FO=
NT size=3D3 face=3DArial>&nbsp;</FONT></td><td style=3D"FONT-SIZE: 14p=
x; FONT-FAMILY: Arial,Helvetica,sans-serif; COLOR: rgb(102,102,102); P=
ADDING-TOP: 26px; MARGIN: 0px; LINE-HEIGHT: 19px"><FONT size=3D3 face=3D=
Arial>Make your PDFs look their best. Crop a photo, resize an object, =
or replace an image altogether. It=E2=80=99s&nbsp;easy to make any edi=
t you need =E2=80=94 without using the original file. Every fix is a q=
uick fix with&nbsp;&nbsp;<A style=3D"TEXT-DECORATION: none; COLOR: rgb=
(20,115,230)" href=3D"https://trackingservice.monday.com/tracker/link?=
token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0d=
HBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1=
jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqD=
hv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAbGlzd=
HMub3psYWJzLm9yZw=3D=3D" target=3D_blank data-saferedirecturl=3D"">Acr=
obat Pro DC</A>.</FONT></td><td style=3D"WIDTH: 30px; MARGIN: 0px"><FO=
NT size=3D3 face=3DArial>&nbsp;</FONT></TD></tr><tr><td style=3D"WIDTH=
: 30px; MARGIN: 0px" width=3D30><FONT size=3D3 face=3DArial>&nbsp;</FO=
NT></td><td style=3D"FONT-SIZE: 16px; FONT-FAMILY: Arial,Helvetica,san=
s-serif; COLOR: rgb(20,115,230); TEXT-ALIGN: center; PADDING-TOP: 24px=
; MARGIN: 0px; LINE-HEIGHT: 20px" align=3Dcenter><FONT size=3D3 face=3D=
Arial> <DIV><A style=3D"FONT-SIZE: 16px; TEXT-DECORATION: none; FONT-F=
AMILY: Arial,Helvetica,sans-serif; WIDTH: 228px; COLOR: rgb(255,255,25=
5); TEXT-ALIGN: center; DISPLAY: inline-block; LINE-HEIGHT: 32px; BACK=
GROUND-COLOR: rgb(20,115,230); border-radius: 16px" href=3D"https://tr=
ackingservice.monday.com/tracker/link?token=3DeyJhbGciOiJIUzI1NiIsInR5=
cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla=
2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDc=
wNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2=
vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D" target=3D=
_blank data-saferedirecturl=3D""><B>Try it free</B></A></DIV></FONT></=
td><td style=3D"WIDTH: 30px; MARGIN: 0px" width=3D30><FONT size=3D3 fa=
ce=3DArial>&nbsp;</FONT></TD></tr><tr><td style=3D"WIDTH: 30px; MARGIN=
: 0px"><FONT size=3D3 face=3DArial>&nbsp;</FONT></td><td style=3D"FONT=
-SIZE: 15px; FONT-FAMILY: Arial,Helvetica,sans-serif; COLOR: rgb(102,1=
02,102); PADDING-BOTTOM: 36px; PADDING-TOP: 14px; MARGIN: 0px; LINE-HE=
IGHT: 19px" align=3Dcenter><FONT size=3D3 face=3DArial><BR></FONT></td=
><td style=3D"WIDTH: 30px; MARGIN: 0px"><FONT size=3D3 face=3DArial>&n=
bsp;</FONT></TD></TR></TABLE></TD></TR></TABLE></TD></tr><tr><td style=
=3D"MARGIN: 0px" align=3Dcenter><table style=3D"WIDTH: 600px; BACKGROU=
ND-COLOR: rgb(240,240,240)" cellSpacing=3D0 cellPadding=3D0 width=3D60=
0 align=3Dcenter bgColor=3D#f0f0f0 border=3D0> <tr><td style=3D"MARGIN=
: 0px"><table style=3D"BACKGROUND-COLOR: rgb(240,240,240)" cellSpacing=
=3D0 cellPadding=3D0 width=3D160 align=3Dleft bgColor=3D#f0f0f0 border=
=3D0> <tr><td style=3D"MARGIN: 0px" width=3D1><FONT size=3D3 face=3DAr=
ial>&nbsp;</FONT></td><td style=3D"FONT-SIZE: 12px; FONT-FAMILY: Arial=
,Helvetica,sans-serif; COLOR: rgb(102,102,102); PADDING-TOP: 20px; MAR=
GIN: 0px; LINE-HEIGHT: 12px; PADDING-RIGHT: 10px" vAlign=3Dtop><FONT s=
ize=3D3 face=3DArial><IMG style=3D"VERTICAL-ALIGN: top; DISPLAY: block=
" border=3D0 hspace=3D0 alt=3D"Enabled by Adobe Campaign" src=3D"https=
://i.gyazo.com/13a966e33043417649770831ee12cf9f.png" width=3D140 heigh=
t=3D30></FONT></TD></TR></TABLE><table style=3D"WIDTH: 400px; FLOAT: r=
ight; BACKGROUND-COLOR: rgb(240,240,240)" cellSpacing=3D0 cellPadding=3D=
0 width=3D400 align=3Dright bgColor=3D#f0f0f0 border=3D0> <tr><td styl=
e=3D"FONT-SIZE: 12px; FONT-FAMILY: Arial,Helvetica,sans-serif; COLOR: =
rgb(102,102,102); PADDING-TOP: 20px; MARGIN: 0px; LINE-HEIGHT: 12px; P=
ADDING-RIGHT: 10px" vAlign=3Dmiddle align=3Dright><FONT size=3D3 face=3D=
Arial>Join the conversation</FONT></td><td style=3D"PADDING-TOP: 20px;=
 MARGIN: 0px" width=3D16><FONT size=3D3 face=3DArial><A style=3D"COLOR=
: rgb(17,85,204)" href=3D"https://trackingservice.monday.com/tracker/l=
ink?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6I=
mh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzE=
zYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9N=
NMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAb=
GlzdHMub3psYWJzLm9yZw=3D=3D" target=3D_blank data-saferedirecturl=3D""=
><IMG style=3D"VERTICAL-ALIGN: top; DISPLAY: block" border=3D0 hspace=3D=
0 alt=3DTwitter src=3D"https://i.gyazo.com/2f2d0f17d9d4c9601bd2df9d5bd=
ec37c.png" width=3D16 height=3D16></A></FONT></td><td style=3D"MARGIN:=
 0px" width=3D10><FONT size=3D3 face=3DArial>&nbsp;</FONT></td><td sty=
le=3D"PADDING-TOP: 20px; MARGIN: 0px" width=3D16><FONT size=3D3 face=3D=
Arial><A style=3D"COLOR: rgb(17,85,204)" href=3D"https://trackingservi=
ce.monday.com/tracker/link?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ=
9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhbSIs=
ImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJpYX=
QiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;r=3D=
euc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D" target=3D_blank dat=
a-saferedirecturl=3D""><IMG style=3D"VERTICAL-ALIGN: top; DISPLAY: blo=
ck" border=3D0 hspace=3D0 alt=3DLinkedIn src=3D"https://i.gyazo.com/9a=
013d4cea0eec2a526fefdf42463d4d.png" width=3D16 height=3D16></A></FONT>=
</td><td style=3D"MARGIN: 0px" width=3D10><FONT size=3D3 face=3DArial>=
&nbsp;</FONT></td><td style=3D"PADDING-TOP: 20px; MARGIN: 0px" width=3D=
16><FONT size=3D3 face=3DArial><A style=3D"COLOR: rgb(17,85,204)" href=
=3D"https://trackingservice.monday.com/tracker/link?token=3DeyJhbGciOi=
JIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHl=
wLnRvcC9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4N=
y1jYzY4NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jl=
pOHpGrFzE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=
=3D" target=3D_blank data-saferedirecturl=3D""><IMG style=3D"VERTICAL-=
ALIGN: top; DISPLAY: block" border=3D0 hspace=3D0 alt=3DBlog src=3D"ht=
tps://i.gyazo.com/4822a94f147e52f96d9754b6aa4d2b46.png" width=3D16 hei=
ght=3D16></A></FONT></td><td style=3D"MARGIN: 0px" width=3D1><FONT siz=
e=3D3 face=3DArial>&nbsp;</FONT></TD></TR></TABLE></TD></TR></TABLE><t=
able style=3D"WIDTH: 600px; BACKGROUND-COLOR: rgb(240,240,240)" cellSp=
acing=3D0 cellPadding=3D0 width=3D600 align=3Dcenter bgColor=3D#f0f0f0=
 border=3D0> <tr><td style=3D"MARGIN: 0px" width=3D22><FONT size=3D3 f=
ace=3DArial>&nbsp;</FONT></td><td style=3D"FONT-SIZE: 11px; FONT-FAMIL=
Y: Arial,Helvetica,sans-serif; COLOR: rgb(161,161,161); PADDING-BOTTOM=
: 40px; TEXT-ALIGN: left; PADDING-TOP: 40px; MARGIN: 0px; LINE-HEIGHT:=
 14px" align=3Dleft><FONT size=3D3 face=3DArial>Adobe, the&nbsp;Adobe&=
nbsp;&nbsp;logo,&nbsp;Acrobat, and the&nbsp;Adobe&nbsp;PDF logo are ei=
ther registered trademarks or trademarks of&nbsp;Adobe&nbsp;Systems In=
corporated in the United States and/or other countries. All other trad=
emarks are the property of their respective owners.<BR><BR>&copy; 2025=
&nbsp;AD0BE&nbsp;&nbsp;Systems Incorporated. All&nbsp;rights&nbsp;rese=
rved.<BR><BR>This is a marketing email from&nbsp;AD0BE&nbsp;Systems In=
corporated, 345 Park Avenue, San Jose, CA 95110 USA.&nbsp;&nbsp;<A sty=
le=3D"TEXT-DECORATION: underline; COLOR: rgb(161,161,161)" href=3D"htt=
ps://trackingservice.monday.com/tracker/link?token=3DeyJhbGciOiJIUzI1N=
iIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC=
9ub3Nla2Vub3dhbSIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4=
NmNiZDcwNGYiLCJpYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jlpOHpGrF=
zE89lz2vgQ&amp;r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D" =
target=3D_blank data-saferedirecturl=3D"">Click here</A>&nbsp;to unsub=
scribe.<BR><BR>Your privacy is important to us. Please review the&nbsp=
;&nbsp;<A style=3D"COLOR: rgb(161,161,161)" href=3D"https://trackingse=
rvice.monday.com/tracker/link?token=3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpX=
VCJ9.eyJvcmlnaW5hbFVybCI6Imh0dHBzOi8vL3RyaGVneHlwLnRvcC9ub3Nla2Vub3dhb=
SIsImVtYWlsSWQiOiJjYmNhMzEzYS1jMTI3LTQ5MWQtYTg4Ny1jYzY4NmNiZDcwNGYiLCJ=
pYXQiOjE3Njc4ODE3NjV9.9F9NNMqDhv9F2NypRJigxWK6jlpOHpGrFzE89lz2vgQ&amp;=
r=3Deuc1#bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZw=3D=3D" target=3D_blank=
 data-saferedirecturl=3D"" span=3D"">Privacy Policy</A>.<BR><BR></FONT=
></td><td style=3D"MARGIN: 0px" width=3D22><FONT size=3D3 face=3DArial=
>&nbsp;</FONT></TD></TR></TABLE></TD></TR></TABLE><FONT size=3D3 face=3D=
Arial><BR></DIV></DIV></FONT></body>
 </html>

--qqGD42md7Hd6gn=_dI0iK6o4ljY1O7I7uw--


