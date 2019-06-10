Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EF3B250
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jun 2019 11:37:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Mp2c29vhzDqRK
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jun 2019 19:37:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Mp2V1wDszDqRD
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jun 2019 19:37:35 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C663E4202C791DA4E475;
 Mon, 10 Jun 2019 17:37:27 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 10 Jun
 2019 17:37:21 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH 1/2] staging: erofs: add requirements field in superblock
Date: Mon, 10 Jun 2019 17:36:39 +0800
Message-ID: <20190610093640.96705-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There are some backward incompatible optimizations pending
for months, mainly due to on-disk format expensions.

However, we should ensure that it cannot be mounted with
old kernels. Otherwise, it will causes unexpected behaviors.

Fixes: ba2b77a82022 ("staging: erofs: add super block operations")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/erofs_fs.h | 11 +++++++++--
 drivers/staging/erofs/super.c    |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index fa52898df006..531821757845 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -17,10 +17,16 @@
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
+/*
+ * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
+ * incompatible with this kernel version.
+ */
+#define EROFS_ALL_REQUIREMENTS  0
+
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
 /*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;
+/*  8 */__le32 features;        /* extra features for the image */
 /* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
 /* 13 */__u8 reserved;
 
@@ -34,8 +40,9 @@ struct erofs_super_block {
 /* 44 */__le32 xattr_blkaddr;
 /* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
 /* 64 */__u8 volume_name[16];   /* volume name */
+/* 80 */__le32 requirements;    /* all mandatory minimum requirements */
 
-/* 80 */__u8 reserved2[48];     /* 128 bytes */
+/* 84 */__u8 reserved2[44];     /* 128 bytes */
 } __packed;
 
 /*
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index f580d4ef77a1..815e5825db59 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -104,6 +104,14 @@ static int superblock_read(struct super_block *sb)
 		goto out;
 	}
 
+	/* check if the kernel meets all mandatory requirements */
+	if (le32_to_cpu(layout->requirements) & (~EROFS_ALL_REQUIREMENTS)) {
+		errln("too old to meet minimum requirements: %x supported: %x",
+		      le32_to_cpu(layout->requirements),
+		      EROFS_ALL_REQUIREMENTS);
+		goto out;
+	}
+
 	sbi->blocks = le32_to_cpu(layout->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
-- 
2.17.1

