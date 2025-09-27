Return-Path: <linux-erofs+bounces-1118-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA5BA617C
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Sep 2025 18:26:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cYt9r6Fybz30PF;
	Sun, 28 Sep 2025 02:26:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758990368;
	cv=none; b=cz7YJpIWQlBkDp8gkJQlEf2yF/Ah1nshE80VUyYzU4cvrtVlM61Z7zmoE5D6sJVsiIP+pvxDx7tiGx6ZKDLvk1qMSpXtNvu2SQ0SCcyGw1mqTasG4bkidUAzVZBGxIlPHD9S0rgGWvYARLEVGnETMHbsLY6pXs2/RJETO3UxTctD4zEMmw61WqQAQyeXr6LkuTL9yWhwnItMwTnBHStZlmaa20VbZe23KsWqrtTqQS2bg6uqcE51NTqNVRDAjmyoVopz1cZKFhqn+PCuo7wC/ONVvEJV/sM0h/Of5UXZhNJCNP+xFR8i/Dic63axnatBZzZz6jIP4biW0YxIAqDOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758990368; c=relaxed/relaxed;
	bh=4Ps0DplQXA73X53g2Vfz3oFTN83weJFlSXKJI57GVfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpJuxQHmC/2qM/wMrguRjOapZoa0wcjAaaSK9sXYpGnQRZ4S3JW6hir1qTMxZRgICBLTWNqcBPIbEQTEu3kQ2IlaQU3KCWsy2Cij0fGEVx6qQ6f8fXFkYNQStkf17kXKo55cv0UryIgn14u+Jkc1QBklIX44SRTxunipexgxdzIO5Cwlf8AYKp+/4neqt2J5vqzdYea6I+EseA58bG7iEpntSXdxOo0LjuHTahkfwQxag1vmCp1eLYf/eyyad7G235lCpzi740RQoMojSQTHu88SyCGr172aSZ5X2K87DhBFM+cOEEVZFzKyiLrWgAP5VsGTXmlGyYc9fFlsO1r6KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G5xEXHrg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G5xEXHrg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cYt9l3898z301K
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 02:26:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758990356; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4Ps0DplQXA73X53g2Vfz3oFTN83weJFlSXKJI57GVfs=;
	b=G5xEXHrg1WUmrpZiAWld9AnuVfeiGPFOo0sdBXWzwCReoChooV0/kDBW3vyzyczlsmwis8BoYwjRve1N69WkQQ6eWH/TeGMY3JchQ77txwlEQM8JrGa0hhD6e6zNUBF46ZXg2BLJ91rrVshUGdzaABZBUGGMEEPPirGiBXeOsOg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WovwCf5_1758990349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 00:25:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix incorrect big pcluster judgment
Date: Sun, 28 Sep 2025 00:25:47 +0800
Message-ID: <20250927162548.1508593-1-hsiangkao@linux.alibaba.com>
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

`params->pclusterblks_max` should be greater than 1.

Fixes: 0d0aa8522672 ("erofs-utils: lib: migrate pclustersize configurations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index b4c2d1b..f879d3e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2130,7 +2130,7 @@ int z_erofs_compress_init(struct erofs_importer *im)
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (params->pclusterblks_max) {
+	if (params->pclusterblks_max > 1) {
 		if (pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
 			erofs_err("pcluster size (%u blocks) is too large",
 				  params->pclusterblks_max);
-- 
2.43.5


