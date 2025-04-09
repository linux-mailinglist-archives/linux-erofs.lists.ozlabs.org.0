Return-Path: <linux-erofs+bounces-173-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24594A82C76
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 18:33:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXpR24674z30Vr;
	Thu, 10 Apr 2025 02:33:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744216398;
	cv=none; b=KFF2eV5ig//SeU1zh1TIpZaOx+VbvWYHVBgEvkeX9Mlknm24325fxqfNUQL+ri/sI0R8xQ+TVRRmXMKPYJ5IW7bwiMHOUrQsoclGFE+zsNggwx15sD6Fr7kTM8en490FthYdebhgjSuzxpatrKlNkr5m3mxop5MpjegiccH5rpibrryHuzj/rfVuZUL2TAwDqAjit0+oOAWI936K0pfWTAUJdr7hJe787ukF7egs6jUD4TxOAwSpQdYR2pvEZ04EGqcQ01QEf6IRL239QNwWH7QPCB1ctYVkmKDvHKV7bUf+Mvwx3Zu7k6JaiCvZYeo1wQT2vUt/eOj1k3UgFTlYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744216398; c=relaxed/relaxed;
	bh=xYm5ZZU/Q8a2mBL/bFfUOZbUeIES0lpV2nwEmCpyHGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz+UevUTlyIrEZA4V26diaKAr90UvfN3gWucFq5WPvX+CjWrILgxoV+zoJoiYv6fzXXiIopDDy6zjIWSW+ROMYR1U60nNrTKuXaNg/Dr+QWnvWHLLsoScJdYrEtIVjN5VixUmQLHpla2XC1kRKxOh5NVlzzFk9phfIEgE2l1SFSL0OY4sZAaCb+oL1/CQlFohJp+FlTSseUwfqVLgUjCgSLcTEWyKggmaRAJAH9HiD4hn4zDEbLcbbjyjAERcXwMfU5bmM7EE4HHcpfFPiAJn+EoGwYnrc0ZdhWN5OywgKu+KTmhWCiAzbajAYd6DJLJd+8uH9vroFBL0Cl5Iun2Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ldBdH728; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ldBdH728;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXpR04rJKz30Vm
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 02:33:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744216392; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xYm5ZZU/Q8a2mBL/bFfUOZbUeIES0lpV2nwEmCpyHGQ=;
	b=ldBdH728GhVBqxc0apUOUONHwoZ/8BXLjrV5NELbi+7KtKHIzCuBSuiyiSIjDfZ5jrb7mF9SmJe1XPYHxjn9i6bB1368t4nyUF8/+dzdJIYgaqy7aGlWAn9woOsYtZFbInjV2E9VyHALXvNW+JY3yBTkUbPESLHQh4yf7GFNgxw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWKsZVh_1744216391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 00:33:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 08/10] erofs-utils: support dot-omitted directories
