Return-Path: <linux-erofs+bounces-1097-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D040EB9DE37
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 09:44:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXQhr13Brz2yrP;
	Thu, 25 Sep 2025 17:44:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758786268;
	cv=none; b=aLXJw51mL0dwULSZr9SDZHGETmyluLv/tYEgpZZvili/e5uLipRo9xosFVOYK/BZq9BF0Ci6yerVnpzSgta7S7RLcLcCVhKJBRhfBGjWpbqhGxsAAjtYHBv/zsCiVPm8ZIZySAIpOYMpw8sSa8D0QieybkpwTzKOprcSV8lq8gBagO2aCocI0fapeh4be4vNkMa91YzN4KhLIIwb5hsBakcvIDSzztbg/9WfKwyH8j00MPDG5OmSJNfmbT5viZIBtdBcsA2ixHhrTkIfdd906KSF5T5GYDp3HKJIXiltTmXBcCOKvduqthOnMcdAz9HPkwQnuFMloYzu6z2xmlFB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758786268; c=relaxed/relaxed;
	bh=3bmHHJYgocKZC7ZpPDNAui6UCXzeC+8khsLG5CyBgGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4VZMoAezdNDRIfKgNvJK35XQ6S55JwnG/PKzzeHK76TJJ5WxutPSpyjyM0E+piioQFWHqc0/Q+EOkp4tnqvrii3YdUON9d2u3pL9ihUTDt1OhBKnyLbqvc4D96dHIckOJ1HzaIfUUtu5JerT1mIK8mhq9K/pS2dAYBGFULl1WJF/LwXuxS5rtjx9W/zIjHyF7yZehhTNWsTqMyrwrdRItw4mt6iqgbwj8HNOe8ETie40Z/5KsFQnfcQT8T0seloFPdn5DldO+ZMtdIWmmaAfvsG/nbAbBsmTHuhJ9EjmjGh5t+1WBGIuUpxkKgGH4R2IF9wH5i0xxSPNNPPlOpWFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oU6F5Xmt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oU6F5Xmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXQhp24Ckz2yrm
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 17:44:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758786261; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3bmHHJYgocKZC7ZpPDNAui6UCXzeC+8khsLG5CyBgGI=;
	b=oU6F5Xmt2+09Eel5uZOXoYe9bKPEr/zZGQ9xCqgL7Z7qkz3yoCrORnLcpSNU7/zzArn1JME7Z5BQcmNXluTreUAlN8yrsuQd2LVqP3SyqKXrUqrX2Hi4kzFufx4VN+wVxtaE5k4KKm4QSYCZwjSF5Ol38MD5uuXqa4s415oKF2c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WomxJEU_1758786259 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:44:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: combine erofs_{mkfs,rebuild}_handle_inode
Date: Thu, 25 Sep 2025 15:44:12 +0800
Message-ID: <20250925074412.1390263-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250925074412.1390263-1-hsiangkao@linux.alibaba.com>
References: <20250925074412.1390263-1-hsiangkao@linux.alibaba.com>
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
 lib/inode.c | 107 +++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 65 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 2918791..6148b86 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1323,6 +1323,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 		erofs_iput(inode);
 		return ERR_PTR(ret);
 	}
+	inode->datasource = EROFS_INODE_DATA_SOURCE_LOCALPATH;
 	return inode;
 }
 
@@ -1773,58 +1774,48 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im,
 	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 }
 
