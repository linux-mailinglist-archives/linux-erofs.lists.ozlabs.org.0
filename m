Return-Path: <linux-erofs+bounces-735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0995BB16B28
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 06:26:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bswyf2MhXz2yLB;
	Thu, 31 Jul 2025 14:26:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753936010;
	cv=none; b=A8RYig1ggqqt5VKPET8GrKEtSPssoeo2DHVvU719Rt7rg4eD9Lv32FnHnt3essuTCVXc1WEZdg7KdnGlE0sYNftfV9uSGgTyMyGXPB796sMh1jpOw56FQCEANXXU5YlCf04mZO5h0BeKyGcU7hVdK5cy9ohgyRppXfLgAe3Tm9jxQpHb2L3URRTtFKxquuTDvVV1ZMjk8TmL03ewbtnAsUHop6B/H9weAnvt4i1j5sVkPysL7QpgCbBWDXycM/yUmPHGtMUewATiGrA4dFYjjRnU/31w2MBBrqnA4q6SaQ0U4JvCUfZALFT3YDSeTxFj5sFxeHdHMVIr9AFY2QZAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753936010; c=relaxed/relaxed;
	bh=0N/mABjFdFXRll4Z0OdZdr1GwWg8UKKZmcACZJaqWMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXPc38Qcz5A/LoDujkzmpgr590n1GDSyAGQUnOOyfgBy5VEYp6x87X5cr1zuY8jD/EZ0yft6aVEF6BuJ+Nwvmal+DW1yQoD1I9fyvMXPQU+AXDk/V0mwD291MS8vkDskb6HpaY+MGYqx7nvRy2m1YSmXub2j6x4C6Rr8/MokZcrwj7zAWfPVFpL9O6OJv2IRE1Jbh+gs81ZjE/cCDDglY+zwmCY2DlEpGkIwFttt+Yl1KIPUqT/N20Q+r/1IR9Tk46JZgt0YvLjtRA6Cy2DVHk3QBqZzh3I4w52Acatzpk3Fvd/znKe40b5W+py7ZzVpCvzApYEZ1j/YFIte7O43wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iClaMVJO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iClaMVJO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bswyb63Vcz2yF1
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 14:26:46 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753936002; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0N/mABjFdFXRll4Z0OdZdr1GwWg8UKKZmcACZJaqWMU=;
	b=iClaMVJOr51X116GjtAL4rJ8d+5GlmRWn4TL1royqczpWLtTW85W32xXJgtddhBU/b0FLXqM9dBKWNThwjnUTqK05xGuUhPJRyxsfIrT9li+9u2wk2+XCOQW7ajKqmdn4zAu3ifyBDv/VdHovrmszKXgOrdZCjHJ74z3uEsA4UA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWoVYO_1753935996 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 12:26:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 3/3] erofs-utils: lib: implement 3-way merge sort
Date: Thu, 31 Jul 2025 12:26:34 +0800
Message-ID: <20250731042634.2248194-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250731032009.2144589-1-hsiangkao@linux.alibaba.com>
References: <20250731032009.2144589-1-hsiangkao@linux.alibaba.com>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

...so that only substrings need to be compared.

As a follow-up, need to add a fallback to a trivial comparison and
sort method when the total number of strings is small.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - just reset step as one byte.

 lib/inode.c | 84 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 59031144..850cec1b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -211,28 +211,63 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
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
+		struct erofs_dentry *e0, *d;
+		struct list_head le[2] = {
+			[0] = LIST_HEAD_INIT(le[0]),
+			[1] = LIST_HEAD_INIT(le[1]),
+		};
+		int cmp, k1;
+
+		e0 = list_entry(great, struct erofs_dentry, d_child);
+		great = great->next;
+		list_add_tail(&e0->d_child, &le[1]);
+
+		while (*greatp) {
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
+		}
+
+		if (!list_empty(&le[0])) {
+			if (le[0].prev != le[0].next)
+				erofs_dentry_mergesort(&le[0], k);
+			__list_splice(&le[0], entries->prev, entries);
+		}
 
-	da = *((const struct erofs_dentry **)a);
-	db = *((const struct erofs_dentry **)b);
-	commonlen = min(round_up(da->namelen, EROFS_DENTRY_NAME_ALIGNMENT),
-			round_up(db->namelen, EROFS_DENTRY_NAME_ALIGNMENT));
-	sign = memcmp(da->name, db->name, commonlen);
-	if (sign)
-		return sign;
-	return cmpsgn(da->namelen, db->namelen);
+		if (!list_empty(&le[1])) {
+			k1 = k + EROFS_DENTRY_MERGESORT_STEP;
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
@@ -252,21 +287,9 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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
@@ -275,6 +298,11 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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


