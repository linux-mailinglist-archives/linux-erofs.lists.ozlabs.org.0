Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420E46FBC7
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:37:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9N5f1NXLz3bhd
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:37:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9N5b1vt9z2yng
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:37:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-8ADFS_1639121800; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8ADFS_1639121800) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:40 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 17/19] netfs: support on demand read
Date: Fri, 10 Dec 2021 15:36:17 +0800
Message-Id: <20211210073619.21667-18-jefflexu@linux.alibaba.com>
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

Add demand_read() callback to netfs_cache_ops to implement demand read.

To implement demand-read semantics, the data blob file is a sparse file
on the first beginning. When fs starts to access the data blob file, it
will "cache miss" (hit the  hole) and then .issue_op() callback will be
called to prepare the data.

.issue_op() callback could call netfs_demand_read() helper function
introduced in this patch to prepare the data, which will in turn call
.demand_read() callback of fscache backend.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 26 ++++++++++++++++++++++++++
 include/linux/netfs.h  |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ade1523fc180..3460cfd7a570 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1125,6 +1125,32 @@ int netfs_readpage_demand(struct folio *folio,
 }
 EXPORT_SYMBOL(netfs_readpage_demand);
 
+void netfs_demand_read(struct netfs_read_subrequest *subreq)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	loff_t start_pos;
+	size_t len;
+	int ret;
+
+	start_pos = subreq->start + subreq->transferred;
+	len = subreq->len - subreq->transferred;
+
+	/*
+	 * In success case (ret == 0), user daemon has downloaded data for us,
+	 * thus transform to NETFS_READ_FROM_CACHE state and advertise that 0
+	 * byte readed, so that the request will enter into INCOMPLETE state and
+	 * re-read from backing file.
+	 */
+	ret = cres->ops->demand_read(cres, start_pos, len);
+	if (!ret) {
+		subreq->source = NETFS_READ_FROM_CACHE;
+		__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+	}
+
+	netfs_subreq_terminated(subreq, ret, false);
+}
+
 /*
  * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5f45eb31defd..8a9dae361f07 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -253,6 +253,9 @@ struct netfs_cache_ops {
 	int (*prepare_write)(struct netfs_cache_resources *cres,
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
+
+	int (*demand_read)(struct netfs_cache_resources *cres,
+			   loff_t start_pos, size_t len);
 };
 
 struct readahead_control;
@@ -271,6 +274,7 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     void **,
 			     const struct netfs_read_request_ops *,
 			     void *);
+extern void netfs_demand_read(struct netfs_read_subrequest *);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
-- 
2.27.0

