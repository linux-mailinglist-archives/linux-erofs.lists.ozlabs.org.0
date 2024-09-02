Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 242959685B0
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 13:06:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy5YG2NYhz2yNj
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 21:06:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725275200;
	cv=none; b=WM7dX0VBmjfqsN1omD7kBAv/knvR2IylvjFjzh4a9s3pYemDW3ZVGddchYt0RUKSKhAG6U272uU1WHTl9KpawAArH/F+jT0NRDqSThKCq24Pwail1rXAVv9vSQSOqbgOoNyhTNUjucn/vlMWEFDIX4VhOuqiZKcqsBZRMQcYNH+7UzWBpNOwROvEu0jV3F+vyBMIszVcsm+1dcSfVqJBQ7JXiscIyvkXuEMf/ASCgdyLKRsTrO3uGNV2XQ7YcnFoVC8q7hb6FutHHgvhaImGas5mHQys5+EyPyy/uHoCX/ppcEXCp6mn09IDVXiPbU0M6IAW5vwrR1T7ST/lAn75eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725275200; c=relaxed/relaxed;
	bh=3lx/WieEaOEVggL0VOeyWGBi+pM61qJto+aBTEIGQYo=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=ZTlCwGaN+rGQtX1zLwfrWtr/2NXo/n3bkjDI5J7E7wQTJ37i1crwDT+BxjsMD48Ql2MfIl202omVVLANAhVOifWE+k3c8GROOKKl96gTEs20jwHZ8XdNyuLGDDCzO8JX1y4GqXyygBZ9LuDt9F/epolc4OgrBiqN227a3nScYj9k6nmW03QkFWNEPdHteLGTPLEJDuOIRGaevS9+BoUSCZE4wQKJyWZ6f4aCIfzgWDXMsUrPh1KBvhRh0W5E/dHCwMAQRwY6P0TBHiDDr3DcEiYNLvvMVCNQxj1V3+U4jO0jupQ9bohvaZmyxfezJJfsan4eeLV4vj4G2pb/47QmjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pTV9IUXu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pTV9IUXu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy5YC5NXTz2xfT
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 21:06:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275195; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3lx/WieEaOEVggL0VOeyWGBi+pM61qJto+aBTEIGQYo=;
	b=pTV9IUXuTM/3BBpAVK/dFiFt8iwpzgvlH3jRYTVKovGzm4L+TtYIJ+CGdALVoRv+stWb123MohQkZhWfx9KQ7y2R5MICyAvVY6g5jnN2Qrv180rFe854pjWhOPl0v/eHwUnn4jIhSgwMztfc8vMK9ViLEVvh5wjArA2om8u+j7E=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE7YYpT_1725275194)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:34 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC v4 1/4] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Mon,  2 Sep 2024 19:06:17 +0800
Message-ID: <20240902110620.2202586-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
References: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Move the `struct erofs_anon_fs_type` to the super.c and
expose it in preparation for the upcoming page cache share
feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v4: There are no changes compared to v3.
v3: https://lore.kernel.org/all/20240828111959.3677011-2-hongzhen@linux.alibaba.com/
v2: The patch set v2 does not move the `struct erofs_anon_fs_type` to super.c.
v1: https://lore.kernel.org/all/20240722065355.1396365-2-hongzhen@linux.alibaba.com/
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..826b2893acb2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
-#include <linux/pseudo_fs.h>
 #include <linux/fscache.h>
 #include "internal.h"
 
@@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
 static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
-static int erofs_anon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
-	.name           = "pseudo_erofs",
-	.init_fs_context = erofs_anon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
 struct erofs_fscache_io {
 	struct netfs_cache_resources cres;
 	struct iov_iter		iter;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..3d6bb1b36378 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -387,6 +387,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6cb5c8916174..afca576144ca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -834,6 +835,26 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static const struct super_operations erofs_anon_sops = {
+	.statfs	= simple_statfs,
+};
+
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+
+	if (ctx)
+		ctx->ops = &erofs_anon_sops;
+	return ctx ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
+	.owner		= THIS_MODULE,
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+
 static int __init erofs_module_init(void)
 {
 	int err;
-- 
2.43.5

