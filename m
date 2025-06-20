Return-Path: <linux-erofs+bounces-476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43095AE1CF8
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Jun 2025 16:00:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNzdm6qczz2yFK;
	Sat, 21 Jun 2025 00:00:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750428044;
	cv=none; b=l8csFPafJknDVqFXcNQO+Dpw2wxu8BJSfN64cH4gTWFxR9P+qoH2vfRg11fqSIBPJeWYgWjrjd/C4COFQunwEHb8oup5Vjp1UiTohoPxvT7YhXbQhqLRV2UQXIzMh/CoPbsEvC+RtkesseZiAiIxAnw9AS69ADHOhUrzeVaPjKQLrv3AfJLg1EbTJzo6VvkTwYQo7eN2J7ck0pvKXgvVGIvKOifGJWMtwAcURTGWSixPp69P2BlRTm4NflvmpglKyHOk0VxWvSdztqBAoBcA80JMVILce6t6sHvThBg+BB0fLOm+pzsRsmLyDiksiBsElITt9CjqIX1rZnCLn8TVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750428044; c=relaxed/relaxed;
	bh=Qp9Zu+pxMlQo328MqSz39C11Z+hXjkNUFPzyliQ+beI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEs4WaP9jmoP+euBM1MmspLdpio79HQM5YsETU9g+uGqM25uM6mPF9wJSSq/vABV1G9EIZMGWl69dmR8ei5Efs6nx3yMpd9s6capbTiT/eeRn0zQV1FB+DWjXF0a2xFgZkYwC22HH4bcqKW41R4LHeoKRbIwsQB8X1Y2vmKhQisQsGDequcylKe5pJpoJkv9S24jCyFGQW3nx0iIerCHWkQAvtYHvuQOfjQa3tongSdYu+d1iDfsfxFyxkDyWpx4ULZDYaPFs3vZXBo9/vyUjeKa4oNUU5HYTGg6C/lffIOCzpyzq6BYg/EAYirOX7vLSSodUKhDxBKZZig5Qy1idQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AXQW2Y5v; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AXQW2Y5v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNzdk4x3Bz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Jun 2025 00:00:41 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750428036; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qp9Zu+pxMlQo328MqSz39C11Z+hXjkNUFPzyliQ+beI=;
	b=AXQW2Y5vE05V6ZDC5evKh8cJXGWyIMFnUiVH6eY8kv8YUfIdmjW8uzkOMlT5SL0z9Vyvw63Jp75zkTx0HpVIH6ZUjcHwe5ZGlhcbOvDebJpq0v8Ek1Zr5ktsXOeXOWm0vcHORzQkX6sg5tHt2wr7Veq3E0oT8poR/iGZzDjVreY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeKyTHz_1750428030 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 22:00:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix sub-page block handling in erofs_read_superblock()
Date: Fri, 20 Jun 2025 22:00:29 +0800
Message-ID: <20250620140029.1243087-1-hsiangkao@linux.alibaba.com>
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

`sbi->sb_size > (1 << sbi->blkszbits) - EROFS_SUPER_OFFSET ` doesn't
work correctly when the block size is 1024.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/super.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index fb644bc..8efef50 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -76,13 +76,13 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 {
 	u8 data[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_super_block *dsb;
-	int ret;
+	int read, ret;
 
-	sbi->blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
-	ret = erofs_blk_read(sbi, 0, data, 0, erofs_blknr(sbi, sizeof(data)));
-	if (ret < 0) {
+	read = erofs_io_pread(&sbi->bdev, data, 0, EROFS_MAX_BLOCK_SIZE);
+	if (read < EROFS_SUPER_END) {
+		ret = read < 0 ? read : -EIO;
 		erofs_err("cannot read erofs superblock: %d", ret);
-		return -EIO;
+		return ret;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
@@ -105,9 +105,8 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	}
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
-	if (sbi->sb_size > (1 << sbi->blkszbits) - EROFS_SUPER_OFFSET) {
-		erofs_err("invalid sb_extslots %u (more than a fs block)",
-			  dsb->sb_extslots);
+	if (sbi->sb_size > read - EROFS_SUPER_OFFSET) {
+		erofs_err("invalid sb_extslots %u", dsb->sb_extslots);
 		return -EINVAL;
 	}
 	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks_lo);
-- 
2.43.5


