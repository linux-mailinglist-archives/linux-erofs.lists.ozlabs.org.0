Return-Path: <linux-erofs+bounces-359-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69CAC07AF
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 10:50:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b326l4Y0Nz2ySP;
	Thu, 22 May 2025 18:50:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747903807;
	cv=none; b=RBN7G2CNl00vjMLWujMbCpSoKR5+izRHO0gKWCdzsw8keeHjqhl4jE7ch8BqOA8bop99L1WpRe6CY2/wciuFOx4OeJ32sNxX4syYp3q0VWW2YViCTcN8y/Lqre0Ao/2R77tT6p+O7WBqzwaEnH2wO6NfUpT4z8wfqWmXU2NDKIchy23burAhXdUxlzHaulczpbAeuVSvRIOQYXgXevJ3JyDU0xhJiXsE59Gj8rlaKWA57dHcxcRIxYDGHFWqlbXc5VAq7XMnH0XXes7vAE8avhOea+OsvkCa86CrobBnfw7/RmC2xZ23trxRA990W2PJLLvnZaBFkF7N0OdijaZQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747903807; c=relaxed/relaxed;
	bh=XsgZbeTYJ1De+zCUdNxTFPv+ZFEa7d4CVAY3g5Aq4SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtH8alO8mpu7wmu6RQ7PO2C27NUppJCScD+4ZYpA0unFMZF6sJO4PJy8u/AN3kcHUI8YzkzLHa0kRyWFS7btedImBJ23IyY5dJMbhq6Zbsg0SIcnugKqGhVvg8JXbPpaZfn+2PTpEQb2IFqF3P4Srqc3Sh+oCIn3OuFjfmlDK5q647HmbQ24UHAHTt5xSd3RxbwndldN7yUtJU7aWPl3QfTohbghUHOjyk+ptHpx91/9jdeslLVj5iAaq0ZtATDogYzt3itg22ptoa8UTtJpv59v3FcE7G5TVXEM1nya4VUJrxv3mCoKI/ai6WnyH4CoXHEfw/J66RcflU4er5/lIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vnkQoHO/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vnkQoHO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b326j46msz3c3D
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 18:50:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747903800; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XsgZbeTYJ1De+zCUdNxTFPv+ZFEa7d4CVAY3g5Aq4SU=;
	b=vnkQoHO/mDGXj6n50TPKMUL1Wdy7cznsV4DPAL/S43jjWgyyng1WNsBJmbRMUWSBgy6Z21e7bp8qA43CLCkmwtQzW0iJj9rTiJGnTQ3oaVh7AMlN5PHoPucZqbo9LMjWZkMXYb78sdgfWoEv7Ke154I/PDcZ0HdAm5ztj+YKivk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbVHIyW_1747903794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 16:49:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: clean up erofs_{init,exit}_sysfs()
Date: Thu, 22 May 2025 16:49:53 +0800
Message-ID: <20250522084953.412096-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Get rid of useless `goto`s.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/sysfs.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dad4e6c6c155..c6650350c4cd 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -248,6 +248,12 @@ void erofs_unregister_sysfs(struct super_block *sb)
 	}
 }
 
+void erofs_exit_sysfs(void)
+{
+	kobject_put(&erofs_feat);
+	kset_unregister(&erofs_root);
+}
+
 int __init erofs_init_sysfs(void)
 {
 	int ret;
@@ -255,24 +261,12 @@ int __init erofs_init_sysfs(void)
 	kobject_set_name(&erofs_root.kobj, "erofs");
 	erofs_root.kobj.parent = fs_kobj;
 	ret = kset_register(&erofs_root);
-	if (ret)
-		goto root_err;
-
-	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
-				   NULL, "features");
-	if (ret)
-		goto feat_err;
-	return ret;
-
-feat_err:
-	kobject_put(&erofs_feat);
-	kset_unregister(&erofs_root);
-root_err:
+	if (!ret) {
+		ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
+					   NULL, "features");
+		if (!ret)
+			return 0;
+		erofs_exit_sysfs();
+	}
 	return ret;
 }
-
-void erofs_exit_sysfs(void)
-{
-	kobject_put(&erofs_feat);
-	kset_unregister(&erofs_root);
-}
-- 
2.43.5


