Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935A6A5F15
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 19:55:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PR64t2429z3cB9
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 05:55:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PR64d422hz3c3W
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 05:55:11 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VckM4Mf_1677610501;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VckM4Mf_1677610501)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 02:55:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: get rid of useless nr_dup
Date: Wed,  1 Mar 2023 02:54:57 +0800
Message-Id: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Also refine the longest detection.

Fixes: 990c7e383795 ("erofs-utils: mkfs: support fragment deduplication")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index c67c1bb..1e41485 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -26,7 +26,7 @@
 
 struct erofs_fragment_dedupe_item {
 	struct list_head	list;
-	unsigned int		length, nr_dup;
+	unsigned int		length;
 	erofs_off_t		pos;
 	u8			data[];
 };
@@ -53,7 +53,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	struct erofs_fragment_dedupe_item *cur, *di = NULL;
 	struct list_head *head;
 	u8 *data;
-	unsigned int length, e2;
+	unsigned int length, e2, deduped;
 	int ret;
 
 	head = &dupli_frags[FRAGMENT_HASH(crc)];
@@ -83,6 +83,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 
 	DBG_BUGON(length <= EROFS_TOF_HASHLEN);
 	e2 = length - EROFS_TOF_HASHLEN;
+	deduped = 0;
 
 	list_for_each_entry(cur, head, list) {
 		unsigned int e1, mn, i = 0;
@@ -97,22 +98,22 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 		while (i < mn && cur->data[e1 - i - 1] == data[e2 - i - 1])
 			++i;
 
-		if (i && (!di || i + EROFS_TOF_HASHLEN > di->nr_dup)) {
-			cur->nr_dup = i + EROFS_TOF_HASHLEN;
+		if (!di || i + EROFS_TOF_HASHLEN > deduped) {
+			deduped = i + EROFS_TOF_HASHLEN;
 			di = cur;
 
 			/* full match */
-			if (i == mn)
+			if (i == e2)
 				break;
 		}
 	}
 	if (!di)
 		goto out;
 
-	DBG_BUGON(di->length < di->nr_dup);
+	DBG_BUGON(di->length < deduped);
 
-	inode->fragment_size = di->nr_dup;
-	inode->fragmentoff = di->pos + di->length - di->nr_dup;
+	inode->fragment_size = deduped;
+	inode->fragmentoff = di->pos + di->length - deduped;
 
 	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
 		  inode->fragmentoff | 0ULL);
@@ -161,7 +162,6 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
 	memcpy(di->data, data, len);
 	di->length = len;
 	di->pos = pos;
-	di->nr_dup = 0;
 
 	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
 	return 0;
-- 
2.36.1

