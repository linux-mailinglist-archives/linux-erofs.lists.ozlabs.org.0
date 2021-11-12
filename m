Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0344EB16
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 17:10:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrNpT1wKwz2yp1
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Nov 2021 03:10:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ez+L4PuT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Ez+L4PuT; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrNpF5LFyz2yb6
 for <linux-erofs@lists.ozlabs.org>; Sat, 13 Nov 2021 03:09:57 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id q126so8397737pgq.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kLMWAoj8qSn+0ptWLrH+Qgwuhtiiv7yETqv2709noO0=;
 b=Ez+L4PuTj+IfJoy69BoBb6HAdgip2d6riQfR6vlN7NguWQI9vnJFuHiy8ygJEaA+2P
 OvsISYngvcRNK5RZah1+4zAJQ6IxOkwzFsmC5yV7Cm9whH13LO8eeHfksjUcDucNSNW8
 TEjU0IDPv6Zgy5X4NkmQJ5B/jKqWjaAs66f4ITbjB6xbKXcP1kO/e6lqyaROqR6FrMjh
 fQeBpkDivOme8iZotCK25YXuU5Qj8R5AjQFa51N35rvrETA5BDpt1vIZCCG5ZKTLQyFt
 Jau2Dj/EJ+thLCCbzeLn5BQOX9BjkhWIz0MRZNRkR9asdQ4EjDxae5UDsi5outboJ4o/
 2q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kLMWAoj8qSn+0ptWLrH+Qgwuhtiiv7yETqv2709noO0=;
 b=ZMmJnai/4iewDYCdU1EXVJxVmj+JGHDPOwiUId6+ktUGB+A4nFJ0bb7pTDwAWA8cv1
 qXMsm55NjSQPOM+gHjKFr6/7xt/YJy+db6r79cb7jaj8Q/dTwXwGZ1DK4EFD0edrb66t
 gLuCzMOYRcD6mkvnqfiCCSpgUV880AlhOzL32ddJwiDJJ6nZZOVSW1+pVL4CflqUveGB
 OE7YK5OmIlqRkWzI0j0LnavxhDXQl/FsGS+GN67DrhErbcAWYbtekkP51t+jE1OiB0YB
 dtTHfVKUoJTNF6MbWkx0HZQDJPV4VnFW4Yy6xvjpINSTB3v082FBd+1LOHiZ8/Co2na/
 gQGQ==
X-Gm-Message-State: AOAM5311zzZbkK33YG5kVe+oQX2VKAfRo/SXHiWlPw20cP4TbQcNxR1y
 yq3L5pGCaUBfpLyvu3fDqCc8TJcQ7xg=
X-Google-Smtp-Source: ABdhPJzYPRtHTsb1CAk1fIScu8akbRcFOe37snQFIlamHNha7JHYji5V5bOCl40f0L/FkIzzp5zbpA==
X-Received: by 2002:aa7:96ba:0:b0:49f:c35f:83f8 with SMTP id
 g26-20020aa796ba000000b0049fc35f83f8mr14816867pfk.47.1636733394627; 
 Fri, 12 Nov 2021 08:09:54 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id j17sm7490674pfj.55.2021.11.12.08.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 08:09:54 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v6 3/3] erofs: add sysfs node to control sync decompression
 strategy
Date: Sat, 13 Nov 2021 00:09:35 +0800
Message-Id: <20211112160935.19394-3-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112160935.19394-1-jnhuang95@gmail.com>
References: <20211112160935.19394-1-jnhuang95@gmail.com>
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
Cc: zhangshiming@oppo.co, yh@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So add a sysfs
node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
since v4:
- Resend in a clean chain.

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
index a9512594dc4c..8b620fb49962 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
 		device_table, compr_head2, sb_chksum.
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
index 43f0332fa489..8e70435629e5 100644
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
index 80ca5ed59bb4..8f0a71e880ea 100644
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
@@ -86,6 +94,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
@@ -132,6 +142,11 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
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

