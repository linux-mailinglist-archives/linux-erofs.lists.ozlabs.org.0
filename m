Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C8905867
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 18:18:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UB7TJZYK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzrMK5n8Pz3dK1
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 02:18:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UB7TJZYK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzrM640SDz3d3Q
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 02:18:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718209115; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KfSv4c0xrCIqNMrV0wF+BFyR0swrK/FAsRYao5AXy48=;
	b=UB7TJZYK+A9a9rYf75m1YIKkchyQ7HQHBLY3wSwV3GA3cd+iZXnooRwV9MhAWBnFB3kqTabf1eedkEW22LRKd6I+Vn+Vskql9nlVsQqbMzhv5D1C6INZn4Im2tLIQyd6fH+k650Ctua88CGoeaIYlUtnY8CUYRGz6GpayHmPaZ4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8LOtR0_1718209107;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8LOtR0_1718209107)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 00:18:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs-utils: lib: get rid of erofs_prepare_dir_layout()
Date: Thu, 13 Jun 2024 00:18:22 +0800
Message-Id: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just open-code the previous erofs_prepare_dir_file() and rename
`erofs_prepare_dir_layout()` to `erofs_prepare_dir_file()`.

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 70 ++++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7d4ccc4..09bf76b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -208,8 +208,30 @@ static int comp_subdir(const void *a, const void *b)
 	return strcmp(da->name, db->name);
 }
 
-static int erofs_prepare_dir_layout(struct erofs_inode *dir,
-				    unsigned int nr_subdirs)
+int erofs_init_empty_dir(struct erofs_inode *dir)
+{
+	struct erofs_dentry *d;
+
+	/* dot is pointed to the current dir inode */
+	d = erofs_d_alloc(dir, ".");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	d->inode = erofs_igrab(dir);
+	d->type = EROFS_FT_DIR;
+
+	/* dotdot is pointed to the parent dir */
+	d = erofs_d_alloc(dir, "..");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	d->inode = erofs_igrab(erofs_parent_inode(dir));
+	d->type = EROFS_FT_DIR;
+
+	dir->i_nlink = 2;
+	return 0;
+}
+
+static int erofs_prepare_dir_file(struct erofs_inode *dir,
+				  unsigned int nr_subdirs)
 {
 	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d, *n, **sorted_d;
@@ -248,41 +270,6 @@ static int erofs_prepare_dir_layout(struct erofs_inode *dir,
 	return 0;
 }
 
-int erofs_init_empty_dir(struct erofs_inode *dir)
-{
-	struct erofs_dentry *d;
-
-	/* dot is pointed to the current dir inode */
-	d = erofs_d_alloc(dir, ".");
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	d->inode = erofs_igrab(dir);
-	d->type = EROFS_FT_DIR;
-
-	/* dotdot is pointed to the parent dir */
-	d = erofs_d_alloc(dir, "..");
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	d->inode = erofs_igrab(erofs_parent_inode(dir));
-	d->type = EROFS_FT_DIR;
-
-	dir->i_nlink = 2;
-	return 0;
-}
-
-int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
-{
-	int ret;
-
-	ret = erofs_init_empty_dir(dir);
-	if (ret)
-		return ret;
-
-	/* sort subdirs */
-	nr_subdirs += 2;
-	return erofs_prepare_dir_layout(dir, nr_subdirs);
-}
-
 static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 			  struct erofs_dentry *head, struct erofs_dentry *end)
 {
@@ -1358,7 +1345,11 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 	}
 	closedir(_dir);
 
-	ret = erofs_prepare_dir_file(dir, nr_subdirs);
+	ret = erofs_init_empty_dir(dir);
+	if (ret)
+		return ret;
+
+	ret = erofs_prepare_dir_file(dir, nr_subdirs + 2); /* sort subdirs */
 	if (ret)
 		return ret;
 
@@ -1399,7 +1390,8 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 		++nr_subdirs;
 	}
 
-	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
+	DBG_BUGON(nr_subdirs < i_nlink);
+	ret = erofs_prepare_dir_file(dir, nr_subdirs);
 	if (ret)
 		return ret;
 
-- 
2.39.3