-static int erofs_mkfs_handle_inode(struct erofs_importer *im,
-				   struct erofs_inode *inode)
+static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
+					 struct erofs_inode *inode)
 {
-	const char *relpath = erofs_fspath(inode->i_srcpath);
-	char *trimmed;
-	int ret;
-
-	trimmed = erofs_trim_for_progressinfo(relpath[0] ? relpath : "/",
-					      sizeof("Processing  ...") - 1);
-	erofs_update_progressinfo("Processing %s ...", trimmed);
-	free(trimmed);
-
-	ret = erofs_scan_file_xattrs(inode);
-	if (ret < 0)
-		return ret;
+	struct erofs_mkfs_job_ndir_ctx ctx =
+		{ .inode = inode, .fd = -1 };
 
-	ret = erofs_prepare_xattr_ibody(inode, false);
-	if (ret < 0)
-		return ret;
-
-	if (!S_ISDIR(inode->i_mode)) {
-		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode, .fd = -1 };
-
-		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
+	if (S_ISREG(inode->i_mode) && inode->i_size) {
+		switch (inode->datasource) {
+		case EROFS_INODE_DATA_SOURCE_DISKBUF:
+			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
+			if (ctx.fd < 0)
+				return ctx.fd;
+			break;
+		case EROFS_INODE_DATA_SOURCE_LOCALPATH:
 			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 			if (ctx.fd < 0)
 				return -errno;
-
-			if (cfg.c_compr_opts[0].alg &&
-			    erofs_file_is_compressible(im, inode)) {
-				ctx.ictx = erofs_begin_compressed_file(im,
-							inode, ctx.fd, 0);
-				if (IS_ERR(ctx.ictx))
-					return PTR_ERR(ctx.ictx);
-			}
+			__erofs_fallthrough;
+		default:
+			break;
+		}
+		if (cfg.c_compr_opts[0].alg &&
+		    erofs_file_is_compressible(im, inode)) {
+			ctx.ictx = erofs_begin_compressed_file(im, inode,
+							ctx.fd, ctx.fpos);
+			if (IS_ERR(ctx.ictx))
+				return PTR_ERR(ctx.ictx);
 		}
-		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
-	} else {
-		ret = erofs_mkfs_handle_directory(im, inode, false, false);
 	}
-	erofs_info("file /%s dumped (mode %05o)", relpath, inode->i_mode);
-	return ret;
+	return erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 }
 
-static int erofs_rebuild_handle_inode(struct erofs_importer *im,
-				    struct erofs_inode *inode, bool incremental)
+static int erofs_mkfs_handle_inode(struct erofs_importer *im,
+				   struct erofs_inode *inode,
+				   bool rebuild, bool incremental)
 {
+	const char *relpath = erofs_fspath(inode->i_srcpath);
 	const struct erofs_importer_params *params = im->params;
 	char *trimmed;
 	int ret;
 
-	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+	trimmed = erofs_trim_for_progressinfo(*relpath ? relpath : "/",
 					      sizeof("Processing  ...") - 1);
 	erofs_update_progressinfo("Processing %s ...", trimmed);
 	free(trimmed);
@@ -1847,6 +1838,12 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 			return ret;
 	}
 
+	if (!rebuild) {
+		ret = erofs_scan_file_xattrs(inode);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
 	if (params->ovlfs_strip)
 		erofs_clear_opaque_xattr(inode);
@@ -1858,28 +1855,12 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode)) {
-		struct erofs_mkfs_job_ndir_ctx ctx =
-			{ .inode = inode, .fd = -1 };
-
-		if (S_ISREG(inode->i_mode) && inode->i_size &&
-		    inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
-			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
-			if (ctx.fd < 0)
-				return ret;
-
-			if (cfg.c_compr_opts[0].alg &&
-			    erofs_file_is_compressible(im, inode)) {
-				ctx.ictx = erofs_begin_compressed_file(im, inode,
-							ctx.fd, ctx.fpos);
-				if (IS_ERR(ctx.ictx))
-					return PTR_ERR(ctx.ictx);
-			}
-		}
-		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
+		ret = erofs_mkfs_begin_nondirectory(im, inode);
 	} else {
-		ret = erofs_mkfs_handle_directory(im, inode, true, incremental);
+		ret = erofs_mkfs_handle_directory(im, inode,
+						  rebuild, incremental);
 	}
-	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
+	erofs_info("file %s dumped (mode %05o)", *relpath ? relpath : "/",
 		   inode->i_mode);
 	return ret;
 }
@@ -1921,8 +1902,7 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		root->xattr_isize = cfg.c_root_xattr_isize;
 	}
 
-	err = !rebuild ? erofs_mkfs_handle_inode(im, root) :
-			erofs_rebuild_handle_inode(im, root, incremental);
+	err = erofs_mkfs_handle_inode(im, root, rebuild, incremental);
 	if (err)
 		return err;
 
@@ -1952,11 +1932,8 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 					  erofs_parent_inode(inode) != dir);
 				erofs_mark_parent_inode(inode, dir);
 
-				if (!rebuild)
-					err = erofs_mkfs_handle_inode(im, inode);
-				else
-					err = erofs_rebuild_handle_inode(im,
-							inode, incremental);
+				err = erofs_mkfs_handle_inode(im, inode,
+							rebuild, incremental);
 				if (err)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
-- 
2.43.5


