Return-Path: <linux-erofs+bounces-906-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C6B33ECB
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 14:08:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9V1K3TJ5z3chS;
	Mon, 25 Aug 2025 22:08:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756123685;
	cv=none; b=GUya3xl8km5v531uCT3xw1yWgg1CdP5s/Y8ktGgCyGNigbQKZszCGPsIsud/e4TRUc3f31nvn30xfNS1wOUWdIAXIMMiI0izd99Zi+dNCurjMGaXXMrb/dZi1o74b72EuXqRqOSF9NAqktPpTIMmhjcXUG+zz68hBzIy96Qavs2O1QxZioU5rWMntsEjLsczNq8ISRQ8YhHo7GsQumzJX6QtzQYI6DEs0+LF74K6Pv3EA1+46Chru5BeU9Q54psAC2JTbvJ45JxNaq6KzJd1jpEt54WNm6XDK9S/uQxe6htqXPHAI5QD1yLpAz8Sg1QiDPauMG9xdiie2xxaRW1dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756123685; c=relaxed/relaxed;
	bh=VyQcILVbsQcOa6rM1yCl4YgPSFDh6tnRcENRpEOkC2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U85jCyYT5iiG7IANugH2ZdkoQfRmdBRRgRJsWh0QjKo60m55ueDkyIaZhpL/tAAR1GzZD9BMUgGR6X0y2McSlLJj+vQSfGMY5JQn65TUgMXHteX9jpdqa1pI9uI/aW5wuJN/fid5t5oblppbZp0dtWbb6MEfQvJvyPjr8BD7L+F0kJoyQdhpHiY8RzWTgyIPZHkh0d6J2bOfhsfQNlaX84xqNYblyy9ro/m0ZKKozW8UEjUvzDdH79mZngUhY1qgsjZJ5eknL3SoBWrgtdzWZ0odAT8cjZSvxv1QnjjQh1A5GMUZje4jFZywASGJiszB6+eAXHUP+5b4xWyOvl7XCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Mon, 25 Aug 2025 22:08:03 AEST
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9V1H7538z3cgV
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 22:08:03 +1000 (AEST)
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202508252006433278;
        Mon, 25 Aug 2025 20:06:43 +0800
Received: from localhost.localdomain (10.94.4.237) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 25 Aug 2025 20:06:45 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Date: Mon, 25 Aug 2025 08:06:17 -0400
Message-ID: <20250825120617.19746-1-liubo03@inspur.com>
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
X-Originating-IP: [10.94.4.237]
tUid: 2025825200643879c5d1907785c46d1a62c5bb4ec3e08
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Bo Liu (OpenAnolis) <liubo03@inspur.com>

Add support for reading to the erofs volume label from the
FS_IOC_GETFSLABEL ioctls.

Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
---
 fs/erofs/Makefile   |  2 +-
 fs/erofs/data.c     |  4 ++++
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    |  2 +-
 fs/erofs/internal.h | 10 ++++++++++
 fs/erofs/ioctl.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c    |  2 ++
 fs/erofs/zdata.c    | 11 +++++++++++
 8 files changed, 80 insertions(+), 2 deletions(-)
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
index 9a2f59721522..9248143e26df 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -214,7 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
-			inode->i_fop = &generic_ro_fops;
+			inode->i_fop = &z_erofs_file_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
 		break;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..2f874b920c8b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,6 +32,8 @@ __printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
+#define EROFS_VOLUME_LABEL_LEN	16
+
 /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
@@ -166,6 +168,9 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* volume name */
+	u8 volume_label[EROFS_VOLUME_LABEL_LEN];
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -404,6 +409,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations z_erofs_file_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
@@ -535,6 +541,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
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
index 000000000000..10bfd593225f
--- /dev/null
+++ b/fs/erofs/ioctl.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/fs.h>
+#include <linux/compat.h>
+#include <linux/file.h>
+
+#include "erofs_fs.h"
+#include "internal.h"
+
+static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	size_t len;
+	int ret;
+	char label[EROFS_VOLUME_LABEL_LEN];
+
+	memcpy(label, sbi->volume_label, EROFS_VOLUME_LABEL_LEN);
+
+	len = strnlen(label, EROFS_VOLUME_LABEL_LEN);
+	if (len == EROFS_VOLUME_LABEL_LEN)
+		erofs_err(inode->i_sb, "label is too long, return the first %zu bytes",
+			  --len);
+
+	ret = copy_to_user(arg, label, len);
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
index 1b529ace4db0..e6ad6cf4ba82 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -343,6 +343,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
+	memcpy(sbi->volume_label, dsb->volume_name, EROFS_VOLUME_LABEL_LEN);
+
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..b612bf7b2f08 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1931,3 +1931,14 @@ const struct address_space_operations z_erofs_aops = {
 	.read_folio = z_erofs_read_folio,
 	.readahead = z_erofs_readahead,
 };
+
+const struct file_operations z_erofs_file_fops = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= generic_file_read_iter,
+	.unlocked_ioctl	= erofs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= erofs_compat_ioctl,
+#endif
+	.mmap		= generic_file_readonly_mmap,
+	.splice_read	= filemap_splice_read,
+};
-- 
2.31.1


