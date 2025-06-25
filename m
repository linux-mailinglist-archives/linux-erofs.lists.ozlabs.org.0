Return-Path: <linux-erofs+bounces-490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CFBAE79B3
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jun 2025 10:15:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRvkj2Ls6z307q;
	Wed, 25 Jun 2025 18:15:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750839308;
	cv=none; b=gTN2CcBGCbJUqEQ9wqOm+utLhUtk/FJfoR5q/8i9vgvgplN5QsItfURWDQFu48A23w7E4tGZOxAUDo6td/LVILU3F6DMT29f+o7ZryBV6OWbTnL/HPTPDqOPE/qOF4PpTsZTb/4QdPlDsyZpCmB3LUnGcwuGMSQl6NMVYoz1crK52eOAfJhZ5uUDyYBhxUebybPqbEw50Bvaz89kBcIHyBPhvdNp4Uip7CYxewp8OH5V1uN08fFkaJO+7TzfUxeu7DxAXGD1gq/nATWgiO/aCeIboFHvZo8PKEF2Adozo72xqdKwQr8Bbc1tjF5UQ4J6WZLEOxdgPSFRU8jRR+N/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750839308; c=relaxed/relaxed;
	bh=ADbUH13t/8zhH70KpP1QQ0rHjx1uUSRY2gmyAVEAvkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfeBbkWm4EWGcyvWOhAKYpcmwuuoU2OKoFZUjO6E1HS2ulj3R/3UUSuD4seLz0mrJV1Mrdq9k3TxioYcbzraYCVUsdAIjzwioUcfdojunxKC/A3dYoJbLE8133kzu1M8bQIOfg+xinZoBqH43c/Ep9Vfg0IPxI+4ubGddwZOXOblSqCy8IydhV9tD1ZAXmbWex8rwkePE52BtZJMGGxPZH7BDiuvIUaDAIwsfTCnDrqlGTdWE8QqUhY3MN8o9M7uFHG5jzv/VJMGz3fT9Q1esiSGz53A1eYMAPILr/bIuj9lz/p+PQIgbUxIAKyrnCeRX9hGbQ9DxKGCHO1Iwje/LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E55YVbiE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E55YVbiE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRvkd4lLYz2xk5
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jun 2025 18:15:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750839298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ADbUH13t/8zhH70KpP1QQ0rHjx1uUSRY2gmyAVEAvkY=;
	b=E55YVbiEOLvNzpIyTJX9UvEAhw4iFQ2ieGeOufUGDZB5E8s5hlZao4QskRX/GP7UkLfB5HRjJlQUekyj/P0v72QgRXJ044sNSnuP3UDuYYrcDStY2gxszM9cCMyJd757UNxp/LLpRRNcx8epXsf7k+3RmOQn4SjF9CTtAXBBrGo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wev1XIf_1750839293 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 16:14:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: fix memory leak from small fragments
Date: Wed, 25 Jun 2025 16:14:52 +0800
Message-ID: <20250625081452.1897027-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fix memory leak for fragments smaller than EROFS_TOF_HASHLEN.

Fixes: 84bae6acdbee ("erofs-utils: lib: keep full data until the fragment is committed")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/fragments.c b/lib/fragments.c
index 83fd821..6111631 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -365,6 +365,8 @@ int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh)
 		return 0;
 	}
 	inode->fragmentoff = (erofs_off_t)offset - len;
+	inode->fragment = NULL;
+	free(fi->data);
 	free(fi);
 	return 0;
 }
-- 
2.43.5


