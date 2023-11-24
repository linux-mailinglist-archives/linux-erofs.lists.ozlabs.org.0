Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408D7F6B94
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 06:06:24 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BtJIuQVe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc2y570RYz3dJm
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 16:06:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BtJIuQVe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc2y15HYvz3bPM
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 16:06:17 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so1017320a12.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 21:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700802375; x=1701407175; darn=lists.ozlabs.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvNNbXzuX85yU8uYODvZwqb+9+gYm9Lg5oOITX6NEqk=;
        b=BtJIuQVeNb/N9gEEre0PUoB2wO4flZG61qgC9g0VZL7wqHB64pseUF/LHwnhp0rfTH
         B7sSINKEzMgVhiLdfS//CG3j1Rk9dgzvXfiJTkCDOj4g8YHA2xaaJT9moGkIbl7sEt7T
         KGhIrBceKdoQwkuNLzu6Yrqf0FoGyC0cPJERtwvuZh7YLD2tfX9T/MrCYbawLcZ+vzov
         UkNFy6dOZA9t6xarF9tnfh72v+roIlv5ayExwBfCAURh0SYnxm4bypW0LdXcjFV8AcY/
         R48eY6FC0qI0aMbbgts6Mc1TJoJaAldJEjMWW54wfswscaZli+5aDkwo8VKJWwKQ9Ezi
         sTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700802375; x=1701407175;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvNNbXzuX85yU8uYODvZwqb+9+gYm9Lg5oOITX6NEqk=;
        b=dcN3nTv9fSU0YSUMcwxrqCuBvsOcexzYWq8/cXlUW4rHT1BrkP7xLVfTuW2sREc7MP
         WWJKiQD3h1HhEbUkn49kc285CHYF3X7kXgRT9I3yw0nDI1+p4M4cZvz5Y7Z/Rjtzb4i9
         ooaWcIeGpfGKZjSabOcMs7VLtWJzDz8+aRIL4yE9IB3CcYZRbbuT5inlZUGiiFPfhTbF
         FylIn8P1M0PhbXF5/9xDjF/GJ8hnoIrajA6+HJGl0vs93+VPnhZG1610irAV+8Ab1zCn
         4mmIsGgm/SAZ/ijH5edXCu8c+bG1YQIu6OGVNIxioNkHeQn+IdK8qOrsrcPuEk8DoDuQ
         9WvA==
X-Gm-Message-State: AOJu0YyPrFlyXufrSeZXQmaWFSgPfh/AjYcTkzRy6tDt/4mGhOlaafqE
	mPU+alEzbJiyEDaVbgEX0dS57mEba3M=
X-Google-Smtp-Source: AGHT+IHDwoAcibOZbSVQEVfezjADkP5jpPLuEGNQ9fmkbkGn3ZFqQG9T8E+UQcWJWkvTPKiHSoAZ7A==
X-Received: by 2002:a05:6a21:168c:b0:18b:8d6b:e601 with SMTP id np12-20020a056a21168c00b0018b8d6be601mr1912774pzb.7.1700802375532;
        Thu, 23 Nov 2023 21:06:15 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id v1-20020a63d541000000b005b18c53d73csm2044095pgi.16.2023.11.23.21.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 21:06:15 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: tests: fix build warning in test_LZ4_compress_HC_destSize
Date: Fri, 24 Nov 2023 13:06:03 +0800
Message-Id: <20231124050603.29128-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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

badlz4.c:72:58: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
   printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
                                                         ~^
                                                         %ld

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 tests/src/badlz4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/src/badlz4.c b/tests/src/badlz4.c
index f2f1f05..221b714 100644
--- a/tests/src/badlz4.c
+++ b/tests/src/badlz4.c
@@ -70,7 +70,7 @@ int test_LZ4_compress_HC_destSize(int inlen)
 	LZ4_freeStreamHC(ctx);
 	if (SrcSize <= sizeof(dst)) {
 		printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
-		       inlen, SrcSize, sizeof(dst));
+		       inlen, SrcSize, (int)sizeof(dst));
 		return 1;
 	}
 	printf("test LZ4_compress_HC_destSize(%d) OK\n", inlen);
-- 
2.17.1

