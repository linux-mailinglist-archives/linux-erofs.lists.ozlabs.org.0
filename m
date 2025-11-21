Return-Path: <linux-erofs+bounces-1420-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6428C77C4F
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 08:58:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCSJ75kRpz2yD5;
	Fri, 21 Nov 2025 18:57:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763711879;
	cv=none; b=EKNMJoQumlL4JtrJz28LR+b453Z+ykL7zwXSEeAvHh1Ue+P/rH8H33CVGAIRg16zov054kJ2f241IuI9ztrUw1/dDXQFRv0LwpWjcofA4bT0U96AVKZDBnJiCZlZhhX3TmsiVrBh+Nlr3OvGyDeeH1K/D02E4WZfDtqtsmNt9c5eJGFpawCtNvHOewirzoLinQs9OpWFxc9+jHPKY/06ctMXOolP92brk3BE1XmlskPs6V1BNCSbSkb2gzRYJw1oacewfXqkEQj3gfmErDAeTk6w0y1mSmyEQlEr+zHnL08Dy6/hc60RhS0dGMnMqLv7JYqumYOymwJQU66+ccSXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763711879; c=relaxed/relaxed;
	bh=ZcOdTkejjAZ3vBBBtCufWKj8bfiLWB2nxXGHzIy7zL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUxBLhjs/L/XXqJ4FmPJ/tj+pk13KtzY1qbE8KxDLXCmVtqgdCe0G8my+b575TNGAbYEQuUh7yLXBetVm3F1svDpIOSb5C5VtYZ31SOTj1uZpO8Go//Cw0IKb6nugincGzbLyrMviFFZvJhl9GTCq60aMQkQU9FqOgCPiP0ixWdMVR2QKWCxE7WGDETwo2oUuJMygZCaQ6ULG2LL4/zRfm22rsJas3DGfOG+RZAtswvPPMz42QGCX4ol//Lyl9rE382jxKvyFhZM3dx91TCYgYzpZznNNONdUnWivb2c5IoEjQzzBf9vpvGo7zHjKMOB4i/9X/JCaCIOQ1Lihv+mGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LW5A+10u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LW5A+10u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCSJ45vcCz2y5T
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 18:57:55 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763711870; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZcOdTkejjAZ3vBBBtCufWKj8bfiLWB2nxXGHzIy7zL8=;
	b=LW5A+10uRP6rlaPmOxft73YD7/j8wfiii+JyUFlLo4BR2sMM/EiY5s6cF3vSI3nrqNfOw0sGvC5f3WdmlwzkhA2lPj7J5N9Umpyq2/2rG3Fz6WZj4XXxqx0/2oI2Hr9Ax+L5eOVftkcoYeFHGUijfaJmygiR9GFYHXJI4QRd39Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt-lqgF_1763711865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 15:57:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: add support to issue directory data separately
Date: Fri, 21 Nov 2025 15:57:44 +0800
Message-ID: <20251121075744.3773724-1-hsiangkao@linux.alibaba.com>
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

Especially since compressed directory data could be in the packing
inode, it would be better to compress them together.

