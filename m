Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D20D9625D8
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 13:20:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv25B26mgz302T
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 21:20:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724844010;
	cv=none; b=NoBzwmAGmrVzg4mYLbRfaIt6p7p9m9bCWKOy29KJZ9iknY5PhZOjYHlo/n5s0ov7Ri0gHXKHbsQdiSSclzn0TAF6AkiAWAFHi0aThcz6sZCUuYf/T/wPvvqqPWtrUXNvnYrxCoP1sDJ4ktNCgFk5WmZzL6bzfY/4gOWiukrbBeiA337rHuQ2YIVcKkBpnakQHcu7oD59W3wmn51yFZa3ITa9/62S0FTjm4lKcCV/Z8CXzb+x69uGH1Kd4MzKf0VCgrL+j3ZDA3KAQiKFci3m0JVgfRnAvz7dRIkd9HClEKpeT03Fb4sGu5zO4gaf0VxR/BQ4EQkkY+OnaQ4CygSl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724844010; c=relaxed/relaxed;
	bh=+MAPxIrkS42YkSLKKULbrzqnaSd+CBL8Uk5HdFnoGPE=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=bjF3XHaTpxIC4k70PRMKuNvIE0USCaLElem+aLFkUYQWbksv4GbLvULJ2tKW0hPpykjGdca1E78+HGS6oHWL+OhiNmrBvrFY8C4O97u6BYtViQVOYK3bmxFQNJwkktoOKnjPm2R0BgL6kQa1DLsFijyMmFRW3rYF8+XXNqyw7HLWeHjDbzFlgMwRgAU8go6PKgWfxgNZcJ3baGol7ZWJNCWYkb//s68gCD+UI3nh58cYnM+PeR3YG6zHJ4ljpknE508n1xE+5dITiRr3olKA5681uE56IbAZA+J2iKzOWKV76TJImkQQaZfg11mh+3JOQRwQYFwJGPb5rQokKalk7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kArGM87h; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kArGM87h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv2550wbqz2xsN
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 21:20:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844004; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+MAPxIrkS42YkSLKKULbrzqnaSd+CBL8Uk5HdFnoGPE=;
	b=kArGM87huxXH0AitJNm/jOlKBLGcAQEJlds6hkdAOPpG8C/KKU0F64lMfof6cuVqfHS9Vwa294QUfcXgX3smUmWWpTPiPuQzSfVbjHJEyAuD1NS5KudoBvPTeb8rAnqHMijBf199V+y93+YBXwSgGo8Dc/h+upU9oNmmXBAyp4s=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDpbUOx_1724844002)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:20:03 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Subject: [PATCH RFC v3 1/3] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Wed, 28 Aug 2024 19:19:57 +0800
Message-ID: <20240828111959.3677011-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
References: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
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
v3:
Changes since the v1:
	- Utilize the `erofs_anon_sops` as the interface for the VFS to operate
	  on anonymous inodes. The subsequent patch will implement .free_inode to
	  facilitate more granular control over anonymous inodes.

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
index 736607675396..3f1984664dac 100644
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
index 32ce5b35e1df..36291feaa5f6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -848,6 +849,26 @@ static struct file_system_type erofs_fs_type = {
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

