Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763934ED8D5
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 13:58:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KThdy2HbSz3bsQ
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 22:58:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KThdj1Hnjz2yJQ
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Mar 2022 22:58:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8imrsv_1648727888; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8imrsv_1648727888) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 31 Mar 2022 19:58:09 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 10/19] erofs: add fscache context helper functions
Date: Thu, 31 Mar 2022 19:57:44 +0800
Message-Id: <20220331115753.89431-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce a context structure for managing data blobs, and helper
functions for initializing and cleaning up this context structure.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 19 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7a6d0239ebb1..67a3c4935245 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,6 +5,52 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+/*
+ * Create an fscache context for data blob.
+ * Return: 0 on success and allocated fscache context is assigned to @fscache,
+ *	   negative error number on failure.
+ */
+int erofs_fscache_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache, char *name)
+{
+	struct fscache_volume *volume = EROFS_SB(sb)->volume;
+	struct erofs_fscache *ctx;
+	struct fscache_cookie *cookie;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
+					name, strlen(name), NULL, 0, 0);
+	if (!cookie) {
+		erofs_err(sb, "failed to get cookie for %s", name);
+		kfree(name);
+		return -EINVAL;
+	}
+
+	fscache_use_cookie(cookie, false);
+	ctx->cookie = cookie;
+
+	*fscache = ctx;
+	return 0;
+}
+
+void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+{
+	struct erofs_fscache *ctx = *fscache;
+
+	if (!ctx)
+		return;
+
+	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
+	fscache_relinquish_cookie(ctx->cookie, false);
+	ctx->cookie = NULL;
+
+	kfree(ctx);
+	*fscache = NULL;
+}
+
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 952a2f483f94..c6a3351a4d7d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -97,6 +97,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_fscache {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -626,9 +630,24 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
+
+int erofs_fscache_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache, char *name);
+void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
+
+static inline int erofs_fscache_register_cookie(struct super_block *sb,
+						struct erofs_fscache **fscache,
+						char *name)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+{
+}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

