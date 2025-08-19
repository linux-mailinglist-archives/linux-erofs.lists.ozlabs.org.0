Return-Path: <linux-erofs+bounces-837-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E6B2B786
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 05:28:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Zmg4S0sz3cb5;
	Tue, 19 Aug 2025 13:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755574115;
	cv=none; b=STwIqVsEEtoq7+c+uwOFNwR9GFxIqAF5JHKIDykDL0YVmzIMXDMrjAVmWLnuHK4F0A+SRseRENR0fPiUJ5lf1dmggbQ2q7XWYSOM3mg7CASPbGe0dUdnBg6fyGLk3jZo/wZoyOzlJj+y/gf8uXyPmTWiM2FyUQSxI2My9Xbf/0EzVLhu97fhHAojVxblKf6InNAGA2/niZLZGXHKRaCqBAfkynx6zMpSdD2zUN1MHQV7uZkKogJ7c203BXBJ+2gttKz7pM3WcBuA9IkC9NSkiDugsqx5jole0J7JkQI0Q/FFXC2ueWcpNAvOOFqEsCuPpLcFNHmSwuQY9UVnW8XOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755574115; c=relaxed/relaxed;
	bh=j+3cazlyCTMTLIn1DyAzP3k9qSw4L6RdxUCJJ5lzbSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0/cLcS/FdltsqLZvqb8bR0IxGz0o4VBQ7hn7r+A/KC/c/LuX1sdfCH7Ax3uM5hTxxaKLt7kzJURETHUtCKbmg8ctHkqAXoHAjglBcMLhX9LzFR0gsjMvPCFdywjzJCvdvNoNO+4UQ4iKkkhfVzsoTWBuyrO4bhFXtY2/qv/bJxJZZa/zprNiN9KkxqRO+y5fhW0B8kEmCV9RjmP1pEyJXfFJNIu23mNrCbk9DCPdo+id0caoBuRt/vc+Kc5wKqzjzqIHimH+2KHesXYA3NXGFZVWOZ3i0Cxl/SU8riympZnqu/M6PHXx++OaABKm4hOLyXkWbCK6/3ftyKee9z/Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xwXX8RW8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xwXX8RW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Zmf3Gqjz3clV
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 13:28:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755574110; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j+3cazlyCTMTLIn1DyAzP3k9qSw4L6RdxUCJJ5lzbSk=;
	b=xwXX8RW8Y4FIO9n4riFggQx0ZBG+JDaou8sW7EE5u5fhD6sV1Sk1b8/7pPAS4SpfDJhOVWbK2hn5/j7uGu0c0/wkGFIZxxb+KJktfr+UvoYWjQniFY8h6N5x23YdO6QGwLbYpFyNmSptVrp5CwA0Ij5u3ROP6DFtlhtYxfRhVZM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm5DR7W_1755574107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:28:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 6/7] erofs-utils: lib: migrate `c_[ug]id` and `c_[ug]id_offset`
Date: Tue, 19 Aug 2025 11:28:17 +0800
Message-ID: <20250819032818.3598157-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
References: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  2 --
 include/erofs/importer.h |  4 ++++
 include/erofs/inode.h    |  4 ++--
 lib/config.c             |  2 --
 lib/importer.c           |  5 ++++-
 lib/inode.c              | 40 +++++++++++++++++++++-------------------
 lib/remotes/s3.c         |  2 +-
 lib/tar.c                |  2 +-
 mkfs/main.c              | 14 +++++++-------
 9 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 40a2011..f1593a5 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -87,9 +87,7 @@ struct erofs_configure {
 	s32 c_mkfs_pclustersize_metabox;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
-	u32 c_uid, c_gid;
 	const char *mount_point;
-	long long c_uid_offset, c_gid_offset;
 	u32 c_root_xattr_isize;
 #ifdef EROFS_MT_ENABLED
 	u64 c_mkfs_segment_size;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 0382913..707da5e 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -15,6 +15,10 @@ extern "C"
 struct erofs_importer_params {
 	char *source;
 	u32 mt_async_queue_limit;
+	u32 fixed_uid;
+	u32 fixed_gid;
+	u32 uid_offset;
+	u32 gid_offset;
 	bool no_datainline;
 };
 
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index c3155ba..8b91771 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -40,8 +40,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
 int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks);
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
-int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
-		       const char *path);
+int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
+		       struct stat *st, const char *path);
 struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
 int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 			     bool incremental);
diff --git a/lib/config.c b/lib/config.c
index f7c6fba..c5e6757 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -33,8 +33,6 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
-	cfg.c_uid = -1;
-	cfg.c_gid = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
 	cfg.c_mkfs_pclustersize_metabox = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
diff --git a/lib/importer.c b/lib/importer.c
index 74bd24a..8e86993 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -16,7 +16,10 @@ static bool erofs_importer_global_initialized;
 
 void erofs_importer_preset(struct erofs_importer_params *params)
 {
-	*params = (struct erofs_importer_params) {};
+	*params = (struct erofs_importer_params) {
+		.fixed_uid = -1,
+		.fixed_gid = -1,
+	};
 }
 
 void erofs_importer_global_init(void)
