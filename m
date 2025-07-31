Return-Path: <linux-erofs+bounces-732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD1B16AC1
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 05:17:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvQ073Jbz2yKw;
	Thu, 31 Jul 2025 13:16:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753931816;
	cv=none; b=Itn1dBIbKPMmOtneqKgOxuaG6F7ObNQQzQ/Yn4Xoi/L8SBshOAaqpdd1l2jolXlaEoNwSm6mfJcjid/vFI4arrVskRuN9nwPqA9t3gSBmcsFPNVQDlqP9zj1uN736a8h5NaZeWXwxA/8w29YupBP/hRl7PSkCDqtEHKpJlkWO5rHVhRIe/cupYHk16ShNGjc33P8aXgVExKBps0nWVP2CQEfgA1uPzDkQteBVZ4Q7/6+wmF1sjbqsMWiry0KGH/jyJ5TadzCwuuTZE0QmlPiKy7s23IFegbf5IXwBEwDcuRNMNd56MQR1r77cvHwS7fvMuCikaCh1rmjRL4jjkmr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753931816; c=relaxed/relaxed;
	bh=utiAOZ5uNg6kionFYMnSkJVH34GvjAXTgKT7ZBFeKWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn8lBPIWp3xPPrBHMMZx0o9/Lai+Wrrjfff/y321HnzH/LFcGA3osGo6G0aarE5UKeijTxyfuqMYyZIdOzb4Wg5OAgsRMsq9URn5l5Nl0OE7xb85xHA4LrJl2ZLT0eP+N43xesHa6KTAZzmbsKt3XGzu016lh+5zbdkToXd/dvhMPXuJM7JtiaNSDG5x+HTfa3aSrDrflec3LyrGIIDKv6xRZU9tahZ8vEeKn6R5ZLsj52iWI/rEq9M1eRfrSJHvMgacFkGRkdtqks479GD9CYQDjLBqCywu15u5T2yqXuOJoxPFOcBorrotlW3TY5oEm27DtbB7rlxSw7FdFT7/yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w7YaFYxZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w7YaFYxZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvPz3CYTz2ymc
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 13:16:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753931811; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=utiAOZ5uNg6kionFYMnSkJVH34GvjAXTgKT7ZBFeKWI=;
	b=w7YaFYxZW9KcOXblHjS35JJg2Cws9MXS3exUwHD8+/HbhNvmetDVUyR7vO/yI0UmIODtcVG31vzZfp5pNl2uginmT73RabzRev2E33aRhZVJ06+ka9LGCzq1orHtl9gokDgRyIalz7INhIO1InBNPcDwIXRgk7TTbNy0qDF4KB0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWixF._1753931807 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 11:16:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: lib: implement 3-way merge sort
Date: Thu, 31 Jul 2025 11:16:42 +0800
Message-ID: <20250731031642.2139859-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250731031642.2139859-1-hsiangkao@linux.alibaba.com>
References: <20250731031642.2139859-1-hsiangkao@linux.alibaba.com>
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

...so that only substrings need to be compared.

As a follow-up, need to add a fallback to a trivial sort and comparison
method when the total number of strings is small.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 88 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 59031144..63875212 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -211,28 +211,67 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 	return 0;
 }
 
-static int comp_subdir(const void *a, const void *b)
+static void erofs_dentry_mergesort(struct list_head *entries, int k)
 {
-	const struct erofs_dentry *da, *db;
-	int commonlen, sign;
+	struct list_head *great = entries->next;
 
-	da = *((const struct erofs_dentry **)a);
-	db = *((const struct erofs_dentry **)b);
-	commonlen = min(round_up(da->namelen, EROFS_DENTRY_NAME_ALIGNMENT),
-			round_up(db->namelen, EROFS_DENTRY_NAME_ALIGNMENT));
-	sign = memcmp(da->name, db->name, commonlen);
-	if (sign)
-		return sign;
-	return cmpsgn(da->namelen, db->namelen);
+	entries->prev->next = NULL;
+	init_list_head(entries);
+	do {
+		struct list_head **greatp = &great;
+		struct erofs_dentry *e0, *d;
+		struct list_head le[2] = {
+			[0] = LIST_HEAD_INIT(le[0]),
+			[1] = LIST_HEAD_INIT(le[1]),
+		};
+		u32 count[2] = {};
+		int cmp, k1;
+
+		e0 = list_entry(great, struct erofs_dentry, d_child);
+		great = great->next;
+		list_add_tail(&e0->d_child, &le[1]);
+
+		while (*greatp) {
+			d = list_entry(*greatp, struct erofs_dentry, d_child);
+#if EROFS_DENTRY_NAME_ALIGNMENT == 4
+			cmp = cmpsgn(*((u32 *)d->name + k),
+				     *((u32 *)e0->name + k));
+#else
+			cmp = memcmp(d->name + k, e0->name + k,
+				     EROFS_DENTRY_NAME_ALIGNMENT);
+#endif
+
+			if (cmp > 0) {
+				greatp = &d->d_child.next;
+				continue;
+			}
+			*greatp = d->d_child.next;
+			list_add_tail(&d->d_child, &le[!cmp]);
+			++count[!cmp];
+		}
+
+		if (!list_empty(&le[0])) {
+			if (le[0].prev != le[0].next)
+				erofs_dentry_mergesort(&le[0], k);
+			__list_splice(&le[0], entries->prev, entries);
+		}
+
+		if (!list_empty(&le[1])) {
+			k1 = k + EROFS_DENTRY_NAME_ALIGNMENT;
+			if (le[1].prev != le[1].next &&
+			    e0->name[k1 - 1] != '\0')
+				erofs_dentry_mergesort(&le[1], k1);
+			__list_splice(&le[1], entries->prev, entries);
+		}
+	} while (great);
 }
 
 static int erofs_prepare_dir_file(struct erofs_inode *dir,
 				  unsigned int nr_subdirs)
 {
-	struct erofs_sb_info *sbi = dir->sbi;
-	struct erofs_dentry *d, *n, **sorted_d;
 	bool dot_omitted = cfg.c_dot_omitted;
-	unsigned int i;
+	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_dentry *d;
 	unsigned int d_size = 0;
 
 	if (!dot_omitted) {
@@ -252,21 +291,9 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 	d->inode = erofs_igrab(erofs_parent_inode(dir));
 	d->type = EROFS_FT_DIR;
 
+	if (nr_subdirs)
+		erofs_dentry_mergesort(&dir->i_subdirs, 0);
 	nr_subdirs += 1 + !dot_omitted;
-	sorted_d = malloc(nr_subdirs * sizeof(d));
-	if (!sorted_d)
-		return -ENOMEM;
-
-	i = 0;
-	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
-		list_del(&d->d_child);
-		sorted_d[i++] = d;
-	}
-	DBG_BUGON(i != nr_subdirs);
-	qsort(sorted_d, i, sizeof(d), comp_subdir);
-	while (i)
-		list_add(&sorted_d[--i]->d_child, &dir->i_subdirs);
-	free(sorted_d);
 
 	/* let's calculate dir size */
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
@@ -275,6 +302,11 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 		if (erofs_blkoff(sbi, d_size) + len > erofs_blksiz(sbi))
 			d_size = round_up(d_size, erofs_blksiz(sbi));
 		d_size += len;
+		--nr_subdirs;
+	}
+	if (nr_subdirs) {
+		DBG_BUGON(1);
+		return -EFAULT;
 	}
 	dir->i_size = d_size;
 
-- 
2.43.5


