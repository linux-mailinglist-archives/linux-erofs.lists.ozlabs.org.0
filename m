Return-Path: <linux-erofs+bounces-989-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C396CB4A3C9
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 09:38:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLbJg1Wcrz30N8;
	Tue,  9 Sep 2025 17:37:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757403475;
	cv=none; b=UeitiPV7LuMy5R7nArxnBnTtiBbqVHlIrPsE5JVt7K6VVl7fHU/0p9snyVSTh1Yknr7ukUejSZVxtQTIHof28jYOFeVzsmoz2eJpvEi6e/FQd31FeEm7DqZh75YABWw2UZSG+Ox5RY6adFOUfnyyP2r73Yx+I/Ek2rI3SkohoS7HAWQnkzEPcldCQ9OTcz1km1cfkXp8Gh4jBgLlV83zPo8Lq7ySpmPLxy9OVE/VloAoa9auzWjdpqSVgYqaKeAltbbHUrL6yo5++RewK7HVsXEOt99r49fJtdrM0XSo9/kf3a0+eEUS3DbM1UeHp6t6gZORFy1SO2p3XFMiI/qOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757403475; c=relaxed/relaxed;
	bh=9xvNfBqQOqUWKpBE4u/xP5LmFCfQGdpy0370+qpMcYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5uEZNemRfhIhWM2T4Ed8gp5wd08bEZjvZHh561zsvpe1KiQNITbHHxUTElkpdh5WQsQ+RB/302etWfkckkAhYYaAwswzNpwfgbeqthnZH9vxjNb7ZbcoFk87zHN/ClRm2mZi1eFL/PH+QBGgtudHgzVOJERXWdg4yHia29tM3Q53t8iwSpMZXA8aL+/9uJEUF5hi8WTg95W2MnskGNXzq2ADHHGyLnlbBwRR1PwjFtoVGhTAhj3AtawMY3u6Qf8SwJIbnjLMYibB3aOSyVZ2ZVawA8A/cBg9j8q3dKcPa0RfUTdIHQIrm4zzzAvosLVuvix6XPRHI1krSQjJWNY2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLbJd64Dqz2yqh
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 17:37:51 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eb17-wi_1757403466 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:37:47 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] erofs-utils:mount: fix memory leak in erofs_nbd_get_identifier
Date: Tue,  9 Sep 2025 15:37:45 +0800
Message-ID: <20250909073745.99080-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909065500.75576-1-hudson@cyzhu.com>
References: <20250909065500.75576-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

The erofs_nbd_get_identifier() function returns dynamically allocated
memory via getline(), but the caller in erofsmount_nbd() was not
freeing this memory, causing a 120-byte memory leak.

Add proper memory cleanup by calling free(id) when the identifier
is not an error pointer.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mount/main.c b/mount/main.c
index b22a729..c52ac3b 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -691,6 +691,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 			if (err)
 				erofs_warn("failed to turn on autoclear for nbd%d: %s",
 					   num, erofs_strerror(err));
+			if (!IS_ERR(id))
+				free(id);
 		}
 	}
 	return err;
-- 
2.51.0


