Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C05D87F6AE3
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 04:36:59 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q2TI299T;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc0yx4rM8z3dDP
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 14:36:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q2TI299T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc0yp4vvjz3d9s
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 14:36:50 +1100 (AEDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2df2fb611so984060b6e.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 19:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700797007; x=1701401807; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcsY+IMFAarGFrkdruFo6tsfLtiA8oqgpJIXZRrXSkM=;
        b=Q2TI299TMbRtjTg3YLQLu0YMRZGmOj7XVhG2w1ocKFdJq383hkESs9rd4smuQS1FG+
         uI99L7QpdIP+RGtym26N1/zJuw0OzOk6BFcmTEUSSv17FZl7xy2eWqPOpj8Tg5Z7hKLC
         0JMlodrgix0ICdnF7h5pZirCfb8GROhNyHu0UU4Gc61x38VjjlU4eTtlkb9Zwi2SGDtJ
         aoua/H1tDSu+bcOtOCJMhczVwqHOH0nOH5R7VRRTzXbx24pKsGawcEhfELdB9Pq0V41x
         LTnxN92U42I65lMXbauNtBMXho9hnxSUjLc8ayraveQM98cDd6swfWrSr2HU1od4IfBJ
         /xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700797007; x=1701401807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcsY+IMFAarGFrkdruFo6tsfLtiA8oqgpJIXZRrXSkM=;
        b=vcKxG12Je056emCJc2W3r41zMd9EXWSLGkUW/FbNAfx4jk6enWLfh7VcWsVYiJFd8T
         zd2oynYQyhiOVnYTkr9DU/3ZhnFVQyXeeZwWNnq4ndQZg6vohP7cye2H8tHLXMseBMh3
         VlcJDTwE30j7RCZ7KArJFB/R/9jv/8Bez5qPgWvpDOAQoPvLOIvZ8D9H0/qc2ctyhXu1
         1PAhSI60cRALs11+s0Gp63kkjnGWwmp4OvYa4oA2FzFTVCQPB5gSKBaXX4kmH6Y2g4SZ
         eeaPeQHF134SVwZsswaNf4tQhkuZx3wobq3mvdAeQGrKs+ji96NWO5qKk3zDNczLe4UW
         5EFw==
X-Gm-Message-State: AOJu0YwAH4m148wgGIIOq2z5NiA6ELisPXgw7/W69ylIL7TRv4ie06gF
	JXv6cNR+vgr0n7A2B8YTVcd5300H1IE=
X-Google-Smtp-Source: AGHT+IFxthYPtTcTUHTtr196OPeEt30lKnk66ktjQV5s3WyXquZ0FtGaCZhev1y6oD0v7RAqhAX9kw==
X-Received: by 2002:a05:6808:1188:b0:3a8:432a:ea13 with SMTP id j8-20020a056808118800b003a8432aea13mr1604809oil.46.1700797007375;
        Thu, 23 Nov 2023 19:36:47 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id d3-20020a63ed03000000b0058ee60f8e4dsm2088004pgi.34.2023.11.23.19.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:36:47 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: tests: fix build warning in test_LZ4_compress_HC_destSize
Date: Fri, 24 Nov 2023 11:36:29 +0800
Message-Id: <20231124033629.26035-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

badlz4.c:72:58: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
   printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
                                                         ~^
                                                         %ld

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 tests/src/badlz4.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/src/badlz4.c b/tests/src/badlz4.c
index f2f1f05..2a4a908 100644
--- a/tests/src/badlz4.c
+++ b/tests/src/badlz4.c
@@ -60,17 +60,18 @@ int test_LZ4_compress_HC_destSize(int inlen)
 	char buf[1642496];
 	int SrcSize = inlen;
 	char dst[4116];
+	int DstSize = sizeof(dst);
 	int compressed;
 
 	void *ctx = LZ4_createStreamHC();
 
 	memset(buf, 0, inlen);
 	compressed = LZ4_compress_HC_destSize(ctx, buf, dst, &SrcSize,
-					      sizeof(dst), 1);
+					      DstSize, 1);
 	LZ4_freeStreamHC(ctx);
-	if (SrcSize <= sizeof(dst)) {
+	if (SrcSize <= DstSize) {
 		printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
-		       inlen, SrcSize, sizeof(dst));
+		       inlen, SrcSize, DstSize);
 		return 1;
 	}
 	printf("test LZ4_compress_HC_destSize(%d) OK\n", inlen);
-- 
2.17.1

