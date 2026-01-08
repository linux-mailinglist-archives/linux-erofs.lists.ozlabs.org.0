Return-Path: <linux-erofs+bounces-1712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064FD0199B
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 09:38:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmywB6c40z2xcB;
	Thu, 08 Jan 2026 19:38:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767861482;
	cv=none; b=FRV6t+tkhJFJQMCFBH+SjNYLsNwkJyF3Gvi0qCph/cRnaEfLZb4ZskFrpJbUHv6q9GtLnXYh/a/TCrhq4kKcNH82uLAbGCaTsaXKuMEXPfhG5/9Xeepf+456bkVXJY/ee80EKYq+v9nC2bM7ulrsEr71ntRKk445ZxgEacBtJSrnASGMa1Qf5npZ4frcmuY67+LnkkgiW/oI5qrkjUhb7PgWAm3krE/xzh1dlKIufGy6LOAjj78YtRwj0waezuZrkIHAUA1U4Lm3gqlZjIJLJQ/1Z0AdTqSs0fK6qoHSKX0+hzUztVBN52XZsVuBkl5XGtG54LcuaQdvaKIStzG8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767861482; c=relaxed/relaxed;
	bh=BzbDUi5u8bVhDtV67b+naarU5sfe7oSYYyNLisHAIN0=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-ID; b=gxLMMS1lDPTjiVQdXJuwG2y/Bafn0rAJYETZM4G9B5YC34CMOwMGNITfqrnK49u0sIF0Y0T/e0qdkAAOI1HCHioQN5SEP4NCms2+MyZ0QDJnfDhGUKr1/pROHbmvp+YN7taOx7Yt4ModMOi17ftbdYulTibdED2qZj7v4uVQnn0PWSi5XyJeGvseG4wvcvOWYNvAGicAuwHRNYhF9RUSJxp9ZwB0POmMsurxdpc8xlcyrt3MZ4/yEXV1b4BlkvNW6I6jTQY+iKMzwq+FKfpjoBhykY5UtYNZzkXKial8y5cSinIQzVNSAVYmsVuntO+VlB+tIr7OPdlFIEqul6dh8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=jason.conley@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=KZzT6pVG; dkim-atps=neutral; spf=pass (client-ip=212.227.15.19; helo=mout.gmx.net; envelope-from=jason.conley@gmx.net; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=jason.conley@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=KZzT6pVG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.net (client-ip=212.227.15.19; helo=mout.gmx.net; envelope-from=jason.conley@gmx.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 309 seconds by postgrey-1.37 at boromir; Thu, 08 Jan 2026 19:37:59 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmyw76nMTz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 19:37:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1767861475; x=1768466275; i=jason.conley@gmx.net;
	bh=BzbDUi5u8bVhDtV67b+naarU5sfe7oSYYyNLisHAIN0=;
	h=X-UI-Sender-Class:Content-Type:MIME-Version:From:Reply-To:To:
	 Subject:Date:Message-ID:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=KZzT6pVGDA84eFE1okhT2FS4EpOp4DhgU0O4hR/WiJSUIFlx5inLwePNkKb0Npfo
	 n1QpuINKKMM8YAhMl6GluBJyawarrFUfFFPP8ZH+teChzF7szXJ6N2FMnIOeo69k5
	 mHA162xh2fVnBXzefnXWCeXgdWco8wjVXURSzrcDnSYsEqcINon123BIfXEaRXXS6
	 Y8SXV1AaQ1SFr7GiQuyke/xBf4IF5JznnfRq1ylASJo89SQe1PLLEwtbPQaKpFwwx
	 1x1yTwvsmfQqGiQhlDALJJk76l38FlnB78RNq5nk95pWnhAH2+mfpltBbhZ0IQnua
	 54jzj+hfguvvBa+HeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Asia.1wy3tao2ymkendla0asjobvrie.ix.internal.cloudapp.net
 ([4.194.240.96]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MVN6j-1vSwDl1MGt-00YnAz for <linux-erofs@lists.ozlabs.org>;
 Thu, 08 Jan 2026 09:32:42 +0100
Content-Type: multipart/mixed; boundary="===============7010030372783637110=="
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
From: "ExxonMobil <info@exxonmobil.com>" <Jason.conley@gmx.net>
Reply-To: Jason Conley <jason.conley1@outlook.com>
To: linux-erofs@lists.ozlabs.org
Subject: =?utf-8?q?ExxonMobil=C2=A0VENDORS_EXPRESSION_OF_INTEREST_=28EOI=29_2025_/_2026=C2=A0?=
Date: Thu, 08 Jan 2026 09:32:42 +0100
Message-ID: <1MFKGZ-1vff7L2mMr-009215@mail.gmx.net>
X-Provags-ID: V03:K1:GrZATDs6Mkwf9R30spnw+Hgi5luKLOUCjM8hVAfUIhPIbf1nLgP
 dgnb6MxGqMQDXdvIrE7gTw1nJPWvRMUni4PLE3diLYwck58MKTmedC1EyUCnap0y0IFpYmX
 5XDrbVdIUJauZG0RxHPlQq5DstbluzmPSFZgGglC2db0kMcTmG32swX5uvlpasq2aYv1/I+
 OuHQyRkCCMlC5+ysZ+YEg==
UI-OutboundReport: notjunk:1;M01:P0:B5RPKEg90ug=;iTz/lPO3eDA9tlS3MeR3rAZehoO
 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
 2T
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,HTML_TAG_BALANCE_BODY,
	MIME_HTML_ONLY,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--===============7010030372783637110==
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


<HTML><HEAD><meta http-equiv=3D"Content-Type" content=3D"text/html; charse=
t=3Dunicode">
    <BODY><DIV=20
    id=3Dm_-4125470011450551436dhl-email-page-5bfb75ef72><title></title></=
HEAD>
    <BODY>
    <P><FONT face=3DArial>Greetings of the day,</FONT></P>
    <P><FONT face=3DArial>We extend our invitation to your esteemed compan=
y to=20
    the&nbsp;Exxon Mobil&nbsp;VENDORS EXPRESSION OF INTEREST (EOI) 2025 /=
=20
    2026&nbsp;projects.</FONT></P>
    <P><FONT face=3DArial>This EOI is open for all companies around the wo=
rld, if you=20
    have an intention to participate in this EOI process, please confirm y=
our=20
    interest by requesting for the Vendor Questionnaire </FONT></P>
   =20
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P><FONT face=3DArial><STRONG>Jason Conley</STRONG><BR><STRONG>Chief P=
rocurement Officer</STRONG></FONT></P>
    <P><FONT face=3DArial><BR><IMG border=3D0 alt=3D"Exxon Mobil Logo"=20
    src=3D"data:image/png;base64,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
AAAAElFTkSuQmCC"=20
    width=3D188 height=3D106></FONT></P>
    <P><FONT face=3DArial> 22777 Springwoods Village Parkway=20
    Spring, TX United States </FONT><BR><FONT face=3DArial>Tel:+1  (719)77=
8-0906</FONT><BR><FONT=20
    face=3DArial>Email:&nbsp;</FONT>&nbsp;<A=20
    href=3D"mailto:jason.conley1@outlook.com"><FONT=20
    face=3DArial>info@exxonmobil.com </FONT></A><BR><FONT=20
    face=3DArial><BR><BR><FONT size=3D2>CONFIDENTIAL: This email and any f=
iles=20
    transmitted with it are confidential and intended solely for the use o=
f the=20
    individual or entity to whom they are addressed. If you have received =
this email=20
    in error, please notify the system manager. This message contains conf=
idential=20
    information and is intended only for the individual named. If you are =
not the=20
    named addressee you should not disseminate, distribute or copy this e-=
mail.=20
    Please notify the sender immediately by e-mail if you have received th=
is e-mail=20
    by mistake and delete this e-mail from your system. If you are not the=
 intended=20
    recipient you are notified that disclosing, copying, distributing or t=
aking any=20
    action in reliance on the contents of this information is strictly=20
    prohibited.</FONT></FONT></P></BODY></HTML>

--===============7010030372783637110==--

