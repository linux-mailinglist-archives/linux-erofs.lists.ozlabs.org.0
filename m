Return-Path: <linux-erofs+bounces-1271-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4BEBF5ECC
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 12:59:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crTp909CFz30MY;
	Tue, 21 Oct 2025 21:59:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761044384;
	cv=none; b=X5CWViG9IEcK7Y+y/JWv/qMDhMbWaCTIVJemXOCPdZBzYv0sII1chqUXolrWB7UNawNcANspsTmKGwyhU/JH0QxGTpk3qvx3fGiCqZ8wbLBzb8I0hQZqyZHNs6/BTPpc0aXXxCJWoi55JGY6rE4S7Iw9rw2pxPand3TOgQHpIh6Cd3AjocCkUa9Hh8MUHaDh7wW6A1RdO4TVy4w+UQuNz2CgByGVZdvX6U3U4JQSuwalfZwBE0lmKBmY+MDIulCv3OUNgdkuIxeHKXAsopP8tpi/rM1tiIFCrDwObuCbmVtzIRh2fUEJqv7OMVfPObB16r8SLRkGYK3wopM8Kb8qfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761044384; c=relaxed/relaxed;
	bh=ck6npKF+h2adwSuQA2R5HJLsYhHiaeynnKxMeeII07Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCr4mbeSVjylfSW9ksApxDKPYAqM5f0Xw3AqihzBPmWdiH7O8FrmwyVY0puGfHMdxhUMuDmtV4KUmRZMgcfLBXKDj5zH4A2R8svMfmzxhV0EXkaHrq7TSDhYxg51/s/55wP1tLqEBNSmUnj+TFrJ0+r12OAUkQ3VnJMEEijZ2MVeWvCBFavdinPV9npG+E+uKH6dfkGOcxMUvt7dYcXqW0La60GOhBpIh8JL3ZRNx6KIuLBKIcuFZ1DKHhXPZI02D3QPoUYzkFVyrzIUaSUSyLxDfO5PfBGXVzYy22oW/8CPothl8/CK8FXPyd0Vqp2Xza7H/Rw3WNRI1eu98Qsa0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=47ADE1VB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=47ADE1VB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crTp36tkhz2ymg
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:59:39 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ck6npKF+h2adwSuQA2R5HJLsYhHiaeynnKxMeeII07Y=;
	b=47ADE1VBKayVDXlfGWjppD5Q3HsUlPmyl2823Ec93LKTFo+BZ4ayGE/cSJOLkotjTQQVYv5Mm
	3G8CxfzCOaXzx8kTnwLFOSgtNsTefOeldOf1AVtinYJGWpvne3rM8/8/s/0zoSqnCoanN0HWkQt
	6kMae5IM70a9CMJGRNW5XXM=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4crTnS6kg7z1prQN;
	Tue, 21 Oct 2025 18:59:08 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5038C180B6B;
	Tue, 21 Oct 2025 18:59:33 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:32 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 1/7] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Tue, 21 Oct 2025 10:48:09 +0000
Message-ID: <20251021104815.70662-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251021104815.70662-1-lihongbo22@huawei.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
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
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Move the `struct erofs_anon_fs_type` to the super.c and
expose it in preparation for the upcoming page cache share
feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
[hongbo: forward port]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 13 +++++++++++++
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279..2d1683479fc0 100644
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
index f7f622836198..eac067446140 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -409,6 +409,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..f9d8f978bf81 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -920,6 +921,18 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
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
2.22.0


