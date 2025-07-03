Return-Path: <linux-erofs+bounces-504-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECDAF73D4
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:23:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXwsj1v9Kz2yf3;
	Thu,  3 Jul 2025 22:23:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751545417;
	cv=none; b=Ep7yYxZki5zAdccrsNgLF8m45kKPIF+P4Y3XHG4lL0tJD2P30lpdF3s+93IHMjdY3SsdUMml50wOxIvcGR/Xa6qYQ625vcuevYRPX7glwQCZ7bHnP3GEMWP7gvq+X9wTKpq01vU7Z+h8JUWYV9LR7YMrYW7+WW21FuYMCFVoEn6COcwx8jNW7Wzz4wqS6x28TYzUejky4yXBTj3MUezKpbLZZprctIgxMHhMWxS9gFToVWGJkBuZOKHkTLK1hmoV+wEetqr8BB9Ts4HU1uWxbSLMM3F/gU6XoBMwcLefF0G1/y530lZN5K7wdtAlKQ3I/5c1vRZrHFUfdB0rD/VqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751545417; c=relaxed/relaxed;
	bh=pgqpJzdrVczFSBKcfaVn2GVXIfZn4aEG6tHDZCqOmxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlwkEVs/GYPjj9A2jAcHiJSRiN9DsvRoP3dXucOxc4MeKBty+mGysTzi22LFmdpreIC16ngHGoxuZOJQ9/jtyN34Xy0v/SwyaSxA4laf+EnyWy1qxJrRbptHGotS1I0tYCyRFBvsoqJdHrvUBpVnFc5RF7fxRmFNyEGFbuDAwGItof6yAKGIKub4jShsjMmoWXRne81dS9vO3v5fS6aAw5GbI8wmr918/ynOJrv/194puejh2aN3uVACyPvg8mQfPQ6+bSUZ3BGjAKgAd6JLEaPSngIry2ZWZSqOGjYcalV7jTk+jrYViW1M7IaaUTI8QIcoEzq3sg1JdsSx4oqM2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aw+MQMpC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aw+MQMpC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXwsh3XzPz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:23:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C45A613B1;
	Thu,  3 Jul 2025 12:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226FDC4CEF2;
	Thu,  3 Jul 2025 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545413;
	bh=tIkexk0NlSjVfKpl85FvzphZmjy8RaMeVxMQXVa+HT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aw+MQMpCae+/7FFKEPeO6uosVucp4YSrE2vRRC0h73ELcMH+HxOsrXxiLGUEq5S/s
	 dfkCkM979421lF36KYF2yjz8tCaZGrqJvaeIukGktrh+Xtq2bSUW8vzgCFzRbLgnQW
	 O55Y8fhquCoHZy2RA7BcWMQecdcyXJLCUxN8WeLKg7dbHRuMKrJlAq69C/8K/GBAoc
	 eQbHzgMAUAVzgw2lcig+Op0b7Z834axqzAFOgrLiSCCIdTuG8Uj/0IFKd6IPh9HJES
	 BAesGy+h4TOLDSuCm+vkUErh6KvsvanR9WJanpBPTPKsmhwmS13TciRIWfT4S1JXwR
	 5LVUl+nKql0Xw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Jul 2025 14:23:10 +0200
Subject: [PATCH RFC 1/4] erofs: move `struct erofs_anon_fs_type` to super.c
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-work-erofs-pcs-v1-1-0ce1f6be28ee@kernel.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
In-Reply-To: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
To: Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Hongzhen Luo <hongzhen@linux.alibaba.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UxL9rHrcB5+0X//+n3ZM8rFbg41zdq3WpJJlg8e4J18=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkldk/3ye5Ze/xcMbeUzrBW+Mypfdw563Z9U6h3V9IS
 8S1YeKbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4SDEyPLwWxfwy/ODW2suv
 13HqBoSwzXuw+2lfjNobZkXmCR6vxBj+yncXtlvdZE/7//rZ9l+a6zwmHyqZv1NTYtLcbbHqJzm
 3MwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Move the `struct erofs_anon_fs_type` to the super.c and
expose it in preparation for the upcoming page cache share
feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Link: https://lore.kernel.org/20240902110620.2202586-2-hongzhen@linux.alibaba.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 34517ca9df91..fe9216dd27f8 100644
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
index a32c03a80c70..30380f7baf5e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -372,6 +372,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..8fb14df2a343 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -889,6 +890,29 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static const struct super_operations erofs_anon_sops = {
+	.statfs	= simple_statfs,
+};
+
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ops = &erofs_anon_sops;
+	return 0;
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
2.47.2


