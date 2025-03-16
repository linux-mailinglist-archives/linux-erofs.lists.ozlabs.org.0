Return-Path: <linux-erofs+bounces-72-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C666A63379
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:37:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLX27h9z2yf0;
	Sun, 16 Mar 2025 14:37:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096228;
	cv=none; b=TZkcqa9um/r6hybkPVeHPtQanMCOX4FeVwLIxfqlKP3WAAdjlvbV2g5cor6sXvBSFX0eqe9Psg2FCA05P/ZCGHjYwhEqiXo/ISiYo4jC2cWfpi+hsQyMGzW2bGbIYojJPAZyQNqeODID//O6hGdzN2a1jmB+aocpjE48FHiFmfWejgyoanE4vmNkYzqLOyEMforLWOWwPVkQjsBCswCMGkNZGq1zQNRmro+ToLOpC4hqlkJcodkJ/2BX6AVqzPd+qns9d2XKT/ItE3HAdybsjY0YnzMR5CSxv0Eya+9ndLsCncjLAWrFCiG4es3uVEaHC9Uz8JkTwPnds/nDXHq1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096228; c=relaxed/relaxed;
	bh=3y/s4UD/eBTW3Jv8eTRnucvtEN8WYDRIAhJYzThWpes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNz/Wr13/ELJGwUmDVisoIM0176FWqtycYAZKiLRrOUGLfl+3FHvlaTyFU+bFsTTmPV3zuoErxD1xCXZ96x/IllDlyv9/QXiCKcUYfA9lFhLzzWpfRr9GIUObSxxx0YmkVB7+v6f/CYBnDhrUJp3py9HnUPcAXgz34C+jeU8sNQJj0l4oxi2+y0jP4yQ8FbuZHAfp4eJutTIhIOuPz1n00Wx3cweCq6JA/JHoZyvP8lwd0aG1gbgTbuBan9Fvd7ZcTr819PcPR3LxxDVOVqn/fytMyzaX4uk/pR85lqlFbQuqywEfYXhkrShAvbbKHQrTtZBefJGq9DyRoPq6DiQSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RVx87+xc; dkim-atps=neutral; spf=pass (client-ip=47.90.199.6; helo=out199-6.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RVx87+xc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.6; helo=out199-6.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLW05Mrz2ySZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:37:06 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096210; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3y/s4UD/eBTW3Jv8eTRnucvtEN8WYDRIAhJYzThWpes=;
	b=RVx87+xcYVAhotisFMPbZ+G4oUV+xEMTSofeonDnJA/QRe2C6PSKiz5U1kNEZxDTAP8OdVVEI/Y0tIQYcZRYWi/Nb6z62l0OQ6BayaJhfQtPuuJ1OzWtG4tNYJ1DXAmB2dZu1mZkW1z1hzl057bM7aWu/JviK4fNeMTs6yN19FM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS66_1742096208 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 6/8] erofs-utils: support dot-omitted directories
Date: Sun, 16 Mar 2025 11:36:37 +0800
Message-ID: <20250316033639.1050759-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
References: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Omit the `dot` dirent by default if 48bit layout is set.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

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
index fd8d43d..227e830 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -236,6 +236,7 @@ struct erofs_inode {
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
index cf3bcee..df1f699 100644
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
@@ -641,10 +649,12 @@ int erofs_iflush(struct erofs_inode *inode)
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
@@ -669,7 +679,8 @@ int erofs_iflush(struct erofs_inode *inode)
 		u.dic.i_format = cpu_to_le16(fmt);
 		break;
 	case sizeof(struct erofs_inode_extended):
-		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
+		fmt |= 1 | (inode->datalayout << 1);
+		u.die.i_format = cpu_to_le16(fmt);
 		u.die.i_xattr_icount = cpu_to_le16(icount);
 		u.die.i_mode = cpu_to_le16(inode->i_mode);
 		u.die.i_nlink = cpu_to_le32(inode->i_nlink);
@@ -1543,13 +1554,17 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 
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
index 2defa92..49a9eff 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -334,6 +334,16 @@ static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
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
@@ -345,6 +355,7 @@ static struct {
 	{"dedupe", erofs_mkfs_feat_set_dedupe},
 	{"fragdedupe", erofs_mkfs_feat_set_fragdedupe},
 	{"48bit", erofs_mkfs_feat_set_48bit},
+	{"dot-omitted", erofs_mkfs_feat_set_dot_omitted},
 	{NULL, NULL},
 };
 
@@ -1247,6 +1258,9 @@ int main(int argc, char **argv)
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


