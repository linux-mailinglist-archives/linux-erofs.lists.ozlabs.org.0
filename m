Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEFEA4CE07
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 23:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1741040175;
	bh=H8+6Qjc9M00FFIfUS1VQxKiaqk5I7RHzna9bLYoohmw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=h9z1sAxI4SjIEED27mhloQiE3C+hKen7WaF4BsSn0RBBvIXrZcn//WPJn8+dR3wAQ
	 umwTjcTxbDk4eOW9zLM26tuYVlPfebmMqdQgflK24g7chbh0zBpt4vp92CFFL4+N7Y
	 CVRRKMQGTuZp08h4waWkadRYiayQbqIbNIVPaka4LmPJ7isGwrMQF7MVx9ify7eXg0
	 zb6nY089gAQZUQqmFO4HYH5qAHFle/497fOn03PeiAiEa0eC4SvcV7dsBKd9W+EsUb
	 xHU0iSgmyW6AooXWI82le3nw4M2xIfxHd7RuhxkPzSv/umEJFvVl0+fzyLtuhb6YB+
	 PI4v3W28LpVtQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Cnq47LKz3bn0
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 09:16:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.159.82.73
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741040174;
	cv=none; b=lVCD+6wqQJNvOqc2BusrMmWm8QJizX9U6YyM2a/s2jFIn1GXz9bxpuMLsla66Pb0aRGzDeXR788LbX4l/fe2TIx+7XGCqAFS43QmUC1iSpApbYpHHLF6AVQglu1YEvUt8l8E4vEs1OXGSQ0YhjLn7bBZ4vRaQUJjhZFjCjUo88e+WGa3+DS1/rzgXyUKvl8OhUjE2db3vZbn8u9G4iIQALtLd3WjdqHZEXHoumtx64LcBR0Dlqq5+rbItLksI8pZ6K6IbsmapwTxmbNeiTlMnf5eWocw28bP7xw8JZtnWW8LziXZ+Mlto+aQPVIGCwI1/cQuptux0DJO4d+DPIGiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741040174; c=relaxed/relaxed;
	bh=H8+6Qjc9M00FFIfUS1VQxKiaqk5I7RHzna9bLYoohmw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbLbx+2ADR8jJRmbiErATfRwVTwJmtA5IMP2vZTucQTts9ZpltzCCKvH31Y/onIoCQOg/rhwSxvAuMiNDQkhBehSjna/5bzaCX8JmicGz0bRJdtVFRBIHVXpu7LUI5Qvz3DnogEfPbByQcMphi9WlqC98XyPfFcoS74h+tmF0ym23SlOhRbHwQlg6d2905BLE0wE8CnE55A1AIQUizMfAUI8aHJlw1BIQIDSh1eGeoSmgXY4z12SEeTyjVWiYXH/T/ZwoUNOaBAmCxrjjaiIsUwLwQ708hab0AY/g5opCJlgS2DwXGjb9fICe3q6unxDDYCJCiBQ+J1xIYRqh6brWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=tgekh.com; dkim=pass (2048-bit key; unprotected) header.d=tgekh.com header.i=@tgekh.com header.a=rsa-sha256 header.s=default header.b=GecFHhlo; dkim-atps=neutral; spf=pass (client-ip=185.159.82.73; helo=postal.tgekh.com; envelope-from=sender@tgekh.com; receiver=lists.ozlabs.org) smtp.mailfrom=tgekh.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=tgekh.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=tgekh.com header.i=@tgekh.com header.a=rsa-sha256 header.s=default header.b=GecFHhlo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tgekh.com (client-ip=185.159.82.73; helo=postal.tgekh.com; envelope-from=sender@tgekh.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 888 seconds by postgrey-1.37 at boromir; Tue, 04 Mar 2025 09:16:13 AEDT
Received: from postal.tgekh.com (postal.tgekh.com [185.159.82.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6Cnn5HKyz2y92
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 09:16:13 +1100 (AEDT)
Received: from hosted-by.tnahosting.net (unknown [169.197.131.201])
	by postal.tgekh.com (Postfix) with ESMTPSA id 8C96BD29EC
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 21:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tgekh.com;
	s=default; t=1741038959;
	bh=H8+6Qjc9M00FFIfUS1VQxKiaqk5I7RHzna9bLYoohmw=; h=From:To:Subject;
	b=GecFHhloZtanZ04j1Jopwqy+5rZEKiJKcvlQ+/zwB0BTIaIF9Q3KeH0NRbQn2l1UC
	 pzLQumx+SG/bOZOB/gwxnB5WfpXuYwWhlmmZQltf5922d6yzppFi6V2HlTk0mNtShQ
	 AvafZyRBW6gZqyO9Xj0wVPmSqU+gvQOFpxK/i3n52Vx3esbm3w8HP6UluaXxT3fBAD
	 cMnZo3c4SmL5GKIhsbaBNc9zPoSOMcZtUU+yrrtqYlOKGCzOJBD00ccSh/3qYxl50m
	 B8A/xIe299oibSjmVA3N9S68IQa0dQPFmq3MihiWkSbKRE8oxNZUUkUW5ur5Yf7Nzj
	 Oml70HO4IrQyw==
Authentication-Results: postal.tgekh.com;
        spf=pass (sender IP is 169.197.131.201) smtp.mailfrom=sender@tgekh.com smtp.helo=hosted-by.tnahosting.net
Received-SPF: pass (postal.tgekh.com: connection is authenticated)
To: linux-erofs@lists.ozlabs.org
Subject: Project Financial Support
Date: 3 Mar 2025 13:55:56 -0800
Message-ID: <20250303135556.E746BA551D09C9B7@tgekh.com>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,
	MIME_HTML_ONLY,REPTO_419_FRAUD_GM_LOOSE,SPF_HELO_NONE,SPF_PASS
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
From: Frank Dawson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: frankjody21@gmail.com
Cc: Frank Dawson <sender@tgekh.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I hope this message finds you well.<br>
<br>
My name is Frank Jody Dawson, and I am an investment consultant representin=
g private investors seeking to explore investment opportunities in various =
sectors globally. These investors are interested in partnering with busines=
ses or entrepreneurs who can demonstrate strong potential for growth and su=
ccess.<br>
<br>
They offer financing options with flexible terms and a competitive annual r=
eturn on investment of 3%. This funding can be utilized for business expans=
ion, new projects, or mergers, depending on your needs.<br>
<br>
If you are working on a promising venture or project that requires funding,=
 I would be happy to discuss the possibilities further. Please feel free to=
 respond at your convenience to explore potential collaboration.<br>
<br>
Best regards,<br>
Frank Jody Dawson=20
