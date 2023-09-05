Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA47921BF
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:02:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1K05qVMz3c01
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:02:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jq6jhlz30f9
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPVOt2_1693908149;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPVOt2_1693908149)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:30 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 02/11] erofs-utils: lib: add list_splice_tail() helper
Date: Tue,  5 Sep 2023 18:02:18 +0800
Message-Id: <20230905100227.1072-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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

Add list_splice_tail() helper.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/list.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/erofs/list.h b/include/erofs/list.h
index 3f5da1a..d7a9fee 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -70,6 +70,26 @@ static inline int list_empty(struct list_head *head)
 	return head->next == head;
 }
 
+static inline void __list_splice(struct list_head *list,
+		struct list_head *prev, struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+static inline void list_splice_tail(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head->prev, head);
+}
+
 #define list_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define list_first_entry(ptr, type, member)                                    \
-- 
2.19.1.6.gb485710b

