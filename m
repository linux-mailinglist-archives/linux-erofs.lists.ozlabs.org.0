Return-Path: <linux-erofs+bounces-733-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C24ACB16ACB
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 05:20:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvTs3g1Wz2ymc;
	Thu, 31 Jul 2025 13:20:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753932017;
	cv=none; b=Ohy2ZsslSTds09ZAbR0IAQ/K6P4OdDVpSN7Ul9vJnBDx0/UlFfCTOlcet4cBCKbprCXXw5scAod753NBmzjdx89fvn+PKdNF8z+Xdvjp9aqESNmPRVkSfbhY1XvYuT0/mRuHVgWD+7p3RkeflPKbcsQYG/OuxH66q6i1WYc79S09GiSCTBWWKYkcnTojsawwJfYbRAbnEkGSTy+LnjVQ/Pup9LO1bdyaeD5XGQlNrRiBHWrQJTeJo8epb4zbkh9+1f0ZbWr1YfqdReey/GvXK6qjN0MDsxdqI6ebTB6Q4Ni67ZIa7NtFebxPSp9IDojzl+TdUp6oOjMCulCfVXVMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753932017; c=relaxed/relaxed;
	bh=VngDezJZb89xos71UpvjhXnEiNG5HVj0bF1q5plDAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTPSqS4IPckbzA/Qn4Iv8kLR9l3bpIYNvQSW0JR/WwtJpoawg487J0/trW9EQAFQqxfrVJqRyYeSh0I4Aci3VSV1RyOpypuqnZLpK+/4lYVWzeN/UJPJxqsHdQTAlycI7UUa3WbV4XoSbCbLuRcbmAz7WyvoYOoigJIQnS+nJUbXNfAM72s4rlaGYEa5HLAdCB1iavB6flNMVv+vnX5OcWzWbcW8PYNYhdsrqTYslMWbWiIYz0pH8W0Kv9nBfFC5YA32juWIYM66tnGHiPBjiNh6jJvn9+cgmnvm8i1+ZrIBc+3ePNieoR96p8AiVF89L9TreXSiQkA/8qHOuhQPPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i11fQ/dO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i11fQ/dO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvTr3H9xz2yKw
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 13:20:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753932012; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VngDezJZb89xos71UpvjhXnEiNG5HVj0bF1q5plDAzk=;
	b=i11fQ/dOI3B7OuMRE6QIscuTYIUU6V20Uc1+SkBT64hfCsikFQ+OFbBkTgJJJDeQMtVywOOtYlI6ahRRe71/99f22+YH/jKF/fSeDK9XiHUIuCXab/CqOfxka+n8FbXOjhzUBIxcI9W43TvD7nns4IQ2RGfgqzrDYIRp8p+6SiU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWg2dZ_1753932010 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 11:20:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 3/3] erofs-utils: lib: implement 3-way merge sort
Date: Thu, 31 Jul 2025 11:20:09 +0800
Message-ID: <20250731032009.2144589-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250731031642.2139859-3-hsiangkao@linux.alibaba.com>
References: <20250731031642.2139859-3-hsiangkao@linux.alibaba.com>
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
change since v1:
 - get rid of unneeded `u32 count[2]`.

 lib/inode.c | 86 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 59031144..b02ec8f8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -211,28 +211,65 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
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
@@ -252,21 +289,9 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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
@@ -275,6 +300,11 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
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


