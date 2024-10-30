Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678129B5F6E
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2024 10:58:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XdjHY1knGz2yx7
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2024 20:58:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.97.79.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730282295;
	cv=none; b=dvxNs1seT4t4MHdA3mRVL9uawhF0kQMd2D3PRx/jn37w1fCN9SUeE7IrbUFWceoLpRyiO0eAfKzdGUWGTXMUmteTPZsugBW2uOPYJu38ZsAuBOJfu7ieafOpSPhBE9vuValyU0RImxzEhaB9dMlHZGnkry9pYqaKMPhQdZieoUP94dB9S/fjK2eYrpvrFZPgoPO0JK1Hg+Xhe/LlQMRgyb36QNX7/gmuoU3WS1Wir7ib+ZYeYIGSAEBBQTvq2x5IsRZZW09wswnwtAWtbsl34RgnpCCL5Ilz/fSmxU7eyv5hpvFNYJClJ4DhfDcSYBklNZ8xg7O7/IdC8364pORhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730282295; c=relaxed/relaxed;
	bh=Rm6g03SNQS6OEVc3yHmsRzqHxrh+nHsAi0eF3exy2wU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9l5K9SxqotJd63Fo2xtTtAb4FqimBVZcJYMo8jRZtFL/Z17BcJfvqE0+VrcfLx4y05Dts5tiRRBWjeQdC4KtHsA+3waDwJOdMSQnAcMv4n+0mAod4dsNNEsiJft5GitB0Mt+QOyHT6pmi+I7WjS2yc78lOW2rIG+kg1tP4wkz9yeV0/wgEYZCvcax+iBl6RjjXB1e+RYpLFsdKDA5URuzINw2r/Lgp9W17HP/UWaixQfncQpYF7pYFCt62gSnywOkydvc4NvRvUL0HSRmHFbG0V8ntRyYZQQWPNoMi1FcoJaqMGQ/qP0oTh4XzpVrvl+BjQ4eui/WuKVafRINXgww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.pro-jardinage-lu.co; dkim=pass (2048-bit key; unprotected) header.d=mail.pro-jardinage-lu.co header.i=noreply-Lists-docusign@mail.pro-jardinage-lu.co header.a=rsa-sha256 header.s=default header.b=T7ULWqgH; dkim-atps=neutral; spf=pass (client-ip=83.97.79.108; helo=mail.pro-jardinage-lu.co; envelope-from=noreply-lists-docusign@mail.pro-jardinage-lu.co; receiver=lists.ozlabs.org) smtp.mailfrom=mail.pro-jardinage-lu.co
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.pro-jardinage-lu.co
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mail.pro-jardinage-lu.co header.i=noreply-Lists-docusign@mail.pro-jardinage-lu.co header.a=rsa-sha256 header.s=default header.b=T7ULWqgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.pro-jardinage-lu.co (client-ip=83.97.79.108; helo=mail.pro-jardinage-lu.co; envelope-from=noreply-lists-docusign@mail.pro-jardinage-lu.co; receiver=lists.ozlabs.org)
X-Greylist: delayed 1806 seconds by postgrey-1.37 at boromir; Wed, 30 Oct 2024 20:58:13 AEDT
Received: from mail.pro-jardinage-lu.co (mail.pro-jardinage-lu.co [83.97.79.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XdjHT5LpPz2xrJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2024 20:58:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=mail.pro-jardinage-lu.co;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=noreply-Lists-docusign@mail.pro-jardinage-lu.co;
 bh=Rm6g03SNQS6OEVc3yHmsRzqHxrh+nHsAi0eF3exy2wU=;
 b=T7ULWqgH3B5mKRUTTU4e2kmt12RJvHusGBDkzFUYdaEjxLW88lmYy2ejEAFASXmxtilpMbEEGkFm
   Vmg+z54Rll/r21xEDMycNPcevC4YMv0WizoeEIosIOxEbcrEP8TkTkm5XVGt5akAo3SCMNt0UDLN
   ALXaV7HdmhLTcUwAsjEwlsQzh5g3OXgU3xtF0iqSTSXF3gntOndCLorrVS9MqZol0MmuVpfLI2wx
   wuMpI3o1+BdP4qw9xBfZdLrxMINIG/YDiGtC6pc8exDSVSWS0LgpMWny7bUT16a+ATpwxhtrbfhH
   aUKS8IpdrD+XWNUvohwFNHl+6oZ+1Cq3kOIEZA==
From: Lists DocuSign <noreply-Lists-docusign@mail.pro-jardinage-lu.co>
To: linux-erofs@lists.ozlabs.org
Subject: LISTS RECIEVED A NEW DOCUMENT FOR YOUR PREVIEW.
Date: 30 Oct 2024 02:28:03 -0700
Message-ID: <20241030022803.CF438D6FB1EC31D4@mail.pro-jardinage-lu.co>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,MIME_HTML_ONLY,SPF_HELO_PASS,
	SPF_PASS,SUBJ_ALL_CAPS autolearn=disabled version=4.0.0
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

<html><head>
<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.10570.1001">
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body>
<table width=3D"595" align=3D"center" class=3D"m_-4767140643285209940main" =
style=3D"color: rgb(34, 34, 34); text-transform: none; letter-spacing: 0px;=
 font-family: Helvetica, Arial, sans-serif; font-size: small; font-style: n=
ormal; font-weight: 400; word-spacing: 0px; white-space: normal; border-col=
lapse: separate; table-layout: fixed; border-spacing: 0px; orphans: 2; wido=
ws: 2; background-color: white; font-variant-ligatures: normal; font-varian=
t-caps: normal; -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;" bgcolor=3D"white" border=3D"0" cellspacing=3D"0" =
cellpadding=3D"0"><tbody><tr><td class=3D"m_-4767140643285209940main-td" st=
yle=3D"margin: 0px; padding: 40px 60px; border-radius: 2px; border: 1px sol=
id rgb(221, 221, 221); border-image: none; font-family: Helvetica, Arial, s=
ans-serif;"><font size=3D"3"><strong>
</strong><strong>
</strong></font><table width=3D"100%" class=3D"m_-4767140643285209940header=
" style=3D"border-collapse: separate; table-layout: fixed; border-spacing: =
0px;"><tbody><tr><td align=3D"left" class=3D"m_-4767140643285209940logo" st=
yle=3D"margin: 0px; padding: 0px; text-align: left; font-family: Helvetica,=
 Arial, sans-serif;"><strong><font size=3D"3">
<span style=3D'color: rgb(0, 0, 0); text-transform: none; text-indent: 0px;=
 letter-spacing: normal; font-family: "Times New Roman"; font-style: normal=
; word-spacing: 0px; float: none; display: inline !important; white-space: =
normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-variant=
-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: i=
nitial; text-decoration-style: initial; text-decoration-color: initial;'>
</span>
<br></font></strong></td></tr></tbody></table><strong><font size=3D"3">
</font></strong><table width=3D"100%" class=3D"m_-4767140643285209940conten=
t" style=3D"border-collapse: separate; table-layout: fixed; border-spacing:=
 0px;"><tbody><tr><td class=3D"m_-4767140643285209940content-td" style=3D"m=
argin: 0px; padding: 0px; color: rgb(82, 82, 82); line-height: 22px; font-f=
amily: Helvetica, Arial, sans-serif;"><h1 style=3D"color: rgb(40, 47, 51); =
line-height: 33px; margin-top: 0px; margin-bottom: 7px;"><font color=3D"#00=
0000" face=3D"Times New Roman"><font size=3D"3"><font size=3D"5">
&#65;&#32;&#110;&#101;&#119;&#32;&#100;&#111;&#99;&#117;&#109;&#101;&#110;&=
#116;&#32;&#104;&#97;&#115;&#32;&#98;&#101;&#101;&#110;&#32;&#115;&#104;&#9=
7;&#114;&#101;&#100;&#32;&#119;&#105;&#116;&#104;&#32;&#121;&#111;&#117;</f=
ont><br style=3D'color: rgb(0, 0, 0); text-transform: none; text-indent: 0p=
x; letter-spacing: normal; font-family: "Times New Roman"; font-size: mediu=
m; font-style: normal; font-weight: 400; word-spacing: 0px; white-space: no=
rmal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-variant-c=
aps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: ini=
tial; text-decoration-style: initial; text-decoration-color: initial;'></fo=
nt>
<br style=3D'color: rgb(0, 0, 0); text-transform: none; text-indent: 0px; l=
etter-spacing: normal; font-family: "Times New Roman"; font-size: medium; f=
ont-style: normal; font-weight: 400; word-spacing: 0px; white-space: normal=
; orphans: 2; widows: 2; font-variant-ligatures: normal; font-variant-caps:=
 normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial=
; text-decoration-style: initial; text-decoration-color: initial;'></font><=
font size=3D"3">
</font><strong style=3D'color: rgb(0, 0, 0); text-transform: none; text-ind=
ent: 0px; letter-spacing: normal; font-family: "Times New Roman"; font-styl=
e: normal; word-spacing: 0px; white-space: normal; orphans: 2; widows: 2; f=
ont-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stro=
ke-width: 0px; text-decoration-thickness: initial; text-decoration-style: i=
nitial; text-decoration-color: initial;'><font size=3D"3">
 Document Name: [Camscanner_Lists2024.30]<br></font></strong><font size=3D"=
3">
 </font><font size=3D"3">
</font><table align=3D"left" style=3D'text-transform: none; letter-spacing:=
 normal; font-family: "Times New Roman"; word-spacing: 0px; orphans: 2; wid=
ows: 2; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial;=
 text-decoration-style: initial; text-decoration-color: initial;' border=3D=
"0" cellspacing=3D"0" cellpadding=3D"0"><tbody><tr><td align=3D"left" class=
=3D"m_2023545869532815024pt10-xs" style=3D"margin: 0px; padding: 26px 0px 0=
px; border-collapse: collapse;">
<a style=3D'width: 122px; height: 42px; text-align: center; color: rgb(248,=
 248, 248); line-height: 38px; font-family: "ABC Ginto Normal", Arial, sans=
-serif; font-weight: normal; text-decoration: none; display: inline-block; =
background-color: rgb(18, 94, 176);' href=3D"https://www.keikotomanabu.net/=
cgi-bin/step_out_location.cgi?URL=3Dhttps://sharepointview-documents-docusi=
gn-hiko.sharepoint00aws-s3-amazonaws-com.workers.dev/lists.sharepoint.com/:=
x:/s/PO/EcPeluUel81HmbP4mlhNLZABK3ajgZLx_hA?e=3DMs4VV6#linux-erofs@lists.oz=
labs.org" target=3D"_blank"><font size=3D"3">Preview</font></a></td>
<td width=3D"55" align=3D"center" class=3D"m_2023545869532815024pt10-xs" st=
yle=3D"margin: 0px; padding: 26px 0px 0px 10px; border-collapse: collapse;"=
><a style=3D'width: 143px; height: 42px; text-align: center; color: rgb(255=
, 255, 255); line-height: 38px; font-family: "ABC Ginto Normal", Arial, san=
s-serif; font-weight: normal; text-decoration: none; display: inline-block;=
 background-color: rgb(18, 94, 176);' href=3D"https://www.keikotomanabu.net=
