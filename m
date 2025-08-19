Return-Path: <linux-erofs+bounces-838-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E03B2B787
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 05:28:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Zmg4tsMz3cll;
	Tue, 19 Aug 2025 13:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755574115;
	cv=none; b=Gd53LOMNYOpmWLWcnZTQRdnNEV2TUABm41kFogq/61ivU9i7TRd8SeHDd5jXbhdtXuNtBj3vkeEPiqOa8s1SppEeoccHesm8O/eNwRca+uJivVYeFYMydXpj6R16E4Xcob4j3CgJsz2uxoUVKhP+YYGLrU2rnmh+TwaDXXNIM/vVzKuKcCJv0oKW9yldtYYAodU9FyUjVCpJ74WPVPClxcfDlNdicP+aRDMzdqUKHL/lPr+hGNnSLjZEiqSYmVwIMZO5tISSoMwt89ZJd+tdvpmM65xLJSHWm3omtKW8jNrY3uRe/ap9/AkBOtmwsyuIB6x3MgL4XeB1fpoSGu5/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755574115; c=relaxed/relaxed;
	bh=c/GFuV0a3Hfvmixp791zluQWCWxx1eMqSwT1vb4whkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQl9MwR4sLgUlzT/q7Rd/iBqHUD+QSN3bsTUe1QHNuzSLIFF+N0vwFAONY3CWyoRM7CJB6GrBP6u+ON7cZx3YJtfbeQiJaA1y71GQUiBGjgerfoV7iEphDaenA/4gbUAW/F5RJ5KC6Gpx0xHjmLxaNkaDhZlOxRADWj+W5/VQ+lIY/Q4fPrkm3H6RQdgWbbTMJmvqlk+BKXcDIKE56kocXghw80J8HWn3Hozny44FoYPRKle14RmeetZ5xwjf/iqmerNP/l73xP4Zz8Ocwol646Orma4T9qkak/sGNLBd7DSzB1dAyaFpPvIOJ2HS2QGt0Ms+t6Mf3/Tq4cU15/sSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IYbUqzla; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IYbUqzla;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Zmd5P4mz3clR
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 13:28:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755574109; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c/GFuV0a3Hfvmixp791zluQWCWxx1eMqSwT1vb4whkM=;
	b=IYbUqzlaKk82mIPaXxQZcVamL5861tzdnGsbD8l+2syxT3gB3wpl3gso6UaVFYt3plXkyfTI+9uENpJWEoqFuMAmdmi3+JQ9Pvwdi2fvZMwBQYgdgVW1i0X8G6dcHBP+G4I7gTNoOOu4qelS6tKJwcDJ3LxgcRIItOfBjCBrELo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm5DR7r_1755574108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:28:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 7/7] erofs-utils: lib: migrate `c_{ovlfs_strip,hard_dereference,dot_omitted}`
