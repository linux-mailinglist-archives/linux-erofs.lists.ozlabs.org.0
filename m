Return-Path: <linux-erofs+bounces-731-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D81BB16ABF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 05:17:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvQ050mWz2yLB;
	Thu, 31 Jul 2025 13:16:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753931816;
	cv=none; b=Mv2VmLnZlNOxTHX/xeKKaPr/RE41hMrOjzbhQnTMG8r8yP8OwO2yjORshnV/2UDLZD+PZQYiThe+b0QtyToGJEPkm0oetMXb2x0q4I0s7YCB9W4SWvRfrZEKVr/KpjcAl496ySEJkkt5cL/UFC9LE5iQO8Bh9fgT9LprUqwTFgyp77nIFBv7zEOHca1PgH8rYJ4MTgJ9VFoUmnmHD+Q/QBe1jw7YbCD+QNMKpmzB0TBoaAJ2u84SyrjANNoAOFP1YPA2Z4ztiDWFOqZ81hqJbcKt5FkN4P0fht4+sxuqnKAMSRyghuEVQwAP5CbyYTC67E4S2c9s/Hn7DD+9RhZxig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753931816; c=relaxed/relaxed;
	bh=M8JBkmnDA9Pji9iiftTSD8jZ8cmtP+RgVvH74YS83ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1QmOkkLLLD+CC3+O+VGLaChl59TXCM4rDq5Sb+pZMTcYWv/1hoEA+fwVftrEbrcut2fzyzoI4lXmtfxuIw0lSlbd5uTzXg0iVfNywaGWKMpClPnMdkEizY/yA9o8KjlUUFJUasR6cS97jMoTgC+nlc7pQBOrfEArwiEwKa5qPcJjcd9i58lIt9MHerID+tiY/rHGPAQDvVAo24BI1NDlZc0bPAeVkp7RC6ljTxjRuDfWOKqHBC3juDRTLsfoIP52KQ47ADfI7GSAoA1AKLd9K1vBGiEvLKin93zA0pE8tgHtXXPTa3IbReRMbveOfqSLt5qNkNpJvWUwbxY3V4PoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rTbHMv8t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rTbHMv8t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvPy5kYqz2yKw
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 13:16:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753931809; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M8JBkmnDA9Pji9iiftTSD8jZ8cmtP+RgVvH74YS83ME=;
	b=rTbHMv8tHpdeKarkfAnGvd7kccpX+RAZrOCWAl0ciYuCuthYq16RsTY4NmO0mpLQZGi5aydHrzkP2+0lWPaf7yLW8so++mc7KcREbo/oomzxZib15ch2t+MMuURx7lz7DO49Gj2R3Fp0GT7HWS1TFfDk/G12VqYWjAX4od8Y+X0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWixDS_1753931803 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 11:16:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: lib: get rid of erofs_init_empty_dir()
Date: Thu, 31 Jul 2025 11:16:40 +0800
Message-ID: <20250731031642.2139859-1-hsiangkao@linux.alibaba.com>
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

... and defer insertion of `.` and `..` entries when preparing
directory inodes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  1 -
 lib/inode.c           | 52 +++++++++++++++++++++----------------------
 lib/rebuild.c         |  4 ++--
 lib/tar.c             |  4 +---
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index fe86101d..b0ac5bee 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -37,7 +37,6 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks);
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
 int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool incremental);
-int erofs_init_empty_dir(struct erofs_inode *dir);
 int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		       const char *path);
 struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
diff --git a/lib/inode.c b/lib/inode.c
index 4f6715af..cbce712b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -226,9 +226,14 @@ static int comp_subdir(const void *a, const void *b)
 	return cmpsgn(da->namelen, db->namelen);
 }
 
