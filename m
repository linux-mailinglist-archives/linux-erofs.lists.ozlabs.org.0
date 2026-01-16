Return-Path: <linux-erofs+bounces-1935-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D35FDD2B24B
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 05:05:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsmTr0jvhz2xSN;
	Fri, 16 Jan 2026 15:05:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768536320;
	cv=none; b=iblz10FLiEhCQ4oJw+is4BcFzOfO5kjLJOsyR6qxePndIaizLiafkyt/bM2OSVxd3sCtxn9gr7nBr/zZFn6EjCpWBtzwiUvOU4kwZILBDva8r8Vko1fYLu0why/BdKvrigf5viZwpFm/+38RKIQ8z6txZR1T5MPXyslPmvZCGghjn2tRc56iRpT1wS3VZCwhGoXtnc+FEidVLD3eQpoAU8YxN3Cymz24j5qSomQ0j42AQt8fLi7jGzVm5K6LBowNS+yeLc7sRZ74vuYKixRMtMjwTk0PBw4VBf7U5RKy032U9ZE8ysL00vkbuukqNqHdlCNls6kQRgySlBblOYKTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768536320; c=relaxed/relaxed;
	bh=XWNeekSTiXv0HyXq/smccFlPm6vq3L4Lw52KKtWZ+YU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikZPvE3rrdrQa5cRAaU07ljCW1eea0cnNBLOHrEiFylB+QVM3URWl4x6IU2KPvkdPsSLjHuktfEA360K75bHkjHy7X5jlZtBUqfVuCNvxz7/cImSxAFMyS2ou7KWk5PZe5tK6Kqol3Bwh3CiGJF0JI4D3QL8FW7bVwd94XVfHmuoHfIikoz1vQ5/manz9zHIs3nqJiC568GzswbVS00K/ScoDrajimwnwhbkunWV/YP1kINrbuE/Kcp4Uj4ckxe2yXaFI3qxQxK2RJ87xdVcG4JXP+7glm8GruOmTdiWSDdioeBf4Zmhr9PI6HZmUBgGaccvjT6Q9So6R6wCtLVztg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Wt7aDKbM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Wt7aDKbM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsmTn269Hz2xPL
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 15:05:15 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XWNeekSTiXv0HyXq/smccFlPm6vq3L4Lw52KKtWZ+YU=;
	b=Wt7aDKbMkVIT7LtQrSVUfYlo30TJWFdGrhTNh3MAQUXxd/MibPrMAHi9cyAtHa7UZoZxNRYco
	5c8ePKlcDrvVzfE1rDieugjw5GYhv/TgX74iI9dl9SvdX7vdX4/C2uor4UbMmdWg7UqDukDkpOz
	ygLRVVg/v+pLKJEj68SKM5c=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dsmPh3ZDkzKm4y
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 12:01:44 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF0F4056C
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 12:05:05 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 12:05:05 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: lib: fix incorrect mtime under -Edot-omitted
Date: Fri, 16 Jan 2026 12:05:09 +0800
Message-ID: <20260116040509.3674821-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`-Edot-omitted`` enables `-E48bits``, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves `erofs_sb_set_48bit()`` forward to the options parsing
stage to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/importer.c | 2 --
 mkfs/main.c    | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/importer.c b/lib/importer.c
index 958a433..cd71a21 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -81,8 +81,6 @@ int erofs_importer_init(struct erofs_importer *im)
 			goto out_err;
 	}
 
-	if (params->dot_omitted)
-		erofs_sb_set_48bit(sbi);
 	return 0;
 
 out_err:
diff --git a/mkfs/main.c b/mkfs/main.c
index 620b1ed..347cdcb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -428,6 +428,8 @@ static int erofs_mkfs_feat_set_dot_omitted(struct erofs_importer_params *params,
 		return -EINVAL;
 
 	mkfs_dot_omitted = en;
+	if (en)
+		erofs_sb_set_48bit(&g_sbi);
 	return 0;
 }
 
-- 
2.47.3


