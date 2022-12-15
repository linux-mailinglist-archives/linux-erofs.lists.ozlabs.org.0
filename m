Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2790364D820
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:59:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXmPG6mqgz3bfF
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:58:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BjAyFpPw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BjAyFpPw;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXmP453lYz3bNy
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:58:48 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so2041372pje.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ7hxoKNbTjaybD4RlFEQkUEwp1y3rxCjfROeQyRoZQ=;
        b=BjAyFpPwtCmeKp69CUCkvB7gvs3Bnjq6nKL1jPmGL1Fje6/ZFsIVIMEGY3bRmeDjfC
         gwEWM8zj9EH4P/2RVZ5dFaI0Sosm9A2zplJtv4vJtKjXhzEI5rhbap4u1rbV971MfUFl
         N8rYvQfSZAizS0gwYlm+Nj8chGTzp/ox9rvys6f0z8bWwnvNcz9qCPJWNTIOCNvjuZXJ
         oFsKIShUJjTh4OpmUJDapPtKDX6ikUvb7ZQuVkQ+QSxgtKXgImeNdMELDsbWqsqimmWJ
         hCf+q6OHVDKrg/sdYShUzMvAIwVWY3DGkVavR88mBxqDYpPDbN3MoDeA6XYigiOrpAX5
         n8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ7hxoKNbTjaybD4RlFEQkUEwp1y3rxCjfROeQyRoZQ=;
        b=W4v8oPQ35VXs7VFBjurMdfN0yEF6KuaD9LH3qpb6AF9LOOTd67uHlOhZOn75sctGhY
         fbV9WJ0q9XC0CloSfcrVzuIWMmaH+zTaa53U3JCE4hPrEwOHmJbgsDajz/iv2UhIumYx
         NkJRSE9cL/lzuh2XyGp/2pcVJvVGQg9NRtBcSFCMH9oauSehWWTNzr/fv2DFGfiyo1yI
         fMSMKFK20KuP53prQ4/CPruMZrlweD7FjcGaOyKWjMZmcG8SnuvBhXun9vddVeCR7pVh
         hmYbUarNuao5uboshdbkS3ttxwHH5EP87veFuT/PfPGq9Nl2Ym67nAE06/UTIVpD7SSI
         F3wQ==
X-Gm-Message-State: ANoB5pkVVYnb7nppT8MGEgAvhKZIiuIs31gW4r0rn5VpQk/hJrTDTB/M
	5x/xAHbObqfwqiHGi1xeG6cW6Y/F3fY=
X-Google-Smtp-Source: AA0mqf5q1COjzE482KpHJ7IlcDlYoJLOqVFgEJsForxABtXDi+5t4fF6PDi74mFqfUpmDuBTpdWo5Q==
X-Received: by 2002:a17:903:1109:b0:185:441f:70a1 with SMTP id n9-20020a170903110900b00185441f70a1mr37427473plh.38.1671094725808;
        Thu, 15 Dec 2022 00:58:45 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b00186a6b63525sm3247881ple.120.2022.12.15.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:58:45 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 3/3] internal.h: Make LFS mandatory for all usecases
Date: Thu, 15 Dec 2022 00:58:42 -0800
Message-Id: <20221215085842.130804-3-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221215085842.130804-1-raj.khem@gmail.com>
References: <20221215085842.130804-1-raj.khem@gmail.com>
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

erosfs depend on the consistent use of a 64bit offset
type, force downstreams to use transparent LFS (_FILE_OFFSET_BITS=64),
so that it becomes impossible for them to use 32bit interfaces.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/erofs/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..d3b2986 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -21,6 +21,7 @@ typedef unsigned short umode_t;
 
 #include "erofs_fs.h"
 #include <fcntl.h>
+#include <sys/types.h> /* for off_t definition */
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -104,6 +105,10 @@ struct erofs_sb_info {
 	};
 };
 
+
+/* make sure that any user of the erofs headers has atleast 64bit off_t type */
+extern int erofs_assert_largefile[sizeof(off_t)-8];
+
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
-- 
2.39.0

