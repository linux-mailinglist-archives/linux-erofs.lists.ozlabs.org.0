Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EB8FADBE
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 10:40:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=je1Wbzd0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VtkZC4J4bz30TC
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 18:40:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=je1Wbzd0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VtkZ40py0z3cQq
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jun 2024 18:40:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717490422; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+yPopFZWz83+QukWfPp1GUKSTe+xJaO6kxj7hVW64XQ=;
	b=je1Wbzd0nh/l6xMEwjs/mc3BTrd0xPd2WUXzAONUNdFU2gY/ekOioSWw9o3TvQbysjpNyqno4TbwXxMSljSdvEv7KXB7Jj6aWss6cEVs09y80QRhTQandgFv+3nykOj/0dFLqgtunpJ+x/jOqas8prCZG1O1TD4cIVoMSvBSh7o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7qIh05_1717490420;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7qIh05_1717490420)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 16:40:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: record sb_size instead of sb_extslots
Date: Tue,  4 Jun 2024 16:40:15 +0800
Message-Id: <20240604084015.2291157-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240604084015.2291157-1-hsiangkao@linux.alibaba.com>
References: <20240604084015.2291157-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Just follow the kernel implementation.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              | 4 ++--
 include/erofs/internal.h | 7 ++++---
 lib/super.c              | 7 ++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index dd2c620..50f4662 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -654,8 +654,8 @@ static void erofsdump_show_superblock(void)
 		fprintf(stdout, "Filesystem lz4_max_distance:                  %u\n",
 			sbi.lz4_max_distance | 0U);
 	}
-	fprintf(stdout, "Filesystem sb_extslots:                       %u\n",
-			sbi.extslots | 0U);
+	fprintf(stdout, "Filesystem sb_size:                           %u\n",
+			sbi.sb_size | 0U);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
 			sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 46345e0..9fdff71 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -84,13 +84,14 @@ struct erofs_sb_info {
 
 	u32 feature_compat;
 	u32 feature_incompat;
-	u64 build_time;
-	u32 build_time_nsec;
 
-	u8  extslots;
 	unsigned char islotbits;
 	unsigned char blkszbits;
 
+	u32 sb_size;			/* total superblock size */
+	u32 build_time_nsec;
+	u64 build_time;
+
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
 	/* used for statfs, f_files - f_favail */
diff --git a/lib/super.c b/lib/super.c
index f952f7e..4d16d29 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,12 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		return ret;
 	}
 
+	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
+	if (sbi->sb_size > (1 << sbi->blkszbits) - EROFS_SUPER_OFFSET) {
+		erofs_err("invalid sb_extslots %u (more than a fs block)",
+			  dsb->sb_extslots);
+		return -EINVAL;
+	}
 	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
@@ -114,7 +120,6 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
-	sbi->extslots = dsb->sb_extslots;
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
-- 
2.39.3

