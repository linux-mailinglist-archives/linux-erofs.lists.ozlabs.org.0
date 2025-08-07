Return-Path: <linux-erofs+bounces-791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78380B1D432
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Aug 2025 10:20:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byKq66kQCz2xck;
	Thu,  7 Aug 2025 18:20:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754554834;
	cv=none; b=Omp2eutkrViKSDCxoGiO62R6Ox3TYAHlbAXl2eQvx9s4TOocTWPM7eNREshFtDWCbDTZLEMyXXEVIKH0gK9WeeX6foQ4wMkvvYB3ryzVhemVXavqPjDoDFpK6BLZ42PT6Sb8NFSrzPympbMGM+xc+39gDTCoX+gFIaGZljJHam0EbUJ5lL0dI0kVtt6ME1bYLZdfzhGNModsGYOUMnWsd8Y3XM3vuAG6SNfeAOjcbvIEIrU8U0obGCkfFgxsK0JYystb094eOpmo7IOWzadcyQd2BC/RrxDPTHxLE5pWMQIA1HAFasYIljwR2jFeD5xvwKFuWWn7srq41jNQplH+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754554834; c=relaxed/relaxed;
	bh=Slt0hp4ov7NR2wbSxNCQhhukVQ0RwOD/sGT8MUG2I6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGkbfhPsT2Y1zdhm4ll7+B9yvPwBdZGDMFdAr+wN4cl+ffsM0fpiJyHQXR7nPEuAOj3UJ+x2v73VDbm3M3aT6H7pzpFW34zqOholZg+6EilyYEG8Ed6mOz0qAFWPmyQr1slKO2/yYZ8Jf6ctZ23eOWyQ/nm/Lrz3cpcVgI4GQsJh8zYfw6nyD6qi5mnLWDKUzLMtCL4uivk7XsysyCQXK5Ag88dnn+U06yV7o4afzYdvm6f0zxJo55trZorollfozP4Su3X6l8HbG8g4406jhh0IZjF2JsXg7ePMGeLksORyyyeGfHHCpZG7icT0KtjTD1Aw0iTS6U5yjYtCQvWKGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvmPxBJp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvmPxBJp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byKq43jrrz2xcD
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 18:20:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754554826; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Slt0hp4ov7NR2wbSxNCQhhukVQ0RwOD/sGT8MUG2I6Y=;
	b=MvmPxBJpYq7fXwT0tjKGt6/FdDFIQNNuVqH0Ap5yu8rGsezDxvu1obHfRmhs+FT4HKPvIeGHW4Z5Z1hPoXM4Zk4+0ZcvO02QuMSCKpMcr42oiqHcBjaWLQB3ps9rCLUW6lCMAUu/p1xjEs9YaZHD7HD04Et6nTQBEUOY64QfryY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlDe27._1754554820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 16:20:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix block count report when 48-bit layout is on
Date: Thu,  7 Aug 2025 16:20:19 +0800
Message-ID: <20250807082019.3093539-1-hsiangkao@linux.alibaba.com>
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

Fix incorrect shift order when combining the 48-bit block count.

Fixes: 2e1473d5195f ("erofs: implement 48-bit block addressing for unencoded inodes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1020aa60771..4ca7ab4e1e82 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -313,8 +313,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
 		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
-		sbi->dif0.blocks = (sbi->dif0.blocks << 32) |
-				le16_to_cpu(dsb->rb.blocks_hi);
+		sbi->dif0.blocks = sbi->dif0.blocks |
+				((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
 	} else {
 		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	}
-- 
2.43.5


