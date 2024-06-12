Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413990586A
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 18:19:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoXjCkoV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzrMS2CHdz3dWr
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 02:19:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoXjCkoV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzrM63ppJz3cYB
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 02:18:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718209117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9c0akUlAdtO//MIf8awzoF5wNSzereAfdE4SXPaUvc4=;
	b=KoXjCkoViAt1GV8i0hkOuQEuGX4abimWZ6J5INyR79XR1KBrlz16agwuNtGoCzrIxmMFxACjSZuZXRgvFUcd4mI8sy6/TZfOdmLBh43+gBc16eb6CMM0aVY6AYA5sKm3DlMfLQ/+CfjjxjO9WQYSze+iMeCeOZHNdMnyvUdV0s8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8LOtUP_1718209116;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8LOtUP_1718209116)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 00:18:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: mkfs: assign root NID in the main thread
Date: Thu, 13 Jun 2024 00:18:25 +0800
Message-Id: <20240612161826.711279-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
References: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
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

Thus it could be customized (skiped), especially for incremental builds.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 09bf76b..069484d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1186,8 +1186,6 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 		if (ret)
 			return ret;
 		inode->bh->op = &erofs_skip_write_bhops;
-		if (IS_ROOT(inode))	/* assign root NID */
-			erofs_fixup_meta_blkaddr(inode);
 		return 0;
 	}
 
@@ -1206,20 +1204,31 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 struct erofs_mkfs_dfops {
 	pthread_t worker;
 	pthread_mutex_t lock;
-	pthread_cond_t full, empty;
+	pthread_cond_t full, empty, drain;
 	struct erofs_mkfs_jobitem *queue;
 	unsigned int entries, head, tail;
 };
 
 #define EROFS_MT_QUEUE_SIZE 128
 
-void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
+static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
+{
+	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
+
+	pthread_mutex_lock(&q->lock);
+	pthread_cond_wait(&q->drain, &q->lock);
+	pthread_mutex_unlock(&q->lock);
+}
+
+static void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 {
 	struct erofs_mkfs_jobitem *item;
 
 	pthread_mutex_lock(&q->lock);
-	while (q->head == q->tail)
+	while (q->head == q->tail) {
+		pthread_cond_signal(&q->drain);
 		pthread_cond_wait(&q->empty, &q->lock);
+	}
 
 	item = q->queue + q->head;
 	q->head = (q->head + 1) & (q->entries - 1);
@@ -1229,7 +1238,7 @@ void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 	return item;
 }
 
-void *z_erofs_mt_dfops_worker(void *arg)
+static void *z_erofs_mt_dfops_worker(void *arg)
 {
 	struct erofs_sb_info *sbi = arg;
 	int ret = 0;
@@ -1247,8 +1256,8 @@ void *z_erofs_mt_dfops_worker(void *arg)
 	pthread_exit((void *)(uintptr_t)ret);
 }
 
-int erofs_mkfs_go(struct erofs_sb_info *sbi,
-		  enum erofs_mkfs_jobtype type, void *elem, int size)
+static int erofs_mkfs_go(struct erofs_sb_info *sbi,
+			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
 	struct erofs_mkfs_jobitem *item;
 	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
@@ -1268,8 +1277,8 @@ int erofs_mkfs_go(struct erofs_sb_info *sbi,
 	return 0;
 }
 #else
-int erofs_mkfs_go(struct erofs_sb_info *sbi,
-		  enum erofs_mkfs_jobtype type, void *elem, int size)
+static int erofs_mkfs_go(struct erofs_sb_info *sbi,
+			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
 	struct erofs_mkfs_jobitem item;
 
@@ -1277,6 +1286,9 @@ int erofs_mkfs_go(struct erofs_sb_info *sbi,
 	memcpy(&item.u, elem, size);
 	return erofs_mkfs_jobfn(&item);
 }
+static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
+{
+}
 #endif
 
 static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
@@ -1537,6 +1549,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
 	if (err)
 		return err;
 
+	erofs_mkfs_flushjobs(root->sbi);
+	erofs_fixup_meta_blkaddr(root);		/* assign root NID */
 	do {
 		int err;
 		struct erofs_inode *dir = dumpdir;
@@ -1635,6 +1649,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	pthread_mutex_init(&q->lock, NULL);
 	pthread_cond_init(&q->empty, NULL);
 	pthread_cond_init(&q->full, NULL);
+	pthread_cond_init(&q->drain, NULL);
 
 	q->head = 0;
 	q->tail = 0;
@@ -1653,6 +1668,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 fail:
 	pthread_cond_destroy(&q->empty);
 	pthread_cond_destroy(&q->full);
+	pthread_cond_destroy(&q->drain);
 	pthread_mutex_destroy(&q->lock);
 	free(q->queue);
 	free(q);
-- 
2.39.3