Date: Thu, 10 Apr 2025 00:32:57 +0800
Message-ID: <20250409163259.2077865-8-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
References: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Omit the `dot` dirent by default if 48bit layout is set.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/dir.c                |  2 ++
 lib/inode.c              | 35 +++++++++++++++++++++++++----------
 lib/namei.c              |  3 ++-
 mkfs/main.c              | 14 ++++++++++++++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 92c1467..eb5cad8 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -66,6 +66,7 @@ struct erofs_configure {
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
 	bool c_hard_dereference;
+	bool c_dot_omitted;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 83fd86c..94bca2d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -239,6 +239,7 @@ struct erofs_inode {
 	bool opaque;
 	/* OVL: non-merge dir that may contain whiteout entries */
 	bool whiteouts;
+	bool dot_omitted;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/lib/dir.c b/lib/dir.c
index d786a5b..3405844 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -150,6 +150,8 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 		return -ENOTDIR;
 
 	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
+	if (dir->dot_omitted)
+		ctx->flags |= EROFS_READDIR_DOT_FOUND;
 	pos = 0;
 	while (pos < dir->i_size) {
 		erofs_blk_t lblk = erofs_blknr(sbi, pos);
diff --git a/lib/inode.c b/lib/inode.c
index 23a4fc1..7f589e7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -253,21 +253,29 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 {
 	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d, *n, **sorted_d;
+	bool dot_omitted = cfg.c_dot_omitted;
 	unsigned int i;
 	unsigned int d_size = 0;
 
 	sorted_d = malloc(nr_subdirs * sizeof(d));
 	if (!sorted_d)
 		return -ENOMEM;
+
+	dir->dot_omitted = dot_omitted;
 	i = 0;
 	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
 		list_del(&d->d_child);
+		if (dot_omitted && !strcmp(d->name, ".")) {
+			erofs_iput(d->inode);
+			free(d);
+			continue;
+		}
 		sorted_d[i++] = d;
 	}
-	DBG_BUGON(i != nr_subdirs);
-	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
-	for (i = 0; i < nr_subdirs; i++)
-		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
+	DBG_BUGON(i + dot_omitted != nr_subdirs);
+	qsort(sorted_d, i, sizeof(d), comp_subdir);
+	while (i)
+		list_add(&sorted_d[--i]->d_child, &dir->i_subdirs);
 	free(sorted_d);
 
 	/* let's calculate dir size */
@@ -640,10 +648,12 @@ int erofs_iflush(struct erofs_inode *inode)
 		nlink_1 = false;
 		nb = (union erofs_inode_i_nb){};
 	}
+	fmt = S_ISDIR(inode->i_mode) && inode->dot_omitted ?
+		1 << EROFS_I_DOT_OMITTED_BIT : 0;
 
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
-		fmt = 0 | (inode->datalayout << 1);
+		fmt |= 0 | (inode->datalayout << 1);
 		u.dic.i_xattr_icount = cpu_to_le16(icount);
 		u.dic.i_mode = cpu_to_le16(inode->i_mode);
 		u.dic.i_nb.nlink = cpu_to_le16(inode->i_nlink);
@@ -668,7 +678,8 @@ int erofs_iflush(struct erofs_inode *inode)
 		u.dic.i_format = cpu_to_le16(fmt);
 		break;
 	case sizeof(struct erofs_inode_extended):
-		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
+		fmt |= 1 | (inode->datalayout << 1);
+		u.die.i_format = cpu_to_le16(fmt);
 		u.die.i_xattr_icount = cpu_to_le16(icount);
 		u.die.i_mode = cpu_to_le16(inode->i_mode);
 		u.die.i_nlink = cpu_to_le32(inode->i_nlink);
@@ -1538,13 +1549,17 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 
 	/*
 	 * if there're too many subdirs as compact form, set nlink=1
-	 * rather than upgrade to use extented form instead.
+	 * rather than upgrade to use extented form instead if possible.
 	 */
 	if (i_nlink > USHRT_MAX &&
-	    dir->inode_isize == sizeof(struct erofs_inode_compact))
-		dir->i_nlink = 1;
-	else
+	    dir->inode_isize == sizeof(struct erofs_inode_compact)) {
+		if (dir->dot_omitted)
+			dir->inode_isize = sizeof(struct erofs_inode_extended);
+		else
+			dir->i_nlink = 1;
+	} else {
 		dir->i_nlink = i_nlink;
+	}
 
 	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
diff --git a/lib/namei.c b/lib/namei.c
index dec544c..5da8ed9 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -100,8 +100,9 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	}
 
 	switch (vi->i_mode & S_IFMT) {
-	case S_IFREG:
 	case S_IFDIR:
+		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
+	case S_IFREG:
 	case S_IFLNK:
 		vi->u.i_blkaddr = le32_to_cpu(copied.i_u.startblk_lo) |
 			((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
diff --git a/mkfs/main.c b/mkfs/main.c
index 336c351..80e31c4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -332,6 +332,16 @@ static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
 	return 0;
 }
 
+static int erofs_mkfs_feat_set_dot_omitted(bool en, const char *val,
+					   unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+
+	cfg.c_dot_omitted = en;
+	return 0;
+}
+
 static struct {
 	char *feat;
 	int (*set)(bool en, const char *val, unsigned int len);
@@ -343,6 +353,7 @@ static struct {
 	{"dedupe", erofs_mkfs_feat_set_dedupe},
 	{"fragdedupe", erofs_mkfs_feat_set_fragdedupe},
 	{"48bit", erofs_mkfs_feat_set_48bit},
+	{"dot-omitted", erofs_mkfs_feat_set_dot_omitted},
 	{NULL, NULL},
 };
 
@@ -1242,6 +1253,9 @@ int main(int argc, char **argv)
 		g_sbi.epoch = mkfs_time;
 	}
 
+	if (cfg.c_dot_omitted)
+		erofs_sb_set_48bit(&g_sbi);
+
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
-- 
2.43.5


