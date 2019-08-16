Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4248FBD9
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 09:13:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468vfg4vXrzDrdQ
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 17:12:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468vf671vVzDrbt
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 17:12:30 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0B2F5E6B3FC0967671C6;
 Fri, 16 Aug 2019 15:12:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 16 Aug
 2019 15:12:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] staging: erofs: use common file type conversion
Date: Fri, 16 Aug 2019 15:11:42 +0800
Message-ID: <20190816071142.8633-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Deduplicate the EROFS file type conversion implementation and
remove EROFS_FT_* definitions since it's the same as defined
by POSIX, let's follow ext2 as Linus pointed out [1]
commit e10892189428 ("ext2: use common file type conversion").

[1] https://lore.kernel.org/r/CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com/

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/dir.c      | 16 +---------------
 drivers/staging/erofs/erofs_fs.h | 17 +++++------------
 drivers/staging/erofs/namei.c    |  2 +-
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 01efc96e1212..5f38382637e6 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -8,17 +8,6 @@
  */
 #include "internal.h"
 
-static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
-	[EROFS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[EROFS_FT_REG_FILE]	= DT_REG,
-	[EROFS_FT_DIR]		= DT_DIR,
-	[EROFS_FT_CHRDEV]	= DT_CHR,
-	[EROFS_FT_BLKDEV]	= DT_BLK,
-	[EROFS_FT_FIFO]		= DT_FIFO,
-	[EROFS_FT_SOCK]		= DT_SOCK,
-	[EROFS_FT_SYMLINK]	= DT_LNK,
-};
-
 static void debug_one_dentry(unsigned char d_type, const char *de_name,
 			     unsigned int de_namelen)
 {
@@ -46,10 +35,7 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		unsigned int de_namelen;
 		unsigned char d_type;
 
-		if (de->file_type < EROFS_FT_MAX)
-			d_type = erofs_filetype_table[de->file_type];
-		else
-			d_type = DT_UNKNOWN;
+		d_type = fs_ftype_to_dtype(de->file_type);
 
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 8dc2a75e478f..6db70f395937 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -282,18 +282,11 @@ struct erofs_dirent {
 	__u8 reserved;  /* 11, reserved */
 } __packed;
 
-/* file types used in inode_info->flags */
-enum {
-	EROFS_FT_UNKNOWN,
-	EROFS_FT_REG_FILE,
-	EROFS_FT_DIR,
-	EROFS_FT_CHRDEV,
-	EROFS_FT_BLKDEV,
-	EROFS_FT_FIFO,
-	EROFS_FT_SOCK,
-	EROFS_FT_SYMLINK,
-	EROFS_FT_MAX
-};
+/*
+ * EROFS file types should match generic FT_* types and
+ * it seems no need to add BUILD_BUG_ONs since potential
+ * unmatchness will break other fses as well...
+ */
 
 #define EROFS_NAME_LEN      255
 
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index c0963f5a2d22..8334a910acef 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -237,7 +237,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	} else {
 		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
 			dentry->d_name.name, nid, d_type);
-		inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
+		inode = erofs_iget(dir->i_sb, nid, d_type == FT_DIR);
 	}
 	return d_splice_alias(inode, dentry);
 }
-- 
2.17.1

