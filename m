Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C92E8BD7
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Jan 2021 12:04:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D7wqj0mdzzDqGv
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Jan 2021 22:04:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=barbaralimon90@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kh4jsxQ/; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7wqZ3BLJzDqGY
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Jan 2021 22:03:54 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id y8so12895091plp.8
 for <linux-erofs@lists.ozlabs.org>; Sun, 03 Jan 2021 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:reply-to:to:subject:content-transfer-encoding
 :date:message-id;
 bh=p5Qfb5AKKl/JqHMFQnfYUQrXymdVnV4fiENxA5S+duc=;
 b=kh4jsxQ/zTsuSVSsHjZPX3TprHLVvMG3tvGL/X4oVThB4IdJHD/PHg5fcnND52IDHV
 +K0G0MLTUQosbrBO9avYP7q4G4Q/2FKJ5MPQpzhyRj9okLg89zpk4NTYW0h5sorZ5lls
 3e5JjGK9eT2fKHUG9bEN4yxE+EwmfhIzPGHGQWrMca94r4RSwBRTbR3frh9DLqT7ttWz
 15DEPpLm03Ns2X94Hvw06OKP+tesd8hykrGNdnGfPvqIGYtThtcg2V9NjCORZOYcejKl
 0lvm0v9w750GwpUb3EBFWvIH2ERvBRIeYTTYRlEgFovXB6qR8d3mlqJ5UnQ/M7sO6F7V
 nmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:reply-to:to:subject
 :content-transfer-encoding:date:message-id;
 bh=p5Qfb5AKKl/JqHMFQnfYUQrXymdVnV4fiENxA5S+duc=;
 b=hmwg4zXU6kWrMAthPgR91G9jG6fyDB63vWkT13EmRCWjj1xnJLFnJS4V82fCSKbx6L
 xRCW9+5FYTvAdS8XySwmw40hCil1Pme1f+dsvHnO3zyH1bHu0fuT/b0kjfkQv0xg45Pi
 FlxEwpkQsuG9edehbj5/T+olDh3x/LVh80GCbM5nbn01ePBVntSj4cQ3A2oDsSdRibp2
 RvA74qlPR0kmpjGtwf4H2Z+tfR9f0TtLorSLlvkN4vtPkmAfxzBr57t85o7OgYem2Vrb
 trpP6qwm2WHyOho1dv9Y0Pla04dM+UkeendQxTorsUQwYauw5/yIVqQkB5qNS8qHUnfb
 L5iQ==
X-Gm-Message-State: AOAM5337n5UB/yA1flXbKUfSiiCN+sGpsSnc0g36QKgt2gEEOPuruf/U
 DMIrXzbY+56owJpIE8cNpiWXmg5qxeMHNSr4
X-Google-Smtp-Source: ABdhPJwOhbyogHdzYRQMVAmuro+0nOTRL9IC8jIcNYtpCuKYGCoCiDfL1FYMY3HieA8zWyapVnomnQ==
X-Received: by 2002:a17:902:bc49:b029:db:eb10:c5a1 with SMTP id
 t9-20020a170902bc49b02900dbeb10c5a1mr68203795plz.11.1609671831214; 
 Sun, 03 Jan 2021 03:03:51 -0800 (PST)
Received: from DESKTOP53F6QH8 ([103.99.182.34])
 by smtp.gmail.com with ESMTPSA id y190sm56781118pgb.36.2021.01.03.03.03.49
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Jan 2021 03:03:50 -0800 (PST)
MIME-Version: 1.0
From: "GiftCardoffer" <barbaralimon90@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: Get Free amazon gift card is here
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_4_4_2
Date: Sun, 3 Jan 2021 17:03:41 +0600
Message-ID: <184684644916722415515180@DESKTOP-53F6QH8>
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
Reply-To: barbaralimon90@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<head>=0A   =0A<meta http-equiv=3D"Content-Type" content=3D"text/html; char=
set=3Dwindows-1252">  =0A<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.1=
0570.1001"></head> =0A<body>=0A<p class=3D"MsoNormal">Here's&nbsp;</p>=0A<p=
 class=3D"MsoNormal">how you get to enter for the&nbsp;</p>=0A<p class=3D"M=
soNormal">Step:1 =97Click this&nbsp; Link: <a href=3D"http://giftcardoffer.=
org/amazon.html" target=3D"_blank">Amazon</a></p>=0A<p class=3D"MsoNormal">=
<br></p>=0A<p class=3D"MsoNormal">Step:2 =97 Choose measure for your gift c=
ard value as $25,$50 =0A yet $100;</p>=0A<p class=3D"MsoNormal"><br></p>=0A=
<p class=3D"MsoNormal">Step:3=97 proof you are human or verify humanity</p>=
=0A<p class=3D"MsoNormal"><br></p>=0A<p class=3D"MsoNormal">Step:4 =97 Comp=
lete to the one simple task or offer for =0A unlocking your premium content=
</p>=0A<p class=3D"MsoNormal"><br></p>=0A<p class=3D"MsoNormal">Step:5=97 C=
heck your account</p>=0A</body>
