Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F66BE446
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 09:50:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PdHs13W5Jz3chg
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 19:50:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PdHrr6c4qz3cMh
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Mar 2023 19:50:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Ve2QCsX_1679043015;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ve2QCsX_1679043015)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 16:50:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lazy write directory data
Date: Fri, 17 Mar 2023 16:50:09 +0800
Message-Id: <20230317085009.15435-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230317085009.15435-1-hsiangkao@linux.alibaba.com>
References: <20230317085009.15435-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h | 11 ++++++-----
 lib/inode.c           |  9 +++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 1461305..d07a3cb 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -19,13 +19,14 @@ struct erofs_buffer_head;
 struct erofs_buffer_block;
 
 #define DATA		0
-#define META		1
+#define DIRA		1
+#define META		2
 /* including inline xattrs, extent */
-#define INODE		2
+#define INODE		3
 /* shared xattrs */
-#define XATTR		3
+#define XATTR		4
 /* device table */
-#define DEVT		4
+#define DEVT		5
 
 struct erofs_bhops {
 	bool (*preflush)(struct erofs_buffer_head *bh);
@@ -54,7 +55,7 @@ struct erofs_buffer_block {
 
 static inline const int get_alignsize(int type, int *type_ret)
 {
-	if (type == DATA)
+	if (type == DATA || type == DIRA)
 		return erofs_blksiz();
 
 	if (type == INODE) {
diff --git a/lib/inode.c b/lib/inode.c
index ff17295..6fb8ecb 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -142,7 +142,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 
 /* allocate main data for a inode */
 static int __allocate_inode_bh_data(struct erofs_inode *inode,
-				    unsigned long nblocks)
+				    unsigned long nblocks,
+				    int type)
 {
 	struct erofs_buffer_head *bh;
 	int ret;
@@ -305,7 +306,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	q = used = blkno = 0;
 
 	/* allocate dir main data */
-	ret = __allocate_inode_bh_data(dir, erofs_blknr(dir->i_size));
+	ret = __allocate_inode_bh_data(dir, erofs_blknr(dir->i_size), DIRA);
 	if (ret)
 		return ret;
 
@@ -353,7 +354,7 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
-	ret = __allocate_inode_bh_data(inode, nblocks);
+	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
 	if (ret)
 		return ret;
 
@@ -386,7 +387,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / erofs_blksiz();
 
-	ret = __allocate_inode_bh_data(inode, nblocks);
+	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
 	if (ret)
 		return ret;
 
-- 
2.24.4

