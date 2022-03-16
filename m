Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7B4DB0E4
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 14:17:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJW6M1Ys4z30RG
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 00:17:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJW6B3htTz306h
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 00:17:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7NEPnw_1647436645; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7NEPnw_1647436645) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 21:17:26 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 01/22] fscache: export fscache_end_operation()
Date: Wed, 16 Mar 2022 21:17:02 +0800
Message-Id: <20220316131723.111553-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
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
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Export fscache_end_operation() to avoid code duplication.

Besides, considering the paired fscache_begin_read_operation() is
already exported, it shall make sense to also export
fscache_end_operation().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fscache/internal.h   | 11 -----------
 fs/nfs/fscache.c        |  8 --------
 include/linux/fscache.h | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index f121c21590dc..ed1c9ed737f2 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -70,17 +70,6 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 			     where);
 }
 
-/*
- * io.c
- */
-static inline void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-
-	if (ops)
-		ops->end_operation(cres);
-}
-
 /*
  * main.c
  */
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cfe901650ab0..39654ca72d3d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -249,14 +249,6 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 	}
 }
 
-static inline void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-
-	if (ops)
-		ops->end_operation(cres);
-}
-
 /*
  * Fallback page reading interface.
  */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 296c5f1d9f35..d2430da8aa67 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -456,6 +456,20 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 	return -ENOBUFS;
 }
 
+/**
+ * fscache_end_operation - End the read operation for the netfs lib
+ * @cres: The cache resources for the read operation
+ *
+ * Clean up the resources at the end of the read request.
+ */
+static inline void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+
+	if (ops)
+		ops->end_operation(cres);
+}
+
 /**
  * fscache_read - Start a read from the cache.
  * @cres: The cache resources to use
-- 
2.27.0

