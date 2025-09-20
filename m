Return-Path: <linux-erofs+bounces-1051-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD77B8C067
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Sep 2025 08:06:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cTJly072zz2ytg;
	Sat, 20 Sep 2025 16:06:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.26.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758348381;
	cv=none; b=S7Ubva9LtEZoSaOZBQ9rmECBoZNlDmUu32QJhekWAGKggWTGxCm+Ryd8DsGV+lcnKLiAcHIvYDywRi0YG1GI0evXNDsGQcKRQHwquI8PDcgA4F3rLbI7s/mvJel6ozP9s9/LFioLiS5SpHmdv3L40ysnQmO0/Z0qEQmKdhwoMsfDlM44Q5VVewE5TOXGhQ7YkbfIjmGlCKAPVAttQJvkFzsdUyaEE8SS9NDUR4bPCnElLr9vMGRKRwWiFZ3dJOyaqVuP1PC7z8hedrJ0Rf7cqnOGKV2zBHMPu4ittXh1tTyzDXYjnv0XK79SuaNYvj2vTtt1WG8fOLBr9MpjkyD2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758348381; c=relaxed/relaxed;
	bh=2J4D0wI3jlV5NdMyeZegOLM8P3RLz/eBGEScO3bsGJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcrtD2YN2sOqxNufMbOOygaf1RSl26EIw3U7BYHVZ9wxKu+r05+Cv8c+GXQx7RX7g34lIDW24AWvWFkNklXhbiKxH5rGK3jo89R+3Lx8G/+FIjwiLeC/6zVl7NPzioXWMLhLJJ10lmwr0hayZ2M9gYyC1gfiHRBkVJ3PgLKi9YfXHmgmTZ7tmEgMBieKvXT1uYacl2orQAV7OeHjKDfnqO26g7S19PH/J1LxnEtO2zrojdxuoVGE3PcLE0wFII/qc/dyq7ce5wgcMbeVZssJZ0pq6/LWqm8C0cBlNdHePeeQ/GaKzlum1LB7arP44qeTgz16ye7WZ+RTyKf58QQitw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.26.145; helo=unicom145.biz-email.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Sat, 20 Sep 2025 16:06:20 AEST
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cTJlw2Jv5z2xck
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Sep 2025 16:06:20 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509201405058224;
        Sat, 20 Sep 2025 14:05:05 +0800
Received: from localhost.localdomain (10.94.4.193) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sat, 20 Sep 2025 14:04:56 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Date: Sat, 20 Sep 2025 02:04:55 -0400
Message-ID: <20250920060455.24002-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
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
Content-Type: text/plain
X-Originating-IP: [10.94.4.193]
X-ClientProxiedBy: Jtjnmail201616.home.langchao.com (10.100.2.16) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 20259201405064a5f25bdb439cce417eb537a216a8821
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
---

v1: https://lore.kernel.org/linux-erofs/63904ade56634923ba734dcdab3c45d0@inspur.com/T/#t
v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/T/#u

Changes since v2:
- remove unnecessary code

 fs/erofs/Makefile   |  2 +-
 fs/erofs/data.c     |  4 ++++
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    |  5 +----
 fs/erofs/internal.h |  7 +++++++
 fs/erofs/ioctl.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c    |  8 ++++++++
 7 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100644 fs/erofs/ioctl.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..5be6cc4acc1c 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
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
index 9a2f59721522..a7ec17eec4b2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
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
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..311346a017a7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -166,6 +166,9 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* volume name */
+	char *volume_name;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -535,6 +538,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
 static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
+long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
+			unsigned long arg);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c
new file mode 100644
index 000000000000..fbcbf820c4d7
--- /dev/null
+++ b/fs/erofs/ioctl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/fs.h>
+#include <linux/compat.h>
+#include <linux/file.h>
+
+#include "internal.h"
+
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


