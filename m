Return-Path: <linux-erofs+bounces-241-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A41A9E0E6
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 10:30:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zlfsd1Hd3z2yr0;
	Sun, 27 Apr 2025 18:30:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745742629;
	cv=none; b=DHUXChpIbgJn2cnA6KYpWM8usgJSYy/vnUW6JTA/1hhek+SX6jmr8tHcmDi/JgFI80UsEPkGrNBpdZZeqIJqKXeDZ4Ym83zXjAaMunMv8NRe1nduEj5T620UHMtumwJbz7wY9yPgGOVraNEZlyq2NE1viZKSZ/CqunR5FoTSBvOd2yDbvcnkWcfS70eag+QmlgK+VFapCdZq/q4kCaXJAfzT3K4TJlKL/ePQ5BuKeRh0/ml+MUopbOHI2WjPN4mlBFWSjZEj4TQM9PTt9gwLN3y29E0DhRO6B7TvXuSlJo7wKmgqc7MjQSRRfqSgfbNOOEqJSCsadzr18xpLV1G/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745742629; c=relaxed/relaxed;
	bh=oD2SRwaK8i24sblgrDT8zhY9GFhN2L2uMWl9zCRGRWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFiZUu7V7m95Zyc3AN2e+TuHbStS6m9+ArtsVVOtOFkxYv+qHJCpxvjC14mT7vvwKZ1g1fOXL2uBp62Pq1atj8tMtF3hAGx17fgh/IqLRBjxBbzmhNjNTw7aOaovJ6WFYuw/yHbMiej+vdl2Z0nUGaPauIh3MEzHfW/omWic2y+XQ/Ck/bEUADJSsGf/do8+89RTp9f+rP39A0Uw+FEHfyrbGgq6RcT/C62HkyCq9X5xx/evXbtPt1Lh0OoFJKwER4dbhm1Bd1GGZMgc7D3rLvgX4GKoHS+8b0gqfdtuvZs6VcGwCdow5Cpx9EWwxW7kiGm3tnAbwPWYkhOapY3Dsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tYEzu6M5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tYEzu6M5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zlfsb0HNLz2xxr
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 18:30:25 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745742620; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oD2SRwaK8i24sblgrDT8zhY9GFhN2L2uMWl9zCRGRWo=;
	b=tYEzu6M5HDsK/vUaZxgUE49RPdWD5zXkUj8Y90r7GFQQnbj9Lg6tDZAZn/5Yc+ScdjnlNTLCp2PEZiPvorfDdTAYQRhEJs/rzFxn5/jd82jsK0QcDB67zRD88E5s/e6y3sFJQIOqFDmE2x0htBK8YEgjw14l3KY8QgyWSSf5Kgo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY8IcdL_1745742615 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 16:30:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: handle crafted fragments in the packed inode
Date: Sun, 27 Apr 2025 16:30:13 +0800
Message-ID: <20250427083013.630329-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Should error out this invalid case immediately.

Fixes: 654a9be311a1 ("erofs-utils: lib: support fragments")
Closes: https://github.com/erofs/erofs-utils/issues/18
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/data.c b/lib/data.c
index 28460ef..0f79f78 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -249,6 +249,11 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	int ret = 0;
 
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		if (__erofs_unlikely(inode->nid == sbi->packed_nid)) {
+			erofs_err("fragment should not exist in the packed inode %llu",
+				  sbi->packed_nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
 		return erofs_packedfile_read(sbi, buffer, length - skip,
 				   inode->fragmentoff + skip);
 	}
-- 
2.43.5


