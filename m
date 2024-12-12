Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7B9EDDB9
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 03:40:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7xWy2fCkz30W0
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 13:39:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733971196;
	cv=none; b=QODYkjTNPTcVpmpk9XoCBkhQ4sDJlXAxRppOvPI9oJFlwVrw2DXGwrNCQ4A/sS7P4VvTYuym0XoM48xs9vCqqBWAYRnXsTxj7DbE1D8HLMstpbQdc43vNjHmvSSQhOk0xyEOSXkiyTp6qbt7xutUHoPu8C5Tx3Zm19TQsS1Ju6TSJwbtQIHZExIQvJiN7jW7/xZSYkJj50VoLzyDVzQ3OJkocH5SvA6y1MjpomZpVwvb2JzMQ1N0xivCyD4/CemxmrMsxXR29OAXYaS/MgiKDZYpT3UR+u5rBq0QmJ7Myd0sbYDkfjQ7ZLQUCuGO1b8C/nDyk4NvII5tNWPlqhcZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733971196; c=relaxed/relaxed;
	bh=zvwBAjm4sRjF6VmYTwkZE+OC+nmPpYLZaHaDGt4Pxe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuD4BFsgXDf+7vCtvaKQ3HdYVDHL7JJ7opec14WbMmTRL0EITWIaX/ibDwzdGpaLykNAdn8Maalh3u6YspduAq+laxALzEPP5i/Sv53HMRKvhOnOczynMFCwrL4NyTDI1GDWFWqGev90tR3GoySgCuwJkLt/PGGTyMqzSB4HOxD54z8AHGUASDhrC8YVlZ5eTJ+kAtQZ/+Q2glc1sZDySjqwN19AbafBYsV5uuscOqkVfy1YbGpU2j5dgTnz+W6c3RiHqKt/oNICS2T1FXvTvIZDQeocRhMSOtGAar4hM3bwflWnyw1gvvappus6yITqoLSflTl+S96g26OyO/j2eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UZmQ10zD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UZmQ10zD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7xWv5fLsz2yFP
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 13:39:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733971191; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zvwBAjm4sRjF6VmYTwkZE+OC+nmPpYLZaHaDGt4Pxe8=;
	b=UZmQ10zDpDMm+BXD9lWCekhAOEvT40VI1Z13IExMMuZ3MGlpZvD85XBrEwYcMbv/x9cWiWj0FnhtQXJcvNuFF9lYITHFdWre0e3TElE9KhxMzTc+NgapdkvhsawEUxrhEcBBlpCcTB6RjannclfnQIU/gLivoDefjjp+cH6RQOs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLK-wx5_1733971189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 10:39:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RESEND] erofs: micro-optimize superblock checksum
Date: Thu, 12 Dec 2024 10:39:48 +0800
Message-ID: <20241212023948.1143038-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
References: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just verify the remaining unknown on-disk data instead of allocating a
temporary buffer for the whole superblock and zeroing out the checksum
field since .magic(EROFS_SUPER_MAGIC_V1) is verified and .checksum(0)
is fixed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  3 ++-
 fs/erofs/super.c    | 30 +++++++++++-------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index c8f2ae845bd2..199395ed1c1f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -9,6 +9,7 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
+/* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
@@ -54,7 +55,7 @@ struct erofs_deviceslot {
 /* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
-	__le32 checksum;        /* crc32c(super_block) */
+	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
 	__le32 feature_compat;
 	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9166054370aa..faf1506c47f5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -39,29 +39,21 @@ void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-	size_t len = 1 << EROFS_SB(sb)->blkszbits;
-	struct erofs_super_block *dsb;
-	u32 expected_crc, crc;
+	struct erofs_super_block *dsb = sbdata + EROFS_SUPER_OFFSET;
+	u32 len = 1 << EROFS_SB(sb)->blkszbits, crc;
 
 	if (len > EROFS_SUPER_OFFSET)
 		len -= EROFS_SUPER_OFFSET;
+	len -= offsetof(struct erofs_super_block, checksum) +
+			sizeof(dsb->checksum);
 
-	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
-	if (!dsb)
-		return -ENOMEM;
-
-	expected_crc = le32_to_cpu(dsb->checksum);
-	dsb->checksum = 0;
-	/* to allow for x86 boot sectors and other oddities. */
-	crc = crc32c(~0, dsb, len);
-	kfree(dsb);
-
-	if (crc != expected_crc) {
-		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
-			  crc, expected_crc);
-		return -EBADMSG;
-	}
-	return 0;
+	/* skip .magic(pre-verified) and .checksum(0) fields */
+	crc = crc32c(0x5045B54A, (&dsb->checksum) + 1, len);
+	if (crc == le32_to_cpu(dsb->checksum))
+		return 0;
+	erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
+		  crc, le32_to_cpu(dsb->checksum));
+	return -EBADMSG;
 }
 
 static void erofs_inode_init_once(void *ptr)
-- 
2.43.5

