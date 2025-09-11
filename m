Return-Path: <linux-erofs+bounces-1018-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F859B53C41
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Sep 2025 21:27:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cN6yR3nMHz2ypw;
	Fri, 12 Sep 2025 05:27:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757618847;
	cv=none; b=UsUPR5qmSxASNPYDN4em1oxuleZCO2W6AAqrn6EE200Hv4dQ/DcsStULOUoyX6ewtk124f63YkV41Mbi4wg0HKJ6KmLLwHJYeSzZLu8UjBqN7pyaTCvdAvjIzwUgcSsy4ZcRtyvx2ZA69a5y/IODxpqrvDx4ILvFFGRDL5J9upZhpQCy6RnCMXKS2ADUefZbOe2nDkn1KxZLZ/EJvOt5d0QLOdpZkiauZx5+VKWbpXJhKduLXUAaXugbI4K2iT+B+AGrpJ8mQHrQMHr7w5lGdFIx0zLy7ztG6zsfKE1jokuQ+IWU7igiDRRr7V0C0uKvly0ikd0D/N6bX5N+5gVapg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757618847; c=relaxed/relaxed;
	bh=TgS+L0bL55mIYD7rURt5we3dz3uCQIidBU8PE3G6xGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvLwurnHQosXep4uxmGZiTVSqNzCGt6IMqGNjDxjHxzrWqL1WdyfUfkC4dpI6ysn8a9eEZugC29xoGu0hfetvilK6y8ZqdgMAYclf8ELPYpAoXCKpsmJB+RuDvCwUfioXp3u2JcyKL55JZDbJIdE2FsUv3xO9sWV4JcNCYjebqq+pRHMNtPnNsBbQ4A6KzFWSFhN/o3/KQrgVGKowK29DBfdU18/Wio10aErTGY6GenbM3etby1cl+wXMaGntiWQsShoX4xAk5OcP8RruOw3PhpG1mGFWEv4zv7uRwJ5zg157CYPjwZ0gi936riK7AzbojaUqmrj03hXYLvTNvsrPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8rFbf+c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8rFbf+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cN6yP3KNjz2ykc
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Sep 2025 05:27:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757618839; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TgS+L0bL55mIYD7rURt5we3dz3uCQIidBU8PE3G6xGQ=;
	b=L8rFbf+cnawEwlPEvvb49ReeUccG6GJTACDnxw0XKf/H0kLD9ZhIdzNOLol6FxKPbKyzSH8qPa0u9HLao50Q6VILgqmL5YfJBkSXVQDFc3rqpg+2JfjIQd7znepkmaJIPrgW6NTy3jbgNYGPxqV4sJOXNmsywEGQcQ2+rGqxIek=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnnaSWZ_1757618832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 03:27:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix long xattr name prefix placement
Date: Fri, 12 Sep 2025 03:27:11 +0800
Message-ID: <20250911192711.1771664-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, xattr name prefixes are forcibly placed into the packed
inode if the fragments feature is enabled, and users have no option
to put them in plain form directly on disk.

This is inflexible. First, as mentioned above, users should be able
to store unwrapped long xattr name prefixes unconditionally
(COMPAT_PLAIN_XATTR_PFX). Second, since we now have the new metabox
inode to store metadata, it should be used when available instead
of the packed inode.

Fixes: 414091322c63 ("erofs: implement metadata compression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  8 +++++---
 fs/erofs/internal.h |  1 +
 fs/erofs/xattr.c    | 13 ++++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 377ee12b8b96..3d5738f80072 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -12,10 +12,12 @@
 /* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
-#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
-#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
-#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM			0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME			0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
 #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
+#define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
+
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..9319c66e86c3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -234,6 +234,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
+EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
 
 static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index eaa9efd766ee..396536d9a862 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -482,6 +482,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
 	struct erofs_xattr_prefix_item *pfs;
 	int ret = 0, i, len;
+	bool plain = erofs_sb_has_plain_xattr_pfx(sbi);
 
 	if (!sbi->xattr_prefix_count)
 		return 0;
@@ -490,9 +491,15 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (!pfs)
 		return -ENOMEM;
 
-	if (sbi->packed_inode)
-		buf.mapping = sbi->packed_inode->i_mapping;
-	else
+	if (!plain) {
+		if (erofs_sb_has_metabox(sbi))
+			(void)erofs_init_metabuf(&buf, sb, true);
+		else if (sbi->packed_inode)
+			buf.mapping = sbi->packed_inode->i_mapping;
+		else
+			plain = true;
+	}
+	if (plain)
 		(void)erofs_init_metabuf(&buf, sb, false);
 
 	for (i = 0; i < sbi->xattr_prefix_count; i++) {
-- 
2.43.5


