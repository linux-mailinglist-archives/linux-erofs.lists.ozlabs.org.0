Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D47688DA8
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:02:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7L6G15Pqz3f6H
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:01:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7L662D6Gz3cf2
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:01:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VampZ0n_1675393304;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VampZ0n_1675393304)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:45 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/9] erofs: support readahead in meta routine
Date: Fri,  3 Feb 2023 11:01:35 +0800
Message-Id: <20230203030143.73105-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In prep for the following support for readahead for page cache sharing,
add support for readahead in meta routine.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 014e20962376..e2ebe8f7dbe9 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -193,6 +193,30 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 	return ret;
 }
 
+static void erofs_fscache_meta_readahead(struct readahead_control *rac)
+{
+	int ret;
+	struct erofs_fscache *ctx = rac->mapping->host->i_private;
+	struct erofs_fscache_request *req;
+
+	if (!readahead_count(rac))
+		return;
+
+	req = erofs_fscache_req_alloc(rac->mapping,
+			readahead_pos(rac), readahead_length(rac));
+	if (IS_ERR(req))
+		return;
+
+	/* The request completion will drop refs on the folios. */
+	while (readahead_folio(rac))
+		;
+
+	ret = erofs_fscache_read_folios_async(ctx->cookie, req, req->start, req->len);
+	if (ret)
+		req->error = ret;
+	erofs_fscache_req_put(req);
+}
+
 static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 {
 	struct address_space *mapping = primary->mapping;
@@ -319,6 +343,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 
 static const struct address_space_operations erofs_fscache_meta_aops = {
 	.read_folio = erofs_fscache_meta_read_folio,
+	.readahead  = erofs_fscache_meta_readahead,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
-- 
2.19.1.6.gb485710b

