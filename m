Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290246509B
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 15:55:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J42Fk6MLfz3dhH
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 01:55:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=exRE5BAx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=exRE5BAx; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J42Fb5wdsz3bX0
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 01:55:30 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id
 gf14-20020a17090ac7ce00b001a7a2a0b5c3so21219619pjb.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 01 Dec 2021 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2AwY8wkHb6MO7jCF0qQqjtG4E4i0Psc+PhRo4M1VbvE=;
 b=exRE5BAxcjQHJQPfRzV4fqFOtYLd7Rk0sjiXG+ptwzF4MnIywGKg8m6K21Z6BYywy2
 lsFDF59XslcJeOLIhUqnMbb2Yqu8EkBIaQTj4HiiU27Va79P4Q3WQjX/Sw+24xBXpFkq
 i1LCo/n2D4N4HwAhAZkTdV/aT0u/QkzuufpMISZz2QP73izSujyIEsVvZlVdnRAUySky
 3dHm7ofICnJszyy4y0CpQeRoAjBT/lURc5KLrsTMVqFhB5Z/m6shdWTxcwopvvoj51vL
 pWG9G1646KpfAvLeKGNqDepL8PhgxRL/SfPL4SN80h/VzYhzol9KLRDTYKuNZhqye2BR
 mVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2AwY8wkHb6MO7jCF0qQqjtG4E4i0Psc+PhRo4M1VbvE=;
 b=oDNqls1d4kCSl8UWPOSffcdspcKUgmrZLHn+QU31WDou6/cnMcXfIY9UP00Qi2EX1f
 VF+y7h7WO5yH5+nmfinDZLnee4B025DZXgIzvBxlLm4zHgWxCWiM/KHj/sBMLftOih5p
 eLwUJKDiBsN69ENzGeqRwgYyRP5n0b/ZLi9aLkz2xOl0DND3TeAXrzRkxF+ZdlTbG4Pt
 lnjk5BsCV48gVs0vONY12PGqG2ZFieMps+HzS68a8/xYfEJEg5GHeBGOiRLv2fduMfnN
 Vlp7jICvaULQzEMzNLutksBsXsXOHiU3bDr2TnjUFwegsMtPtrF1YFPY9tA4nsLjYFbg
 riFw==
X-Gm-Message-State: AOAM530GEbKhk6oila9B/JeJTY1oWbJtA4O4YV5VZLNqEsZPjGP2fmeU
 y6WPg3DglEYVTzrGc3/SwqVEAqYJRzA=
X-Google-Smtp-Source: ABdhPJxJ2kjgi76DYAC3zujKtM0392MIdrauLlYgOLvKcwl+3nqIT00d4j76bq/H6Y4VScWk0DrYbw==
X-Received: by 2002:a17:902:da85:b0:142:11b4:b5c0 with SMTP id
 j5-20020a170902da8500b0014211b4b5c0mr8070231plx.53.1638370527575; 
 Wed, 01 Dec 2021 06:55:27 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id c9sm30709pgq.58.2021.12.01.06.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 06:55:26 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v7 2/3] erofs: add sysfs interface
Date: Wed,  1 Dec 2021 22:54:36 +0800
Message-Id: <20211201145436.4357-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJfKizqxkt4BYa26cmOgCD9OFOck_J0NZ8hxCQbVoyv0j4SMJg@mail.gmail.com>
References: <CAJfKizqxkt4BYa26cmOgCD9OFOck_J0NZ8hxCQbVoyv0j4SMJg@mail.gmail.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add sysfs interface to configure erofs related parameters later.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
since v6:
- change license to GPL-2.0-or-later

since v5:
- Add missing supported features in sysfs API documentation.
- Fill up supported feature for EROFS_FEATURE_FUNCS.

since v4:
- Resend in a clean chain.

since v3:
- Add description of sysfs in erofs documentation.

since v2:
- Check whether t in erofs_attr_store is illegal.
- Print raw value for bool entry.

since v1:
- Add sysfs API documentation.
- Use sysfs_emit over snprintf. 

 Documentation/ABI/testing/sysfs-fs-erofs |   7 +
 Documentation/filesystems/erofs.rst      |   8 +
 fs/erofs/Makefile                        |   2 +-
 fs/erofs/internal.h                      |  12 ++
 fs/erofs/super.c                         |  12 ++
 fs/erofs/sysfs.c                         | 244 +++++++++++++++++++++++
 6 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
 create mode 100644 fs/erofs/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
