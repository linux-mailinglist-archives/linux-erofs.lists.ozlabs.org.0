Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD890C4E1
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:24:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PZuzVv/J;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KYh2Yq6z3cJl
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:24:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PZuzVv/J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYG6XQJz30VJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699068; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CciUQxoolnlB7Edb+kfDodmquYfXjDz8hy8rE0APuD4=;
	b=PZuzVv/JeWSlMr8ijmP6FCEPdZ6yNSDWask33OOSJxV7GaUArbLWVfb67WGRQiFQo2bn2dvnj/jJiOnLaUicJrQlUB/IGE74DBbbMVs+SEE/bPlXfTmyjQUvY2hlxbfON7z0Dg+DpVDl1VsTO+CRIk7Ymz1vHTNrzp4oLN8fdBM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcN47_1718699055;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcN47_1718699055)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 01/10] erofs-utils: simplify erofs_insert_ihash
Date: Tue, 18 Jun 2024 16:24:06 +0800
Message-Id: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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

Get rid of unnecessary arguments for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  2 +-
 lib/inode.c           | 16 +++++++---------
 lib/rebuild.c         |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 3bdc2b4..557150c 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -26,7 +26,7 @@ unsigned char erofs_mode_to_ftype(umode_t mode);
 umode_t erofs_ftype_to_mode(unsigned int ftype, unsigned int perm);
 unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
-void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t ino);
+void erofs_insert_ihash(struct erofs_inode *inode);
 struct erofs_inode *erofs_iget(dev_t dev, ino_t ino);
 struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid);
 unsigned int erofs_iput(struct erofs_inode *inode);
diff --git a/lib/inode.c b/lib/inode.c
index 1ec73fe..e27399d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -94,10 +94,11 @@ void erofs_inode_manager_init(void)
 		init_list_head(&inode_hashtable[i]);
 }
 
-void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t ino)
+void erofs_insert_ihash(struct erofs_inode *inode)
 {
-	list_add(&inode->i_hash,
-		 &inode_hashtable[(ino ^ dev) % NR_INODE_HASHTABLE]);
+	unsigned int nr = (inode->i_ino[1] ^ inode->dev) % NR_INODE_HASHTABLE;
+
+	list_add(&inode->i_hash, &inode_hashtable[nr]);
 }
 
 /* get the inode from the (source) inode # */
@@ -991,11 +992,6 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	if (!inode->i_srcpath)
 		return -ENOMEM;
 
-	if (!S_ISDIR(inode->i_mode)) {
-		inode->dev = st->st_dev;
-		inode->i_ino[1] = st->st_ino;
-	}
-
 	if (erofs_should_use_inode_extended(inode)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
@@ -1007,7 +1003,9 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		inode->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
-	erofs_insert_ihash(inode, st->st_dev, st->st_ino);
+	inode->dev = st->st_dev;
+	inode->i_ino[1] = st->st_ino;
+	erofs_insert_ihash(inode);
 	return 0;
 }
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 806d8b2..b9bced2 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -346,7 +346,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 				goto out;
 			}
 
-			erofs_insert_ihash(inode, inode->dev, inode->i_ino[1]);
+			erofs_insert_ihash(inode);
 			parent = dir = inode;
 		}
 
-- 
2.39.3

