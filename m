Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDAA019F2
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jan 2025 16:12:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YR15B5Bryz3cVT
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 02:12:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736089944;
	cv=none; b=fPxFLoQ5LFWxpKVfxO6I+GT8ch39kXPq2Jwgo8t9zcT8tG1BgzABhLtTAAy9yAbzMLn3uhEHI0wfGNKZF5VO8JSrIslLXEqX8D+ttymJ6BGaZWHvFjmBh0r5JMQcFWv1EUPD1ry8qKOCAt0WgLXaXR+Z4pDvJCVeqP9bppk1f5Ttb4zegLKp4OLi521yTuDM9AYU7NoaUUPOv7+ZtI8GzVQ0tX8boIU5iXN0aA6ZbzwjDLLO3Qxd+ISV5Dmt+o+QXF/V5Ug/SDtgHk8B9GwI61aOdNsRUzQjAkSfqcUEBDHbhgZF8pxI/k8lFLZctRa1HHoKuPmF36ShLM52BwGmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736089944; c=relaxed/relaxed;
	bh=7JzKr/Q1YXpJrtDxijOF4+BJ1RBdmdJhpP2voDpJsTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ydep9L+DL7cyuC93tQFXJSNgRg9Vs1jwfTmEmBboB2s2FVQR2POF3/wOwBHl0x/IGJZW/WSn7hjit9xk9BJt8sIK6DWOmLyVfIFks1P8Bc7PkbCcqXhXkCVnIIScL3bwjmZ1Nx1rVQXDTciskOb9B82mWNCFQVuNsVVUIxfUOGjqT8gl0pHyMC1ZV7BWjqEmRkn0mp1IjpY+ueH9eRoYB1yifMIP3m5WGu9B/eg0ndXtcVqkbHfN8BosTteTwZjMTmkN1+FY+A8k0bw5fpQ7Rw4sopIglxKxGxhh36nfFnU1CmLa7K9G2eiHNQO7InXSsrByyh/oogB4BI0KXmNJyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ICi9CAdV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ICi9CAdV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YR1503QRfz2yNP
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 02:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736089934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7JzKr/Q1YXpJrtDxijOF4+BJ1RBdmdJhpP2voDpJsTU=;
	b=ICi9CAdV6OuDnW07GHmJWpC9uxl0m6NdDRrPHnXmhZH6vDsi9DwzPiKXTzQkP13r8no+yDB0IMwWqGywkQcfAnF79ZBX/evECHEIHRiq+wJcOit9bKETvIXkGD2qVghWHcGTY/F9KS/I2+cLnrxSfMO3GmvnRwpk4MCMJ3qmJ9Q=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WMyob0G_1736089930 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 05 Jan 2025 23:12:11 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 1/4] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Sun,  5 Jan 2025 23:12:05 +0800
Message-ID: <20250105151208.3797385-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 13 +++++++++++++
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce3d8737df85..ae7bd9ebff38 100644
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
index 686d835eb533..47004eb89838 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -379,6 +379,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1fc5623c3a4d..25d2c2b44d0a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -852,6 +853,18 @@ static struct file_system_type erofs_fs_type = {
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
2.43.5

