Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD24926C2
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jan 2022 14:13:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JdTjc2SGWz30Lr
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 00:13:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JdThw2kWNz30NC
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jan 2022 00:12:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2C2ayE_1642511560; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2C2ayE_1642511560) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Jan 2022 21:12:41 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 20/20] erofs: support on-demand reading
Date: Tue, 18 Jan 2022 21:12:16 +0800
Message-Id: <20220118131216.85338-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the .issue_op() callback, and all work is done by
netfs_ondemand_read().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index e8df35ee4ba8..9ba668c42098 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -28,9 +28,15 @@ static void erofs_noop_cleanup(struct address_space *mapping, void *netfs_priv)
 {
 }
 
+static void erofs_issue_op(struct netfs_read_subrequest *subreq)
+{
+	netfs_ondemand_read(subreq);
+}
+
 static const struct netfs_read_request_ops erofs_blob_req_ops = {
 	.begin_cache_operation  = erofs_blob_begin_cache_operation,
 	.cleanup		= erofs_noop_cleanup,
+	.issue_op		= erofs_issue_op,
 };
 
 static int erofs_begin_cache_operation(struct netfs_read_request *rreq)
@@ -58,6 +64,7 @@ static const struct netfs_read_request_ops erofs_req_ops = {
 	.begin_cache_operation  = erofs_begin_cache_operation,
 	.cleanup		= erofs_noop_cleanup,
 	.clamp_length		= erofs_clamp_length,
+	.issue_op		= erofs_issue_op,
 };
 
 static int erofs_fscache_blob_readpage(struct file *data, struct page *page)
-- 
2.27.0