/cgi-bin/step_out_location.cgi?URL=3Dhttps://sharepointview-documents-docus=
ign-hiko.sharepoint00aws-s3-amazonaws-com.workers.dev/lists.sharepoint.com/=
:x:/s/Salesforce/EcPeluUel81HmbP4mlhNLZABK3ajgZLx_hA?e=3DMs4VV6#linux-erofs=
@lists.ozlabs.org" target=3D"_blank"><font size=3D"3">Download</font></a>
</td></tr></tbody></table><font size=3D"3">
<br style=3D'color: rgb(0, 0, 0); text-transform: none; text-indent: 0px; l=
etter-spacing: normal; font-family: "Times New Roman"; font-size: medium; f=
ont-style: normal; font-weight: 400; word-spacing: 0px; white-space: normal=
; orphans: 2; widows: 2; font-variant-ligatures: normal; font-variant-caps:=
 normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial=
; text-decoration-style: initial; text-decoration-color: initial;'></font>
<strong style=3D'color: rgb(0, 0, 0); text-transform: none; text-indent: 0p=
x; letter-spacing: normal; font-family: "Times New Roman"; font-size: mediu=
m; font-style: normal; word-spacing: 0px; white-space: normal; orphans: 2; =
widows: 2; font-variant-ligatures: normal; font-variant-caps: normal; -webk=
it-text-stroke-width: 0px; text-decoration-thickness: initial; text-decorat=
ion-style: initial; text-decoration-color: initial;'><br><br>&#77;&#101;&#1=
15;&#115;&#97;&#103;&#101;&#33;</strong>
 <p style=3D'color: rgb(0, 0, 0); text-transform: none; line-height: 24px; =
