Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF486648C83
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 03:22:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTWr058v8z3bg1
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 13:22:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YeYQ/enY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YeYQ/enY;
	dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTWqn4x6dz3bVP
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Dec 2022 13:22:13 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id a14so4968355pfa.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 09 Dec 2022 18:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ii1dil+CbFFXLB+JoOAXlZbxGAp4w7qPIBdB4vFF8=;
        b=YeYQ/enY2GpsVToJRpYrMwX/WP0eGGyrxtiny3TW6Q6rcoK6cDr08LmNSR69iUmqbp
         SazuY6Uvx9kv5UK1wGcEHztTPyBYabrACocJRt0xKxPeuFC0+j4Dm0UB+dEDJPD/J2zT
         Y+EIxZRB5G5xJVUFWF+rrtXa/U+pjGLRm9gTaBumAZIpyTGaJFEhQSneiljPUQ12slBZ
         Qggi2wRC4A4aUSDyYHo0SzV1ePsz564Mykfg7iFtmyCuqOshMeb38DPbsi5CBhqNjsF7
         BHW3CMELFYMZw9CmshnAHzvk8YneQQdxML3UbWH9YqRAal9lDjfqyp5MYjzrWk4Tq90A
         N4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/ii1dil+CbFFXLB+JoOAXlZbxGAp4w7qPIBdB4vFF8=;
        b=PQL3xm1/AiVATPcah0fP2jDoF98bvGw5wwePTUft4Retqg7lUILneGQRskcnXkAvlA
         +j7R+gRfBlvYLlFOa3TMk/Q0n8Lz6g2ZF8Sgc+0/miCp+tLftBaz2/uYidQO3hvXsZfj
         l5u4A0sU9qbN5PUKKzcZVxfc+MeGmlcXnuojaAj3krZksPGiDq7I5zDW8jVXZfJx8Xsm
         UGtGEluDFjcYY9J8f7fTiYD7rrzQ9G+zp/cX4biNHgHRnTWiEbBiPAYAWQ6m3xT+Acqj
         cd1ykaU3gX9Ha+wKMO2W2Sms1UcqQcyfrROdKB0jOTRWEC/JEQcBhvxFxwjRKPVEZ6YJ
         n6Ag==
X-Gm-Message-State: ANoB5pkZZxBs50Kx2bk1QtscZizoh1Z0Nv4c6R8845a6zFpA1nNgAup9
	imNaTr/oz5GEuyQ45Gm1Z5TwjxHUcPA=
X-Google-Smtp-Source: AA0mqf645GqBDEat8qR2GbeKktLiyuTh8P2p6/+b/wamZnBXVUYEejNcIQArntpKULpaV0XIx0w3Hw==
X-Received: by 2002:a62:1c93:0:b0:576:45c8:100f with SMTP id c141-20020a621c93000000b0057645c8100fmr6809204pfc.23.1670638930188;
        Fri, 09 Dec 2022 18:22:10 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id b64-20020a621b43000000b0056c3a0dc65fsm1814475pfb.71.2022.12.09.18.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:22:09 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [[PATCH v2 1/3] configure: use AC_SYS_LARGEFILE
Date: Fri,  9 Dec 2022 18:22:05 -0800
Message-Id: <20221210022207.757975-1-raj.khem@gmail.com>
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

