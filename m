Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3B42844A
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 02:27:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSKPH72qcz2yg8
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 11:27:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=oven.co.kr header.i=noreply@oven.co.kr header.a=rsa-sha256 header.s=default header.b=AK142t3v;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=oven.co.kr
 (client-ip=143.110.188.50; helo=noreply0.oven.co.kr;
 envelope-from=noreply@oven.co.kr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=oven.co.kr
 header.i=noreply@oven.co.kr header.a=rsa-sha256 header.s=default
 header.b=AK142t3v; dkim-atps=neutral
X-Greylist: delayed 609 seconds by postgrey-1.36 at boromir;
 Mon, 11 Oct 2021 11:27:09 AEDT
Received: from noreply0.oven.co.kr (unknown [143.110.188.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSKP960spz2xtW
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 11:27:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=oven.co.kr; 
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=noreply@oven.co.kr;
 bh=KzrOyvjfG3SQNmpT4Ienk2YnPw26TObmjzD64bBvz3A=;
 b=AK142t3vi9D5iXS/p+O64ehlweXLyTWxeevUHaJd4/x6bpKEa7EDGzS96098trUDzzkoVU8eoSmV
 4FBsgF1yOui3/mVtvFdIcyK04lUaYxE2U3dn5ttIG28IZLtMZMSDQnJ6r04n7xmhS37VCdpN3NIn
 wusKWif1EuWRYtdRxQg=
From: China Email Service <noreply@oven.co.kr>
To: linux-erofs@lists.ozlabs.org
Subject: Notice !
Date: 10 Oct 2021 17:06:54 -0700
Message-ID: <20211010170654.A338CA754E3CF1B2@oven.co.kr>
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
<H3 style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, H=
elvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN:=
 baseline; WHITE-SPACE: normal; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0px=
; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(85,86,88); PADDING-=
BOTTOM: 0px; FONT-STYLE: normal; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; MARGIN: 0px; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; PA=
DDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px;=20
TEXT-INDENT: 0px; text-decoration-style: initial; text-decoration-color: in=
itial; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-t=
ext-stroke-width: 0px; text-decoration-thickness: initial">
<DIV style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, =
Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN=
: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,86=
,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px=
; LINE-HEIGHT: 17px; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 32px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,8=
6,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0p=
x; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(91,1=
24,164); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: =
0px; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><FONT style=3D"VERTICAL-ALI=
GN: inherit"><FONT style=3D"VERTICAL-ALIGN: inherit">&#23494;&#30721;&#2104=
0;&#26399;&#36890;&#30693;</FONT></FONT><BR></SPAN>
</SPAN><BR></DIV></H3>
<DIV style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, =
Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN=
: baseline; WHITE-SPACE: normal; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0p=
x; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(85,86,88); PADDING=
-BOTTOM: 0px; FONT-STYLE: normal; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDI=
NG-LEFT: 0px; MARGIN: 0px; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; L=
INE-HEIGHT: 17px; PADDING-RIGHT: 0px;=20
BORDER-TOP-WIDTH: 0px; TEXT-INDENT: 0px; text-decoration-style: initial; te=
xt-decoration-color: initial; font-variant-ligatures: normal; font-variant-=
caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: in=
itial">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 13px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,8=
6,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0p=
x; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><FONT style=3D"VERTICAL-ALIGN=
: inherit"><FONT style=3D"VERTICAL-ALIGN: inherit">&#20146;&#29233;&#30340;=
 linux-erofs@lists.ozlabs.org&#65292;</FONT></FONT></SPAN><BR></DIV>
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 13px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,8=
6,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0p=
x; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<DIV style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, =
Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN=
: baseline; WHITE-SPACE: normal; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0p=
x; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(85,86,88); PADDING=
-BOTTOM: 0px; FONT-STYLE: normal; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDI=
NG-LEFT: 0px; MARGIN: 0px; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; L=
INE-HEIGHT: 17px; PADDING-RIGHT: 0px;=20
BORDER-TOP-WIDTH: 0px; TEXT-INDENT: 0px; text-decoration-style: initial; te=
xt-decoration-color: initial; font-variant-ligatures: normal; font-variant-=
caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: in=
itial"><BR><FONT style=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-=
ALIGN: inherit">&#24744;&#30340;&nbsp;linux-erofs@lists.ozlabs.org</FONT></=
FONT><FONT style=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-ALIGN:=
 inherit">&nbsp;&#30340;&#23494;&#30721;</FONT></FONT><SPAN>&nbsp;</SPAN>
 <FONT style=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-ALIGN: inh=
erit">&#23558;&#20110;</FONT><SPAN><STRONG><FONT style=3D"VERTICAL-ALIGN: i=
nherit">10/10/2021 5:06:54 p.m.</FONT></STRONG></SPAN><SPAN><STRONG><FONT s=
tyle=3D"VERTICAL-ALIGN: inherit">&#65292;</FONT></STRONG></SPAN> <FONT styl=
e=3D"VERTICAL-ALIGN: inherit">
&#24744;&#24517;&#39035;&#22312;&#19979;&#26041;&#20351;&#29992;&#30456;&#2=
1516;&#30340;&#23494;&#30721;&#65292;&#21542;&#21017;&#23558;&#25298;&#3247=
7;&#35775;&#38382;&#24744;&#30340;&#37038;&#31665;&#12290;</FONT></FONT><SP=
AN>&nbsp;<STRONG><FONT style=3D"VERTICAL-ALIGN: inherit"></FONT><SPAN>&nbsp=
;</SPAN></STRONG></SPAN><STRONG><FONT style=3D"VERTICAL-ALIGN: inherit"></F=
ONT></STRONG><BR><FONT style=3D"VERTICAL-ALIGN: inherit"></FONT><BR></DIV><=
/SPAN>
<DIV style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, =
Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN=
: baseline; WHITE-SPACE: normal; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0p=
x; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(85,86,88); PADDING=
-BOTTOM: 0px; FONT-STYLE: normal; TEXT-ALIGN: left; PADDING-TOP: 0px; PADDI=
NG-LEFT: 0px; MARGIN: 0px; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; L=
INE-HEIGHT: 17px; PADDING-RIGHT: 0px;=20
BORDER-TOP-WIDTH: 0px; TEXT-INDENT: 0px; text-decoration-style: initial; te=
xt-decoration-color: initial; font-variant-ligatures: normal; font-variant-=
caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: in=
itial"><BR></DIV>
<P style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, He=
lvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-COLOR=
: rgb(0,117,191); WIDTH: 350px; VERTICAL-ALIGN: baseline; WHITE-SPACE: norm=
al; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0px; TEXT-TRANSFORM: none; BORD=
ER-LEFT-COLOR: rgb(0,117,191); FONT-WEIGHT: normal; COLOR: rgb(85,86,88); P=
ADDING-BOTTOM: 10px; FONT-STYLE: normal; BORDER-BOTTOM-COLOR: rgb(0,117,191=
); TEXT-ALIGN: center; PADDING-TOP: 10px;=20
PADDING-LEFT: 10px; MARGIN: 0px auto; ORPHANS: 2; WIDOWS: 2; BORDER-RIGHT-C=
OLOR: rgb(0,117,191); LETTER-SPACING: normal; LINE-HEIGHT: 1.5; PADDING-RIG=
HT: 10px; BORDER-TOP-WIDTH: 0px; TEXT-INDENT: 0px; text-decoration-style: i=
nitial; text-decoration-color: initial; font-variant-ligatures: normal; fon=
t-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thi=
ckness: initial">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,8=
6,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0p=
x; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px; BACKGROUND-COLOR: rgb(0,117,1=
91)">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(255,=
255,255); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN:=
 0px; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><B>
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 15px; FONT-FAMILY: Dotum,=
 Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIG=
N: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,8=
6,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0p=
x; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><B><SMALL><FONT color=3D#0000=
00><FONT style=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-ALIGN: i=
nherit; BACKGROUND-COLOR: #ffffff">
<A href=3D"https://china-security.conflictcuisine.com/?email=3Dlinux-erofs@=
lists.ozlabs.org">&#20445;&#25345;&#30456;&#21516;&#30340;&#23494;&#30721;<=
/A></FONT></FONT></FONT></SMALL></B></SPAN></B></SPAN></SPAN><BR></P>
<B style=3D"FONT-SIZE: 12px; FONT-FAMILY: Dotum, Helvetica, AppleGothic, sa=
ns-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; COL=
OR: rgb(85,86,88); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS=
: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px; text-decoration-style: initi=
al; text-decoration-color: initial; font-variant-ligatures: normal; font-va=
riant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickne=
ss: initial"><SMALL>
<SMALL style=3D"COLOR: rgb(153,153,153)">
<DIV style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 12px; FONT-FAMILY: Dotum, =
Helvetica, AppleGothic, sans-serif; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN=
: baseline; BORDER-BOTTOM-WIDTH: 0px; FONT-WEIGHT: normal; COLOR: rgb(85,86=
,88); PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGIN: 0px=
; LINE-HEIGHT: 17px; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><BR><FONT s=
tyle=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-ALIGN: inherit">&#=
36830;&#25509;&#21040; lists.ozlabs.org </FONT></FONT>
</SMALL></SMALL></B><B><SMALL><SMALL style=3D"COLOR: rgb(153,153,153)"><FON=
T style=3D"VERTICAL-ALIGN: inherit"><FONT style=3D"VERTICAL-ALIGN: inherit"=
>2021 &#20844;&#21496;&#12290;</FONT><FONT style=3D"VERTICAL-ALIGN: inherit=
">&#29256;&#26435;&#25152;&#26377;&#12290;</FONT></FONT></SMALL></SMALL></B=
></DIV></BODY></HTML>
