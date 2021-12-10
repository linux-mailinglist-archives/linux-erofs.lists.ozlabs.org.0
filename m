Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD646FBF1
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:41:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NC63qmDz3cCw
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:41:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NC04fdfz3c7v
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-8PLQ6_1639121790; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8PLQ6_1639121790) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:31 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 09/19] netfs: refactor netfs_rreq_unlock()
Date: Fri, 10 Dec 2021 15:36:09 +0800
Message-Id: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In demand-read case, the input folio of netfs API is may not the page
cache inside the address space of the netfs file. Instead it may be just
a temporary page used to contain the data.

Thus iterate corresponding pages through rreq->folio directly.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 04d0cc2fca83..af12a7996672 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -414,6 +414,22 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
 	bool subreq_failed = false;
 
+	if (rreq->type == NETFS_TYPE_DEMAND) {
+		folio = rreq->folio;
+
+		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+			subreq_failed = (subreq->error < 0);
+			if (subreq_failed)
+				break;
+		}
+
+		if (!subreq_failed)
+			folio_mark_uptodate(folio);
+
+		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags))
+			folio_unlock(folio);
+	} else {
+
 	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
 
 	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
@@ -480,6 +496,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 		}
 	}
 	rcu_read_unlock();
+	}
 
 	task_io_account_read(account);
 	if (rreq->netfs_ops->done)
-- 
2.27.0