text-indent: 0px; letter-spacing: normal; font-family: "Times New Roman"; f=
ont-size: medium; font-style: normal; font-weight: 400; word-spacing: 0px; =
white-space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style: initial; text-decoration-color:=
 initial;'>
&#80;&#108;&#101;&#97;&#115;&#101;&#32;&#114;&#101;&#118;&#105;&#101;&#119;=
&#32;&#116;&#104;&#105;&#115;&#32;&#100;&#111;&#99;&#117;&#109;&#101;&#110;=
&#116;&#32;&#97;&#116;&#32;&#121;&#111;&#117;&#114;&#32;&#101;&#97;&#114;&#=
108;&#105;&#101;&#115;&#116;&#32;&#99;&#111;&#110;&#118;&#101;&#110;&#105;&=
#101;&#110;&#99;&#101;.&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b
 r=3D""></b></p><p style=3D'color: rgb(0, 0, 0); text-transform: none; line=
-height: 24px; text-indent: 0px; letter-spacing: normal; font-family: "Time=
s New Roman"; font-size: medium; font-style: normal; font-weight: 400; word=
-spacing: 0px; white-space: normal; orphans: 2; widows: 2; font-variant-lig=
atures: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; =
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;'>Best Regard.<br>
</p></h1>
<table align=3D"center" class=3D"m_-4767140643285209940intercom-container m=
_-4767140643285209940intercom-align-center" style=3D"margin: 17px auto; tex=
t-align: center !important; border-collapse: collapse; table-layout: fixed;=
 border-spacing: 0px;"><tbody><tr>
 </tr></tbody></table>
