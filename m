Return-Path: <linux-erofs+bounces-1938-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5103D2EAFB
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 10:23:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsvYJ1pDZz2xSN;
	Fri, 16 Jan 2026 20:23:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768555428;
	cv=none; b=RdKSwMd2fSx1+HgADAkn/mlN6SDgLY+8Y4HsjDDA3KYyak7H0CIVPADLsMJkATlYYsfjPz3PUsmZpjXWbXu6Ad5uApAwVUksHurt42lYWQZhr3b3a34UewXnctEly+9dtOMp740d3D0P8wtmtmYScTMqc/qZ4yAYQzEX81Ut6573nicxZTHkZpTgtx73QOVGSpZt8WqNMPK/SK5T8JxjW8GREAkeSfrxh+wAumqG30Q2D9ss7olAs8qTFYr5g+JMJIXhZ1R+0E2IjW7zYAcWr1l81Igrszps5lhmHHP8Aw4bueXD55NOluQKu1wGusMj3oMIy1tobgeNjprAcXraDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768555428; c=relaxed/relaxed;
	bh=i6FmR1rK7y2vQnVHxnV0x2iCyA0hmjCiBeXr9y8fmbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMMthEry6B21w35eE738/gAkXB07g1HcCFfKkXNA0UQB0QDDiVOFIIGlV1cBm3nghY0OK0MfwEqMmBQPu4gqZxCTgmmylCws2iTuwjny4y4Yf6U6St3iZi6R60uUOufB4KLggGOU81L6OdAc8lik3GKne+u7ljYQ4aZSQPpwngKpsylXLNqyTehGuvptKSGBBZmT516D3pBT6sCkPmW7O8vqcY/n39hQjrfPvRQmNH8vdygxrvqj+rGP6s8Zr9P4JWHugpqQQKiDdSAEQ7PE2XVFzvba4P3BgjNbEFxEZfDwqbx7CJ8dsfjYZDjJX16BWkYZp4Vaxchl/B+/jVRe6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Rb9F2uVw; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Rb9F2uVw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsvYD7137z2xPL
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 20:23:42 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i6FmR1rK7y2vQnVHxnV0x2iCyA0hmjCiBeXr9y8fmbI=;
	b=Rb9F2uVwRy76r2ry+UINHDEFuCz99b8tZY6ZPnZ4UJKnmEVPxEP0fjnltwF+t6sepxHiQs8DR
	e7d5HWkCJfmZCeBT40L3C9yEQTLs6GRQdMEQM74b2+aFW89eMQQBnbYaipJigd/elEs5mqIRp8x
	qQmcrMmD02UybSQJrIWgbWc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dsvTD6XJ6z1cyT8
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 17:20:16 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 3423240363
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 17:23:37 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 17:23:36 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v3] erofs-utils: lib: fix incorrect mtime under -Edot-omitted
Date: Fri, 16 Jan 2026 17:23:40 +0800
Message-ID: <20260116092340.3691124-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b8540497-50c2-4d4f-8025-060ae6352229@linux.alibaba.com>
References: <b8540497-50c2-4d4f-8025-060ae6352229@linux.alibaba.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`-Edot-omitted` enables `-E48bits`, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves time initialization logic into `erofs_importer_init()`
to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/importer.c | 17 +++++++++++++++++
 mkfs/main.c    | 15 ---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/lib/importer.c b/lib/importer.c
index 958a433..b62ec20 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2025 Alibaba Cloud
  */
+#include <sys/time.h>
 #include "erofs/importer.h"
 #include "erofs/config.h"
 #include "erofs/dedupe.h"
@@ -43,6 +44,8 @@ int erofs_importer_init(struct erofs_importer *im)
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_importer_params *params = im->params;
 	const char *subsys = NULL;
+	struct timeval t;
+	s64 mkfs_time = 0;
 	int err;
 
 	erofs_importer_global_init();
@@ -83,6 +86,20 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	if (params->dot_omitted)
 		erofs_sb_set_48bit(sbi);
+
+	sbi->fixed_nsec = 0;
+	if (cfg.c_unix_timestamp != -1) {
+		mkfs_time = cfg.c_unix_timestamp;
+	} else if (!gettimeofday(&t, NULL)) {
+		mkfs_time = t.tv_sec;
+	}
+	if (erofs_sb_has_48bit(sbi)) {
+		sbi->epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
+		sbi->build_time = mkfs_time - sbi->epoch;
+	} else {
+		sbi->epoch = mkfs_time;
+	}
+
 	return 0;
 
 out_err:
diff --git a/mkfs/main.c b/mkfs/main.c
index 620b1ed..6ee7f54 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1710,9 +1710,7 @@ int main(int argc, char **argv)
 	};
 	struct erofs_inode *root = NULL;
 	bool tar_index_512b = false;
-	struct timeval t;
 	FILE *blklst = NULL;
-	s64 mkfs_time = 0;
 	int err;
 	u32 crc;
 
@@ -1736,19 +1734,6 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	g_sbi.fixed_nsec = 0;
-	if (cfg.c_unix_timestamp != -1) {
-		mkfs_time = cfg.c_unix_timestamp;
-	} else if (!gettimeofday(&t, NULL)) {
-		mkfs_time = t.tv_sec;
-	}
-	if (erofs_sb_has_48bit(&g_sbi)) {
-		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
-		g_sbi.build_time = mkfs_time - g_sbi.epoch;
-	} else {
-		g_sbi.epoch = mkfs_time;
-	}
-
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
-- 
2.47.3


