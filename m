Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B97373DA5
	for <lists+linux-erofs@lfdr.de>; Wed,  5 May 2021 16:26:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZzYM0Mmdz2yys
	for <lists+linux-erofs@lfdr.de>; Thu,  6 May 2021 00:26:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1620224807;
	bh=GluVXBIaUNi3BrqU2L7CG2ELWoeX5K5/wFdDfnw72Bk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=HeI4ZKsnD1mM1XM42Ll6Q2WI+HuD/+3I9SUC/lsh9jLYV4s+fepIh1XkXUj09V1Pg
	 b4PQ+lJK2XmgGSOYguerOWpR+3CP9mfbhcCHxPRDWxBspThtFMwVvQZdss1FiHcSBV
	 dw9brwbPEIgbwQTg050mAY7sXjBHn4Sz71YWL4XejnNAEOpDnI9+8Og7QJztOKFQE6
	 DbNGt/FcuP7za+mHhq18EHomrWKp/7BIF0g83LVerU++9/ms5MorBOXAGFPBqIkmM2
	 qAOm677z7/OLtbRFd0HZcmhBpLmHtGc6aCr/lvuwQ+e0egaYgLMdCiexB8c+i9xUOL
	 f1VczmFbOTG7g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.15;
 helo=out30-15.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Cob4NnTq; dkim-atps=neutral
Received: from out30-15.freemail.mail.aliyun.com
 (out30-15.freemail.mail.aliyun.com [115.124.30.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZzYF5y1Bz2yRG
 for <linux-erofs@lists.ozlabs.org>; Thu,  6 May 2021 00:26:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.150916-0.00154654-0.847537;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04394; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---0UXoIzSo_1620224782; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UXoIzSo_1620224782) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 05 May 2021 22:26:22 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 2/2] erofs-utils: introduce erofs_subdirs to one dir for
 sort
Date: Wed,  5 May 2021 22:26:15 +0800
Message-Id: <20210505142615.38306-2-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505142615.38306-1-bluce.lee@aliyun.com>
References: <20210505142615.38306-1-bluce.lee@aliyun.com>
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The structure erofs_subdirs has a dir number and a list_head,
the list_head is the same with i_subdirs in the inode.
Using erofs_subdirs as a temp place for dentrys under the dir,
and then sort it before replace to i_subdirs

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
---
 include/erofs/internal.h |  5 +++
 lib/inode.c              | 95 +++++++++++++++++++++++++---------------
 2 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1339341..7cd42ca 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -172,6 +172,11 @@ struct erofs_inode {
 #endif
 };
 
+struct erofs_subdirs {
+	struct list_head i_subdirs;
+	unsigned int nr_subdirs;
+};
+
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4..3e138a6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -96,7 +96,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	return 0;
 }
 
-struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
+struct erofs_dentry *erofs_d_alloc(struct erofs_subdirs *subdirs,
 				   const char *name)
 {
 	struct erofs_dentry *d = malloc(sizeof(*d));
@@ -107,7 +107,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	strncpy(d->name, name, EROFS_NAME_LEN - 1);
 	d->name[EROFS_NAME_LEN - 1] = '\0';
 
-	list_add_tail(&d->d_child, &parent->i_subdirs);
+	list_add_tail(&d->d_child, &subdirs->i_subdirs);
+	subdirs->nr_subdirs++;
 	return d;
 }
 
@@ -150,38 +151,12 @@ static int comp_subdir(const void *a, const void *b)
 	return strcmp(da->name, db->name);
 }
 
