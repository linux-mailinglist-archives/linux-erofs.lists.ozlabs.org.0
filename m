Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8A46FBF7
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:42:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NCP0t2Qz3c56
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:42:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NC443ZGz3brd
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-8E0Pr_1639121788; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8E0Pr_1639121788) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:28 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 07/19] netfs: add netfs_readpage_demand()
Date: Fri, 10 Dec 2021 15:36:07 +0800
Message-Id: <20211210073619.21667-8-jefflexu@linux.alibaba.com>
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

netfs_readpage_demand() is the demand-read version of
netfs_readpage().

When netfs API works in demand-read mode, fs using fscache shall call
netfs_readpage_demand() instead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |  3 ++
 2 files changed, 66 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9240b85548e4..26fa688f6300 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1022,6 +1022,69 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
+int netfs_readpage_demand(struct folio *folio,
+			  const struct netfs_read_request_ops *ops,
+			  void *netfs_priv)
+{
+	struct netfs_read_request *rreq;
+	unsigned int debug_index = 0;
+	int ret;
+
+	_enter("%lx", folio_index(folio));
+
+	rreq = __netfs_alloc_read_request(ops, netfs_priv, NULL);
+	if (!rreq) {
+		if (netfs_priv)
+			ops->cleanup(netfs_priv, folio_file_mapping(folio));
+		folio_unlock(folio);
+		return -ENOMEM;
+	}
+	rreq->type	= NETFS_TYPE_DEMAND;
+	rreq->folio	= folio;
+	rreq->start	= folio_file_pos(folio);
+	rreq->len	= folio_size(folio);
+	__set_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags);
+
+	if (ops->begin_cache_operation) {
+		ret = ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
+			folio_unlock(folio);
+			goto out;
+		}
+	}
+
+	netfs_stat(&netfs_n_rh_readpage);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
+
+	netfs_get_read_request(rreq);
+
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	 * the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	do {
+		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		netfs_rreq_assess(rreq, false);
+	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
+
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_readpage);
+		ret = -EIO;
+	}
+out:
+	netfs_put_read_request(rreq, false);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_readpage_demand);
+
 /*
  * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 638ea5d63869..de6948bcc80a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -261,6 +261,9 @@ extern int netfs_readpage(struct file *,
 			  struct folio *,
 			  const struct netfs_read_request_ops *,
 			  void *);
+extern int netfs_readpage_demand(struct folio *,
+				 const struct netfs_read_request_ops *,
+				 void *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct folio **,
 			     void **,
-- 
2.27.0

