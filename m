Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C864D69F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 07:48:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXjVW1XW4z3bhv
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 17:48:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pMWHf7/s;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pMWHf7/s;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXjVG2Rr2z3bNs
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 17:48:05 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id n3so6058277pfq.10
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Dec 2022 22:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qr/9+wgzxcYG12CE6kV5VttnZL120JIqdtsizeXtY0w=;
        b=pMWHf7/sVm4Bqzu2ZHIMRPOp5I84l+dmcpFMRivqLvkoNziGyg1zL1qJjLOktqzOGV
         LDnHatv3lDAeClfdKA4tCvubFLbLoxHKos+6n8ixzFVbQ2UxGjiy4GmPvq/t5CnE05QR
         6TNWyWSbmcNIZoge0ij3UWy0eq1HM4PpPY79bIMe5Y27bjX2Kr0NKqTayJR5Q7TJfJXU
         +uAPMxgJzXu54od13zHGq4Cv2OzH0Yepnm0xDQscoctWDiJ3mtMPNVbPNGzLEzKsm4lT
         PN2UpJ/wJDgAedhtwvsP8XbeuOOvcQs3wcMRyZy9XbdVzU4MMcVNoSDtilOA/1HrkLFo
         jSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qr/9+wgzxcYG12CE6kV5VttnZL120JIqdtsizeXtY0w=;
        b=sB1Y20HK+jcEMVUQQ6t8+jpfFK9XrAsPErDRJduwfv9cUj7y1s6CA6sLovtx3LZNnT
         3Fozg+OTQeocrhvTGDJw6mi2esURYHxjnv8Eq7w1fE9T8jGwotK/Lb0yN/CMw0fNa8Ex
         FYwLEk5YrxccVlFgZKRuaVIBgNZRwaROeRM7C9WHh9dChdmAMKMjt5NaX7Eq7U+7aKPq
         0g6H04r/mirEPpZXL0rOFF2VpPFSQk5GyEqOUyhlRTMCCfCJTl5qpu5CLfVq3qJKCNSe
         NTYYwUOXDMf5ZKQy7JHRrj8XEL7lmO1lk6nMWBkLE4toJK0CG7zktmOjdqU0YuSkohu/
         Cm4g==
X-Gm-Message-State: ANoB5pn06en3LSxq9V7OVAQTo1dGXn6W05vCTcPeR7bg+XhX20bYr4SC
	eAxfSb/UfNSvyEiaROxUpBGUOSQ7Alc=
X-Google-Smtp-Source: AA0mqf7sQMlbOvxKozhtR/QOSH3G5/5VGmngh+XGNLtCE0jDoqhNfHLaO75X4Zk0n0uIOv+tURC89g==
X-Received: by 2002:a05:6a00:1696:b0:56e:dca8:ba71 with SMTP id k22-20020a056a00169600b0056edca8ba71mr35164146pfc.32.1671086882266;
        Wed, 14 Dec 2022 22:48:02 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id c202-20020a621cd3000000b0057524960947sm926689pfc.39.2022.12.14.22.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 22:48:01 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/3] configure: use AC_SYS_LARGEFILE
Date: Wed, 14 Dec 2022 22:47:56 -0800
Message-Id: <20221215064758.93821-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Pass -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=66 via CFLAGS

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index a736ff0..e8bb003 100644
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
@@ -319,6 +321,9 @@ if test "x$enable_lzma" = "xyes"; then
   CPPFLAGS="${saved_CPPFLAGS}"
 fi
 
+# Enable 64-bit off_t
+CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
+
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
-- 
2.39.0

