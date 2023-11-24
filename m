Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED77F6BB7
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 06:31:29 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YEZ/LBsI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc3W26tNPz3dK4
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 16:31:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YEZ/LBsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc3Vv5r27z3d8t
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 16:31:19 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso1350635b3a.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 21:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700803875; x=1701408675; darn=lists.ozlabs.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J47mkq3ebRdVeWycJCCohJkYoO2ncjGxKvL3jJh5GaE=;
        b=YEZ/LBsI7mefa8wo9S5TZGJiXXlBMNygksIwmYQq5KUC5HfIeZmVxMjpvUGFMrwtVM
         gDUISLbvJPT4jwVgX4Rp/MgWaTBTtw3f6FnvNT3ZZKLFLAQMSq4Vw0S7rqBWoXbNsAdK
         8zNISK657lMbWe+RRm165tOtBSSxJuM1wfFdJJu5BW6wfM1D5sFavrUVF2IauR/7M22L
         DyJtCjlk9qvJ05nSwabwHTLOcS65+0yO16WSJ61a5KzFNNywPCTUaZ3y2q8Mli3D+4a2
         TYtTBaDQ2X6K+WBTbXRpViQFGQ22pw4lcvSnXsde9v3ryyimc+zZmu5vnlvxeeIchC4v
         erAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700803875; x=1701408675;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J47mkq3ebRdVeWycJCCohJkYoO2ncjGxKvL3jJh5GaE=;
        b=WGDcWlYCPusLa5OCE1PuqCiXM7PqjtqTFfJbV0g7qXc0EQnQPlwDrkSm3+DOS8w65m
         1FC4NHeStCSGkZwyERxF3VqjPIGsZJnGP2KcpBKu2Jg5qIpu/GngSkYV2ZQYrLdfy8kR
         cmdSpA9QNMKccNKFUpMXiaUj8TNkq6l2CY6rGjLCOfR1LTp6jpoW4Rq6NKyYRzmbqCgj
         kGzJZ67dbZRPTY3YlxFPGFSOkkxvixX8t1l72kVHyNHIT5crKfXBhBvKSD0m5HrODLma
         1m0khA9C/xvZtcu1oaJMJNm5NYFt2238IFy+9aRYfgCIaVrcmuCVJxIxYCyagWKZ9vV8
         UYGA==
X-Gm-Message-State: AOJu0YxYYnInbaAJw3rI9vxeJKP4haSVIfQYCWFolWFZZuYFXE2RY989
	RNfgArjO4ZKBmfHAPFBvvq6cbl7XLSc=
X-Google-Smtp-Source: AGHT+IGloakVonM0k0gW5MkB27D6N+MK5n6etkLzHYGCE+KqVLlbjRtOGiKg6yKXxi7pCrLrnxDq2g==
X-Received: by 2002:a05:6a00:4ace:b0:6c3:3bf9:217e with SMTP id ds14-20020a056a004ace00b006c33bf9217emr1560717pfb.19.1700803875477;
        Thu, 23 Nov 2023 21:31:15 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id f23-20020a63f117000000b005b3cc663c8csm2242524pgi.21.2023.11.23.21.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 21:31:15 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update .gitignore for test results and tools
Date: Fri, 24 Nov 2023 13:30:59 +0800
Message-Id: <20231124053059.29514-1-zbestahu@gmail.com>
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

No need to track these generated test files.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 33e5d30..5b9ecd0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,3 +31,6 @@ stamp-h1
 /fuse/erofsfuse
 /dump/dump.erofs
 /fsck/fsck.erofs
+tests/results/
+tests/src/badlz4
+tests/src/fssum
-- 
2.17.1

