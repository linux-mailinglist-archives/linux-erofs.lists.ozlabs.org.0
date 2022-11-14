Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF403627D89
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 13:19:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N9pKN5bK0z3cGm
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Nov 2022 23:19:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N9pKK2bnKz2yYj
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Nov 2022 23:19:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUmtJD9_1668428383;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUmtJD9_1668428383)
          by smtp.aliyun-inc.com;
          Mon, 14 Nov 2022 20:19:44 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	yinxin.x@bytedance.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix missing xas_retry() in fscache mode
Date: Mon, 14 Nov 2022 20:19:43 +0800
Message-Id: <20221114121943.29987-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The xarray iteration only holds the RCU read lock and thus may encounter
XA_RETRY_ENTRY if there's process modifying the xarray concurrently.
This will cause oops when referring to the invalid entry.

Fix this by adding the missing xas_retry(), which will make the
iteration wind back to the root node if XA_RETRY_ENTRY is encountered.

Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
Suggested-by: David Howells <dhowells@redhat.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2:
- update the commit message suggested by David
- add "Suggested-by" tag, as this patch actually fixes the same issue
  as that fixed by David's patch [1]. Sorry I forgot in v1 ;-\
- add "Reviewed-by" tags

[1] https://lore.kernel.org/lkml/084d78a4-6052-f2ec-72f2-af9c4979f5dc@linux.alibaba.com/T/#m036d0221dacde491a1bcf2f4428e8b1450179df9
---
 fs/erofs/fscache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fe05bc51f9f2..458c1c70ef30 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -75,11 +75,15 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_page) {
-		unsigned int pgpos =
-			(folio_index(folio) - start_page) * PAGE_SIZE;
-		unsigned int pgend = pgpos + folio_size(folio);
+		unsigned int pgpos, pgend;
 		bool pg_failed = false;
 
+		if (xas_retry(&xas, folio))
+			continue;
+
+		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
+		pgend = pgpos + folio_size(folio);
+
 		for (;;) {
 			if (!subreq) {
 				pg_failed = true;
-- 
2.19.1.6.gb485710b

