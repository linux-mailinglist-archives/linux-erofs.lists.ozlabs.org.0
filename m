Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 352909D013F
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Nov 2024 23:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731796293;
	bh=aLo1JdFhN9EjzFisnq3v5YF5EXZKO0W5CxpjAwl7Fi0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=SViSox+iLGwLQp5P7V9N9XFmDkJNIreOT2BMrICK6CQSLHpzW3Z8Y2vMU54tcYRlT
	 PHJ1zhhlmJiIdpqwVlVRzRetOleF0RtYQtTZI7xuuSWlJqmo2MEssNfdwxD24aRvBw
	 me32vSivLe4SkUqjtc0FwCn+6yAh9Z8pwtat7AIADshKa+z5SoMEOOaK/07d1baLsr
	 Pug4n8Gtv0IIqJhxAtSV3XGYXlSsIaZ2jhD28T5VbCEK7BlxbOJd76TcoVYnkx31hz
	 BwtDiuW1VVuImRi9AxHvHmTd2qr3QLjHCqxZ2w4c82opLmAYlaILEMZV0DRexpCuXV
	 qxWMKSivjYLDQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XrTBs3nTdz3bXk
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 09:31:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.245.225.39
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731796291;
	cv=none; b=abHWOm8jqy0MsSiZ5YqD0V6/r2Vx4vW3g632BTTH0oQMpDZVHPbgEF/T4Jo7ApI9y2cxx16DuSlXAYQF25f/i72NWNtkQAhLz9Wq+3hYdVnBQzivEcVduj3l+HF/PoDfG3u2bCCMmYWGCFIHqpcl5nfl9wbvoVn1z+oafp6lll5YTOrBuXYp152eKulb3n6Y+y6+TVqLBqOu+RwIM1HBW6ddj4vr5uQdqoXsviGCrOdo+ZoImfnyotL/1bBk6AGUr9VwPvK/nBOBjefzo5NGzodZ7JHUEigLDmpJbEsXTmjHsK/xF6XZo4zUAv9/1XmtBIt1PLNAeD1a2f/ilKhZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731796291; c=relaxed/relaxed;
	bh=aLo1JdFhN9EjzFisnq3v5YF5EXZKO0W5CxpjAwl7Fi0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTDXbMzArcu+tQvIdvnsxf2BhNf3SLBNwlxc3tEVC2lJ7YjjTYDhOZeCZH5q4rRyyxv67hmsVwf0uiYRJgDZ5FHGy0RcigJ9utq0VKsIIgxM9ehciwe7b7Qh4aBapTG5yp0zoauMMEKhQYsQjRmGKJ1i5CNdcMujKCgI1AoiWnDrT7cJlNTyo6LIuvEBgsOtE3am4vma7d91zcvasDtDc5TLGuFI1DeJnNxBzJzCxkd/GFl8pfPtxqJkjorpxVNhbQUdfTOwtSYAs86QeXEjbu2BH+YoZIw5lZGKnkLpAVj1xTeTV/UCfhnrDvPfZ/PU8k9lOSCp3a8+KygWDKbYTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lists.ozlabs.org; spf=neutral (client-ip=172.245.225.39; helo=mail0.industechint.org; envelope-from=linux-erofs@lists.ozlabs.org; receiver=lists.ozlabs.org) smtp.mailfrom=lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=lists.ozlabs.org (client-ip=172.245.225.39; helo=mail0.industechint.org; envelope-from=linux-erofs@lists.ozlabs.org; receiver=lists.ozlabs.org)
Received: from mail0.industechint.org (mail0.industechint.org [172.245.225.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XrTBp0JB0z2xtb
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2024 09:31:29 +1100 (AEDT)
From: Zix.lists.ozlabs.org <linux-erofs@lists.ozlabs.org>
To: linux-erofs@lists.ozlabs.org
Subject: NEW ORDER NEEDED
Date: 16 Nov 2024 17:31:27 -0500
Message-ID: <20241116173127.A1754809A3249D6A@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NEUTRAL,SUBJ_ALL_CAPS,
	TO_EQ_FM_DIRECT_MX autolearn=disabled version=4.0.0
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
Reply-To: kimjones@donkingss.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;"><p><span style=3D"color: rgb(34, 34, 34); te=
xt-transform: none; text-indent: 0px; letter-spacing: normal; font-family: =
arial, sans-serif; font-size: small; font-style: normal; font-weight: 400; =
word-spacing: 0px; white-space: normal; orphans: 2; widows: 2; font-variant=
-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0=
px; text-decoration-thickness: initial; text-decoration-style: initial; tex=
t-decoration-color: initial;">
Hello Dear linux-erofs,</span><br style=3D"color: rgb(34, 34, 34); text-tra=
nsform: none; text-indent: 0px; letter-spacing: normal; font-family: Arial,=
 Helvetica, sans-serif; font-size: small; font-style: normal; font-weight: =
400; word-spacing: 0px; white-space: normal; orphans: 2; widows: 2; font-va=
riant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-wid=
th: 0px; text-decoration-thickness: initial; text-decoration-style: initial=
; text-decoration-color: initial;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">We are Interested in buying your =
product</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">Kindly send your company's latest=
 catalog and your best price list.</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">Waiting for your timely reply</sp=
an>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">Best Regards</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">Kim Jones</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">(Purchasing manager)</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">---------------------------------=
-- &nbsp;</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">DON KING PRODUCTIONS, INC.</span>=

<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">501 FAIRWAY DRIVE</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">DEERFIELD BEACH, Florida 33441, U=
S</span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<span style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0=
px; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-weight: 400; word-spacing: 0px; floa=
t: none; display: inline !important; white-space: normal; orphans: 2; widow=
s: 2; background-color: rgb(255, 255, 255); font-variant-ligatures: normal;=
 font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration=
-thickness: initial; text-decoration-style:=20
initial; text-decoration-color: initial;">Te: +1 954-447-6600</span></p></b=
ody></html>
