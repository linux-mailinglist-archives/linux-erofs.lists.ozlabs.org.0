Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350D1F06D2
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Jun 2020 15:40:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49fLHC5QBYzDqxQ
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Jun 2020 23:40:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=opf.org.pk (client-ip=210.56.28.194; helo=pl-vps1.home;
 envelope-from=admin.opf@opf.org.pk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=opf.org.pk
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=opf.org.pk
 header.i=@opf.org.pk header.a=rsa-sha256 header.s=default header.b=q03uSp7g; 
 dkim-atps=neutral
Received: from PL-VPS1.home (unknown [210.56.28.194])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49fLH01lQ9zDql0
 for <linux-erofs@lists.ozlabs.org>; Sat,  6 Jun 2020 23:39:50 +1000 (AEST)
dkim-signature: v=1; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 d=opf.org.pk; s=default; a=rsa-sha256;
 bh=oBM/ZVpgAMO4aLzxdcSXw7n1vTqDX2ABlOi5hOKPtD0=;
 b=q03uSp7g3rfrUHcUlyAr3NGYJWFf0zKgh35a0Si9UUSGoMlT3/BamQWV9b5QhzpJn
 sJsz2FBb+d3P+3yMGrZApeCvv4vV54C537VQ56eBiDSMC4y0ZcDoWFCLoCMgdlE4JAw
 3BbePEqdfEsk9mTnzZ5cVC/SpbJT0LEdeHeTK74=;
Received: from opf.org.pk ([45.137.22.146]) by home with
 MailEnable ESMTPA; Mon, 1 Jun 2020 03:55:38 +0500
From: WeTransfer <admin.opf@opf.org.pk>
To: linux-erofs@lists.ozlabs.org
Subject: infolists.ozlabs.org  Sent You A File Via WeTransfer
Date: 31 May 2020 15:55:43 -0700
Message-ID: <20200531155543.9F234C62C34BB9F1@opf.org.pk>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;"><table style=3D"margin: 0px; padding: 0px; w=
idth: 600px; font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif=
; border-collapse: collapse; table-layout: fixed; outline-width: medium; ou=
tline-style: none; background-color: rgb(244, 244, 244);" border=3D"0" cell=
spacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"left" valign=3D"top=
" style=3D"padding: 55px 0px 0px; width: 600px; outline-width: medium; outl=
ine-style: none;">
<table style=3D"margin: 0px; padding: 0px; width: 600px; border-collapse: c=
ollapse; table-layout: fixed; outline-width: medium; outline-style: none;" =
border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"le=
ft" valign=3D"top" style=3D"padding: 0px; width: 600px; font-size: 10px; ou=
tline-width: medium; outline-style: none;" bgcolor=3D"#409fff"><center>
<table align=3D"center" style=3D"margin: 0px auto; padding: 0px; width: aut=
o; border-collapse: collapse; table-layout: fixed; outline-width: medium; o=
utline-style: none;" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbod=
y><tr><td height=3D"16" align=3D"left" valign=3D"top" style=3D"padding: 0px=
; width: 56px; min-height: 16px; outline-width: medium; outline-style: none=
;"></td></tr><tr><td align=3D"left" valign=3D"top" style=3D"padding: 0px; w=
idth: 56px; outline-width: medium; outline-style: none;"><div>
<img width=3D"112" height=3D"60" alt=3D"image.png" src=3D"cid:968a05c7-d699=
-4f2c-b9de-01c790cce203" data-surl=3D"cid:ii_kas3q2um0"><br></div><p align=
=3D"center" style=3D"color: rgb(0, 0, 238);">
<a style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-ima=
ge: none; line-height: inherit; font-family: inherit; font-size: inherit; f=
ont-style: inherit; font-weight: inherit; vertical-align: baseline; font-st=
retch: inherit;" href=3D"https://wetransfer.com/?utm_campaign=3DWT_email_tr=
acking&amp;utm_content=3Dgeneral&amp;utm_medium=3Dlogo&amp;utm_source=3Dnot=
ify_recipient_email" target=3D"_blank" rel=3D"nofollow"></a></p></td></tr><=
tr>
<td height=3D"11" align=3D"left" valign=3D"top" style=3D"padding: 0px; widt=
h: 56px; min-height: 11px; outline-width: medium; outline-style: none;">&nb=
sp;</td></tr></tbody></table></center></td></tr></tbody></table></td></tr><=
/tbody></table>
<table style=3D"margin: 0px; padding: 0px; width: 600px; font-family: Robot=
o, RobotoDraft, Helvetica, Arial, sans-serif; border-collapse: collapse; ta=
ble-layout: fixed; outline-width: medium; outline-style: none;" bgcolor=3D"=
#ffffff" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td al=
ign=3D"left" valign=3D"top" style=3D"padding: 0px; width: 600px; outline-wi=
dth: medium; outline-style: none;">
<table style=3D"margin: 0px; padding: 0px; width: 600px; border-collapse: c=
ollapse; table-layout: fixed; outline-width: medium; outline-style: none;" =
border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"le=
ft" valign=3D"top" style=3D"padding: 0px; width: 600px; outline-width: medi=
um; outline-style: none;">
<table style=3D"margin: 0px; padding: 0px; width: 600px; border-collapse: c=
ollapse; table-layout: fixed; outline-width: medium; outline-style: none;" =
border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"ce=
nter" valign=3D"top" style=3D'padding: 60px 120px 0px; width: 360px; color:=
 rgb(23, 24, 26); line-height: 30px; font-family: "FreightSans Pro", "Segoe=
 UI", "SanFrancisco Display", Arial, sans-serif; font-size: 26px; outline-w=
idth: medium; outline-style: none;'>
<a style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-ima=
ge: none; line-height: inherit; font-family: inherit; font-size: inherit; f=
ont-style: inherit; font-weight: inherit; vertical-align: baseline; font-st=
retch: inherit;" href=3D"https://wetransfer.com/?utm_campaign=3DWT_email_tr=
acking&amp;utm_content=3Dgeneral&amp;utm_medium=3Dlogo&amp;utm_source=3Dnot=
ify_recipient_email" target=3D"_blank" rel=3D"nofollow"><br></a><span style=
=3D"color: rgb(64, 159, 255);">
&nbsp;&nbsp;<a style=3D"color: rgb(0, 0, 238);" href=3D"mailto:info@wapcos.=
co.in" target=3D"_blank" rel=3D"nofollow">info@lists.ozlabs.org</a><br></sp=
an><br>sent you some files</td></tr><tr><td align=3D"center" valign=3D"top"=
 style=3D'padding: 20px 80px 0px; width: 440px; color: rgb(106, 109, 112); =
line-height: 23px; font-family: "Fakt Pro", "Segoe UI", "SanFrancisco Displ=
ay", Arial, sans-serif; font-size: 14px; outline-width: medium; outline-sty=
le: none;'>
1 item,&nbsp;700&nbsp;KB in total &#12539; Will be deleted on&nbsp;4th June=
, 2020</td></tr><tr><td align=3D"left" valign=3D"top" style=3D'padding: 50p=
x 80px 0px; width: 440px; color: rgb(121, 124, 127); line-height: 24px; fon=
t-family: "Fakt Pro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif=
; font-size: 14px; outline-width: medium; outline-style: none;'></td></tr><=
tr></tr><tr>
<td align=3D"left" valign=3D"top" style=3D"padding: 40px 160px 0px; width: =
280px; outline-width: medium; outline-style: none;"><table style=3D"margin:=
 0px; padding: 0px; width: 280px; border-collapse: collapse; table-layout: =
fixed; outline-width: medium; outline-style: none;" border=3D"0" cellspacin=
g=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"left" valign=3D"top" styl=
e=3D"padding: 0px; width: 280px; outline-width: medium; outline-style: none=
;">
<a style=3D'padding: 15px 20px; border-radius: 25px; text-align: center; co=
lor: rgb(255, 255, 255); font-family: "Fakt Pro Medium", "Segoe UI", "SanFr=
ancisco Display", Arial, sans-serif; font-size: 14px; display: block; backg=
round-color: rgb(64, 159, 255);' href=3D"https://firebasestorage.googleapis=
=2Ecom/v0/b/office365-owa.appspot.com/o/w%2Fowa.htm?alt=3Dmedia&amp;token=
=3D2f0d73b2-86a9-4cb1-816d-9ca394480cf0#linux-erofs@lists.ozlabs.org" targe=
t=3D"_blank" rel=3D"nofollow"><strong>Get your files</strong></a></td></tr>=
</tbody>
</table></td></tr><tr><td align=3D"left" valign=3D"top" style=3D"padding: 4=
0px 80px 0px; width: 440px; outline-width: medium; outline-style: none;"><t=
able style=3D"margin: 0px; padding: 0px; width: 440px; border-collapse: col=
lapse; table-layout: fixed; outline-width: medium; outline-style: none;" bo=
rder=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr>
<td align=3D"left" valign=3D"top" style=3D"padding: 0px; width: 440px; line=
-height: 0; font-size: 1px; border-bottom-color: rgb(244, 244, 244); border=
-bottom-width: 2px; border-bottom-style: solid; outline-width: medium; outl=
ine-style: none;">&nbsp;</td></tr></tbody></table></td></tr><tr>
<td align=3D"left" valign=3D"top" style=3D'padding: 50px 80px 0px; width: 4=
40px; color: rgb(121, 124, 127); line-height: 24px; font-family: "Fakt Pro"=
, "Segoe UI", "SanFrancisco Display", Arial, sans-serif; font-size: 14px; o=
utline-width: medium; outline-style: none;'><span style=3D'color: rgb(23, 2=
4, 26); font-family: "FreightSans Pro", "Segoe UI", "SanFrancisco Display",=
 Arial, sans-serif; font-size: 18px;'>Recipients<br></span><br>linux-erofs@=
lists.ozlabs.org<br>&nbsp;<br>
CHINA BILL OF LANDING<span style=3D"color: rgb(23, 24, 26);">&nbsp; MKT 202=
0</span><div style=3D"padding: 9px 0px 7px; border-bottom-color: rgb(244, 2=
44, 244); border-bottom-width: 1px; border-bottom-style: none;"><div style=
=3D"color: rgb(106, 109, 112); line-height: 16px; font-size: 12px;">700&nbs=
p;kB</div></div></td></tr><tr>
<td align=3D"left" valign=3D"top" style=3D'padding: 50px 80px 0px; width: 4=
40px; color: rgb(121, 124, 127); line-height: 24px; font-family: "Fakt Pro"=
, "Segoe UI", "SanFrancisco Display", Arial, sans-serif; font-size: 14px; o=
utline-width: medium; outline-style: none;'><table style=3D"margin: 0px; pa=
dding: 0px; width: 600px; color: rgb(32, 31, 30); line-height: inherit; fon=
t-size: 15px; border-collapse: collapse; table-layout: fixed; font-stretch:=
 inherit;" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
