Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10C6BE447
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 09:50:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PdHs36cFnz3f3n
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 19:50:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PdHrs02KWz3cMk
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Mar 2023 19:50:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Ve2QCpG_1679043010;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ve2QCpG_1679043010)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 16:50:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fix up nlink for d_type unsupported fses
Date: Fri, 17 Mar 2023 16:50:08 +0800
Message-Id: <20230317085009.15435-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

i_mode should be used instead for some old random fs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0f49f6e..ff17295 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -182,7 +182,7 @@ static int comp_subdir(const void *a, const void *b)
 int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 {
 	struct erofs_dentry *d, *n, **sorted_d;
-	unsigned int d_size, i_nlink, i;
+	unsigned int d_size, i;
 
 	/* dot is pointed to the current dir inode */
 	d = erofs_d_alloc(dir, ".");
@@ -216,26 +216,14 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 
 	/* let's calculate dir size and update i_nlink */
 	d_size = 0;
-	i_nlink = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		int len = strlen(d->name) + sizeof(struct erofs_dirent);
 
 		if ((d_size & (erofs_blksiz() - 1)) + len > erofs_blksiz())
 			d_size = round_up(d_size, erofs_blksiz());
 		d_size += len;
-
-		i_nlink += (d->type == EROFS_FT_DIR);
 	}
 	dir->i_size = d_size;
-	/*
-	 * if there're too many subdirs as compact form, set nlink=1
-	 * rather than upgrade to use extented form instead.
-	 */
-	if (i_nlink > USHRT_MAX &&
-	    dir->inode_isize == sizeof(struct erofs_inode_compact))
-		dir->i_nlink = 1;
-	else
-		dir->i_nlink = i_nlink;
 
 	/* no compression for all dirs */
 	dir->datalayout = EROFS_INODE_FLAT_INLINE;
@@ -1039,7 +1027,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
-	unsigned int nr_subdirs;
+	unsigned int nr_subdirs, i_nlink;
 
 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
@@ -1100,10 +1088,6 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 			goto err_closedir;
 		}
 		nr_subdirs++;
-
-		/* to count i_nlink for directories */
-		d->type = (dp->d_type == DT_DIR ?
-			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
 	}
 
 	if (errno) {
@@ -1124,6 +1108,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
 
+	i_nlink = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		char buf[PATH_MAX];
 		unsigned char ftype;
@@ -1159,12 +1144,21 @@ fail:
 			++dir->subdirs_queued;
 		}
 		ftype = erofs_mode_to_ftype(inode->i_mode);
-		DBG_BUGON(ftype == EROFS_FT_DIR && d->type != ftype);
+		i_nlink += (ftype == EROFS_FT_DIR);
 		d->inode = inode;
 		d->type = ftype;
 		erofs_info("file %s/%s dumped (type %u)",
 			   dir->i_srcpath, d->name, d->type);
 	}
+	/*
+	 * if there're too many subdirs as compact form, set nlink=1
+	 * rather than upgrade to use extented form instead.
+	 */
+	if (i_nlink > USHRT_MAX &&
+	    dir->inode_isize == sizeof(struct erofs_inode_compact))
+		dir->i_nlink = 1;
+	else
+		dir->i_nlink = i_nlink;
 	return 0;
 
 err_closedir:
-- 
2.24.4

