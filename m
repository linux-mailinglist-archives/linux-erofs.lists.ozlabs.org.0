Return-Path: <linux-erofs+bounces-1165-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E1BCB600
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Oct 2025 03:53:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjVBl3q6lz2yrT;
	Fri, 10 Oct 2025 12:53:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.69.209.167
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760061199;
	cv=none; b=eGWZXw5CYZQqY3kuSDZqHN2XdB8iUP+SZlqdaBxMJ9PCpAokCj2eaGmDhQm3R5pjKSVnmGu7N1xBSElbxKqVrzG8qTR6c3gxyPHnfjGkTn+3N0N7l2NualRkE/iTNd6opeoc4s3mZDiS/57F4IWxCaDkfIJOZ2EbHisM7n9Ge+pOOm951RfiOQiRHYGeG8x7B4XzGwl5/KKgUftfh75XnnwLKyNgXBbw5/0JPeMaSuiG4CvWz3ZhUQ1c1aBxlOOFw8bb1ZgAS3aq4Q8RptXXB6VeXKJ1HmgsHFgjB0Wb+XYcHYJY7R6bAA1F7uroP7fEV2GMOLo9I608ttxvXoXHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760061199; c=relaxed/relaxed;
	bh=MsmS3qXUa1oBBGiJ2yNc5LQza5NPnJrt2vBAKL5AR50=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=IddTx29hVnNjytykwhy8FRBQ27CfSxMI7iyyJthXUbo0arF+aM6EwboOggLtfBGQM1c5759pRR+4gQzMjet7B10gZBlIY84TlGjZ4P0c9QCEnsOCcjMTzx8+TF95aP13ogMMBvkMTRcrE5WJ85hAVg7qFCJBJdIJJKF5YnQtPEzFOVWNmRGd+Wngp71ux8tPTfYu9dAyXBiIdFGlKdYNo/GTqd0L0YAqml06FT+vCEl5PnICwxazT984zM/6IgMLEOq9XOu6utM6Xdmw98n72g4WCieOvNxAiDJVtUAvathZhccwk9Cc5PzTfQcHQzkhe/0wZl6P0mBzPE01iXAQxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; dkim=pass (2048-bit key; unprotected) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.a=rsa-sha256 header.s=s2 header.b=Tp9o8xV4; dkim-atps=neutral; spf=pass (client-ip=203.69.209.167; helo=cmsr-t-8.hinet.net; envelope-from=linux-erofs@ms29.hinet.net; receiver=lists.ozlabs.org) smtp.mailfrom=ms29.hinet.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.a=rsa-sha256 header.s=s2 header.b=Tp9o8xV4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ms29.hinet.net (client-ip=203.69.209.167; helo=cmsr-t-8.hinet.net; envelope-from=linux-erofs@ms29.hinet.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 3065 seconds by postgrey-1.37 at boromir; Fri, 10 Oct 2025 12:53:17 AEDT
Received: from cmsr-t-8.hinet.net (cmsr-t-8.hinet.net [203.69.209.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjVBj4fsSz2xQD
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 12:53:17 +1100 (AEDT)
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cmsr-t-8.hinet.net (8.15.2/8.15.2) with ESMTPS id 59A128IC400745
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 09:02:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760058128; bh=MsmS3qXUa1oBBGiJ2yNc5LQza5NPnJrt2vBAKL5AR50=;
	h=From:To:Subject:Date;
	b=Tp9o8xV4UI2FH7weSalzS320aMgGMNl+O14yi+UZw3O0EN33aE804mlc7CVUptdJ6
	 2Itkimqs9fRrhg9DJMIKMO8Jvxs6I1hGEHD9Q80hwRGc3QSXMVEvo2jok4qWsgTiek
	 ZvVuPbWbYUuxgo9koeWWF+RIkqkXOiKmT5JPgXonWmc9pm2i7/JRQSueNXi4GwY8RG
	 p4Y1OTnavoR/iMod1HfTma4uGo0nuck6EY6vnQ2Iw0BqLf5W3w2dNoAJp9zlF+OII+
	 IXaC3QE14qj3v1YlYFiGvzIn21JDn4yjhPilOTJi6NgFOtroYcDFspXf9tMiqnH+aO
	 p64LR1ETENESw==
Received: from [127.0.0.1] (111-249-177-126.dynamic-ip.hinet.net [111.249.177.126])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 59A0rlpX436907
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 09:01:48 +0800
From: "Block - Muller" <Linux-erofs@ms29.hinet.net>
To: linux-erofs@lists.ozlabs.org
Reply-To: Procurement <mr00@usa.com>
Subject: =?UTF-8?B?TFBPIDcxOTQ3IEZyaWRheSwgT2N0b2JlciAxMCwgMjAyNSBhdCAwMzowMTo0MyBBTQ==?=
Message-ID: <ca10f883-c936-0ba5-7dc7-9d95a867a21f@ms29.hinet.net>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Oct 2025 01:01:44 +0000
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
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=eJKwj2p1 c=1 sm=1 tr=0 ts=68e85b10
	a=MuNfr0PJkKhTTJ+wBupL8w==:117 a=lmFmFWn-aroA:10 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10 a=x7bEGLp0ZPQA:10 a=dFwqHLXSQQoT74FyTesA:9
	a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Dear Linux-erofs,

I hope this email finds you well. I am interested in obtaining more =
information about the following attached products:

Could you please provide me with details such as price, availability, =
specifications, and any applicable promotions? Additionally, I would =
appreciate information regarding shipping options and the estimated =
delivery time.

You can reach us on WhatsApp at +15043731130.

Thank you for your assistance. I look forward to your prompt response.

Best regards,

Nora Pagac
Head of Procurement