It improves the overall compressed directory access performance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/importer.h |  2 ++
 lib/inode.c              | 68 ++++++++++++++++++++++++++++++++++++----
 mkfs/main.c              |  6 ++--
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index e1734b995ae8..a9d9c569d157 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -44,6 +44,8 @@ struct erofs_importer_params {
 	char force_inodeversion;
 	bool ignore_mtime;
 	bool no_datainline;
+	/* Issue directory data (except inline data) separately from regular inodes */
+	bool grouped_dirdata;
 	bool hard_dereference;
 	bool ovlfs_strip;
 	bool dot_omitted;
diff --git a/lib/inode.c b/lib/inode.c
index d993c8fd7428..1d08e39317c0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1494,6 +1494,7 @@ enum erofs_mkfs_jobtype {	/* ordered job types */
 
 struct erofs_mkfs_jobitem {
 	enum erofs_mkfs_jobtype type;
+	unsigned int _usize;
 	union {
 		struct erofs_inode *inode;
 		struct erofs_mkfs_job_ndir_ctx ndir;
@@ -1529,6 +1530,11 @@ static int erofs_mkfs_jobfn(struct erofs_importer *im,
 		if (inode->datalayout == EROFS_INODE_FLAT_INLINE)
 			inode->idata_size = inode->i_size & (bsz - 1);
 
+		/*
+		 * Directory on-disk inodes should be close to other inodes
+		 * in the parent directory since parent directories should
+		 * generally be prioritized.
+		 */
 		ret = erofs_prepare_inode_buffer(im, inode);
 		if (ret)
 			return ret;
@@ -1657,6 +1663,48 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 }
 #endif
 
+struct erofs_mkfs_pending_jobitem {
+	struct list_head list;
+	struct erofs_mkfs_jobitem item;
+};
+
+int erofs_mkfs_push_pending_job(struct list_head *pending,
+				enum erofs_mkfs_jobtype type,
+				void *elem, int size)
+{
+	struct erofs_mkfs_pending_jobitem *pji;
+
+	pji = malloc(sizeof(*pji));
+	if (!pji)
+		return -ENOMEM;
+
+	pji->item.type = type;
+	if (size)
+		memcpy(&pji->item.u, elem, size);
+	pji->item._usize = size;
+	list_add_tail(&pji->list, pending);
+	return 0;
+}
+
+int erofs_mkfs_flush_pending_jobs(struct erofs_importer *im,
+				  struct list_head *q)
+{
+	struct erofs_mkfs_pending_jobitem *pji, *n;
+	int err2, err;
+
+	err = 0;
+	list_for_each_entry_safe(pji, n, q, list) {
+		list_del(&pji->list);
+
+		err2 = erofs_mkfs_go(im, pji->item.type, &pji->item.u,
+				     pji->item._usize);
+		free(pji);
+		if (!err)
+			err = err2;
+	}
+	return err;
+}
+
 static int erofs_mkfs_import_localdir(struct erofs_importer *im, struct erofs_inode *dir,
 				      u64 *nr_subdirs, unsigned int *i_nlink)
 {
@@ -1943,6 +1991,8 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 	struct erofs_inode *root = im->root;
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
+	bool grouped_dirdata = im->params->grouped_dirdata;
+	LIST_HEAD(pending_dirs);
 	int err, err2;
 
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
@@ -2009,13 +2059,19 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		err2 = erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR_BH,
-				     &dir, sizeof(dir));
-		if (err || err2)
-			return err ? err : err2;
+		err2 = grouped_dirdata ?
+			erofs_mkfs_push_pending_job(&pending_dirs,
+				EROFS_MKFS_JOB_DIR_BH, &dir, sizeof(dir)) :
+			erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR_BH,
+				      &dir, sizeof(dir));
+		if (err || err2) {
+			if (!err)
+				err = err2;
+			break;
+		}
 	} while (dumpdir);
-
-	return err;
+	err2 = erofs_mkfs_flush_pending_jobs(im, &pending_dirs);
+	return err ? err : err2;
 }
 
 struct erofs_mkfs_buildtree_ctx {
diff --git a/mkfs/main.c b/mkfs/main.c
index 76bf84348364..9719aec7952e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1410,10 +1410,12 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			tarerofs_decoder = EROFS_IOS_DECODER_GZRAN;
 			break;
 		case 536:
-			if (!optarg || strcmp(optarg, "1"))
+			if (!optarg || strcmp(optarg, "1")) {
 				params->compress_dir = true;
-			else
+				params->grouped_dirdata = true;
+			} else {
 				params->compress_dir = false;
+			}
 			break;
 		case 537:
 			if (!optarg || strcmp(optarg, "1"))
-- 
2.43.5


