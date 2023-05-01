Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58E6F2FB3
	for <lists+linux-erofs@lfdr.de>; Mon,  1 May 2023 11:05:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q8y3W5kC9z3bbX
	for <lists+linux-erofs@lfdr.de>; Mon,  1 May 2023 19:05:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=D3VKN15q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2c; helo=mail-yb1-xb2c.google.com; envelope-from=tdtemccnp@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=D3VKN15q;
	dkim-atps=neutral
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q8y3P6Tcyz2ynD
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 May 2023 19:05:21 +1000 (AEST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so3436966276.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 01 May 2023 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931918; x=1685523918;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hfkBBsHV6solT9kayJaZbXHAYMay+rReywiFxEP41vw=;
        b=D3VKN15qapbndvV49MfuKDBCm6aSNfbpLNVJDg1E9JBZ8NUv2h2gXH08+tH7mfuvGS
         d8CE3UFgtS0uQmRTMonC3g9OEn5vA9nbcmfDEbfb69n9qCTxYuxvDcso019VuFsR8E2i
         HZkv/YGjZ1qkt/QCADwobf3As9ToUI4OJyCLCQF4breotEpgCNLvgK3py9Fca0uJ7gJ8
         rZtK4qs1ZhA6s3iqUr2Ir9f9zwCpFh2xay7x8kIymqdiKfys2P966XeT6kfz9N7U3ceM
         dpG0cZKrSe79PxFMfs42s3qNz47/J11FIf1yyDQu/H/z1AVso1eFwpJi0VZTF82UfaHM
         XxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931918; x=1685523918;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfkBBsHV6solT9kayJaZbXHAYMay+rReywiFxEP41vw=;
        b=kGVXAPRUI9TwLfqrmKjq+tj7RCNGeqbrU1JSjMlAL+0WUEKkREUf7s2Cp3K5vnxK8X
         EDQNLbBgWtAyU7fHyBJXJSSVwa6Xvp3gbG1IMG+yvtWdzw/IfPETCQuU1tsIfQhZP060
         PSqYKv7rWnBd/xvRES1WvVXyqcKN0GobTQrCGJ7TmwdogBSALcFMwQRti5BTbWDfRlLS
         Y1OUklrIL1WoOkf7cEiLSsp1BSZ3NQJuF/WLb6lov9Dunr6VG9QpbRDDkgfkNo0dXmxY
         JaW9ygeBYGyLNSzgK5jryJq1STJTH7wZBUE0hZGpYBj4FArVCuOSkJlx/FkRXHT/st/f
         NgNQ==
X-Gm-Message-State: AC+VfDz41fHRHGdhP6nM5Ei9zsffyQsjfLhzlsd0Cr8iW7PVD/KTR/mz
	t9NGq4E7Qhw0m3PQxRxhavB+JcTm3ZqGGmj5If8ZinJ2yXRNDQ==
X-Google-Smtp-Source: ACHHUZ7dOMj+E1gl4sRYd5wpUU5bMwCPxqfthHTQ2ldvEvfemjrkHXonbeDAXJhGAEHW1VIwrr5tg4LViIexptZzH0A=
X-Received: by 2002:a05:6902:1005:b0:b99:4ac6:3c75 with SMTP id
 w5-20020a056902100500b00b994ac63c75mr16712068ybt.10.1682931918050; Mon, 01
 May 2023 02:05:18 -0700 (PDT)
MIME-Version: 1.0
From: Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>
Date: Mon, 1 May 2023 17:05:06 +0800
Message-ID: <CAD3upLsZ_Y=b4vyWzv4_aX9JOGes=Y-rwqMJ52pDQ+Na+j0xtg@mail.gmail.com>
Subject: EROFS Receives Some Useful Improvements With Linux 6.4
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: ceo@teo-en-ming-corp.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Subject: EROFS Receives Some Useful Improvements With Linux 6.4

Good day from Singapore,

I have just come across this article. Thought of sharing it.

Article: EROFS Receives Some Useful Improvements With Linux 6.4
Link: https://www.phoronix.com/news/Linux-6.4-EROFS

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
