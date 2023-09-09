Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C14799A01
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdp21YQjz3cHS
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rjdnh1pgsz3cJN
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:33:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqVQ_1694277185;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqVQ_1694277185)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:33:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 09/13] erofs-utils: lib: add erofs_insert_ihash() helper
Date: Sun, 10 Sep 2023 00:32:36 +0800
Message-Id: <20230909163240.42057-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Add erofs_insert_ihash() helper inserting inode into inode hash table.

Also add prototypes of erofs_iget() and erofs_iget_by_nid() in the
header file.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  3 +++
 lib/inode.c           | 10 +++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index e8a5670..1c602a8 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -25,6 +25,9 @@ u32 erofs_new_encode_dev(dev_t dev);
 unsigned char erofs_mode_to_ftype(umode_t mode);
 unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
+void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t ino);
+struct erofs_inode *erofs_iget(dev_t dev, ino_t ino);
+struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
diff --git a/lib/inode.c b/lib/inode.c
index c976be3..3191843 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -75,6 +75,12 @@ void erofs_inode_manager_init(void)
 		init_list_head(&inode_hashtable[i]);
 }
 
+void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t ino)
+{
+	list_add(&inode->i_hash,
+		 &inode_hashtable[(ino ^ dev) % NR_INODE_HASHTABLE]);
+}
+
 /* get the inode from the (source) inode # */
 struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 {
@@ -976,9 +982,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		inode->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
-	list_add(&inode->i_hash,
-		 &inode_hashtable[(st->st_ino ^ st->st_dev) %
-				  NR_INODE_HASHTABLE]);
+	erofs_insert_ihash(inode, st->st_dev, st->st_ino);
 	return 0;
 }
 
-- 
2.24.4

