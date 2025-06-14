Return-Path: <linux-erofs+bounces-404-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D2AD99AE
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jun 2025 04:33:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bK0gG0Z7fz2xHp;
	Sat, 14 Jun 2025 12:33:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749868394;
	cv=none; b=C9fay6H6XZ3qfGmJ8bMHyQoDYi0U6wjCplgVbokNwW2tJFMFL01DH9wqedEnZT7Prhbv5R3HogtsLcT7MQIgcxyZdSCzGqpel289ya/pqueov60UqzJ/ueuLpEg/833WKFrhpWLaDmLY2oUmTkgraBjaCY/kofRsV9pORAFK7+9sxzm3P59cussYXVy6U5bZqeNx5a3fKXqw3AAHTQmhCKwlju6JRUAqOdLqDO7qS+Fd6AZ1oJxrJxmlNFaaxgKi1lB7AjLZREkpOQnk5U960zQbBJGcUCOP55G7/UVWKv1V6qRg7HXFPIlhfAzmTFiMbomyHQIPiGmEI1WRtG4ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749868394; c=relaxed/relaxed;
	bh=dAOZ/rDEJBzB4QwBf9KhBRruaTdFjmV6uOwxhL0KLpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9NLkEmykkNGFF0TR6kHHccczjs/BALuvMdKh2EnAKY4Qtq0w+3IgT5Qt2kAOfgwOiwmZyQa0jPgar9rCep9XAdbiaTvD3+ckSn11+4/c97cZb7K8MAXroovyHQ9diHyJokMEmXd7WIOgfjS3CRrlUp6wuBPEGSUgE4lPqj3kPUDmXr9MZe9iRsG/Ilwxx8snE4XYaZdTH9OYxFhkAq17MRu54cqOIvrmM7G25eLgDPjhQZ30CknU/PTmmbwzJOGsWoSeR60RIK/B8V6DUmg6cWhWVhIOV/S1n0abCcATwmwVfgzZRTdweJKj0rfLMayIl2MjKhTzFhQxsq8exkKwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HCuuhdMB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HCuuhdMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bK0gD2CmVz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 12:33:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749868388; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dAOZ/rDEJBzB4QwBf9KhBRruaTdFjmV6uOwxhL0KLpE=;
	b=HCuuhdMBPyFM5KReoNSExKRFEK2k0bSYzLDzG4w7fhS4Ouhb9Q8o6ba4k2Ck7fZi+rCvK2kpAh0sMpEXxVMu/aMzdGWGhcn8QwF6uRN5j6ZnzAHxONLYVGZ7DnnAMt/cfY5d4mq6XrmjZ7ehYM7zbMbsY/0sUnR3gor9ordP+rE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdm5aFk_1749868385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Jun 2025 10:33:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: mkfs: handle early exit of the dfops worker
Date: Sat, 14 Jun 2025 10:32:59 +0800
Message-ID: <20250614023259.1688845-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250614023259.1688845-1-hsiangkao@linux.alibaba.com>
References: <20250614023259.1688845-1-hsiangkao@linux.alibaba.com>
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

Otherwise, the main thread will be stuck due to the full queue.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 39ffebc..db26236 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1393,6 +1393,7 @@ struct erofs_mkfs_dfops {
 	struct erofs_mkfs_jobitem *queue;
 	unsigned int entries, head, tail;
 	bool idle;	/* initialize as false before the dfops worker runs */
+	bool exited;
 };
 
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
@@ -1443,6 +1444,10 @@ static void *z_erofs_mt_dfops_worker(void *arg)
 		ret = erofs_mkfs_jobfn(item);
 		erofs_mkfs_pop_jobitem(dfops);
 	} while (!ret);
+
+	dfops->exited = true;
+	if (ret < 0)
+		pthread_cond_signal(&dfops->full);
 	pthread_exit((void *)(uintptr_t)(ret < 0 ? ret : 0));
 }
 
@@ -1454,8 +1459,13 @@ static int erofs_mkfs_go(struct erofs_sb_info *sbi,
 
 	pthread_mutex_lock(&q->lock);
 
-	while (q->tail - q->head >= q->entries)
+	while (q->tail - q->head >= q->entries) {
+		if (q->exited) {
+			pthread_mutex_unlock(&q->lock);
+			return -ECHILD;
+		}
 		pthread_cond_wait(&q->full, &q->lock);
+	}
 
 	item = q->queue + (q->tail++ & (q->entries - 1));
 	item->type = type;
@@ -1912,9 +1922,10 @@ static int erofs_get_fdlimit(void)
 
 static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
+	struct erofs_sb_info *sbi = ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
 	struct erofs_mkfs_dfops *q;
 	int err, err2;
-	struct erofs_sb_info *sbi = ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
+	void *retval;
 
 	q = calloc(1, sizeof(*q));
 	if (!q)
@@ -1946,9 +1957,13 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 
 	err = __erofs_mkfs_build_tree(ctx);
 	erofs_mkfs_go(sbi, ~0, NULL, 0);
-	err2 = pthread_join(sbi->dfops_worker, NULL);
-	if (!err)
+	err2 = pthread_join(sbi->dfops_worker, &retval);
+	DBG_BUGON(!q->exited);
+	if (!err || err == -ECHILD) {
 		err = err2;
+		if (!err)
+			err = (intptr_t)retval;
+	}
 
 fail:
 	pthread_cond_destroy(&q->empty);
-- 
2.43.5