-int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
+int erofs_prepare_dir_file(struct erofs_inode *dir)
 {
-	struct erofs_dentry *d, *n, **sorted_d;
-	unsigned int d_size, i_nlink, i;
+	struct erofs_dentry *d;
+	unsigned int d_size, i_nlink;
 	int ret;
 
-	/* dot is pointed to the current dir inode */
-	d = erofs_d_alloc(dir, ".");
-	d->inode = erofs_igrab(dir);
-	d->type = EROFS_FT_DIR;
-
-	/* dotdot is pointed to the parent dir */
-	d = erofs_d_alloc(dir, "..");
-	d->inode = erofs_igrab(dir->i_parent);
-	d->type = EROFS_FT_DIR;
-
-	/* sort subdirs */
-	nr_subdirs += 2;
-	sorted_d = malloc(nr_subdirs * sizeof(d));
-	if (!sorted_d)
-		return -ENOMEM;
-	i = 0;
-	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
-		list_del(&d->d_child);
-		sorted_d[i++] = d;
-	}
-	DBG_BUGON(i != nr_subdirs);
-	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
-	for (i = 0; i < nr_subdirs; i++)
-		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
-	free(sorted_d);
-
 	/* let's calculate dir size and update i_nlink */
 	d_size = 0;
 	i_nlink = 0;
@@ -926,13 +901,58 @@ void erofs_d_invalidate(struct erofs_dentry *d)
 	erofs_iput(inode);
 }
 
+void erofs_subdirs_init(struct erofs_inode *dir, struct erofs_subdirs *subdirs)
+{
+	struct erofs_dentry *d;
+
+	subdirs->nr_subdirs = 0;
+	init_list_head(&subdirs->i_subdirs);
+
+	/* dot is pointed to the current dir inode */
+	d = erofs_d_alloc(subdirs, ".");
+	d->inode = erofs_igrab(dir);
+	d->type = EROFS_FT_DIR;
+
+	/* dotdot is pointed to the parent dir */
+	d = erofs_d_alloc(subdirs, "..");
+	d->inode = erofs_igrab(dir->i_parent);
+	d->type = EROFS_FT_DIR;
+}
+
+static int erofs_subdirs_sorted(struct erofs_subdirs *subdirs)
+{
+	struct erofs_dentry *d, *n, **sorted_d;
+	unsigned int i;
+	const unsigned int nr_subdirs = subdirs->nr_subdirs;
+
+	if (nr_subdirs == 0) return 0;
+
+	sorted_d = malloc(nr_subdirs * sizeof(d));
+	if (!sorted_d)
+		return -ENOMEM;
+	i = 0;
+	list_for_each_entry_safe(d, n, &subdirs->i_subdirs, d_child) {
+		list_del(&d->d_child);
+		sorted_d[i++] = d;
+	}
+
+	DBG_BUGON(i != nr_subdirs);
+	DBG_BUGON(!list_empty(&subdirs->i_subdirs));
+
+	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
+	for (i = 0; i < nr_subdirs; i++)
+		list_add_tail(&sorted_d[i]->d_child, &subdirs->i_subdirs);
+	free(sorted_d);
+	return 0;
+}
+
 struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 {
 	int ret;
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
-	unsigned int nr_subdirs;
+	struct erofs_subdirs subdirs;
 
 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
@@ -972,7 +992,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		return ERR_PTR(-errno);
 	}
 
-	nr_subdirs = 0;
+	erofs_subdirs_init(dir, &subdirs);
 	while (1) {
 		/*
 		 * set errno to 0 before calling readdir() in order to
@@ -991,12 +1011,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
 			continue;
 
-		d = erofs_d_alloc(dir, dp->d_name);
+		d = erofs_d_alloc(&subdirs, dp->d_name);
 		if (IS_ERR(d)) {
 			ret = PTR_ERR(d);
 			goto err_closedir;
 		}
-		nr_subdirs++;
 
 		/* to count i_nlink for directories */
 		d->type = (dp->d_type == DT_DIR ?
@@ -1009,7 +1028,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	}
 	closedir(_dir);
 
-	ret = erofs_prepare_dir_file(dir, nr_subdirs);
+	ret = erofs_subdirs_sorted(&subdirs);
+	if (ret) goto err;
+
+	list_replace(&subdirs.i_subdirs, &dir->i_subdirs);
+	ret = erofs_prepare_dir_file(dir);
 	if (ret)
 		goto err;
 
-- 
2.17.1

