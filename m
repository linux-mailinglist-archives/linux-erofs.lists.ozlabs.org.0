Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3FC999A23
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 04:14:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPqv32xFtz3bmf
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 13:14:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.23.173.77
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728612857;
	cv=none; b=NjHGHqksHiDUUn3yVb8PTQqOaCz/oy+x3V0Tx82Ea5kR/ZYmV/X5+86su2rLMMTeUzsgnjIQtMwlFeTsQxPVnSQgeE8LA1+vFn4kcIoB61g+sWJMVo3CDJx39CkyPm4FAdF2YclcGWqHJh5eTLXiRxrA/d2D3EMk8lJenpxk38fspqDeMHtQsNVPaIPwZXTAp6mRTKY/g3kfFXPHc59hVOHWPYzZRrp4NWRAjnTTsWlz8F8P7wNxp+AjtysPLVYAby8ypD5y+zEJWuRxS2VFsRk8sujESUXkiFaGtSVpL52MqZca2CpFbHV624S5YQA/DvUDOTYDJYRVUCEK4hDLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728612857; c=relaxed/relaxed;
	bh=sYeB8bVrJLW8xxvEELpxX897WetALVu4WRgqMOVDwCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSH0KkcxDjXyzu+IFeQG82vLwGbenMTA5McsG29xNmSAgXFsxwGoDyM8rgKOk4qZApfZX4xbHr/flMf+A6bL4m8AuMPhydWD4uUQ0R1YXASmcMCgsNLB+Pjx92VAlb5TV2D/GScZ3R1gTBw8NTrlnGZWgQWScB52BIvdBKdb7OTwSrRp5y5gSR3FPvkMTAZqZiCdVvL8xW2MOBE5Jta1LzJ+awSf0Aw5YQNBXe/23ws0mqIkEPDAJC7FMTurUvcGxldCHz589ej9vC/F2o5ZdlS/Ss2puvoT6utKoEJnH9LAQfGxtzcMNZCzf+JPbnGhgECY3Dbo7HMRG3DDcSKDYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sumeria.cloudns.ph; dkim=pass (2048-bit key; unprotected) header.d=sumeria.cloudns.ph header.i=mail@sumeria.cloudns.ph header.a=rsa-sha256 header.s=dkim header.b=4bK2Dk+k; dkim-atps=neutral; spf=pass (client-ip=198.23.173.77; helo=sumeria.cloudns.ph; envelope-from=mail@sumeria.cloudns.ph; receiver=lists.ozlabs.org) smtp.mailfrom=sumeria.cloudns.ph
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sumeria.cloudns.ph
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sumeria.cloudns.ph header.i=mail@sumeria.cloudns.ph header.a=rsa-sha256 header.s=dkim header.b=4bK2Dk+k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sumeria.cloudns.ph (client-ip=198.23.173.77; helo=sumeria.cloudns.ph; envelope-from=mail@sumeria.cloudns.ph; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Fri, 11 Oct 2024 13:14:11 AEDT
Received: from sumeria.cloudns.ph (sumeria.cloudns.ph [198.23.173.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPqtq31Lrz2yNj
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 13:14:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=sumeria.cloudns.ph;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=mail@sumeria.cloudns.ph;
 bh=sYeB8bVrJLW8xxvEELpxX897WetALVu4WRgqMOVDwCQ=;
 b=4bK2Dk+kG1YVZqJj4L3utRFyuhhjwZ2fBWHcbUnqbWvDpnDIOuO3P6unIF9JrRIHOq8yhS+ixPGr
   F2D2Hoh9k4KHyWiSJOMY0u7E2KhPviUV/9xlYayaRHHeQxwxq8uO9cAJl+f8wVcayaN6nNN73FFD
   A+ASBuhB7nQp533psYYBhceQk/TqQBatrX7Ne2KR+okF/G4X4dCna5NijOU385AEysjv4bEH6Kjn
   3YKQEDD9v4iKdZpuy9eLKG28NGJs8muD4B9IiNyLXYel6zUF1HRSe/n3QKfCv9Yk7ZC64AmX0Q1l
   y+rE0/7/hlr0+94F6RWOIAyt/XmDpnWP+3iV8w==
From: "Andre Xavi" <mail@sumeria.cloudns.ph>
To: linux-erofs@lists.ozlabs.org
Subject: Can you ship to luxembourg?
Date: 11 Oct 2024 04:04:02 +0200
Message-ID: <20241011040401.E993EB9C22FB3777@sumeria.cloudns.ph>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_REPLYTO,HTML_MESSAGE,MIME_HTML_ONLY,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.0
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
Reply-To: sumeriageneraltradingluxembourg@ukr.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;"><p align=3D"justify">
Sumeria General Trading, your trusted partner in providing high-<br>quality=
 goods and services from around the world. Our company is<br>based in the v=
ibrant city of Barcelona, Spain, and we work with<br>clients and suppliers =
in many countries, including the Middle<br>East, Europe, China, Brazil, and=
 Southeast Asia.</p><p align=3D"justify">With the help of our sourcing agen=
t, we got to know about your<br>company. We want to do business with you.</=
p><p align=3D"justify">
Do you ship directly to luxembourg?</p><p align=3D"justify">Andre Xavi<br><=
a href=3D"mailto:sumeriageneraltradingluxembourg@ukr.net">sumeriageneraltra=
dingluxembourg@ukr.net</a><br>C/ de Fran&ccedil;a, 22<br>08024, Barcelona<b=
r>Spain<br>+34 66 520 39 65</p><p align=3D"justify">


<br></p></body></html>
