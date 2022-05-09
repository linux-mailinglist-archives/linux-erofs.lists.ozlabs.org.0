Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6FC51F573
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:41:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY4w6wBHz3cB1
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:41:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4n1Ppfz3c7R
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:40:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCgwzCt_1652082051; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCgwzCt_1652082051) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:52 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 14/22] erofs: add erofs_fscache_read_folios() helper
Date: Mon,  9 May 2022 15:40:20 +0800
Message-Id: <20220509074028.74954-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add erofs_fscache_read_folios() helper reading from fscache. It supports
on-demand read semantics. That is, it will make the backend prepare for
the data when cache miss. Once data ready, it will read from the cache.

This helper can then be used to implement .readpage()/.readahead() of
on-demand read semantics.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 26f038d9c4e1..ac02af8cce3e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,6 +5,60 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+/*
+ * Read data from fscache and fill the read data into page cache described by
+ * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
+ * the start physical address in the cache file.
+ */
+static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
+				     struct address_space *mapping,
+				     loff_t start, size_t len,
+				     loff_t pstart)
+{
+	enum netfs_io_source source;
+	struct netfs_io_request rreq = {};
+	struct netfs_io_subrequest subreq = { .rreq = &rreq, };
+	struct netfs_cache_resources *cres = &rreq.cache_resources;
+	struct super_block *sb = mapping->host->i_sb;
+	struct iov_iter iter;
+	size_t done = 0;
+	int ret;
+
+	ret = fscache_begin_read_operation(cres, cookie);
+	if (ret)
+		return ret;
+
+	while (done < len) {
+		subreq.start = pstart + done;
+		subreq.len = len - done;
+		subreq.flags = 1 << NETFS_SREQ_ONDEMAND;
+
+		source = cres->ops->prepare_read(&subreq, LLONG_MAX);
+		if (WARN_ON(subreq.len == 0))
+			source = NETFS_INVALID_READ;
+		if (source != NETFS_READ_FROM_CACHE) {
+			erofs_err(sb, "failed to fscache prepare_read (source %d)",
+				  source);
+			ret = -EIO;
+			goto out;
+		}
+
+		iov_iter_xarray(&iter, READ, &mapping->i_pages,
+				start + done, subreq.len);
+		ret = fscache_read(cres, subreq.start, &iter,
+				   NETFS_READ_HOLE_FAIL, NULL, NULL);
+		if (ret) {
+			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
+			goto out;
+		}
+
+		done += subreq.len;
+	}
+out:
+	fscache_end_operation(cres);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
 };
 
-- 
2.27.0

