Return-Path: <linux-erofs+bounces-1082-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354ADB94A52
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 09:01:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW9r96cfQz3cYP;
	Tue, 23 Sep 2025 17:01:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758610889;
	cv=none; b=Qr+/f8DZ0sZzcBYGkcCAf13gBXr2I7PZWe4reAUSIbq22NFwAxjT88aNe8u8v6xmaur38nh4YEodhnbFnE8FS5O35NwaD2p0UhgE14/HKF608g13oKycxRu9TVpMdRGYvl7AIjBTU6Us/ZIQD7jq3lpwya4fyX1Ni8F3E4JOF+6OUFX+myNlPMujK+zd2hhJRINkhwgIElUEGhe/YYg2ky5xQ2b4GLIa6iMFBkIel9O+cNY9Z5oVX62nNZaHEADbMntPGURX+8O6M9uMLsM+f3uwPLDoh7WQCscRt/uTT3GxrLhx5kF6HywwuGN3SOCTl42f2ti1wqYHjXWToNW2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758610889; c=relaxed/relaxed;
	bh=b99jtqCRzgI14pb+VFmDsuYTSOwb5cUK+ScxM83ZV/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcr2jktO3o32sCiOTfugnAMk4pj7/p7LnbenlWbNknkczjlEmc6irKy0V9ZBWXOI8pY60Whm3EGMtseKAN86q+LjL6H82IN8Q0vy2+MFr65oVVPd64lvMPSwrANbKeBrARqC1D21007jjgvTA9E8zt3zjsqpzl+O7M9qDj6WREGPDuD9OiVoIu0SIC4i8zSyRsOlIT3M+DMH4thCoI60jx+f8YHtKjLOFVkz10jVNlXIB0YrHqk9Xf1fbArxN4DN5O7pjbPr/XhWSL5LY6gHah0SVyu7D5dp0eEto2zWCBmz4S8/9Dyl0TBCeqlXXEZqW8TEpb7v06ZIQF9E4YtvZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW9r854Ztz2yqg
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 17:01:28 +1000 (AEST)
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509231501193791;
        Tue, 23 Sep 2025 15:01:19 +0800
Received: from localhost.localdomain.com (10.94.12.225) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.58; Tue, 23 Sep 2025 15:01:18 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5] erofs: Add support for FS_IOC_GETFSLABEL
Date: Tue, 23 Sep 2025 15:01:12 +0800
Message-ID: <20250923070112.16644-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.43.7
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
Content-Type: text/plain
X-Originating-IP: [10.94.12.225]
tUid: 2025923150119d4a4ee5aa66719bd4aef14354bb679d1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.7 required=3.0 tests=RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Bo Liu (OpenAnolis) <liubo03@inspur.com>

Add support for reading to the erofs volume label from the
FS_IOC_GETFSLABEL ioctls.

Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---

v1: https://lore.kernel.org/linux-erofs/20250825120617.19746-1-liubo03@inspur.com/
v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/
v3: https://lore.kernel.org/linux-erofs/20250920060455.24002-1-liubo03@inspur.com/
v4: https://lore.kernel.org/linux-erofs/20250922092937.2055-1-liubo03@inspur.com/

change since v4:
- fix 0day build errors.

 fs/erofs/data.c     |  4 ++++
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    | 41 +++++++++++++++++++++++++++++++++++++----
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  8 ++++++++
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..8ca29962a3dd 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
 const struct file_operations erofs_file_fops = {
 	.llseek		= erofs_file_llseek,
 	.read_iter	= erofs_file_read_iter,
+	.unlocked_ioctl = erofs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = erofs_compat_ioctl,
+#endif
 	.mmap_prepare	= erofs_file_mmap_prepare,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index debf469ad6bd..32b4f5aa60c9 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= erofs_readdir,
+	.unlocked_ioctl = erofs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = erofs_compat_ioctl,
+#endif
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 9a2f59721522..a3c505e9425d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include <linux/compat.h>
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
@@ -213,10 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
-		if (erofs_inode_is_data_compressed(vi->datalayout))
-			inode->i_fop = &generic_ro_fops;
-		else
-			inode->i_fop = &erofs_file_fops;
+		inode->i_fop = &erofs_file_fops;
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
@@ -341,6 +339,41 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	int ret;
+
+	if (!sbi->volume_name)
+		ret = clear_user(arg, 1);
+	else
+		ret = copy_to_user(arg, sbi->volume_name,
+				   strlen(sbi->volume_name));
+
+	return ret ? -EFAULT : 0;
+}
+
+long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case FS_IOC_GETFSLABEL:
+		return erofs_ioctl_get_volume_label(inode, argp);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
+			unsigned long arg)
+{
+	return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
 	.listxattr = erofs_listxattr,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..b70902e00586 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -166,6 +166,8 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	char *volume_name;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -535,6 +537,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
 static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
+long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
+			unsigned long arg);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1b529ace4db0..f1535ebe03ec 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -343,6 +343,13 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
+	if (dsb->volume_name[0]) {
+		sbi->volume_name = kstrndup(dsb->volume_name,
+					    sizeof(dsb->volume_name), GFP_KERNEL);
+		if (!sbi->volume_name)
+			return -ENOMEM;
+	}
+
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
@@ -822,6 +829,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 	kfree(sbi->domain_id);
 	if (sbi->dif0.file)
 		fput(sbi->dif0.file);
+	kfree(sbi->volume_name);
 	kfree(sbi);
 }
 
-- 
2.31.1


