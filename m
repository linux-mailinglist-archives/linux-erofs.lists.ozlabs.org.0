Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05E9F74F0
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 07:43:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDLc74hgbz30WR
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 17:43:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734590630;
	cv=none; b=DI4Vw9jrHKg6Y/usHoRnhVkowwpZX9Q9A4A8wMhilctEc38alI4YKdBtLeMKIv811zhJWz082BwKTURq9KsDxS5Sbe7kG/3zyvhmYoJfAYPQBozetxQrcTb9lrIxsrcFYGWagnlnDPJgMH0XWDLxkHz6xFYXbXBJyfLcw7YYQ6P7rTkXkIAWueZJoE3PaiHxPDPxnxmbPN0PuG+jsD9rb/6PWro54H7BjOL+9sJqaqI2mMg7znwXAxxeBj+6UDazZVGsBVE0L0MDyJBXt+IwyScBDF6Zu9o4D7h/SbSpDRk6++bKfd3v98Sl9uRsV8UDzSRvrEoOaA2UwdXyQmqNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734590630; c=relaxed/relaxed;
	bh=ALwcBVgJHUKaRy6MlDz44NYHTpjVYbAW+v6dh9jrrmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYlfavZLQ3e5Q5WMNlod3C4ozheJdEsfOY5s70ZMnUUW5mbmAzgaoD7sIeq/jiVaz3wEG9GkzyxGG4FjdZcEFrMePW2IqyDByyM3Vl5EX2jIfdAH5yzoOn91hiTtafRKTrdrt+QXVqoV0yU79aeLlcxzwh6mICInUDtC2x1VeUIEGzck/eLwUD/cjnL2MUFi4ewNdyLMOS5LEO9uQ+/WxNSUGZ7NOM5Uh509btG4ZGGimmmDIkhT/BFaNdjhYLTpK4fptIfOu0k3XCfI1z0kiJ10WaMLrGU/9HXeKRJzE7vKM8Wo1vaFIwfkDzakrgzY4gVrOIeTMFiSUZ2TMNpKMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VMNUfFpZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VMNUfFpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDLc40hrwz2xHT
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2024 17:43:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734590622; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ALwcBVgJHUKaRy6MlDz44NYHTpjVYbAW+v6dh9jrrmU=;
	b=VMNUfFpZ7bCppqAhrxSTc9xerpy8BkNMCEgPoRJj2A7qtYyUYPVWtNELlxqQxlrZ1cg+fvlrH1LpAsBnJgm4OKn8PdTNnW4nZgx9GDUsiks7sjJImD0JyTJgb9dzRm//RDAjg9i1w+vFozB2GPBuPkbtOk4c9wUOti25ZJOGXEY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLpMVJc_1734590619 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 14:43:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/4] erofs-utils: lib: move block boundary check into __erofs_battach()
Date: Thu, 19 Dec 2024 14:43:29 +0800
Message-ID: <20241219064331.2223001-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
References: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It should be guaranteed when buffers are attached, rather than
scattered everywhere.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/cache.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 66bbdca..1cc5007 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -69,7 +69,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   struct erofs_buffer_head *bh,
 			   erofs_off_t incr,
 			   unsigned int alignsize,
-			   unsigned int extrasize,
+			   unsigned int inline_ext,
 			   bool dryrun)
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
@@ -78,11 +78,16 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 	const unsigned int blkmask = blksiz - 1;
 	erofs_off_t boff = bb->buffers.off;
 	const erofs_off_t alignedoffset = roundup(boff, alignsize);
-	const int oob = cmpsgn(roundup(((boff - 1) & blkmask) + 1, alignsize) +
-					incr + extrasize, blksiz);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
+	int oob;
 
+	/* inline data must never span block boundaries */
+	if (erofs_blkoff(sbi, alignedoffset + incr + blkmask)
+			+ inline_ext > blkmask)
+		return -ENOSPC;
+
+	oob = cmpsgn((alignedoffset & blkmask) + incr + inline_ext, blksiz);
 	if (oob >= 0) {
 		/* the next buffer block should be NULL_ADDR all the time */
 		if (oob && list_next_entry(bb, list)->blkaddr != NULL_ADDR)
@@ -111,7 +116,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 						BLK_ROUND_UP(sbi, boff);
 		erofs_bupdate_mapped(bb);
 	}
-	return ((alignedoffset + incr - 1) & blkmask) + 1;
+	return ((alignedoffset + incr + blkmask) & blkmask) + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
@@ -179,12 +184,10 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 			continue;
 		}
 
+		usedmax = ret + inline_ext;
 		/* should contain all data in the current block */
-		used = ret + inline_ext;
-		DBG_BUGON(used > blksiz);
-
+		DBG_BUGON(usedmax > blksiz);
 		bb = cur;
-		usedmax = used;
 		break;
 	}
 
@@ -209,11 +212,8 @@ skip_mapped:
 		if (ret < 0)
 			continue;
 
-		used = (ret & (blksiz - 1)) + inline_ext;
-
-		/* should contain inline data in current block */
-		if (used > blksiz)
-			continue;
+		used = ret + inline_ext;
+		DBG_BUGON(used > blksiz);
 
 		/*
 		 * remaining should be smaller than before or
-- 
2.43.5