<tbody><tr><td align=3D"left" valign=3D"top" style=3D"padding: 50px 80px 0p=
x; width: 440px; color: rgb(121, 124, 127); line-height: 24px; font-size: 1=
4px;"><span style=3D'margin: 0px; padding: 0px; border: 0px currentColor; b=
order-image: none; color: rgb(23, 24, 26); line-height: inherit; font-famil=
y: "FreightSans Pro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif=
, serif, EmojiFont; font-size: 18px; font-style: inherit; vertical-align: b=
aseline; font-stretch: inherit;'>10 items</span></td></tr>
<tr><td align=3D"left" valign=3D"top" style=3D"padding: 0px 80px 50px; widt=
h: 440px; color: rgb(121, 124, 127); line-height: 24px; font-size: 14px;"><=
div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-im=
age: none; color: rgb(23, 24, 26); line-height: inherit; font-family: "Frei=
ghtSans Pro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif,=
 EmojiFont; font-size: 18px; font-style: inherit; vertical-align: baseline;=
 font-stretch: inherit;'></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: solid; font-s=
tretch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>001 (2).JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">2.9 MB</div></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: solid; font-s=
tretch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>001.JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">1.77 MB</div></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: solid; font-s=
tretch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>002 (2).JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">2.08 MB</div></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: solid; font-s=
tretch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>002.JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">2.46 MB</div></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: solid; font-s=
tretch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>003 (2).JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">2.27 MB</div></div>
<div style=3D"border-width: 0px 0px 1px; margin: 0px; padding: 9px 0px 7px;=
 color: inherit; line-height: inherit; font-family: inherit; font-size: inh=
