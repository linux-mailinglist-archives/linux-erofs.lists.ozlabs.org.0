Return-Path: <linux-erofs+bounces-1413-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E5C731E2
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Nov 2025 10:26:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBtJd6ktRz2yr9;
	Thu, 20 Nov 2025 20:26:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763630785;
	cv=none; b=oUevpDBOl/BqotTdDItzHE6eGgdviyghjCA+GKYwyyk3yiP3pb3Ns8DUp2FwAKZTgKfQtVfNJ0+TG/T6b1do2u+Ym5otgRHhbw+Z+Kh9ilgOJJYKEYlYkk5VrZ8uU+YCUPosjeKoQ3GYjGVLN0KbHKsurrFSDYGE73MqBGXWAk74hm8FFJjlfcy9JRTuP85qQAqokWfZDpJ8xoDxNmVIO44wW0TWqT65K2dq2Wn2JZB8JFFslZr8zyn+heTA+oImphjegTIR9tGHIQ2GZBXEGEFUJKSxjX5YOP5GPdR6a+5fFIyXllGAefMvLDQKJCUnBeKa2Wrm0cmxMkbWSWrJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763630785; c=relaxed/relaxed;
	bh=YuXOMExEGLmU3ZU/nkr8Dkjyi8E1Cb5gTcqdkaiCp6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hW/79pHscfc2j1KJ+ZW8vc8JtSrYC5n8XFZal+jhhR2ZXbX/Ht8II840DJS823D9w0wT8UExrEK1H/nwwzAKVqmz5UJpoLFckccEb83xuKd3OUP9cibl46/5M0hDVr6HQHKBtWdEOKfB9tAFB2ZWwJmLPgOKKw4vo1BSv3EyzytewSNmhz9BPywZy5OlP/AzE+AbZ4g66RtQIO+ARbao7Kts93vL/TLYe1dKXOMC/A3sDMgj5u1LviYcVUUIlHr4nJEdIptv6zVFw/n48cZ09kTtAPuSlNZFCWJLvj2k1NEc6UMcc/MIHomXs8voT1LunUX53p9Iv2IeLbr+a9D2ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vyyudY5p; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vyyudY5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBtJb1l1dz2ypW
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Nov 2025 20:26:21 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YuXOMExEGLmU3ZU/nkr8Dkjyi8E1Cb5gTcqdkaiCp6U=;
	b=vyyudY5pw4gVbFoW0VDKxGoDUr2hSxlri+YwMVyzFw25cOHSX6vD/Mse+tm9Tkfwuo20UNf8h
	BjKx64Wz1gpfhdRt3C6AS/i9VwE1BtWues2fbc1SbhXfAnAvgrzqos1b+OmTDZMS+kPTVR/8YZx
	wHQ0rXrg03vHBlj4PTeGK4w=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dBtGQ5ZfPz1cypF
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Nov 2025 17:24:30 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 78E9C140155
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Nov 2025 17:26:15 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Nov
 2025 17:26:14 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [PATCH 1/2] erofs-utils: mkfs: fix memleak in error exit path
Date: Thu, 20 Nov 2025 17:22:14 +0800
Message-ID: <20251120092215.3635202-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.33.0
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Cleanup functions `erofs_put_super()` and `liberofs_global_exit()` are
not executed if mkfs.erofs encounts an error. Fix it.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mkfs/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 76bf843..5937027 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -2024,11 +2024,12 @@ exit:
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
 			  erofs_strerror(err));
-		return 1;
+		err = 1;
+	} else {
+		erofs_update_progressinfo("Build completed.\n");
+		erofs_mkfs_showsummaries();
 	}
-	erofs_update_progressinfo("Build completed.\n");
-	erofs_mkfs_showsummaries();
 	erofs_put_super(&g_sbi);
 	liberofs_global_exit();
-	return 0;
+	return err;
 }
-- 
2.33.0