new file mode 100644
index 000000000000..a9512594dc4c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -0,0 +1,7 @@
+What:		/sys/fs/erofs/features/
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Shows all enabled kernel features.
+		Supported features:
+		zero_padding, compr_cfgs, big_pcluster, chunked_file,
+		device_table, compr_head2, sb_chksum.
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 01df283c7d04..7119aa213be7 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -93,6 +93,14 @@ dax                    A legacy option which is an alias for ``dax=always``.
 device=%s              Specify a path to an extra device to be used together.
 ===================    =========================================================
 
+Sysfs Entries
+=============
+
+Information about mounted erofs file systems can be found in /sys/fs/erofs.
+Each mounted filesystem will have a directory in /sys/fs/erofs based on its
+device name (i.e., /sys/fs/erofs/sda).
+(see also Documentation/ABI/testing/sysfs-fs-erofs)
+
 On-disk details
 ===============
 
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 756fe2d65272..8a3317e38e5a 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 273754e7b340..43f0332fa489 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,10 @@ struct erofs_sb_info {
 	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
+
+	/* sysfs support */
+	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
+	struct completion s_kobj_unregister;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -261,7 +265,9 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 EROFS_FEATURE_FUNCS(zero_padding, incompat, INCOMPAT_ZERO_PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
+EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -498,6 +504,12 @@ int erofs_pcpubuf_growsize(unsigned int nrpages);
 void erofs_pcpubuf_init(void);
 void erofs_pcpubuf_exit(void);
 
+/* sysfs.c */
+int erofs_register_sysfs(struct super_block *sb);
+void erofs_unregister_sysfs(struct super_block *sb);
+int __init erofs_init_sysfs(void);
+void erofs_exit_sysfs(void);
+
 /* utils.c / zdata.c */
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
 static inline void erofs_pagepool_add(struct page **pagepool,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a969b1e0ee6..abc1da5d1719 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -695,6 +695,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_register_sysfs(sb);
+	if (err)
+		return err;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
 	return 0;
 }
@@ -808,6 +812,7 @@ static void erofs_put_super(struct super_block *sb)
 
 	DBG_BUGON(!sbi);
 
+	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
@@ -852,6 +857,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto zip_err;
 
+	err = erofs_init_sysfs();
+	if (err)
+		goto sysfs_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -859,6 +868,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_sysfs();
+sysfs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
 	z_erofs_lzma_exit();
@@ -877,6 +888,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_exit_sysfs();
 	z_erofs_exit_zip_subsystem();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
new file mode 100644
index 000000000000..ca18c5dce493
--- /dev/null
+++ b/fs/erofs/sysfs.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
+ *             https://www.oppo.com/
+ */
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+
+#include "internal.h"
+
+enum {
+	attr_feature,
+	attr_pointer_ui,
+	attr_pointer_bool,
+};
+
+enum {
+	struct_erofs_sb_info,
+};
+
+struct erofs_attr {
+	struct attribute attr;
+	short attr_id;
+	int struct_type;
+	int offset;
+};
+
+#define EROFS_ATTR(_name, _mode, _id)					\
+static struct erofs_attr erofs_attr_##_name = {				\
+	.attr = {.name = __stringify(_name), .mode = _mode },		\
+	.attr_id = attr_##_id,						\
+}
+#define EROFS_ATTR_FUNC(_name, _mode)	EROFS_ATTR(_name, _mode, _name)
+#define EROFS_ATTR_FEATURE(_name)	EROFS_ATTR(_name, 0444, feature)
+
+#define EROFS_ATTR_OFFSET(_name, _mode, _id, _struct)	\
+static struct erofs_attr erofs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr_id = attr_##_id,					\
+	.struct_type = struct_##_struct,			\
+	.offset = offsetof(struct _struct, _name),\
+}
+
+#define EROFS_ATTR_RW(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
+
+#define EROFS_RO_ATTR(_name, _id, _struct)	\
+	EROFS_ATTR_OFFSET(_name, 0444, _id, _struct)
+
+#define EROFS_ATTR_RW_UI(_name, _struct)	\
+	EROFS_ATTR_RW(_name, pointer_ui, _struct)
+
+#define EROFS_ATTR_RW_BOOL(_name, _struct)	\
+	EROFS_ATTR_RW(_name, pointer_bool, _struct)
+
+#define ATTR_LIST(name) (&erofs_attr_##name.attr)
+
+static struct attribute *erofs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(erofs);
+
+/* Features this copy of erofs supports */
+EROFS_ATTR_FEATURE(zero_padding);
+EROFS_ATTR_FEATURE(compr_cfgs);
+EROFS_ATTR_FEATURE(big_pcluster);
+EROFS_ATTR_FEATURE(chunked_file);
+EROFS_ATTR_FEATURE(device_table);
+EROFS_ATTR_FEATURE(compr_head2);
+EROFS_ATTR_FEATURE(sb_chksum);
+
+static struct attribute *erofs_feat_attrs[] = {
+	ATTR_LIST(zero_padding),
+	ATTR_LIST(compr_cfgs),
+	ATTR_LIST(big_pcluster),
+	ATTR_LIST(chunked_file),
+	ATTR_LIST(device_table),
+	ATTR_LIST(compr_head2),
+	ATTR_LIST(sb_chksum),
+	NULL,
+};
+ATTRIBUTE_GROUPS(erofs_feat);
+
+static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
+					  int struct_type, int offset)
+{
+	if (struct_type == struct_erofs_sb_info)
+		return (unsigned char *)sbi + offset;
+	return NULL;
+}
+
+static ssize_t erofs_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						s_kobj);
+	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
+	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
+
+	switch (a->attr_id) {
+	case attr_feature:
+		return sysfs_emit(buf, "supported\n");
+	case attr_pointer_ui:
+		if (!ptr)
+			return 0;
+		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
+	}
+
+	return 0;
+}
+
+static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
+						const char *buf, size_t len)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						s_kobj);
+	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
+	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
+	unsigned long t;
+	int ret;
+
+	switch (a->attr_id) {
+	case attr_pointer_ui:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t > UINT_MAX)
+			return -EINVAL;
+		*(unsigned int *)ptr = t;
+		return len;
+	case attr_pointer_bool:
+		if (!ptr)
+			return 0;
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t != 0 && t != 1)
+			return -EINVAL;
+		*(bool *)ptr = !!t;
+		return len;
+	}
+
+	return 0;
+}
+
+static void erofs_sb_release(struct kobject *kobj)
+{
+	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
+						 s_kobj);
+	complete(&sbi->s_kobj_unregister);
+}
+
+static const struct sysfs_ops erofs_attr_ops = {
+	.show	= erofs_attr_show,
+	.store	= erofs_attr_store,
+};
+
+static struct kobj_type erofs_sb_ktype = {
+	.default_groups = erofs_groups,
+	.sysfs_ops	= &erofs_attr_ops,
+	.release	= erofs_sb_release,
+};
+
+static struct kobj_type erofs_ktype = {
+	.sysfs_ops	= &erofs_attr_ops,
+};
+
+static struct kset erofs_root = {
+	.kobj	= {.ktype = &erofs_ktype},
+};
+
+static struct kobj_type erofs_feat_ktype = {
+	.default_groups = erofs_feat_groups,
+	.sysfs_ops	= &erofs_attr_ops,
+};
+
+static struct kobject erofs_feat = {
+	.kset	= &erofs_root,
+};
+
+int erofs_register_sysfs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	int err;
+
+	sbi->s_kobj.kset = &erofs_root;
+	init_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL,
+				   "%s", sb->s_id);
+	if (err)
+		goto put_sb_kobj;
+
+	return 0;
+
+put_sb_kobj:
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+	return err;
+}
+
+void erofs_unregister_sysfs(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+}
+
+int __init erofs_init_sysfs(void)
+{
+	int ret;
+
+	kobject_set_name(&erofs_root.kobj, "erofs");
+	erofs_root.kobj.parent = fs_kobj;
+	ret = kset_register(&erofs_root);
+	if (ret)
+		goto root_err;
+
+	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
+				   NULL, "features");
+	if (ret)
+		goto feat_err;
+
+	return ret;
+
+feat_err:
+	kobject_put(&erofs_feat);
+	kset_unregister(&erofs_root);
+root_err:
+	return ret;
+}
+
+void erofs_exit_sysfs(void)
+{
+	kobject_put(&erofs_feat);
+	kset_unregister(&erofs_root);
+}
-- 
2.25.1

