Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76AB891698
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 11:17:58 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mBiBcMdg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V5bvS4K9rz3vZt
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 21:17:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mBiBcMdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=axabanque6363@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V5bvM4JCHz3cZB
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 21:17:51 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33ecb04e018so1332221f8f.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711707467; x=1712312267; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pt6Y4KrqgaNiziD5GOk3AquJiGBASDiQYisFtAwleW0=;
        b=mBiBcMdgTkUthTyQZzu6xaYL3evJVg71BVwEM4i5Hq+jHTNyoZuY9xPh7tPEXy6XqS
         eTtA4nLE8z/NaBw6Di+BDoUg4g5tA5+8X1rVqkoVamkEo5EecO5iIOHec7tpaQ3nBCoz
         gR9d39pgaqd007DvhPM/t11GSx8jxeNu3Gt4AA3RiFlOkg/srmMVCCfw+MasUdQiLCuV
         zow/qoBHVzwoiICkQBssmAjAOB9jOn3a1ZQlMA5hw3rgNM/wgStjCBvsyLMwS+1X2H1d
         LZ1h/QUPf6XmZJ4BuwGy/2WJasAp8BstbHnHS0OoDiKRCPVsmBdASBR0U0Qi38lRLGgf
         R0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711707467; x=1712312267;
        h=content-transfer-encoding:mime-version:message-id:subject:to
         :reply-to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt6Y4KrqgaNiziD5GOk3AquJiGBASDiQYisFtAwleW0=;
        b=QfM2USSScG/yPnqd9mxbFmS9teY2ng+i9pvFKHr9yhGPhq0qyVHsoJgf7eRqo2Ojrt
         B220x/ePi+FLi+oaZxDO/xbO4mJH+9Qhpz//UNYMC7oA9qGectTHsqh7kDCF+M6zBFtV
         JQs7s8UM+EzdDvOQI4j91uE4pPT4gO944Fm2A9fprX5DiB8x7PB4bO6iZEgTN7YIeyXj
         nBkKXvt8ssYbiV5L1WJuaMngtWCEiLSgVG89spAojI8MwGCOAU2gmW3dsccYLG0RQHz8
         6K0we7TP/JlgFQuNUJBLtpftaAXDw9+I/fJUgKKAmFb9gWGsD3A6X7fNVtd3tfVzaoLf
         AZDg==
X-Gm-Message-State: AOJu0YzxcdMm5Z40dLgq6F+Rz04DX8pdDyAAu6FLCNovg+zKODUz6oHO
	34mPsUaTbbe34VFOmVAGSk39parKahWSk04sVHwSuhY0jZfi4AsPinTSyKj4
X-Google-Smtp-Source: AGHT+IF8n7F9IA2FV+pW6qzr8Mav+5qEx7xo635Yj7BlYGwsNnhy7JyVQa1mLbjzQJfnqbMxRtWzzQ==
X-Received: by 2002:a05:6000:1143:b0:33d:b2d6:b3a6 with SMTP id d3-20020a056000114300b0033db2d6b3a6mr1053927wrx.48.1711707467363;
        Fri, 29 Mar 2024 03:17:47 -0700 (PDT)
Received: from [156.0.214.32] ([156.0.214.32])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d4884000000b0033e7603987dsm3850502wrq.12.2024.03.29.03.17.46
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2024 03:17:46 -0700 (PDT)
Date: Fri, 29 Mar 2024 03:17:46 -0700 (PDT)
X-Google-Original-Date: 29 Mar 2024 11:17:45 +0100
From: Office <axabanque6363@gmail.com>
X-Google-Original-From: Office <pictures@jhf-china.org>
To: linux-erofs@lists.ozlabs.org
Subject: =?UTF-8?B?R3LDvMOfZSA=?=linux-erofs@lists.ozlabs.org 3/29/2024 10:48:47 a.m..
Message-ID: <20240329104847.BEC921641294E49B@jhf-china.org>
MIME-Version: 1.0
Content-Type: text/html
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
Reply-To: Office <parkerjudith259@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML>

<html><head><title></title>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body style=3D"margin: 0.4em;"><p>Gr&uuml;&szlig;e<br><br>ich wei&szlig; ni=
cht, ob Sie meine erste E-Mail erhalten haben, aber dies ist das zweite Mal=
, dass ich Ihnen schreibe. Ich schreibe Ihnen, um Sie davon in Kenntnis zu =
setzen, dass die Auszahlung Ihrer Zulage vom Verwaltungsrat des &Uuml;berpr=
&uuml;fungsausschusses f&uuml;r Zulagen und Verg&uuml;tungen der Vereinten =
Nationen genehmigt wurde.<br><br>
Ich bitte Sie daher, Ihre Angaben zu best&auml;tigen, damit die Finanzabtei=
lung Ihre Auszahlung unverz&uuml;glich genehmigen kann.<br><br>Bitte f&uuml=
;llen Sie die folgenden Felder aus.<br><br>1. Ihren vollst&auml;ndigen Name=
n<br>2. Ihre Anschrift<br>3. Ihre Telefonnummer:<br><br>Wir freuen uns, bal=
d von Ihnen zu h&ouml;ren.<br><br>Mit freundlichen Gr&uuml;&szlig;en<br><br=
>Judith Parker<br>Leitende Beraterin bei den Vereinten Nationen.<br>Vereini=
gtes K&ouml;nigreich.</p></body></html>
