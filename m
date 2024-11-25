Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEA9D8CE0
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Nov 2024 20:34:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xxwqj4VBYz2ykZ
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Nov 2024 06:33:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.169.172.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732563231;
	cv=none; b=ZgMV67dZ9dYY/87xG9931GfDtyzDpwlLfKWAATTQ2NcnBi/rvfiSNEr2r9Zp4n+H8hhArkAFkbRZMxKyJHJZTTZuHz5Ej/FXcVNai3ZI+bghcQfbim7so8eoyAcp6wk9R4vgn2sjNj3XWRBX8XesQF2ImyUzgxScFk7+/nbsY1WOQn8jVuD3oOf99HtZekckgBCurIG21bdqs2T1SFBxB+wAsr1aN5oln3FR1c7O5ivfrzGgGmod2lvxuvnoRr3qzczDhovGKSmfoSylje0uMU6PHSqhHiUYH0zFjt8mcpXlEetTxoeuxmrdXdjy190329yEikObdmbXyfzftD3RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732563231; c=relaxed/relaxed;
	bh=sjU08lJnF8yUuUOng57OaeuzJVE7XaNZaGH2eXnNkWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ij4aEbAod2x2Z/FJh+oyxTm+fqRpu7lC1zh7Fi6EKo0lJgANGrzD8vKM1+YF9AR+eirsxfvHXJh6SAflH6rtpWN2dBIeuTx04W/bL01Y0z+K/J4bHl4QLl3loj2Nt341M2LfWcFx5gUH+ufM5VGKaRm846ZjNjciT30fqp3BATC2hMzoYjuozfK0mn1s1NewZZjGaSaMOt9rIEwGci3uPitN7G6T2h8DQEk6aQbn0CW2ABQwDpc3Ow8UTYbFgrgbGdncWCokgnCTYVPSGBpKDAQmfedWj/a+LVTz9d8Q/n3pQrvB+KzbsfVpQ1SxZw5nh9reE8r9p8q4pErAO06rbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=stormfieldcapital.com; spf=fail (client-ip=194.169.172.120; helo=wrong.brassroyale.com; envelope-from=info@stormfieldcapital.com; receiver=lists.ozlabs.org) smtp.mailfrom=stormfieldcapital.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=stormfieldcapital.com
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized) smtp.mailfrom=stormfieldcapital.com (client-ip=194.169.172.120; helo=wrong.brassroyale.com; envelope-from=info@stormfieldcapital.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1806 seconds by postgrey-1.37 at boromir; Tue, 26 Nov 2024 06:33:49 AEDT
Received: from wrong.brassroyale.com (wrong.brassroyale.com [194.169.172.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xxwqd31KFz2yKD
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Nov 2024 06:33:46 +1100 (AEDT)
From: "Steven Pilato" <info@stormfieldcapital.com >
To: linux-erofs@lists.ozlabs.org
Subject: Workable Proposal
Date: 25 Nov 2024 11:03:34 -0800
Message-ID: <20241125110333.418140EBF7910E56@stormfieldcapital.com>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_SBL_CSS,SPF_FAIL,SPF_HELO_NONE autolearn=disabled version=4.0.0
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
Reply-To: iris@brassroyale.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;">
<div dir=3D"ltr">
<div class=3D"yiv4656877892elementToProof" style=3D"color: rgb(0, 0, 0); fo=
nt-family: Arial, sans-serif; font-size: 12pt;">
Attn:&nbsp;linux-erofs.</div>
<div style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-siz=
e: 12pt;">
<br>
</div>
<div style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-siz=
e: 12pt;">I am reaching out to you because I have a serious client who want=
s to invest either as a loan or as equity. This requires a competent manage=
r with a secured and workable business plan that can turn good profit.</div=
><div style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-si=
ze: 12pt;"><br>
I look forward to hearing from you so that we can discuss your ideas and pr=
ovide you with more detailed information.</div><div style=3D"color: rgb(0, =
0, 0); font-family: Arial, sans-serif; font-size: 12pt;"><br>Sincerely</div=
><div style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-si=
ze: 12pt;">Steven Pilato</div><div class=3D"yiv4656877892elementToProof" st=
yle=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-size: 12pt=
;"></div>
</div><p><br></p>


</body></html>
