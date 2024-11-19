Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B889D1EBE
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 04:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731986391;
	bh=2s87e5Rq2LAawdpVLlq84Fdoi/gPr8cxng2XikNGzZo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=agrW1e4axWyqPUledJHrYZakKjTbH/Fe6pcHKH0xewFf0CRcn0bjZYNY1EixXBY2h
	 H2c3fTA1nXShHLsiaW1U2rJud7MlDN/jf/u2Cg9iohPaAQvYx4jSJ+CynSekg9vMT/
	 ORtdqewqqqPE4SV7+6ZH1iqLGqrPVgVNBg1ZE+9mUv4ovRwfLCQAFm6xekRQBl2vc4
	 UYjTOu5J6QYB7AdVvtu6auGaLIYxuJpJPShMCqfpf2nkCHyBpIzAD5XJN4fu0GfaoG
	 9We3ZSXmkX0ymu/yF6j2x4UcDKix8tYtKAcTxZy6jcDRv6tuvbU0tkSXkWCcz4h3oj
	 pqwRJAZaTEUvA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsqVb128Rz30g3
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 14:19:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.245.225.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731986389;
	cv=none; b=eOan9dGsG9OqGEB3nTPjr8TsmCeVChCEm16YQdr0Rr9HZAm1RmBDi8CZx1tWjYFzeyli4qbc9qthVbjljITHTPt0mSSgefO3NNscXVF1r0cnVuA8oQZQ7SXpD/jVeepeBKnm1Lk3vDBtC+s8cGUXY8rpReVkxsKWeXJ8jM48S4nhiRD3GDV+UeLammffrKRuzPQPs6awdUpbFMmfPzf5grswtaw4O0Gitb6NYkstq4iU26RWu9DsdHUG2eNfCF4jt3buuFoNewcp/MQunBNieMVDcHn49NOXqVsFQMspBkeF4nZl39gMdvuL5ALjDk8fVL2Hm8rG59mimrrRePcwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731986389; c=relaxed/relaxed;
	bh=2s87e5Rq2LAawdpVLlq84Fdoi/gPr8cxng2XikNGzZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQmyNAcrORhg3U7nd5PLiI49Y9EF2wN3kW1IZTRSCgPysBjjI4CDvEwXMpJ33f8L0wWNy8lj/Ruc8xVsFCjRHhYImteQTavrpYFkeJkCQWYJnL5L8+nBy0YewZHU/KX8KFCkqDog/rrbh5VtarfTunEmcygWTdUVgBNzvFaASbcdOQYO+Sb8W/f3V3B3j0gpq2/p1+KzmNJ41TsX2r+U1IDxeq49JT/H0y1Hq7izswsww9DCIRPvw0jwZNYFd3s/Wv7Zv5P6IbUFRB4wiWGWBG+Kk9eVZQ+wFBgh3ye+3mPkC7fROiqBWsrFZscgNVyyPPnt+5nXUFlaQBv69D5qhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lists.ozlabs.org; spf=neutral (client-ip=172.245.225.44; helo=mail4.industechint.org; envelope-from=linux-erofs@lists.ozlabs.org; receiver=lists.ozlabs.org) smtp.mailfrom=lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=lists.ozlabs.org (client-ip=172.245.225.44; helo=mail4.industechint.org; envelope-from=linux-erofs@lists.ozlabs.org; receiver=lists.ozlabs.org)
Received: from mail4.industechint.org (mail4.industechint.org [172.245.225.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsqVX3TGtz2yF4
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 14:19:47 +1100 (AEDT)
From: Zix.lists.ozlabs.org <linux-erofs@lists.ozlabs.org>
To: linux-erofs@lists.ozlabs.org
Subject: Urgent Order
Date: 18 Nov 2024 22:19:45 -0500
Message-ID: <20241118221945.43432D1E262BAFBC@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NEUTRAL,TO_EQ_FM_DIRECT_MX
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
Reply-To: alfred.dr@alfred-drs.cam
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;"><p><span style=3D'color: rgb(34, 34, 34); te=
xt-transform: none; text-indent: 0px; letter-spacing: normal; font-family: =
"times new roman", serif; font-size: small; font-style: normal; font-weight=
: 400; word-spacing: 0px; white-space: normal; orphans: 2; widows: 2; font-=
variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-w=
idth: 0px; text-decoration-thickness: initial; text-decoration-style: initi=
al; text-decoration-color: initial;'>
<font color=3D"#000000">Hello linux-erofs,</font></span>
<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-indent: 0px=
; letter-spacing: normal; font-family: Arial, Helvetica, sans-serif; font-s=
ize: small; font-style: normal; font-weight: 400; word-spacing: 0px; white-=
space: normal; orphans: 2; widows: 2; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial; text-decoration-color: initi=
al;">
<br>Could you help us source for the product we need </p><p>kindly contact =
me directly for more detail</p><p>Waiting for your timely reply</p><p>Best =
Regards</p><p>
Dr. Alfred<br style=3D"color: rgb(34, 34, 34); text-transform: none; text-i=
ndent: 0px; letter-spacing: normal; font-family: Arial, Helvetica, sans-ser=
if; font-size: small; font-style: normal; font-weight: 400; word-spacing: 0=
px; white-space: normal; orphans: 2; widows: 2; font-variant-ligatures: nor=
mal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decora=
tion-thickness: initial; text-decoration-style: initial; text-decoration-co=
lor: initial;">
</p></body></html>
