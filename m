Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2433464D821
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:59:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXmPM08Zfz3bcN
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:59:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nPWwRbZ2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nPWwRbZ2;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXmP44fBJz30RT
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:58:47 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d7so6144310pll.9
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heDpuAS5mXUhds1vOzkAHyKbq4SYOTfBojQ89B7OY8s=;
        b=nPWwRbZ2TzpbF8Uw2fOQBeuoomLgM7yzVPH3Wf5iaUSy0J1dmWALFIhs3CoIMWpBwL
         4AEwd45QAZ3xZ2VL1uAyRrfc7nxg/RbZGlGl3+GZTIEU2339lri+5RTKCHjak5z+EH4o
         363p2OL/JSPdux8dSTT3BOmwIbzMURvQHf0hGkAq74iWj+1Rwy+OZUqptorz9I3PFFEe
         Cfqzbd+VZDsG6hn45F4SU5Rm+PY4V63UUWoUxyBDs48bnCa5Zjz5Vmw16z3I9fH8lrxT
         n/33QVTavlMxyJY4H4IYUXf/Vy7zqJQuU3v+PWvX7vVmPoMjQSlDW6GGuSq+fjHLk1X4
         kzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heDpuAS5mXUhds1vOzkAHyKbq4SYOTfBojQ89B7OY8s=;
        b=gZdkL6y7KB4eA/VrxQFAcIFsfe4IYWIpmU4o2/+f1t6boeiEV7IWNaVcWxuO1jgnp9
         4iTyMJI/j8nZ2v8AcmvxD/r7PnIkYPbgZQlO1Ik8iKKYBwSMQWkN2ExYdVpV+xn/hPei
         mixx/cKU2BcvPQu6/eG3IBpx5Kn0fybCcBA68M496y1BdHR1BIjoOS2Ws9HpMKoRJHBd
         Bpkt8RSYI1sJxLX8hAKxVPXMC7+ZoSd3bE0+MQdrW8CiLAOfTIe1T83DpyO9UHOKGHmi
         U/gEGp3DLJPdGikKUzYHE+E9gI1hHYAgoxLata5LbP8R9EJ7bG6SZnECJEUY/BP29Rsq
         lyNg==
X-Gm-Message-State: ANoB5plw2Wxyfuyn7uxsz/PlkrZcJdnP1G/27yii5HNJJ76/0TXbyoYY
	0amHcMnYJWhM0ljH2W1eOi8VmTfLrzc=
X-Google-Smtp-Source: AA0mqf6KEm+Q0rbVMIdD2iLq0Fax7mA094/zMYrvAma4RVBc5i+CyEFvemhvNM1cfmTTiVyy5VaoBg==
X-Received: by 2002:a17:903:54:b0:189:ba1f:b16a with SMTP id l20-20020a170903005400b00189ba1fb16amr24829744pla.10.1671094724160;
        Thu, 15 Dec 2022 00:58:44 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b00186a6b63525sm3247881ple.120.2022.12.15.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:58:43 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 1/3] configure: Use 64bit off_t
Date: Thu, 15 Dec 2022 00:58:40 -0800
Message-Id: <20221215085842.130804-1-raj.khem@gmail.com>
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

Pass -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 via CFLAGS
this enabled large file support on 32bit architectures

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index a736ff0..c2b948c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -319,6 +319,9 @@ if test "x$enable_lzma" = "xyes"; then
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