Date: Tue, 19 Aug 2025 11:28:18 +0800
Message-ID: <20250819032818.3598157-7-hsiangkao@linux.alibaba.com>
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
 include/erofs/config.h   |  3 ---
 include/erofs/importer.h |  3 +++
 lib/inode.c              | 23 ++++++++++++-----------
 mkfs/main.c              | 17 ++++++++---------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index f1593a5..0312909 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -63,9 +63,6 @@ struct erofs_configure {
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
-	bool c_ovlfs_strip;
-	bool c_hard_dereference;
-	bool c_dot_omitted;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 707da5e..e83c3e3 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -20,6 +20,9 @@ struct erofs_importer_params {
 	u32 uid_offset;
 	u32 gid_offset;
 	bool no_datainline;
+	bool hard_dereference;
+	bool ovlfs_strip;
+	bool dot_omitted;
 };
 
 struct erofs_importer {
diff --git a/lib/inode.c b/lib/inode.c
index fe056a6..302492c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -297,15 +297,15 @@ static void erofs_dentry_mergesort(struct list_head *entries, int k)
 		list_add_tail(great, entries);
 }
 
-static int erofs_prepare_dir_file(struct erofs_inode *dir,
-				  unsigned int nr_subdirs)
+static int erofs_prepare_dir_file(struct erofs_importer *im,
+			       struct erofs_inode *dir, unsigned int nr_subdirs)
 {
-	bool dot_omitted = cfg.c_dot_omitted;
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d;
 	unsigned int d_size = 0;
 
-	if (!dot_omitted) {
+	if (!params->dot_omitted) {
 		/* dot is pointed to the current dir inode */
 		d = erofs_d_alloc(dir, ".");
 		if (IS_ERR(d))
@@ -313,7 +313,7 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 		d->inode = erofs_igrab(dir);
 		d->type = EROFS_FT_DIR;
 	}
-	dir->dot_omitted = dot_omitted;
+	dir->dot_omitted = params->dot_omitted;
 
 	/* dotdot is pointed to the parent dir */
 	d = erofs_d_alloc(dir, "..");
@@ -324,7 +324,7 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 
 	if (nr_subdirs)
 		erofs_dentry_mergesort(&dir->i_subdirs, 0);
-	nr_subdirs += 1 + !dot_omitted;
+	nr_subdirs += 1 + !params->dot_omitted;
 
 	/* let's calculate dir size */
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
@@ -1297,7 +1297,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
 	 */
-	if (!S_ISDIR(st.st_mode) && (!cfg.c_hard_dereference)) {
+	if (!S_ISDIR(st.st_mode) && !im->params->hard_dereference) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
@@ -1664,7 +1664,7 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_i
 	}
 	closedir(_dir);
 
-	ret = erofs_prepare_dir_file(dir, nr_subdirs); /* sort subdirs */
+	ret = erofs_prepare_dir_file(im, dir, nr_subdirs); /* sort subdirs */
 	if (ret)
 		return ret;
 
@@ -1725,7 +1725,7 @@ static int erofs_rebuild_handle_directory(struct erofs_importer *im,
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs, i_nlink;
-	bool delwht = cfg.c_ovlfs_strip && dir->whiteouts;
+	bool delwht = im->params->ovlfs_strip && dir->whiteouts;
 	int ret;
 
 	nr_subdirs = 0;
@@ -1746,7 +1746,7 @@ static int erofs_rebuild_handle_directory(struct erofs_importer *im,
 		++nr_subdirs;
 	}
 	DBG_BUGON(nr_subdirs + 2 < i_nlink);
-	ret = erofs_prepare_dir_file(dir, nr_subdirs);
+	ret = erofs_prepare_dir_file(im, dir, nr_subdirs);
 	if (ret)
 		return ret;
 
@@ -1813,6 +1813,7 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 				    struct erofs_inode *inode, bool incremental)
 {
+	struct erofs_importer_params *params = im->params;
 	char *trimmed;
 	int ret;
 
@@ -1840,7 +1841,7 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 	}
 
 	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
-	if (cfg.c_ovlfs_strip)
+	if (params->ovlfs_strip)
 		erofs_clear_opaque_xattr(inode);
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
diff --git a/mkfs/main.c b/mkfs/main.c
index a2b905e..a11134e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -372,13 +372,15 @@ static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
 	return 0;
 }
 
+static bool mkfs_dot_omitted;
+
 static int erofs_mkfs_feat_set_dot_omitted(bool en, const char *val,
 					   unsigned int vallen)
 {
 	if (vallen)
 		return -EINVAL;
 
-	cfg.c_dot_omitted = en;
+	mkfs_dot_omitted = en;
 	return 0;
 }
 
@@ -1101,10 +1103,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			erofstar.aufs = true;
 			break;
 		case 516:
-			if (!optarg || !strcmp(optarg, "1"))
-				cfg.c_ovlfs_strip = true;
-			else
-				cfg.c_ovlfs_strip = false;
+			params->ovlfs_strip = !optarg || !strcmp(optarg, "1");
 			break;
 		case 517:
 			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
@@ -1185,7 +1184,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				erofstar.try_no_reorder = true;
 			break;
 		case 528:
-			cfg.c_hard_dereference = true;
+			params->hard_dereference = true;
 			break;
 		case 529:
 			dsunit = strtoul(optarg, &endptr, 0);
@@ -1525,9 +1524,6 @@ int main(int argc, char **argv)
 		g_sbi.epoch = mkfs_time;
 	}
 
-	if (cfg.c_dot_omitted)
-		erofs_sb_set_48bit(&g_sbi);
-
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
@@ -1546,6 +1542,9 @@ int main(int argc, char **argv)
 
 	importer_params.source = cfg.c_src_path;
 	importer_params.no_datainline = mkfs_no_datainline;
+	importer_params.dot_omitted = mkfs_dot_omitted;
+	if (importer_params.dot_omitted)
+		erofs_sb_set_48bit(&g_sbi);
 
 	err = erofs_importer_init(&importer);
 	if (err)
-- 
2.43.5


