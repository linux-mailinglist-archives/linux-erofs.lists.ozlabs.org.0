Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B18ED7DD
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 03:52:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 475y5Z5Gc1zF3L8
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 13:52:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475xz73NtdzF3Tb
 for <linux-erofs@lists.ozlabs.org>; Mon,  4 Nov 2019 13:47:14 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DBFE7DE1AF02E49B7528;
 Mon,  4 Nov 2019 10:47:06 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 10:46:56 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v7] erofs: support superblock checksum
Date: Mon, 4 Nov 2019 10:49:37 +0800
Message-ID: <20191104024937.113939-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030050846.175623-1-gaoxiang25@huawei.com>
References: <20191030050846.175623-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Pratik Shinde <pratikshinde320@gmail.com>

Introduce superblock checksum feature in order to
check at mounting time.

Note that the first 1024 bytes are ignore for x86
boot sectors and other oddities.

Link: https://lore.kernel.org/r/20191030050846.175623-1-gaoxiang25@huawei.com
Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v6:
 - fix kunmap(data) to kunmap(page) by mistake
   reported by Dan Carpenter;

 fs/erofs/Kconfig    |  1 +
 fs/erofs/erofs_fs.h |  3 ++-
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 9d634d3a1845..74b0aaa7114c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee5654750d..385fa49c7749 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -11,6 +11,8 @@
 
 #define EROFS_SUPER_OFFSET      1024
 
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
@@ -37,7 +39,6 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
 	__u8 reserved2[44];
 };
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..96d97eab88e3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -85,6 +85,7 @@ struct erofs_sb_info {
 
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
+	u32 feature_compat;
 	u32 feature_incompat;
 
 	unsigned int mount_opt;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e369494f2f2..849c0bdf49d9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,30 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
+{
+	struct erofs_super_block *dsb;
+	u32 expected_crc, crc;
+
+	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
+		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
+	if (!dsb)
+		return -ENOMEM;
+
+	expected_crc = le32_to_cpu(dsb->checksum);
+	dsb->checksum = 0;
+	/* to allow for x86 boot sectors and other oddities. */
+	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	kfree(dsb);
+
+	if (crc != expected_crc) {
+		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
+			  crc, expected_crc);
+		return -EBADMSG;
+	}
+	return 0;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -112,7 +137,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	sbi = EROFS_SB(sb);
 
-	data = kmap_atomic(page);
+	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -121,6 +146,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
+	if (sbi->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_superblock_csum_verify(sb, data);
+		if (ret)
+			goto out;
+	}
+
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
@@ -155,7 +187,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	ret = 0;
 out:
-	kunmap_atomic(data);
+	kunmap(page);
 	put_page(page);
 	return ret;
 }
-- 
2.17.1