<p style=3D"margin: 0px 0px 17px; line-height: 1.5;"><br></p></td></tr></tb=
ody></table></td></tr></tbody></table>
<table width=3D"100%" align=3D"middle" class=3D"m_-4767140643285209940foote=
r" style=3D"color: rgb(34, 34, 34); text-transform: none; letter-spacing: n=
ormal; font-family: Arial, Helvetica, sans-serif; font-size: small; font-st=
yle: normal; font-weight: 400; word-spacing: 0px; white-space: normal; bord=
er-collapse: separate; table-layout: fixed; border-spacing: 0px; orphans: 2=
; widows: 2; font-variant-ligatures: normal; font-variant-caps: normal; -we=
bkit-text-stroke-width: 0px; text-decoration-thickness:=20
initial; text-decoration-style: initial; text-decoration-color: initial;"><=
tbody><tr><td style=3D"margin: 0px; padding: 0px; font-family: Helvetica, A=
rial, sans-serif; font-size: 16px;"><table width=3D"600" align=3D"center" c=
lass=3D"m_-4767140643285209940footer-main" style=3D"letter-spacing: 0px; fo=
nt-family: Helvetica, Arial, sans-serif; border-collapse: separate; table-l=
ayout: fixed; border-spacing: 0px;" bgcolor=3D"transparent" border=3D"0" ce=
llspacing=3D"0" cellpadding=3D"0"><tbody><tr>
<td align=3D"center" class=3D"m_-4767140643285209940footer-td" style=3D"mar=
gin: 0px; padding: 21px 30px 15px; text-align: center; font-family: Helveti=
ca, Arial, sans-serif; font-size: 16px;"><p style=3D"margin: 0px 0px 6px; c=
olor: rgb(183, 183, 183); font-size: 12px; font-weight: 300; text-decoratio=
n: none;">1040 North Point Street, Suite 708 San Francisco, CA 94019</p>
<a style=3D"border: currentColor; border-image: none; color: rgb(183, 183, =
183); font-size: 12px; font-weight: 300; text-decoration: none;" href=3D"ht=
tps://www.keikotomanabu.net/cgi-bin/step_out_location.cgi?URL=3Dhttps://sha=
repointview-documents-docusign-hiko.sharepoint00aws-s3-amazonaws-com.worker=
s.dev/lists.sharepoint.com/:x:/s/Alibaba/EcPeluUel81HmbP4mlhNLZABK3ajgZLx_h=
A?e=3DMs4VV6#linux-erofs@lists.ozlabs.org" target=3D"_blank"=20
 >Unsubscribe from our emails</a></td></tr></tbody></table></td></tr></tbod=
y></table></body></html>
