Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDEE753009
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 05:38:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2HJP6C9Hz3c1w
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 13:38:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2HJL0g3bz3bVG
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 13:38:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnK9lEl_1689305913;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnK9lEl_1689305913)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 11:38:33 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: deprecate superblock checksum feature
Date: Fri, 14 Jul 2023 11:38:32 +0800
Message-Id: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Later we're going to introduce fs-verity based verification for the
whole image.  Make the superblock checksum feature deprecated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Kconfig |  1 -
 fs/erofs/super.c | 44 +++++---------------------------------------
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f259d92c9720..ebcb1f6a426a 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -4,7 +4,6 @@ config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
 	select FS_IOMAP
-	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
 	  file system with modern designs (e.g. no buffer heads, inline
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..bb6a966ac4d4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -8,7 +8,6 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-#include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/dax.h>
@@ -51,33 +50,6 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
-static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
-{
-	size_t len = 1 << EROFS_SB(sb)->blkszbits;
-	struct erofs_super_block *dsb;
-	u32 expected_crc, crc;
-
-	if (len > EROFS_SUPER_OFFSET)
-		len -= EROFS_SUPER_OFFSET;
-
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
-}
-
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -113,15 +85,16 @@ static void erofs_free_inode(struct inode *inode)
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *dsb)
 {
-	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	EROFS_SB(sb)->feature_incompat = feature;
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
 
 	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+	if (sbi->feature_incompat & (~EROFS_ALL_FEATURE_INCOMPAT)) {
 		erofs_err(sb,
 			  "unidentified incompatible feature %x, please upgrade kernel version",
-			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+			   sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
 	return true;
@@ -365,13 +338,6 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
-	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
-	if (erofs_sb_has_sb_chksum(sbi)) {
-		ret = erofs_superblock_csum_verify(sb, data);
-		if (ret)
-			goto out;
-	}
-
 	ret = -EINVAL;
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
-- 
2.19.1.6.gb485710b

