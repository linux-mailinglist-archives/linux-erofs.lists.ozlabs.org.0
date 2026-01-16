Return-Path: <linux-erofs+bounces-1936-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE4BD2B29A
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 05:07:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsmXM4RM5z2xSN;
	Fri, 16 Jan 2026 15:07:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768536451;
	cv=none; b=cgdSrTy8ZUf0OynO3bLL1FgAxiVNXNqhQ0xEnmJexhIYZ4UuzwfOfI30Wn07A7K8i5j+5wxFjf6dd2G0vkgaTNM0ZDh7l0+DtB1GDH9dt/0hGcTCHkPFR6ZH7OlDsnLx/Hw31YgWh9sEupUx6vSAC4bV1bnS6wLLsV8KSiGJi+e1l2pLvu+c5NqGolnXgFimacCBqeZA2wb3nIc24Kob4eE2Ij1FUtgvHtZ2uvja1K6jo8nyVyCY5s6ghDjNOf/fF2vZgicR2QeHq6c+zwHxbhJ3C1VY5k4846e8xPeyG47gp6IE+w+EfWRjjKaayeUGZY8C3rt1LX36xY5Go8Fa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768536451; c=relaxed/relaxed;
	bh=oxhqIJf45o9V1hDrQO1qKQEe53GbO7lRSeyvzIbPZ+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfcLKgYA5vgratOTZV/uEsMh5FLlX04Kieu2ZE8MbyAZqMmh+YV2BsNNqPZT8Un0AGBSDluXrPRW1R3YK1YB3+WP7ToaHgcQPtfTh+g9jxb+tw/gw90J7W+vj/5meLuBnF00y3YVUBN17t7fRfO73wQWniuOVTgpQ8YLlhHM+zmrPiFzi2k7h3AHAl/K7fYjldlZOA+XDF7n7IfpI5WP4C3qw7+oqkDvLFfWDPPTyxDdvjdYsZK4Q2rHpyJVnhs+pKVWNmX+g/vDlwJWfdkqZQklACD2UnVx8gYUgcLkWDtz8WMLWhD68YEwcHY4pB95BMqgcuZZMvcsIIP2r+ZZfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aCOIOMPH; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aCOIOMPH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsmXL5XqKz2xPL
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 15:07:30 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oxhqIJf45o9V1hDrQO1qKQEe53GbO7lRSeyvzIbPZ+g=;
	b=aCOIOMPHlChmViXom9l3QpUYQo6Dwc2zH2Tjylf4jShsUctQe1Ab5uzZZUWZ0n5YS/bHVNPLY
	NTDCf1+a4J3Ssk6JM4kfUHh9ZIyBI80HRHFNLMXTZWuTEyVqj8t5zg86QzWobeWX/O0rRUntbxR
	JjGXf3WNXGLTkdke7UcXBMo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsmSq0Tdtz12LDk
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 12:04:27 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 4402140567
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 12:07:26 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Jan
 2026 12:07:25 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2] erofs-utils: lib: fix incorrect mtime under -Edot-omitted
Date: Fri, 16 Jan 2026 12:07:29 +0800
Message-ID: <20260116040729.3675421-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116040509.3674821-1-zhaoyifan28@huawei.com>
References: <20260116040509.3674821-1-zhaoyifan28@huawei.com>
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

`-Edot-omitted` enables `-E48bits`, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves `erofs_sb_set_48bit()` forward to the options parsing
stage to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
v2:
- Fix mis-formatted commit msg, oops..

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