-int erofs_init_empty_dir(struct erofs_inode *dir)
+static int erofs_prepare_dir_file(struct erofs_inode *dir,
+				  unsigned int nr_subdirs)
 {
-	struct erofs_dentry *d;
+	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_dentry *d, *n, **sorted_d;
+	bool dot_omitted = cfg.c_dot_omitted;
+	unsigned int i;
+	unsigned int d_size = 0;
 
 	/* dot is pointed to the current dir inode */
 	d = erofs_d_alloc(dir, ".");
@@ -244,18 +249,7 @@ int erofs_init_empty_dir(struct erofs_inode *dir)
 	d->inode = erofs_igrab(erofs_parent_inode(dir));
 	d->type = EROFS_FT_DIR;
 
-	dir->i_nlink = 2;
-	return 0;
-}
-
-static int erofs_prepare_dir_file(struct erofs_inode *dir,
-				  unsigned int nr_subdirs)
-{
-	struct erofs_sb_info *sbi = dir->sbi;
-	struct erofs_dentry *d, *n, **sorted_d;
-	bool dot_omitted = cfg.c_dot_omitted;
-	unsigned int i;
-	unsigned int d_size = 0;
+	nr_subdirs += 2;
 
 	sorted_d = malloc(nr_subdirs * sizeof(d));
 	if (!sorted_d)
@@ -1564,11 +1558,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 	}
 	closedir(_dir);
 
-	ret = erofs_init_empty_dir(dir);
-	if (ret)
-		return ret;
-
-	ret = erofs_prepare_dir_file(dir, nr_subdirs + 2); /* sort subdirs */
+	ret = erofs_prepare_dir_file(dir, nr_subdirs); /* sort subdirs */
 	if (ret)
 		return ret;
 
@@ -1615,6 +1605,13 @@ bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d)
 	return false;
 }
 
+static void erofs_dentry_kill(struct erofs_dentry *d)
+{
+	list_del(&d->d_child);
+	erofs_d_invalidate(d);
+	free(d);
+}
+
 static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 					  bool incremental)
 {
@@ -1625,22 +1622,23 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 	int ret;
 
 	nr_subdirs = 0;
-	i_nlink = 0;
+	i_nlink = 2;
 
 	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (is_dot_dotdot(d->name)) {
+			DBG_BUGON(1);
+			erofs_dentry_kill(d);
+			continue;
+		}
 		if (delwht && erofs_dentry_is_wht(sbi, d)) {
 			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
-			list_del(&d->d_child);
-			erofs_d_invalidate(d);
-			free(d);
+			erofs_dentry_kill(d);
 			continue;
 		}
 		i_nlink += (d->type == EROFS_FT_DIR);
 		++nr_subdirs;
 	}
-
-	DBG_BUGON(i_nlink < 2);		/* should have `.` and `..` */
-	DBG_BUGON(nr_subdirs < i_nlink);
+	DBG_BUGON(nr_subdirs + 2 < i_nlink);
 	ret = erofs_prepare_dir_file(dir, nr_subdirs);
 	if (ret)
 		return ret;
@@ -2134,6 +2132,6 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 	root->i_parent = root;
 	root->i_mtime = root->sbi->epoch + root->sbi->build_time;
 	root->i_mtime_nsec = root->sbi->fixed_nsec;
-	erofs_init_empty_dir(root);
+	root->i_nlink = 2;
 	return root;
 }
diff --git a/lib/rebuild.c b/lib/rebuild.c
index c580f81f..26bc9aca 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -59,7 +59,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	inode->i_mtime = dir->i_mtime;
 	inode->i_mtime_nsec = dir->i_mtime_nsec;
 	inode->dev = dir->dev;
-	erofs_init_empty_dir(inode);
+	inode->i_nlink = 2;
 
 	d = erofs_d_alloc(dir, s);
 	if (IS_ERR(d)) {
@@ -241,7 +241,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 		inode->u.i_rdev = erofs_new_encode_dev(inode->u.i_rdev);
 		break;
 	case S_IFDIR:
-		err = erofs_init_empty_dir(inode);
+		inode->i_nlink = 2;
 		break;
 	case S_IFLNK:
 		inode->i_link = malloc(inode->i_size + 1);
diff --git a/lib/tar.c b/lib/tar.c
index 72c12ed0..3146fc9d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1122,9 +1122,7 @@ new_inode:
 		}
 		inode->i_nlink++;
 	} else if (!inode->i_nlink) {
-		ret = erofs_init_empty_dir(inode);
-		if (ret)
-			goto out;
+		inode->i_nlink = 2;
 	}
 
 	ret = tarerofs_merge_xattrs(&eh.xattrs, &tar->global.xattrs);
-- 
2.43.5


