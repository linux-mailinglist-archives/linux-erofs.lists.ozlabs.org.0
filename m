Return-Path: <linux-erofs+bounces-378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A90ACB9FF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Jun 2025 19:08:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bB0fy1kw6z2y8l;
	Tue,  3 Jun 2025 03:08:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748884121;
	cv=none; b=BSehcS9DGt78ISshvvThSgYgYfZ1OibpqTkcb/ptq/8/lqJXg/MZxz1ZZJMcsb42s7ali5nUMYEtufOWbfWM/rjwGmSiVDaTVzgfR+tGR4jWpGUsM+JWcAAeUXHjLyKyvuK0aKxiuiqQCXG2e6D6/6Qs7CTJ6lfGwkf1CFw8wMjhANU50rTwIL3XviJYt1ZBrnCeu4xUDy/pl83y8YrqAorQHFvWMI/2Gd6zn3zThcwUd9A1TmUxfjWwA7XJV7LkMLF0sTHPKtXPTe11YMc7WMX5Smnp/86DIaeuqSKZFX2N0/U7NFkrl66ABL+rfNdw459wfbr1EvWAIQoC6S2ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748884121; c=relaxed/relaxed;
	bh=lc+DEamDSfRrtRfYvXJhzn0P0HnN5KoH3zIJyV5c1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqhYh5sdRDTQ61Eqrt718ZG1xKfTICJCu1I0K/knqZJt0g4ar2eKpE7wZbH6Be6ttOJayCu/SVZUh4RilUdG/p5d1JJ/ttxFnotPQ2q6YDnjwg+y1HC/YEU0nx4ZZ47CPjweTPAoB8E1CovSiAGu9YUW44oTs0ZZvt0HhBw8ZbHSJciEkaU5oe6I+tHSb0x4fVMf8u5nmh5HOYqGHmpmv3pj5kgOBd8X96/49Msc4K1OJ7tdXgFORQ1u6X+hg9lw0UfXwqtRv7QTfZrDlAc8PUPRNar52IDrzd2tchMV10dSVofhG+6SnOvW6MHYhrsE+03YSjUXth1RKj0gSxbJbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eocPpelt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eocPpelt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bB0fv1pMhz2xfB
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 03:08:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748884113; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lc+DEamDSfRrtRfYvXJhzn0P0HnN5KoH3zIJyV5c1Po=;
	b=eocPpeltunbUzE88tXtQlhalem5IhCRG3lwAip/xf2MiQObSPin+lYQdHxpH66MBwaGxjQNsgF1rki1GzD8tFSc3cnNkZOsAG7KAb8GVHwN8dP08TrydC1Vy/ja8UseLEGVR/+p+kgOjKSEZrFPlx8cX2ZSSlNShelqpuO2eHgo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wcdijid_1748884105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 01:08:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: mkfs: fix image reproducibility of `-E(all-)fragments`
Date: Tue,  3 Jun 2025 01:08:23 +0800
Message-ID: <20250602170823.1201737-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
References: <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
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

The timestamp of the packed inode should be fixed to the build time.

Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix time assignment (assign `i_mtime_nsec` too) [Hongbo];

 lib/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7a10624..9095ebc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -910,7 +910,8 @@ out:
 	return 0;
 }
 
-static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
+static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
+					    const char *path)
 {
 	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
 		return true;
@@ -924,7 +925,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != inode->sbi->build_time ||
+	if (path != EROFS_PACKED_INODE &&
+	    (inode->i_mtime != inode->sbi->build_time ||
 	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
@@ -1016,6 +1018,11 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		erofs_err("gid overflow @ %s", path);
 	inode->i_gid += cfg.c_gid_offset;
 
+	if (path == EROFS_PACKED_INODE) {
+		inode->i_mtime = sbi->build_time;
+		inode->i_mtime_nsec = sbi->build_time_nsec;
+		return 0;
+	}
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
@@ -1029,7 +1036,6 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	default:
 		break;
 	}
-
 	return 0;
 }
 
@@ -1065,7 +1071,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	if (!inode->i_srcpath)
 		return -ENOMEM;
 
-	if (erofs_should_use_inode_extended(inode)) {
+	if (erofs_should_use_inode_extended(inode, path)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
@@ -1610,7 +1616,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	erofs_update_progressinfo("Processing %s ...", trimmed);
 	free(trimmed);
 
-	if (erofs_should_use_inode_extended(inode)) {
+	if (erofs_should_use_inode_extended(inode, inode->i_srcpath)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
-- 
2.43.5


