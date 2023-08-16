Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CEB77D83B
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 04:14:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQWst64xxz3cSR
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 12:14:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQWsP64yfz3cNt
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 12:14:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VptkfNs_1692152036;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VptkfNs_1692152036)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 10:13:57 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 08/12] erofs-utils: lib: add erofs_insert_ihash() helper
Date: Wed, 16 Aug 2023 10:13:43 +0800
Message-Id: <20230816021347.126886-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
References: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add erofs_insert_ihash() helper inserting inode into inode hash table.

Also add prototypes of erofs_iget() and erofs_iget_by_nid() in the
header file.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
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
index d54f84f..b967aab 100644
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
2.19.1.6.gb485710b

