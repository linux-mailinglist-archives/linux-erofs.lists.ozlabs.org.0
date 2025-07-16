Return-Path: <linux-erofs+bounces-635-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4719B07186
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 11:23:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhrFX3gsXz30VV;
	Wed, 16 Jul 2025 19:23:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752657792;
	cv=none; b=UTydyHbPBwMKGQ3Y8RZgfGtOunpTNqOifmJAo1xp5iZerPJ4mASQSztNsgpsVNVlTYzbxuQvRQhID7u4r9DLwpwrFo2QWXXPf92KkNfqCdMKkue1UBLSxLPdX5GuVLOB5YHd0IFcFNKLF2fByUWKMrrLWWjzfNbuYUD7nJJ4tD1NBKAsBw/trTA1kyrRnQYvefNPfcTrJuFWu13GyS3dgLleBgjkZBR2AWRPdrKw5e9XnAByQoGTcIU1Us8MJ4xL9uJio78q6ntUNQg8DqvjDMXceOoTDahNCIsq/UEkqJxKRLFAVXWq9AC2og+KBDMKE/q41D2Z/dopigESsB5n4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752657792; c=relaxed/relaxed;
	bh=oRq1da1ShbWLicICYakMfFg739TWglB9aY30Dnetp14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7w/mrY81+XJvPMvxaiSnNnFCuYvdsNsNBM4Qaie+pgteJ2Q7GAflks7ATZR3fk4Fu/AN/hU3PQGCqvw5x0JT8t4JVIRhRv2mCuukzhunys/1TFcvlh3JhJRTIWOgbYMmkPCRSh8V5NSNMR+7qbnkmX4NaM8UctYVwAaUD0ny7SmIKrlz87LHAE9jFHZlYVt92HiWv1kzvUsIFmJgqxIkazOahH7MsY/K6chChPiiw7+102d/3eQj/JXYpSNY20sR1heGS80+o7VShBshaYodGZQ1kvUhpPnBDV6jqEoLB0YjxxJJxZiwVM2PMmaXlaDiE529RkmW83HH6sP4mWfRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d/68gguZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d/68gguZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhrFV0ypJz30T8
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 19:23:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752657783; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oRq1da1ShbWLicICYakMfFg739TWglB9aY30Dnetp14=;
	b=d/68gguZZyVdAaiKc5amjvZhwrHqEPk7e00lsbzZU2NQH4DFMYbaiA6XuaSURBqrcoe5pCeaEXsp6IRLb7Ig5y0Wa+0XH1WjDumayoc2qtumiE+b5ZSfkTRPGCin2RBkFozn5bBTKdIkQdVevUOcw72rgWVgO97CZdzYttkplh0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj3WLvn_1752657776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 17:23:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: refine erofs_iomap_begin()
Date: Wed, 16 Jul 2025 17:22:54 +0800
Message-ID: <20250716092254.3826715-1-hsiangkao@linux.alibaba.com>
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

 - Avoid calling erofs_map_dev() for unmapped extents;

 - Assign `iomap->addr` for inline extents too (since they have physical
   location).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index dd7d86809c18..383c1337e157 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -269,6 +269,16 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
+	iomap->offset = map.m_la;
+	iomap->length = map.m_llen;
+	iomap->flags = 0;
+	iomap->private = NULL;
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		return 0;
+	}
+
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
@@ -277,22 +287,14 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret)
 		return ret;
 
-	iomap->offset = map.m_la;
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_dif->dax_dev;
 	else
 		iomap->bdev = mdev.m_bdev;
-	iomap->length = map.m_llen;
-	iomap->flags = 0;
-	iomap->private = NULL;
 
-	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		iomap->type = IOMAP_HOLE;
-		iomap->addr = IOMAP_NULL_ADDR;
-		if (!iomap->length)
-			iomap->length = length;
-		return 0;
-	}
+	iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
+	if (flags & IOMAP_DAX)
+		iomap->addr += mdev.m_dif->dax_part_off;
 
 	if (map.m_flags & EROFS_MAP_META) {
 		void *ptr;
@@ -306,9 +308,6 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
-		if (flags & IOMAP_DAX)
-			iomap->addr += mdev.m_dif->dax_part_off;
 	}
 	return 0;
 }
-- 
2.43.5


