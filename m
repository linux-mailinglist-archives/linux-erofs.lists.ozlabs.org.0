Return-Path: <linux-erofs+bounces-1096-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF4B9DE34
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 09:44:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXQhq72Wqz2ytg;
	Thu, 25 Sep 2025 17:44:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758786267;
	cv=none; b=WQ345bPyljdyAFtg59yFfb5zR3geXJSlwCdn4GkvzDWuNY2vPZP2h6CH4dFChmgTd4vbWwNcDz8YuPe/Ncng01h5t9u4CCjk6Wg9nE9k7/NWFO6xhOLV/S4SksD/9MAyrjkXBTqRVvzkbFRxTtvjlhZ+spOUxbhLHHR/dHiq/ntdzExgN12V8O2T0aNBC4J8kBme0foVe+3Bm/ndv3rBCBTzzg2ujMiDfUM68mWhoAwJAXqbPCHi1HltixAoc/sBClG2DYCfJFt6AefeWyq2wB6wwKj+CVPFSPCnqE+TEGsg5VFvhikSfRlHMgj73fJX7DOCabhsGBDhATOLNhg5og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758786267; c=relaxed/relaxed;
	bh=cC/fOBSSxjwtVXZUTyxKADjIkapUKcOqFunhkL11laQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ui+JEeSylb/CUVj7vWKxwXd4L+EXSmgMWoVfvidvuDwZQmHVp3NwiKfw+eYo6CBP+mbC7+xNKnud8IitgHjbptqrakMs0HpvLlo3minzZJXXk+f4/ednI5pQ979ryDbeXPDSl+iPy22v4E38/6sEEk0AvX1+M0/M1yfOLxUJ8GkrXdIYe9gucraz8YNroVpWFc9y9+jLYx2j4z9z+HNUYFPXLZAGXXmfjd7RE4RzcvHOkbfpHhw5A9V3EiOyA/PN5g/O7pxgZU0tlkdcDecp+T1b0IU+KXqf6FgQlZ0zScnNv8DyuhEn6UyMcTtkF/dNSomvpW3ExqolKBBDY/q4Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b85z3fns; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b85z3fns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXQhp0pJGz2yrP
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 17:44:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758786261; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cC/fOBSSxjwtVXZUTyxKADjIkapUKcOqFunhkL11laQ=;
	b=b85z3fnsb+6mcmdhkyuSutA9ZnxDXO9q2iv6L0/qRcPbnV2tQ5gHudWyvFYUkV+LkP0N1nf4cyMgI3BDDS8ftlox+AmH5NvIKGlo331V+UXP28hizoDz4rJNAtVMqYnPuBqwa0WQmwYWuhYAni54J1D6yRW6gxvCvPloBUuOFAk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WomxJBb_1758786254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:44:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: mkfs: combine erofs_{mkfs,rebuild}_handle_directory
Date: Thu, 25 Sep 2025 15:44:11 +0800
Message-ID: <20250925074412.1390263-1-hsiangkao@linux.alibaba.com>
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

 - Remove redundant logic;

 - In preparation for incremental builds on local paths.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 91 ++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index e57a0db..2918791 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1608,26 +1608,29 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 }
 #endif
 
-static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_inode *dir)
+static int erofs_mkfs_import_localdir(struct erofs_importer *im, struct erofs_inode *dir,
+				      u64 *nr_subdirs, unsigned int *i_nlink)
 {
+	unsigned int __nlink;
+	u64 __nr_subdirs;
 	DIR *_dir;
-	struct dirent *dp;
-	struct erofs_dentry *d;
-	unsigned int nr_subdirs, i_nlink;
 	int ret;
 
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
+		ret = -errno;
 		erofs_err("failed to opendir at %s: %s",
-			  dir->i_srcpath, erofs_strerror(-errno));
-		return -errno;
+			  dir->i_srcpath, erofs_strerror(ret));
+		return ret;
 	}
 
-	nr_subdirs = 0;
-	i_nlink = 0;
+	__nr_subdirs = *nr_subdirs;
+	__nlink = *i_nlink;
 	while (1) {
-		char buf[PATH_MAX];
 		struct erofs_inode *inode;
+		struct erofs_dentry *d;
+		char buf[PATH_MAX];
+		struct dirent *dp;
 
 		/*
 		 * set errno to 0 before calling readdir() in order to
@@ -1636,16 +1639,14 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_i
 		errno = 0;
 		dp = readdir(_dir);
 		if (!dp) {
-			if (!errno)
-				break;
 			ret = -errno;
+			if (!ret)
+				break;
 			goto err_closedir;
 		}
 
-		if (is_dot_dotdot(dp->d_name)) {
-			++i_nlink;
+		if (is_dot_dotdot(dp->d_name))
 			continue;
-		}
 
 		/* skip if it's a exclude file */
 		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
@@ -1668,32 +1669,15 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im, struct erofs_i
 		}
 		d->inode = inode;
 		d->type = erofs_mode_to_ftype(inode->i_mode);
