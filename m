Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B518AC274
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:36:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qvgmKmKc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5sd4F1rz3cbF
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:36:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qvgmKmKc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5sD4nMXz3cYh
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:36:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4707ACE0A08;
	Mon, 22 Apr 2024 00:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A268FC113CE;
	Mon, 22 Apr 2024 00:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746174;
	bh=QICbJ7UqhyFwd6fIGwl5Lstc2T3f5UvoBCXpjc0uqTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvgmKmKcP928a5v6Ke6FZZFeyCLZxNFRjQFoxyHPHCl4pwwIRcRjSH85uttChv960
	 abHODhZrzuoGEcICaSy9lCVW88Yz7jVSc5YsqWWBa+ee2KYJHtnTg5RWjQ5rhb/76Z
	 J2ZC6RlHio4KwITJ5KPGCXNDarLNcq8EUPRUMHNuOaRFs5dK76wl2mNH0j2Bu4dlC1
	 /xH14k2/qfj1rm7fAzGAWFa31gWIyH7/wGH734281D8+0pYx3tMYua+5PJJNgdSGwW
	 CwvJgE1AvQz6TWAWOCUSJZrsFRFimSdS72HpU2bYlqFrUzvVRqfjZQmmbc9zsYBPW2
	 yP/IxhN1dSlQw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 8/8] erofs-utils: mkfs: enable inter-file multi-threaded compression
Date: Mon, 22 Apr 2024 08:34:50 +0800
Message-Id: <20240422003450.19132-8-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422003450.19132-1-xiang@kernel.org>
References: <20240422003450.19132-1-xiang@kernel.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Dispatch deferred ops in another per-sb worker thread.  Note that
deferred ops are strictly FIFOed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   6 ++
 lib/inode.c              | 119 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f31e548..ecbbdf6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -71,6 +71,7 @@ struct erofs_xattr_prefix_item {
 
 #define EROFS_PACKED_NID_UNALLOCATED	-1
 
+struct erofs_mkfs_dfops;
 struct erofs_sb_info {
 	struct erofs_device_info *devs;
 	char *devname;
@@ -124,6 +125,11 @@ struct erofs_sb_info {
 	struct list_head list;
 
 	u64 saved_by_deduplication;
+
+#ifdef EROFS_MT_ENABLED
+	pthread_t dfops_worker;
+	struct erofs_mkfs_dfops *mkfs_dfops;
+#endif
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/inode.c b/lib/inode.c
index 6ad66bf..cf22bbe 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1165,6 +1165,7 @@ enum erofs_mkfs_jobtype {	/* ordered job types */
 	EROFS_MKFS_JOB_NDIR,
 	EROFS_MKFS_JOB_DIR,
 	EROFS_MKFS_JOB_DIR_BH,
+	EROFS_MKFS_JOB_MAX
 };
 
 struct erofs_mkfs_jobitem {
@@ -1203,6 +1204,73 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 	return -EINVAL;
 }
 
+#ifdef EROFS_MT_ENABLED
+
+struct erofs_mkfs_dfops {
+	pthread_t worker;
+	pthread_mutex_t lock;
+	pthread_cond_t full, empty;
+	struct erofs_mkfs_jobitem *queue;
+	unsigned int entries, head, tail;
+};
+
+#define EROFS_MT_QUEUE_SIZE 128
+
+void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
+{
+	struct erofs_mkfs_jobitem *item;
+
+	pthread_mutex_lock(&q->lock);
+	while (q->head == q->tail)
+		pthread_cond_wait(&q->empty, &q->lock);
+
+	item = q->queue + q->head;
+	q->head = (q->head + 1) & (q->entries - 1);
+
+	pthread_cond_signal(&q->full);
+	pthread_mutex_unlock(&q->lock);
+	return item;
+}
+
+void *z_erofs_mt_dfops_worker(void *arg)
+{
+	struct erofs_sb_info *sbi = arg;
+	int ret = 0;
+
+	while (1) {
+		struct erofs_mkfs_jobitem *item;
+
+		item = erofs_mkfs_pop_jobitem(sbi->mkfs_dfops);
+		if (item->type >= EROFS_MKFS_JOB_MAX)
+			break;
+		ret = erofs_mkfs_jobfn(item);
+		if (ret)
+			break;
+	}
+	pthread_exit((void *)(uintptr_t)ret);
+}
+
+int erofs_mkfs_go(struct erofs_sb_info *sbi,
+		  enum erofs_mkfs_jobtype type, void *elem, int size)
+{
+	struct erofs_mkfs_jobitem *item;
+	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
+
+	pthread_mutex_lock(&q->lock);
+
+	while (((q->tail + 1) & (q->entries - 1)) == q->head)
+		pthread_cond_wait(&q->full, &q->lock);
+
+	item = q->queue + q->tail;
+	item->type = type;
+	memcpy(&item->u, elem, size);
+	q->tail = (q->tail + 1) & (q->entries - 1);
+
+	pthread_cond_signal(&q->empty);
+	pthread_mutex_unlock(&q->lock);
+	return 0;
+}
+#else
 int erofs_mkfs_go(struct erofs_sb_info *sbi,
 		  enum erofs_mkfs_jobtype type, void *elem, int size)
 {
@@ -1212,6 +1280,7 @@ int erofs_mkfs_go(struct erofs_sb_info *sbi,
 	memcpy(&item.u, elem, size);
 	return erofs_mkfs_jobfn(&item);
 }
+#endif
 
 static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 {
@@ -1344,7 +1413,11 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	return ret;
 }
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+#ifndef EROFS_MT_ENABLED
+#define __erofs_mkfs_build_tree_from_path erofs_mkfs_build_tree_from_path
+#endif
+
+struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
 {
 	struct erofs_inode *root, *dumpdir;
 	int err;
@@ -1399,10 +1472,52 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 		if (err)
 			return ERR_PTR(err);
 	} while (dumpdir);
-
 	return root;
 }
 
+#ifdef EROFS_MT_ENABLED
+struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+{
+	struct erofs_mkfs_dfops *q;
+	struct erofs_inode *root;
+	int err;
+
+	q = malloc(sizeof(*q));
+	if (!q)
+		return ERR_PTR(-ENOMEM);
+
+	q->entries = EROFS_MT_QUEUE_SIZE;
+	q->queue = malloc(q->entries * sizeof(*q->queue));
+	if (!q->queue) {
+		free(q);
+		return ERR_PTR(-ENOMEM);
+	}
+	pthread_mutex_init(&q->lock, NULL);
+	pthread_cond_init(&q->empty, NULL);
+	pthread_cond_init(&q->full, NULL);
+
+	q->head = 0;
+	q->tail = 0;
+	sbi.mkfs_dfops = q;
+	err = pthread_create(&sbi.dfops_worker, NULL,
+			     z_erofs_mt_dfops_worker, &sbi);
+	if (err)
+		goto fail;
+	root = __erofs_mkfs_build_tree_from_path(path);
+
+	erofs_mkfs_go(&sbi, ~0, NULL, 0);
+	err = pthread_join(sbi.dfops_worker, NULL);
+
+fail:
+	pthread_cond_destroy(&q->empty);
+	pthread_cond_destroy(&q->full);
+	pthread_mutex_destroy(&q->lock);
+	free(q->queue);
+	free(q);
+	return err ? ERR_PTR(err) : root;
+}
+#endif
+
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 {
 	struct stat st;
-- 
2.30.2

