Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 378346C02A0
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Mar 2023 16:14:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PfhHP1Kndz3cCL
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 02:14:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PfhHG2d8nz2ynB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 02:14:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Ve8fPHp_1679238858;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ve8fPHp_1679238858)
          by smtp.aliyun-inc.com;
          Sun, 19 Mar 2023 23:14:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: fix up nlink for d_type unsupported fses
Date: Sun, 19 Mar 2023 23:14:17 +0800
Message-Id: <20230319151417.20432-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230317085045.16263-2-hsiangkao@linux.alibaba.com>
References: <20230317085045.16263-2-hsiangkao@linux.alibaba.com>
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
changes since v1:
 - should bump nlink for "." and ".." as well.

 lib/inode.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0f49f6e..7167f19 100644
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
@@ -214,28 +214,16 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
 	free(sorted_d);
 
-	/* let's calculate dir size and update i_nlink */
+	/* let's calculate dir size */
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
@@ -1124,13 +1108,16 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
 
+	i_nlink = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		char buf[PATH_MAX];
 		unsigned char ftype;
 		struct erofs_inode *inode;
 
-		if (is_dot_dotdot(d->name))
+		if (is_dot_dotdot(d->name)) {
+			++i_nlink;
 			continue;
+		}
 
 		ret = snprintf(buf, PATH_MAX, "%s/%s",
 			       dir->i_srcpath, d->name);
@@ -1159,12 +1146,21 @@ fail:
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

