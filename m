Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF144B089
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 16:39:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpXGN24hjz2yPg
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 02:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CIJrakt3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531;
 helo=mail-pg1-x531.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=CIJrakt3; dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpXGD2hktz2xXB
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 02:39:14 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 188so6472476pgb.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 09 Nov 2021 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JA2ivXv4Vn77d2cpWx/FzKTAGfMDeBPgj7cYP7slka8=;
 b=CIJrakt3vrFCaz14+iRDGtlpgwA0y+zmUeKJDH5WTe3jBnShc5JmOy/TxCKP8JOpGJ
 GwUmHTgTf0Vca4cbm/9QrHK49pqLqpsFl5EJRQCce/PvjfU9mvo4cZjfnv/CZIu1zZM9
 nu4aUef4nyhOvrD/sYYH7nW2aQjgURcJL0XBvFioa6hVsfbPCt6dAvgccSwh3M4nLUbQ
 gzJUILZSovj0PLatCVRA57DPP0dXGjIzxGCEwVaW8G8SFgN9dX2Z1ZBZ41OdZ6h6sVwF
 CufCXpzIoIfEsYwhIFuM5HUN6Xz4UE1Po4e6G2ZjTdRCVa8z8QeKF3nIE7ztdwPb7vUh
 dJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JA2ivXv4Vn77d2cpWx/FzKTAGfMDeBPgj7cYP7slka8=;
 b=hV3LO4oeF+6wNSSEwIHKPGQjir/V/OkCfs26Bzab+QMdYt5PPegJM7enN5351Pt7Z0
 DnmNk77ZMrhojx50noeY56pVr9R6JYalJRsv+zF5EGenYSTfUKlmssWxV2CyNNFy8hyZ
 zqBcqZ9ukmM6YsRk8HWCsBi2ueVY8Pn1VeAoi66ERxQ33CpAWdNo3Ps9o2HdrYGwwkWv
 FQIBCiFpF3GCvIjJXjdnVl8E9zyWiBcwVOfQuixs1uUfyw5NQHXQ/DIwK0EY1M0lzQw3
 FIdVXptZGsQ7FUvSr7GcXhcHiJ1qqsM+2rbMI4JsEUOcUzu5sJKmZtgyQTVUD6U7nsls
 ncbg==
X-Gm-Message-State: AOAM531WWoonrJoZdaMvRMjPRvpvOoIdmWpLqLHPi/3q6753FhodIov7
 79EnoIt/esyPvljhe4R02Nh/6ccfTU4=
X-Google-Smtp-Source: ABdhPJw8Rf4BTvgNH3eUF2UUA8IBBrh3TxINzHn8Xa35VWEtVjRvHmxrWGbmWDSCHPwpO9+ZRfVRmg==
X-Received: by 2002:aa7:9561:0:b0:49f:c8cd:ce6d with SMTP id
 x1-20020aa79561000000b0049fc8cdce6dmr9044557pfq.67.1636472352486; 
 Tue, 09 Nov 2021 07:39:12 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id q89sm3153865pjk.50.2021.11.09.07.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 07:39:12 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v3 2/2] erofs: add sysfs node to control sync decompression
 strategy
Date: Tue,  9 Nov 2021 23:38:56 +0800
Message-Id: <20211109153856.12956-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109153856.12956-1-huangjianan@oppo.com>
References: <fa2eeb31-9579-a4a4-71b3-200509da1ed9@kernel.org>
 <20211109153856.12956-1-huangjianan@oppo.com>
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

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So add a sysfs
node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
since v2:
- use enum to indicate sync decompression strategy
- add missing CONFIG_EROFS_FS_ZIP ifdef

since v1:
- leave auto default
- add a disable strategy for sync_decompress

 Documentation/ABI/testing/sysfs-fs-erofs |  9 +++++++++
 fs/erofs/internal.h                      | 10 ++++++++--
 fs/erofs/super.c                         |  2 +-
 fs/erofs/sysfs.c                         | 15 +++++++++++++++
 fs/erofs/zdata.c                         | 16 ++++++++++++----
 5 files changed, 45 insertions(+), 7 deletions(-)

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
index bcb1b91b234f..4c0a9fdd09ff 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -794,7 +794,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
+		sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1454,9 +1454,11 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
+	bool force_fg = true;
 
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
@@ -1468,8 +1470,11 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	(void)z_erofs_collector_end(&f.clt);
 
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_OFF)
+		force_fg = false;
+
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1488,6 +1493,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
+	bool force_fg = false;
 
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
@@ -1519,8 +1525,10 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
-			 sbi->opt.readahead_sync_decompress &&
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON)
+		force_fg = true;
+
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, force_fg &&
 			 nr_pages <= sbi->opt.max_sync_decompress_pages);
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-- 
2.25.1