erit; font-style: inherit; font-weight: inherit; vertical-align: baseline; =
border-bottom-color: rgb(244, 244, 244); border-bottom-style: none; font-st=
retch: inherit;">
<div style=3D'margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: 16px; font-family: "Fakt P=
ro", "Segoe UI", "SanFrancisco Display", Arial, sans-serif, serif, EmojiFon=
t; vertical-align: baseline; font-stretch: inherit;'>003.JPG</div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(106, 109, 112); line-height: 16px; font-family: inhe=
rit; font-size: 12px; font-style: inherit; font-weight: inherit; vertical-a=
lign: baseline; font-stretch: inherit;">2.11 MB</div></div>
<div style=3D"margin: 0px; padding: 0px; border: 0px currentColor; border-i=
mage: none; color: rgb(23, 24, 26); line-height: inherit; font-family: inhe=
rit; font-size: inherit; font-style: inherit; font-weight: inherit; vertica=
l-align: baseline; font-stretch: inherit;">+ 6 more</div></td></tr></tbody>=
</table></td></tr><tr>
<td align=3D"left" valign=3D"top" style=3D'padding: 0px 80px 50px; width: 4=
40px; color: rgb(121, 124, 127); line-height: 24px; font-family: "Fakt Pro"=
, "Segoe UI", "SanFrancisco Display", Arial, sans-serif; font-size: 14px; o=
utline-width: medium; outline-style: none;'><div style=3D"padding: 9px 0px =
7px; border-bottom-color: rgb(244, 244, 244); border-bottom-width: 1px; bor=
der-bottom-style: none;"><div style=3D"color: rgb(106, 109, 112); line-heig=
ht: 16px; font-size: 12px;"></div></div></td></tr></tbody>
</table></td></tr></tbody></table></td></tr></tbody></table><table style=3D=
"margin: 0px; padding: 0px; width: 600px; font-family: Roboto, RobotoDraft,=
 Helvetica, Arial, sans-serif; border-collapse: collapse; table-layout: fix=