-		i_nlink += S_ISDIR(inode->i_mode);
+		__nlink += S_ISDIR(inode->i_mode);
 		erofs_dbg("file %s added (type %u)", buf, d->type);
-		nr_subdirs++;
+		__nr_subdirs++;
 	}
 	closedir(_dir);
 
-	ret = erofs_prepare_dir_file(im, dir, nr_subdirs); /* sort subdirs */
-	if (ret)
-		return ret;
-
-	/*
-	 * if there're too many subdirs as compact form, set nlink=1
-	 * rather than upgrade to use extented form instead if possible.
-	 */
-	if (i_nlink > USHRT_MAX &&
-	    dir->inode_isize == sizeof(struct erofs_inode_compact)) {
-		if (dir->dot_omitted)
-			dir->inode_isize = sizeof(struct erofs_inode_extended);
-		else
-			dir->i_nlink = 1;
-	} else {
-		dir->i_nlink = i_nlink;
-	}
-
-	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
-
+	*nr_subdirs = __nr_subdirs;
+	*i_nlink = __nlink;
+	return 0;
 err_closedir:
 	closedir(_dir);
 	return ret;
@@ -1728,13 +1712,15 @@ static void erofs_dentry_kill(struct erofs_dentry *d)
 	free(d);
 }
 
-static int erofs_rebuild_handle_directory(struct erofs_importer *im,
-					  struct erofs_inode *dir,
-					  bool incremental)
+static int erofs_mkfs_handle_directory(struct erofs_importer *im,
+				       struct erofs_inode *dir,
+				       bool rebuild,
+				       bool incremental)
 {
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_dentry *d, *n;
-	unsigned int nr_subdirs, i_nlink;
+	unsigned int i_nlink;
+	u64 nr_subdirs;
 	bool delwht = im->params->ovlfs_strip && dir->whiteouts;
 	int ret;
 
@@ -1755,6 +1741,14 @@ static int erofs_rebuild_handle_directory(struct erofs_importer *im,
 		i_nlink += (d->type == EROFS_FT_DIR);
 		++nr_subdirs;
 	}
+
+	if (!rebuild) {
+		ret = erofs_mkfs_import_localdir(im, dir,
+						 &nr_subdirs, &i_nlink);
+		if (ret)
+			return ret;
+	}
+
 	DBG_BUGON(nr_subdirs + 2 < i_nlink);
 	ret = erofs_prepare_dir_file(im, dir, nr_subdirs);
 	if (ret)
@@ -1763,15 +1757,18 @@ static int erofs_rebuild_handle_directory(struct erofs_importer *im,
 	if (IS_ROOT(dir) && incremental)
 		dir->datalayout = EROFS_INODE_FLAT_PLAIN;
 
+	dir->i_nlink = i_nlink;
 	/*
 	 * if there're too many subdirs as compact form, set nlink=1
-	 * rather than upgrade to use extented form instead.
+	 * rather than upgrade to use extented form instead if possible.
 	 */
 	if (i_nlink > USHRT_MAX &&
-	    dir->inode_isize == sizeof(struct erofs_inode_compact))
-		dir->i_nlink = 1;
-	else
-		dir->i_nlink = i_nlink;
+	    dir->inode_isize == sizeof(struct erofs_inode_compact)) {
+		if (dir->dot_omitted)
+			dir->inode_isize = sizeof(struct erofs_inode_extended);
+		else
+			dir->i_nlink = 1;
+	}
 
 	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 }
@@ -1814,7 +1811,7 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 		}
 		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 	} else {
-		ret = erofs_mkfs_handle_directory(im, inode);
+		ret = erofs_mkfs_handle_directory(im, inode, false, false);
 	}
 	erofs_info("file /%s dumped (mode %05o)", relpath, inode->i_mode);
 	return ret;
@@ -1880,7 +1877,7 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 		}
 		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 	} else {
-		ret = erofs_rebuild_handle_directory(im, inode, incremental);
+		ret = erofs_mkfs_handle_directory(im, inode, true, incremental);
 	}
 	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
 		   inode->i_mode);
-- 
2.43.5


