Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B05AA68A
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkQt3fs5z30Cx
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pyoOyAJG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pyoOyAJG;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkQn1yP2z2ypD
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:16 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so690087plo.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W+8+GSPx1N9dlvfECPx2S6Ym0ntuR/QxlEybVAQlmMY=;
        b=pyoOyAJGCZOeDerC2wlR6wRdGKFz2Lr75PXQF+JL4UkQNzfE8THRkoU7dCChr7+cUV
         YfR68T58swRrWjS3IT1bJCnYO1FobcPsTdjWrge53EjwFJT1QVUybMaBtXvacYTD/+n8
         DWjdoK4UocFP0rrSnlJiS7bkFcBiQv27tvTGNJG9rS1aITRKFRxzHUFnxiP4OU4A9xJH
         meHDjiV2VbakJ2JBiL54QAJK5DZZQV2BCtg39jPn3ZfcaFGPmi7OrEL8rYetBP6Pw41x
         xLeQ6nWfH4MGOXIX2qiC5u9Sc/GApiw4EYfYienC/W7OfK4WyS13gyUZuPSXDPksCz+9
         Q16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W+8+GSPx1N9dlvfECPx2S6Ym0ntuR/QxlEybVAQlmMY=;
        b=ffPNnpQUayUED1c4k5Vasaq760OR89qPDejb9p5NxQyx9XnH93rt6ztY91s/1ENi/E
         iKaAV1SNsglaHaSlx+qsFO0OLp55HJ406L5Ix+LBOvulFw+oEDdsc0caFe6i5Dzp9/FU
         GdzCVLJjM5MSN3u6/OsxphLYc3GgUaadymFroDaa1C/ekSYgSJzCsLxbwEmsTJYENg4M
         l1X5IoSTMJFrxfwPqoTVIH+w8E7nJfFrpgDJ0fhj4R+kQpAo1J3GBBHNcbZbMHcxtR4m
         r6/XnvuYJpQPE4W6wU+k8BSPqTeaEBqC+fUeGkOApRJcPALr0r1tblxrEBNERd1EYKXj
         Ai8w==
X-Gm-Message-State: ACgBeo391iDJTP/NYbYuiI0qTet1hGtYHB2/D59eT/zScucnqnEYSL/r
	jEd0lMAYVjaZSi/1mtynR/gwxAlUlU8HKg==
X-Google-Smtp-Source: AA6agR7YCzYtzZd+rIRNwd+ZOG8DjtE46zwGPBAGnl1vuXdaqZM5rBMRZc3ib3TFVTJoUg6x0dmYVw==
X-Received: by 2002:a17:90a:ab8d:b0:1fa:af75:e4ed with SMTP id n13-20020a17090aab8d00b001faaf75e4edmr2659324pjq.119.1662090494594;
        Thu, 01 Sep 2022 20:48:14 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:14 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 2/5] erofs: introduce fscache-based domain
Date: Fri,  2 Sep 2022 11:47:45 +0800
Message-Id: <20220902034748.60868-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

A new fscache-based shared domain mode is going to be introduced for
erofs. In which case, same data blobs in same domain will be shared
and reused to reduce on-disk space usage.

As the first step, we use pseudo mnt to manage and maintain domain's
lifecycle.

The implementation of sharing blobs will be introduced in subsequent
patches.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 103 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  19 +++++++-
 fs/erofs/super.c    |  52 ++++++++++++++++------
 3 files changed, 159 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..3238813ed520 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -1,10 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2022, Alibaba Cloud
+ * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
+#include <linux/pseudo_fs.h>
+#include <linux/fs_context.h>
+#include <linux/magic.h>
 #include <linux/fscache.h>
 #include "internal.h"
 
