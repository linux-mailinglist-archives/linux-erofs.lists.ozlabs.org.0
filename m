Return-Path: <linux-erofs+bounces-736-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C5B17B83
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 05:50:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btX6j5JMHz2y82;
	Fri,  1 Aug 2025 13:50:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754020253;
	cv=none; b=Zf0ye4IziiRn/fir6hqzxVKJZq5vOjlNvwA693+iYngcIMhaIDMbHY0S6YGzOQHc5WY3n5neBez+hSsWnrj7CK9UVA8wskY+z7V8V8bixnLLnWyyfYLUEW0OEQqNowZcw+tX9Dy98T8xz5B36RzaH7uqV1cJ7bLNRc/Qltjm+mazENx91++hky4uj5xpVn3Idlk9BpvRM8hVnu41273+V5p+06/BHNHfMei+kjSXFO5oucb0ZtA+E5EsXsrmdVlpxFpYU04h7LMOoWKG4ijo0VBLe62dWRiVFlkFRVlhNznCgc7Mg7bmOPNDbRfDyMd2+x6vhNL5AQF8Lgj+oU7t/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754020253; c=relaxed/relaxed;
	bh=+uBlgN/JstTW615zW9gyVTTF0807lNvjC//xecduvOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVjAcurQzx3ji2plf/oCIg46B5c0hAvBh8TH6kxdcC1w2QIBw6hGzawuzdaHUG9pumv0TgGNDnw5PwHXd7OPX5JqtEBu/vIcGj439tLiVztc11B7Bo++gN3n9rW/fQJHkoaz3RN63C92Ob/TiTXByo3OmAaPmvRLfp+c9L2rvbiT6j3WK9YlT1PYClOt2P2GMOTRyy2xZvoTF32/YTPnfplxgo0+R+poqj4jBXUV5X/v3vEEcaoxcjgKDM/xIDhX5rUjRRmtUSXtqL5gVnFuIFQHskbPElWFpZte4ljGN9aqlccY/q2Cz74FUQvDTYMe23TE2gIDtCnZkkMGGAmebQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nNjt8XPV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nNjt8XPV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btX6f4kn8z2xRw
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 13:50:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754020244; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+uBlgN/JstTW615zW9gyVTTF0807lNvjC//xecduvOA=;
	b=nNjt8XPVoh6jDJ3xPPuUQJ3Umi4WHWYTSsSTAv90BuV3pvWhRBSOgVyqOwHIIXTWh+wOa3LW1Iir+w5cnL/IVCw+lb9Zb2MlUB19K02L4qRwS2RGhUDazFHrvKa565HXWrvvin71iwixtiaZ3pcDSAMI4k03+kPphRAX69y0VGQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wkb5kdK_1754020242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 11:50:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v4 3/3] erofs-utils: lib: implement 3-way merge sort
Date: Fri,  1 Aug 2025 11:50:42 +0800
Message-ID: <20250801035042.4091447-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250731042634.2248194-1-hsiangkao@linux.alibaba.com>
References: <20250731042634.2248194-1-hsiangkao@linux.alibaba.com>
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

It can still be further improved (e.g., by generating a singly linked
list first); any contributions are welcome!

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/list.h |   5 ++
 lib/inode.c          | 111 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 88 insertions(+), 28 deletions(-)

diff --git a/include/erofs/list.h b/include/erofs/list.h
index d7a9fee..a7e30cc 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -130,6 +130,11 @@ static inline void list_splice_tail(struct list_head *list,
 	     &pos->member != (head);                                           \
 	     pos = n, n = list_next_entry(n, member))
 
+#define list_for_each_entry_safe_from(pos, n, head, member)		\
+	for (n = list_next_entry(pos, member);				\
+	     &pos->member != (head);					\
+	     pos = n, n = list_next_entry(n, member))
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/inode.c b/lib/inode.c
index 5903114..aebd94c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -211,28 +211,90 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 	return 0;
 }
 
-static int comp_subdir(const void *a, const void *b)
+#define EROFS_DENTRY_MERGESORT_STEP	1
+
+static void erofs_dentry_mergesort(struct list_head *entries, int k)
 {
-	const struct erofs_dentry *da, *db;
-	int commonlen, sign;
+	struct list_head *great = entries->next;
+
+	BUILD_BUG_ON(EROFS_DENTRY_MERGESORT_STEP > EROFS_DENTRY_NAME_ALIGNMENT);
+	entries->prev->next = NULL;
+	init_list_head(entries);
+	do {
+		struct list_head **greatp = &great;
+		struct erofs_dentry *e0, *d, *n;
+		struct list_head le[2];
+		int cmp, k1;
+		bool brk;
+
+		e0 = list_entry(great, struct erofs_dentry, d_child);
+		great = great->next;
+		init_list_head(&le[0]);
+		le[1] = (struct list_head)LIST_HEAD_INIT(e0->d_child);
+		e0->d_child.prev = e0->d_child.next = &le[1];
+
+		do {
+			d = list_entry(*greatp, struct erofs_dentry, d_child);
+			cmp = memcmp(d->name + k, e0->name + k,
+				     EROFS_DENTRY_MERGESORT_STEP);
+
+			if (cmp > 0) {
+				greatp = &d->d_child.next;
+				continue;
+			}
+			*greatp = d->d_child.next;
+			list_add_tail(&d->d_child, &le[!cmp]);
+		} while (*greatp);
+
+		k1 = k + EROFS_DENTRY_MERGESORT_STEP;
+		brk = great || !list_empty(&le[0]);
+		while (e0->name[k1 - 1] != '\0') {
+			if (__erofs_likely(brk)) {
+				if (le[1].prev != le[1].next)
+					erofs_dentry_mergesort(&le[1], k1);
+				break;
+			}
+			e0 = list_first_entry(&le[1],
+				struct erofs_dentry, d_child);
+			d = list_next_entry(e0, d_child);
+			list_for_each_entry_safe_from(d, n, &le[1], d_child) {
+				cmp = memcmp(d->name + k1, e0->name + k1,
+					     EROFS_DENTRY_MERGESORT_STEP);
+				if (!cmp)
+					continue;
+
+				__list_del(d->d_child.prev, d->d_child.next);
+				if (cmp < 0) {
+					list_add_tail(&d->d_child, &le[0]);
+				} else {
+					*greatp = &d->d_child;
+					d->d_child.next = NULL;
+					greatp = &d->d_child.next;
+				}
+				brk = true;
+			}
+			k = k1;
+			k1 += EROFS_DENTRY_MERGESORT_STEP;
+		}
+
+		if (!list_empty(&le[0])) {
+			if (le[0].prev != le[0].next)
+				erofs_dentry_mergesort(&le[0], k);
+			__list_splice(&le[0], entries->prev, entries);
+		}
+		__list_splice(&le[1], entries->prev, entries);
+	} while (great && great->next);
 
-	da = *((const struct erofs_dentry **)a);
-	db = *((const struct erofs_dentry **)b);
-	commonlen = min(round_up(da->namelen, EROFS_DENTRY_NAME_ALIGNMENT),
-			round_up(db->namelen, EROFS_DENTRY_NAME_ALIGNMENT));
-	sign = memcmp(da->name, db->name, commonlen);
-	if (sign)
-		return sign;
-	return cmpsgn(da->namelen, db->namelen);
+	if (great)
+		list_add_tail(great, entries);
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
@@ -252,21 +314,9 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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
@@ -275,6 +325,11 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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