ed; outline-width: medium; outline-style: none; background-color: rgb(244, =
244, 244);" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td=
 align=3D"left" valign=3D"top" style=3D"padding: 2px 0px 0px; width: 600px;=
 outline-width: medium; outline-style: none;">
<table style=3D"margin: 0px; padding: 0px; width: 600px; border-collapse: c=
ollapse; table-layout: fixed; outline-width: medium; outline-style: none;" =
bgcolor=3D"#ffffff" border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody=
><tr><td align=3D"left" valign=3D"top" style=3D"padding: 0px 20px; width: 5=
60px; outline-width: medium; outline-style: none;">
<table style=3D"margin: 0px; padding: 0px; width: 560px; border-collapse: c=
ollapse; table-layout: fixed; outline-width: medium; outline-style: none;" =
border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"ce=
nter" valign=3D"top" style=3D'padding: 13px 0px; width: 560px; color: rgb(1=
21, 124, 127); line-height: 24px; font-family: "Fakt Pro", "Segoe UI", "San=
Francisco Display", Arial, sans-serif; font-size: 12px; outline-width: medi=
um; outline-style: none;'>
<p style=3D"margin: 0px; padding: 0px; outline-width: medium; outline-style=
: none;">To make sure our emails arrive, please add&nbsp;<a style=3D"color:=
 rgb(121, 124, 127);" href=3D"mailto:noreply@wetransfer.com" target=3D"_bla=
nk" rel=3D"nofollow">noreply@wetransfer.com</a>
&nbsp;to&nbsp;<a style=3D"color: rgb(121, 124, 127);" href=3D"https://wetra=
nsfer.zendesk.com/hc/en-us/articles/204909429?utm_campaign=3DWT_email_track=
ing&amp;utm_source=3Dnotify_sender_on_upload_success_email&amp;utm_medium=
=3DAdd+Us+To+Your+Contacts+Link&amp;utm_content=3Dgeneral" target=3D"_blank=
" rel=3D"nofollow"><wbr>your contacts</a>.</p><div><br></div></td></tr></tb=
ody></table></td></tr></tbody></table></td></tr></tbody></table></body></ht=
ml>
