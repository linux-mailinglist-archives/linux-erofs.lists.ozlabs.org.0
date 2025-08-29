Return-Path: <linux-erofs+bounces-938-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6EB3C1EE
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Aug 2025 19:39:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cD59l2MRSz2xnv;
	Sat, 30 Aug 2025 03:39:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=190.116.59.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756489163;
	cv=none; b=P66O/g8fQdjM2d7c8+TRQ2n5yMDqnTGCAC7cmZdMauEu5NkbIzS4DImf1mkTORFzhBZDzaq1XsH8sMak6Fux2EFel4LTj98EI7wspq7iWwPYzrpdxGWLMxnWuJUE7lOfvCorOjNT+h7AGkuXOUmDyGwOSvTJ6l7v8KokFH4nSYllfdFBTkCV6QtHlg+hWjJ1XIdV3B3SEMYt2Kuwg5I1PVnPkPJ4U8QG7fPbl8D9GxU4JaCAg89bVKQaTeouFshPXQ8LbCbB2C5FAsipeygfA+Gc1ulBhsgtWR/8JqywTAI1AMiZoetUEjss6SjcDFxujwS/kGEobrqnIwCeQQMwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756489163; c=relaxed/relaxed;
	bh=IZxtw3z/9CaxWzHuOMx6eYG39iga0noJxPVFtMhYG7k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haxnResXHNHw4TUL3gS6RlEMX8eghAqIUj+mxmZjlWseOXjnfPsbDu4DjgSrL5SaqTbaazhJsuVpm6fza9b2ss33go5vrB7Xya+1dwCcijEdkadD/FklHbF9J0nUee67TzRfT+avVGP16Am3LgWyLhL9cvAOBfNc9OugeQZU6HHsbukRJIlDiLXPVxvJ0ZlUzCtLLBi04CgHTcpzuapRYGdJEudIzVVoF6fvxYOGkC8e7x/m9Nna3mH4kBd07HXO9kMgwkTMbQD0WmOiPc+Xf+2T0f23SfCEpWLUHmnu/JRDmtCzh89uFPefx6OIu/IjBeJobFs2Iwmbd3Wutm03qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=notificacionesbys.com; dkim=pass (2048-bit key; unprotected) header.d=notificacionesbys.com header.i=@notificacionesbys.com header.a=rsa-sha256 header.s=804FB474-00E8-11EF-9D29-D8BF0EF47FA2 header.b=Gxbr8pu4; dkim-atps=neutral; spf=pass (client-ip=190.116.59.194; helo=mail.notificacionesdecoperu.com; envelope-from=test@notificacionesbys.com; receiver=lists.ozlabs.org) smtp.mailfrom=notificacionesbys.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=notificacionesbys.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=notificacionesbys.com header.i=@notificacionesbys.com header.a=rsa-sha256 header.s=804FB474-00E8-11EF-9D29-D8BF0EF47FA2 header.b=Gxbr8pu4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=notificacionesbys.com (client-ip=190.116.59.194; helo=mail.notificacionesdecoperu.com; envelope-from=test@notificacionesbys.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 492 seconds by postgrey-1.37 at boromir; Sat, 30 Aug 2025 03:39:21 AEST
Received: from mail.notificacionesdecoperu.com (mail.notificacionesdecoperu.com [190.116.59.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cD59j3sGyz2xnM
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 Aug 2025 03:39:21 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTP id 191C61CD696F
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Aug 2025 12:29:01 -0500 (-05)
Received: from mail.notificacionesdecoperu.com ([127.0.0.1])
 by localhost (mail.notificacionesdecoperu.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HmJ3ub_gg4wt for <linux-erofs@lists.ozlabs.org>;
 Fri, 29 Aug 2025 12:29:00 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTP id D51591CD6973
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Aug 2025 12:29:00 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.notificacionesdecoperu.com D51591CD6973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=notificacionesbys.com; s=804FB474-00E8-11EF-9D29-D8BF0EF47FA2;
	t=1756488540; bh=IZxtw3z/9CaxWzHuOMx6eYG39iga0noJxPVFtMhYG7k=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Gxbr8pu4LfuXBlt5Wzzzo43Xc2Er8UUTg2/0Po+7+m6I9xuGyvzkKMKyCPSHxWEdJ
	 FEzpDll//3hbanUOXH2C/klEa9sONo5FWhTuW6bRuHdO5O+/3pvAMomGmFrjmxLhqo
	 3RU7RddZvAPGYPhfpU6Pn0AkzMWt4ZXvkiOCRh85BOfSMnSGNwm+hV4FwEdehKxd4R
	 DK5avcx9yua9QfvqqrNXy803EQK6L2XBGTxsoT8dNmeuL7/lCcDUlvXOR2LDTpgQQT
	 Y7iiKrCOFeibFj4MWez2pSmZfOPZ/HyTOOZwyltIx5y0EOdL9Wv5omOnwn7zu2JXYE
	 IUtNpv4G1e/Mg==
X-Virus-Scanned: amavis at notificacionesdecoperu.com
Received: from mail.notificacionesdecoperu.com ([127.0.0.1])
 by localhost (mail.notificacionesdecoperu.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NO-X7MuUKWYS for <linux-erofs@lists.ozlabs.org>;
 Fri, 29 Aug 2025 12:29:00 -0500 (-05)
Received: from [45.250.255.20] (unknown [45.250.255.30])
	by mail.notificacionesdecoperu.com (Postfix) with ESMTPSA id 4BB811CD696C
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Aug 2025 12:28:58 -0500 (-05)
Reply-To: luisfernandezconsultant@gmail.com
From: Luis Fernandez Consultant <test@notificacionesbys.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re:Mutual Investment Proposal
Date: 29 Aug 2025 19:29:48 +0200
Message-ID: <20250829192944.1CEAB0CFD2984023@notificacionesbys.com>
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
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Good Day, 


My name is Luis Fernandez, I am contacting you because we have investors th=
at have the capacity to invest in any massive project in your country or in=
vest in your existing project that requires funding. Kindly get back to me =
for more details. 


Best Regards,=20

Luis Fernandez

