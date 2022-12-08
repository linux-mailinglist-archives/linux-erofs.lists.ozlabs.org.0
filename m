Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FE646B17
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 09:54:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSSd44S53z3bjd
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 19:54:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qSrx1yFK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qSrx1yFK;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSScQ029gz3bjY
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Dec 2022 19:53:41 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d7so898009pll.9
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Dec 2022 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ii1dil+CbFFXLB+JoOAXlZbxGAp4w7qPIBdB4vFF8=;
        b=qSrx1yFK0tlEPb2mGFkD9wArv36Za3lAx/DRLtK4drvYF6t2dU+y8AaCfHLQrre33G
         43g/FnduYK1ePpm0A5/xtnUtmKXiMgAr49i1OxkBfn9q/n2+af/qnbADyviw4FulPnzm
         QOhhcHPnyZtmNsT3TVaxjEYA1kugDtSdScdeD1L98RdfOK/MPvJay6YQeBpPAeXy22Bd
         b/XOZrnboOjalM0L36BS7FLUkBWgQqCL8sYxqGNH3oqR8/PWBymumli0+t0Z+hfIhuh4
         kHnOFPusUzzAl0rVdbs5CMHtpNDhMJgvmOnfKqDvuGMVPzYcP+sz4NswQlZwr81bLLkl
         ZmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/ii1dil+CbFFXLB+JoOAXlZbxGAp4w7qPIBdB4vFF8=;
        b=KsrWDv5dcCKIy8R3RqNTntC7TXoNPKoXOslpqID5T6oDCZClSdlh8yhoBFkLMyhlzU
         OZXgFV/XZGCrJ6G9Uj7KL2qIx8heMXsF5hOEPhWOViv/aCxm0+/MSarbeMZ1ytqpuT9S
         PlgVUqqCkYQp2HeHTukZ+T+dW1lItUc/6OR0TC34BWqnYlGGxRubxm0ZiOwpaJF+WDA4
         PJDqyEAVnIpzON5iJMiFvjrdHhIJRIy8De22/4SHEHH6khPoh4zCsneuZ0naRYvRWFBJ
         GrDxg6jS0qMGdOByZK84KFXbc8j6TXyRDifVygTATWlwmXgQIOwcqJQns+Mc8/eD7d8U
         PwvA==
X-Gm-Message-State: ANoB5pnOsK4AOZPOMtDj1FKW40wL3OAyOEjtzU21jVVTc8lONeRGLM+R
	DevkoRSUbdAYsdkJPIHEutpkepeXtFo=
X-Google-Smtp-Source: AA0mqf4svtiH5jWIP7YwJpfiA/BfWue27lsA+23W81oryRCFBwVCrWddmS5/x+7ss4cVxVu8iiH1bw==
X-Received: by 2002:a17:90a:ec0e:b0:219:661f:9d8c with SMTP id l14-20020a17090aec0e00b00219661f9d8cmr1868706pjy.3.1670489618503;
        Thu, 08 Dec 2022 00:53:38 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a7f0100b00205db4ff6dfsm2398392pjl.46.2022.12.08.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 00:53:38 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] configure: use AC_SYS_LARGEFILE
Date: Thu,  8 Dec 2022 00:53:33 -0800
Message-Id: <20221208085335.2884608-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Khem Raj <raj.khem@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The autoconf macro AC_SYS_LARGEFILE defines _FILE_OFFSET_BITS=64
where necessary to ensure that off_t and all interfaces using off_t
are 64bit, even on 32bit systems.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index a736ff0..b880bb0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,6 +13,8 @@ AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_AUX_DIR(config)
 AM_INIT_AUTOMAKE([foreign -Wall])
 
+AC_SYS_LARGEFILE
+
 # Checks for programs.
 AM_PROG_AR
 AC_PROG_CC
-- 
2.38.1

