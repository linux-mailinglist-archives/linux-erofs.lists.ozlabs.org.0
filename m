Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33996BAD6
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 13:35:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzL502rWqz2yhM
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 21:35:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725449698;
	cv=none; b=ESrgHT2l+n96sxALhQXtmj0vvxwUZS0SbaI0QRYAzMfcB5V5fAkh0mLdRxp5qjX27vwb1O4VWJOEA6EayWgRpIXRRH863llJRDsXMrIuvCnR2MXLLFoIQ76Olx+W9RDajOn8qsoniyvLBS3a9FFvuQKGs6pccgYBqRJYMbh9CjwBvA/gFrabEEqeGRzlYdfyeg4lQYWHNoAmRlismlc+yLp15fTigBpNfmKXeG3VCFtkYWAOFlqFXQX7J/HNWJ5v+iFKTSnmpUh5hNxfIgK+LF8oLnU5k5MBQJF+NDgcr2mzBs42pFpMUd6RvdPIV06up79pwBDVQQf0hiOvBsE/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725449698; c=relaxed/relaxed;
	bh=8znPZvt63hueLzAUClg7wSvVPNyk1biB2Vj+8Joppq0=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=AGj60y8dm6I7ll+wUDa2DUvX9cSZStyYaFO2oUu1fat4Xu71pN7WKBqj6hyTJbMdLgyvcomj3BeflwWvskbK9IuBB/Y7+YSze5lL4pTNijhqRTW1k6YTM7QwQr4klXRRN2omEgvupcUpMcIzmKTi4rs+QvBYBHjzS1dDtLGOClV04UpcG48jDSwtnebhhfJhwUqys+nlBrxqAq9it79HooUkuF2JXB2RCUGn+xz8lgVaIGqn5TYerjKTKzoikhNhqTwZx7xm8gP152iLEz6DRUF3x2oZwRgVVnxRSWQUru9V2Ch36Re1LkUhbS5x/yhxUUBJTK4BtK4B/zdYUJHUMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XgAGt+5M; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XgAGt+5M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzL4w29z5z2xGg
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2024 21:34:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725449690; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8znPZvt63hueLzAUClg7wSvVPNyk1biB2Vj+8Joppq0=;
	b=XgAGt+5MSZzTfw1Sg0LaiBbZAhZIS/IznBQHYPTJwdQsJopM048ad/FOmJBgm/DCvtCCLiXzU3pd83h9T33oPMk0PQyswjMk2vUMJz9bRZqZxgDOr4aZcCIE85C8sDz1AY2Pq39zNKZjrOHncxdgcCy22xC8rD2BY3gl1z/pg7s=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEHYW20_1725449689)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 19:34:50 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: introduce the merge sort algorithm for dentries
Date: Wed,  4 Sep 2024 19:34:48 +0800
Message-ID: <20240904113448.646099-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Currently, malloc(), qsort() and free() are used to sort the dentries
in the directory. This patch reuses the existing `dir->i_subdirs` list and
the merge sort to achieve the same objective. This may avoid the potential
performance degradation when using malloc() and free().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/inode.c | 111 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 128c051..2283fc0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -234,27 +234,108 @@ int erofs_init_empty_dir(struct erofs_inode *dir)
 	return 0;
 }
 
+/* given list p and q that are two circles, return a merged circle */
+static struct list_head *erofs_subdirs_merge(struct list_head *p,
+					     struct list_head *q)
+{
+	struct list_head *cur, *ret = NULL;
+	struct erofs_dentry *d1, *d2;
+
+	if (p)
+		p->prev->next = NULL;
+	if (q)
+		q->prev->next = NULL;
+
+	while (p || q) {
+		d1 = d2 = NULL;
+		if (p)
+			d1 = container_of(p, struct erofs_dentry, d_child);
+		if (q)
+			d2 = container_of(q, struct erofs_dentry, d_child);
+		if (d1 && d2) {
+			if (comp_subdir(&d1, &d2) < 0) {
+				cur = p;
+				p = p->next;
+			} else {
+				cur = q;
+				q = q->next;
+			}
+		} else if (d1) {
+			cur = p;
+			p = p->next;
+		} else {
+			cur = q;
+			q = q->next;
+		}
+		if (!ret) {
+			ret = cur;
+			init_list_head(ret);
+		} else
+			list_add_tail(cur, ret);
+	}
+	return ret;
+}
+
+static struct list_head *erofs_subdirs_sort(struct list_head *lst,
+					    unsigned int nr_subdirs)
+{
+	struct list_head *p, *q;
+	int i;
+
+	if (!lst || !nr_subdirs) {
+		erofs_err("invalid lst or nr_subdirs");
+		return NULL;
+	}
+	if (nr_subdirs == 1) {
+		init_list_head(lst);
+		return lst;
+	}
+	p = lst;
+	for (i = 0; i < nr_subdirs / 2 - 1; i ++) {
+		p = p->next;
+	}
+	q = p->next;
+
+	/* split into two circles */
+	q->prev = lst->prev;
+	lst->prev->next = q;
+	lst->prev = p;
+	p->next = lst;
+
+	p = erofs_subdirs_sort(p, nr_subdirs / 2);
+	q = erofs_subdirs_sort(q, nr_subdirs - nr_subdirs / 2);
+	return erofs_subdirs_merge(p, q);
+}
+
+static void erofs_sort_subdirs_list(struct list_head *head,
+				    unsigned int nr_subdirs)
+{
+	struct list_head *lst;
+
+	if (!head || nr_subdirs < 2) {
+		erofs_err("nr_subdirs should >= 2");
+		return;
+	}
+	lst = erofs_subdirs_sort(head->next, nr_subdirs);
+	if (!lst) {
+		erofs_err("fail to sort subdirs");
+		return;
+	}
+	/* attach the head to the sorted list */
+	lst->prev->next = head;
+	head->prev = lst->prev;
+	lst->prev = head;
+	head->next = lst;
+}
+
 static int erofs_prepare_dir_file(struct erofs_inode *dir,
 				  unsigned int nr_subdirs)
 {
 	struct erofs_sb_info *sbi = dir->sbi;
-	struct erofs_dentry *d, *n, **sorted_d;
-	unsigned int i;
+	struct erofs_dentry *d;
 	unsigned int d_size = 0;
 
-	sorted_d = malloc(nr_subdirs * sizeof(d));
-	if (!sorted_d)
-		return -ENOMEM;
-	i = 0;
-	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
-		list_del(&d->d_child);
-		sorted_d[i++] = d;
-	}
-	DBG_BUGON(i != nr_subdirs);
-	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
-	for (i = 0; i < nr_subdirs; i++)
-		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
-	free(sorted_d);
+	erofs_sort_subdirs_list(&dir->i_subdirs, nr_subdirs);
 
 	/* let's calculate dir size */
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-- 
2.43.5

