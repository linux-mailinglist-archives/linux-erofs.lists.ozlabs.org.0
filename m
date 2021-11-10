Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5944C27E
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 14:49:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hq5mq2NF0z2yP7
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 00:49:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UvsrTcXB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=UvsrTcXB; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hq5mf6Ryfz2xY1
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 00:49:06 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 200so2338618pga.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1HAdaYDmjRq0kiAF3GfjJCEfGILWN9jORd49+vr3FP0=;
 b=UvsrTcXBS5k0F4O6tgUADn01WJpq4kaaRN/oWxBSEA8lkpt129UCGkdyr+rxNkiOZq
 gTEuR+CLYASxH9e7NDjeI8RZCppKKopw08PLC19N3/DIjPvCdy/Co5dOS+IYEVjREixn
 zMMZ/3LvW5syp5b/q4JmNMfygqNk272Ra2WU6SR/uOfaehbcdY16re25VIyH+lr11FnG
 y5D8hAChZE+Vt3LI3FuVtaosM7Kk/p38MPu3xSo6MzVqbIi/A2hzwYHSlZ6hHt6WUtPs
 FuTnD45P4ekFZF5LWDDqpoOUrldGQK1Yd39YGzaADxjcrMBeLUrTteTkxQQ/ygPmdetd
 gxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1HAdaYDmjRq0kiAF3GfjJCEfGILWN9jORd49+vr3FP0=;
 b=J8++r2tFPEKgPv/eEXFhdk+wbBmdQuZQSAZsKH8WKV+3R41dqnPFU9KUYvvVGonZvX
 SOxRUbpAhOWOow0mm2shv6UmhLR2UleIT3K6ijJ0bL3CxyVtedZ9//HmEU9oGe+cBWFX
 kpTCbHF1tnydORSHTtvndun9zJS/QJTwOamRVVSD6bPQ+UHkAIRZXm8RbuQCSI1pMFh3
 3QzKU07p59QjHHOXvK2/bOm9WD3FG35+Kn4cR8rZTO6Gjo2HzJkOqqb2NhGqV0W10xPn
 QIxLOjNK5qLRk4QQ9mcEfBmVZcRmYIiuTXU/sLql8lJ8DhXB9S/M8qFkqNITgPY63PXj
 YIaA==
X-Gm-Message-State: AOAM531bptKzg8FEE4wcNSMDZrhnAkcZsyLRXPU0a1gJp065zH9fJZIb
 a0O3js+xPVlt+ShgUNqDhf1HqPm1izg=
X-Google-Smtp-Source: ABdhPJzTG4Ypc9mXjgrQz2pEiMFIAzD1NE2AHvT8cKoHRt81Fe6YINCOZW9YqMCakBdur6QsVE56sA==
X-Received: by 2002:aa7:9903:0:b0:49f:e368:4fc3 with SMTP id
 z3-20020aa79903000000b0049fe3684fc3mr11330pff.1.1636552144102; 
 Wed, 10 Nov 2021 05:49:04 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id h22sm9835893pgh.80.2021.11.10.05.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Nov 2021 05:49:03 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v4 2/2] erofs: add sysfs node to control sync decompression
 strategy
Date: Wed, 10 Nov 2021 21:48:46 +0800
Message-Id: <20211110134846.2707-2-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110134846.2707-1-jnhuang95@gmail.com>
References: <20211109153856.12956-1-huangjianan@oppo.com>
 <20211110134846.2707-1-jnhuang95@gmail.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So add a sysfs
node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
since v3:
- Clean up the sync decompressstrategy into a separate function.

since v2:
- Use enum to indicate sync decompression strategy.
- Add missing CONFIG_EROFS_FS_ZIP ifdef.

since v1:
- Leave auto default.
- Add a disable strategy for sync_decompress.

 Documentation/ABI/testing/sysfs-fs-erofs |  9 ++++++++
 fs/erofs/internal.h                      | 10 ++++++--
 fs/erofs/super.c                         |  2 +-
 fs/erofs/sysfs.c                         | 15 ++++++++++++
 fs/erofs/zdata.c                         | 29 ++++++++++++++++++++----
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 86d0d0234473..d301704de79b 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		lz4_0padding, compr_cfgs, big_pcluster, device_table,
 		sb_chksum.
+
+What:		/sys/fs/erofs/<disk>/sync_decompress
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Control strategy of sync decompression
+		- 0 (defalut, auto): enable for readpage, and enable for
+				     readahead on atomic contexts only,
+		- 1 (force on): enable for readpage and readahead.
+		- 2 (force off): disable for all situations.
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d0cd712dc222..cd30d4f0bada 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -56,12 +56,18 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+enum {
+	EROFS_SYNC_DECOMPRESS_AUTO,
+	EROFS_SYNC_DECOMPRESS_FORCE_ON,
+	EROFS_SYNC_DECOMPRESS_FORCE_OFF
+};
+
 struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (false - auto, true - force on) */
-	bool readahead_sync_decompress;
+	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
+	unsigned int sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index abc1da5d1719..58f381f80205 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.readahead_sync_decompress = false;
+	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&ctx->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index cf88e083eea5..821a73857d82 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -16,6 +16,7 @@ enum {
 
 enum {
 	struct_erofs_sb_info,
+	struct_erofs_mount_opts,
 };
 
 struct erofs_attr {
@@ -55,7 +56,14 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
+#ifdef CONFIG_EROFS_FS_ZIP
+EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+#endif
+
 static struct attribute *erofs_attrs[] = {
+#ifdef CONFIG_EROFS_FS_ZIP
+	ATTR_LIST(sync_decompress),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs);
@@ -82,6 +90,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
@@ -128,6 +138,11 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return ret;
 		if (t > UINT_MAX)
 			return -EINVAL;
+#ifdef CONFIG_EROFS_FS_ZIP
+		if (!strcmp(a->attr.name, "sync_decompress") &&
+		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
+			return -EINVAL;
+#endif
 		*(unsigned int *)ptr = t;
 		return len;
 	case attr_pointer_bool:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..233c8a047c53 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -772,6 +772,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void set_sync_decompress_policy(struct erofs_sb_info *sbi)
+{
+	/* enable sync decompression in readahead for atomic contexts */
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+		sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
+}
+
+static bool get_sync_decompress_policy(struct erofs_sb_info *sbi,
+				       unsigned int readahead_pages)
+{
+	/* auto: enable for readpage, disable for readahead */
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+		return readahead_pages == 0;
+
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON)
+		return readahead_pages <= sbi->opt.max_sync_decompress_pages;
+
+	return false;
+}
+
 static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
@@ -794,7 +814,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
+		set_sync_decompress_policy(sbi);
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1454,6 +1474,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
@@ -1469,7 +1490,8 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 get_sync_decompress_policy(sbi, 0));
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1520,8 +1542,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f.clt);
 
 	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
-			 sbi->opt.readahead_sync_decompress &&
-			 nr_pages <= sbi->opt.max_sync_decompress_pages);
+			 get_sync_decompress_policy(sbi, nr_pages));
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 	erofs_release_pages(&pagepool);
-- 
2.25.1

