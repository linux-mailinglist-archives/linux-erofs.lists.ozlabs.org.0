Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E455403C
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jun 2022 03:48:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LSR9J1wR8z3bkP
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jun 2022 11:48:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YlQS7+ds;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=aresnasaxuchao@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YlQS7+ds;
	dkim-atps=neutral
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LSR995Z19z2yxj
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jun 2022 11:47:56 +1000 (AEST)
Received: by mail-oi1-x229.google.com with SMTP id s124so19420417oia.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jun 2022 18:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pr2uxOUhWmw22ujPg4NNSvR6jELeKjqRv3jkqGoEkzg=;
        b=YlQS7+dsgU01pJ+oAjvFOfVw7W42zM6l0sCyrVLl2VQ5HWTrbxbuvpG91BAbMgQEQc
         qTVvTbNjBllrJCkwJ4fekHAt5hRROqHe4P9lrp1bamhY0qJjO9nLbEX2qE1tBAQGT4su
         VO6qPLkdDas5pEL97OCPvNyLuTccxvwSl1oBmYpf6mohNKuvT0uwdZV2voZT5h1+zMCX
         wBLgbjoCtUnSYqStHRnIlAGS52qPi7kgfqZTZYJaeXiUg4SBvlwBvcAm1/wHWNFctcdd
         cWY4EvhO88KofpkwvwajMDpN8rjZaaddoz0rPWew5F1h+2wTAJdJO8dwC7ghzuVAMjtt
         U0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pr2uxOUhWmw22ujPg4NNSvR6jELeKjqRv3jkqGoEkzg=;
        b=Ios/95eIiz5NMRmu7M1YxC+nNt0cKHHBQ/annpsTxdxEc/YvFOieDM9PBl/AKlOug9
         LX6UDz0xWlVB6W3FcyiWFAk6o3Vajcf9d07l+tHwajH5YROekBgVkPZHSr8xbWgRC8WL
         a+l7twD/LVaySOPI+VgvNcxOVFapRMPwLbRMyuLUTsYJkwIcfxbXs74JDR/SMAUCQwyg
         7x9I0Pgs6RtggvJkaY1ZtNwKqklpFOte1jdOBaUxJAF0fWDYHxz5Mwb0vn41YpQ+YFJk
         lfDCYh6fmo1sGXCeqUEgVeiSOy5m/1cJpE5ql2Mc7OlkWv3mE0KzxctTlIh0PnzMeTTC
         xBfw==
X-Gm-Message-State: AJIora/w9wgvTetqFMvLIPvfPAplsdlDr0USi3mb8KAHofAMrNAs/83L
	M5ct2Naz72gTj/9PX6PIb0SbhQz0Qo2x0IIqXuRMYkiqQMftCg==
X-Google-Smtp-Source: AGRyM1sVkVJxcHjtbr4kbMUfEad4F2tyC/7SuAy+DblpFTMO5/fMydhlaGa61NTjK2QFw7H2pPP+yJsfKaOd6dvLX1M=
X-Received: by 2002:a05:6808:124d:b0:325:788d:e23d with SMTP id
 o13-20020a056808124d00b00325788de23dmr553796oiv.267.1655862470385; Tue, 21
 Jun 2022 18:47:50 -0700 (PDT)
MIME-Version: 1.0
From: Frank Xu <aresnasaxuchao@gmail.com>
Date: Wed, 22 Jun 2022 09:47:38 +0800
Message-ID: <CAMSUc5UO0ga9YNOX30Eb+VOi1gWHb7yQq56iTszzE06RZp6KAg@mail.gmail.com>
Subject: 
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000005827e605e1ff86ba"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000005827e605e1ff86ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

--=20

---------------------------------------------------------------------------=
------------

Best Regards!

=E5=BE=90=E8=B6=85

Email: aresnasaxuchao@gmail.com

--0000000000005827e605e1ff86ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><p><span lang=3D"EN-US" style=3D"color:#1f497d">-------------------------=
--------------------------------------------------------------</span></p>

<p><span lang=3D"EN-US" style=3D"color:#1f497d">Best Regards!</span></p>

<p><span style=3D"font-family:=E5=AE=8B=E4=BD=93;color:#1f497d">=E5=BE=90=
=E8=B6=85</span></p>

<p><span lang=3D"EN-US" style=3D"color:#1f497d">Email: <a href=3D"mailto:ar=
esnasaxuchao@gmail.com" target=3D"_blank">aresnasaxuchao@gmail.com</a></spa=
n></p></div></div></div>

--0000000000005827e605e1ff86ba--