+static DEFINE_MUTEX(erofs_domain_list_lock);
+static LIST_HEAD(erofs_domain_list);
+
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -417,6 +424,92 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
+static void erofs_fscache_domain_get(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	refcount_inc(&domain->ref);
+}
+
+static void erofs_fscache_domain_put(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	if (refcount_dec_and_test(&domain->ref)) {
+		fscache_relinquish_volume(domain->volume, NULL, false);
+		mutex_lock(&erofs_domain_list_lock);
+		list_del(&domain->list);
+		mutex_unlock(&erofs_domain_list_lock);
+		kern_unmount(domain->mnt);
+		kfree(domain->domain_id);
+		kfree(domain);
+	}
+}
+
+static int erofs_fscache_init_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct vfsmount *pseudo_mnt;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
+	if (!domain->domain_id) {
+		kfree(domain);
+		return -ENOMEM;
+	}
+	sbi->domain = domain;
+	pseudo_mnt = kern_mount(&erofs_fs_type);
+	if (IS_ERR(pseudo_mnt)) {
+		err = PTR_ERR(pseudo_mnt);
+		goto out;
+	}
+	err = erofs_fscache_register_fs(sb);
+	if (err) {
+		kern_unmount(pseudo_mnt);
+		goto out;
+	}
+
+	domain->mnt = pseudo_mnt;
+	domain->volume = sbi->volume;
+	refcount_set(&domain->ref, 1);
+	mutex_init(&domain->mutex);
+	pseudo_mnt->mnt_sb->s_fs_info = domain;
+	list_add(&domain->list, &erofs_domain_list);
+	return 0;
+out:
+	kfree(domain->domain_id);
+	kfree(domain);
+	sbi->domain = NULL;
+	return err;
+}
+
+int erofs_fscache_register_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	mutex_lock(&erofs_domain_list_lock);
+	list_for_each_entry(domain, &erofs_domain_list, list) {
+		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
+			erofs_fscache_domain_get(domain);
+			sbi->domain = domain;
+			sbi->volume = domain->volume;
+			mutex_unlock(&erofs_domain_list_lock);
+			return 0;
+		}
+	}
+	err = erofs_fscache_init_domain(sb);
+	mutex_unlock(&erofs_domain_list_lock);
+
+	return err;
+}
+
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode)
@@ -495,7 +588,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	char *name;
 	int ret = 0;
 
-	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
+	name = kasprintf(GFP_KERNEL, "erofs,%s",
+			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
 	if (!name)
 		return -ENOMEM;
 
@@ -515,6 +609,11 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	fscache_relinquish_volume(sbi->volume, NULL, false);
+	if (sbi->domain)
+		erofs_fscache_domain_put(sbi->domain);
+	else
+		fscache_relinquish_volume(sbi->volume, NULL, false);
+
 	sbi->volume = NULL;
+	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fe435d077f1a..7240a2acaa5c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,15 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_domain {
+	refcount_t ref;
+	struct mutex mutex;
+	struct vfsmount *mnt;
+	struct list_head list;
+	struct fscache_volume *volume;
+	char *domain_id;
+};
+
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
@@ -158,6 +167,7 @@ struct erofs_sb_info {
 	/* fscache support */
 	struct fscache_volume *volume;
 	struct erofs_fscache *s_fscache;
+	struct erofs_domain *domain;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -394,6 +404,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
@@ -610,6 +621,7 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
+int erofs_fscache_register_domain(struct super_block *sb);
 
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
@@ -620,10 +632,15 @@ extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
+static inline int erofs_fscache_register_domain(const struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int erofs_fscache_register_cookie(struct super_block *sb,
 						struct erofs_fscache **fscache,
 						char *name, bool need_inode)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d01109069c6b..a3ff87e45f2c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -688,6 +688,13 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
+static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+
+	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -715,12 +722,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_blocksize = EROFS_BLKSIZ;
 		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
 
-		err = erofs_fscache_register_fs(sb);
-		if (err)
-			return err;
-
-		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
-						    sbi->opt.fsid, true);
+		if (sbi->opt.domain_id) {
+			err = erofs_fscache_register_domain(sb);
+			if (err)
+				return err;
+		} else {
+			err = erofs_fscache_register_fs(sb);
+			if (err)
+				return err;
+			err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
+					sbi->opt.fsid, true);
+		}
 		if (err)
 			return err;
 
@@ -798,8 +810,12 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
+		if (!ctx && fc->sb_flags & SB_KERNMOUNT)
+			return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
+		if (ctx->opt.fsid)
+			return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
@@ -849,6 +865,9 @@ static void erofs_fc_free(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
 
+	if (!ctx)
+		return;
+
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
 	kfree(ctx->opt.domain_id);
@@ -864,8 +883,12 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	struct erofs_fs_context *ctx;
 
+	if (fc->sb_flags & SB_KERNMOUNT)
+		goto out;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
@@ -878,6 +901,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	idr_init(&ctx->devs->tree);
 	init_rwsem(&ctx->devs->rwsem);
 	erofs_default_options(ctx);
+out:
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
@@ -892,6 +916,10 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_litter_super(sb);
+		return;
+	}
 	if (erofs_is_fscache_mode(sb))
 		generic_shutdown_super(sb);
 	else
@@ -916,8 +944,8 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
-	DBG_BUGON(!sbi);
-
+	if (!sbi)
+		return;
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -927,7 +955,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