diff --git a/lib/inode.c b/lib/inode.c
index 9a5b67c..fe056a6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1160,25 +1160,27 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
-		       const char *path)
+int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
+		       struct stat *st, const char *path)
 {
-	int err = erofs_droid_inode_fsconfig(inode, st, path);
+	struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = inode->sbi;
+	int err;
 
+	err = erofs_droid_inode_fsconfig(inode, st, path);
 	if (err)
 		return err;
 
-	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
-	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
+	inode->i_uid = params->fixed_uid == -1 ? st->st_uid : params->fixed_uid;
+	inode->i_gid = params->fixed_gid == -1 ? st->st_gid : params->fixed_gid;
 
-	if (inode->i_uid + cfg.c_uid_offset < 0)
+	if ((u32)(inode->i_uid + params->uid_offset) < inode->i_uid)
 		erofs_err("uid overflow @ %s", path);
-	inode->i_uid += cfg.c_uid_offset;
+	inode->i_uid += params->uid_offset;
 
-	if (inode->i_gid + cfg.c_gid_offset < 0)
+	if ((u32)(inode->i_gid + params->gid_offset) < inode->i_gid)
 		erofs_err("gid overflow @ %s", path);
-	inode->i_gid += cfg.c_gid_offset;
+	inode->i_gid += params->gid_offset;
 
 	if (erofs_is_special_identifier(path)) {
 		inode->i_mtime = sbi->epoch + sbi->build_time;
@@ -1201,10 +1203,10 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	return 0;
 }
 
-static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
-			    const char *path)
+static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
+			    struct stat *st, const char *path)
 {
-	int err = __erofs_fill_inode(inode, st, path);
+	int err = __erofs_fill_inode(im, inode, st, path);
 
 	if (err)
 		return err;
@@ -1278,11 +1280,12 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 	return inode;
 }
 
-static struct erofs_inode *erofs_iget_from_local(struct erofs_sb_info *sbi,
+static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 						 const char *path)
 {
-	struct stat st;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_inode *inode;
+	struct stat st;
 	int ret;
 
 	ret = lstat(path, &st);
@@ -1305,7 +1308,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_sb_info *sbi,
 	if (IS_ERR(inode))
 		return inode;
 
-	ret = erofs_fill_inode(inode, &st, path);
+	ret = erofs_fill_inode(im, inode, &st, path);
 	if (ret) {
 		erofs_iput(inode);
 		return ERR_PTR(ret);
@@ -1597,7 +1600,6 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 
 static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_inode *dir)
 {
-	struct erofs_sb_info *sbi = im->sbi;
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
@@ -1649,7 +1651,7 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_i
 		if (ret < 0 || ret >= PATH_MAX)
 			goto err_closedir;
 
-		inode = erofs_iget_from_local(sbi, buf);
+		inode = erofs_iget_from_local(im, buf);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			goto err_closedir;
@@ -1990,7 +1992,7 @@ static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 		if (err)
 			return -errno;
 
-		err = erofs_fill_inode(im->root, &st, params->source);
+		err = erofs_fill_inode(im, im->root, &st, params->source);
 		if (err)
 			return err;
 	}
@@ -2118,7 +2120,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		st.st_nlink = 0;
 	}
 
-	ret = erofs_fill_inode(inode, &st, name);
+	ret = erofs_fill_inode(im, inode, &st, name);
 	if (ret) {
 		free(inode);
 		return ERR_PTR(ret);
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 8f4638f..0296ef4 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -744,7 +744,7 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 
 		st.st_mtime = obj->mtime;
 		ST_MTIM_NSEC_SET(&st, obj->mtime_ns);
-		ret = __erofs_fill_inode(inode, &st, obj->key);
+		ret = __erofs_fill_inode(im, inode, &st, obj->key);
 		if (!ret && S_ISREG(inode->i_mode)) {
 			inode->i_size = obj->size;
 			if (fillzero)
diff --git a/lib/tar.c b/lib/tar.c
index 4b1c101..95129b3 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1079,7 +1079,7 @@ new_inode:
 		goto out;
 	}
 
-	ret = __erofs_fill_inode(inode, &st, eh.path);
+	ret = __erofs_fill_inode(im, inode, &st, eh.path);
 	if (ret)
 		goto out;
 	inode->i_size = st.st_size;
diff --git a/mkfs/main.c b/mkfs/main.c
index a4ff204..a2b905e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -963,21 +963,21 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				return opt;
 			break;
 		case 5:
-			cfg.c_uid = strtoul(optarg, &endptr, 0);
-			if (cfg.c_uid == -1 || *endptr != '\0') {
+			params->fixed_uid = strtoul(optarg, &endptr, 0);
+			if (params->fixed_uid == -1 || *endptr != '\0') {
 				erofs_err("invalid uid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 6:
-			cfg.c_gid = strtoul(optarg, &endptr, 0);
-			if (cfg.c_gid == -1 || *endptr != '\0') {
+			params->fixed_gid = strtoul(optarg, &endptr, 0);
+			if (params->fixed_gid == -1 || *endptr != '\0') {
 				erofs_err("invalid gid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 7:
-			cfg.c_uid = cfg.c_gid = 0;
+			params->fixed_uid = params->fixed_gid = 0;
 			break;
 #ifndef NDEBUG
 		case 8:
@@ -1070,7 +1070,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 		case 16:
 			errno = 0;
-			cfg.c_uid_offset = strtoll(optarg, &endptr, 0);
+			params->uid_offset = strtoul(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid uid offset %s", optarg);
 				return -EINVAL;
@@ -1078,7 +1078,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 		case 17:
 			errno = 0;
-			cfg.c_gid_offset = strtoll(optarg, &endptr, 0);
+			params->gid_offset = strtoul(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid gid offset %s", optarg);
 				return -EINVAL;
-- 
2.43.5


