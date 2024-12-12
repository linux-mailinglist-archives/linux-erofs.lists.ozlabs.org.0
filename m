Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D79EDDB7
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 03:38:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7xTk5nCkz30VM
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 13:38:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733971080;
	cv=none; b=Ikg6aMgYLsm+tGm4kWISQR6sMej7PMRm49+KJdvvmGdAgU2jb73kMyMnR8Q8geVdd6L+m+HZbP4GsJj4g6HelrDYoy9tICurN+6t2PLf93dzqMLw7HonvuHc97ccCk/Y2DIHf5hDTFncqvMWR26s5x4suCDBNoeby96iqHcOo5foGPfXe2X1YwXlSkcaiD2VTUaCL6LSyVLyOtojXIl6LXJ4fG9LYIwdRKk+3ga3GMcFmILC5sHi504CRe6I1/fdIEDkjb52UH7H/m8GM4SQdfRXcOXull/BKZC70NMXPBcF+NWpAoBBSRWt5WpN8PujMmXGbMNgFYSwVHS+HbsQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733971080; c=relaxed/relaxed;
	bh=gu/xoflJF8PWAuUvKcFMh6/9TuZuICRr9lznBaUcGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvP5JkifCqjpPyfwNhPUkIYIziv32Ie7CZdm51BA8T2zBtUN+agOpoP+GEa9jiE0kPUB9P3a9q0VlEZiBteBEVjBMfsgqsSGL+B6bYyGmaFudpRFKB6s2oRrvQ4XWFliNcbqFvyxx2rlk+CxoV9zipERUlaWk0cbWnHb3YDUjxR+ohc2q73ROdDNEER0L+8xzYbNOPZI82zy2yhrMUYFuRAMGfCcrhB32OC8kvuHVnw5x7154uWvsuSh/zmwv52/+EPRCbHE/2M4SR9r76nAF3Pw+QHjbZUKGd5mcK3hhaRqcve25RynbzVo1+DN6MxFWan3CiCwvcLbNsLmmuT03w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mI5hhA5r; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mI5hhA5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7xTc2Wjvz2xHF
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 13:37:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733971068; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gu/xoflJF8PWAuUvKcFMh6/9TuZuICRr9lznBaUcGYg=;
	b=mI5hhA5rxaCfyrlhO7beojrFaY95hqbIE0/iQRZeaNtrHHUmhkgbyglULelNRzXby05uLxFkFW/iOv3DZjrE13xzFJQvI9TYFzF/rt1E27r+2DwiDeGPvErWps03vUYXfiIf9Hx8qpzrbnQRVzM9eGkVzSqEcPjBcUvuvt66Jqk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLJyHuE_1733971058 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 10:37:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: micro-optimize superblock checksum
Date: Thu, 12 Dec 2024 10:37:37 +0800
Message-ID: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.0
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
 fs/erofs/super.c    | 31 ++++++++++++-------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

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
index 9166054370aa..6cc0c5ea5ff5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -6,6 +6,7 @@
  */
 #include <linux/statfs.h>
 #include <linux/seq_file.h>
+#include <linux/crc32.h>
 #include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
@@ -39,29 +40,21 @@ void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 
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

