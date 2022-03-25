Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8044E7308
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 13:23:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQ1Sy4fHpz30Q9
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 23:22:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQ1St24Vkz3bNn
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Mar 2022 23:22:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V89aFsk_1648210962; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V89aFsk_1648210962) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 25 Mar 2022 20:22:43 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 12/22] erofs: add cookie context helper functions
Date: Fri, 25 Mar 2022 20:22:13 +0800
Message-Id: <20220325122223.102958-13-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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

Introduce "struct erofs_fscache" for managing cookie for backinig file,
and helper functions for initializing and cleaning up this context
structure.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 14 +++++++++++
 2 files changed, 75 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 08cf570a0810..73235fd43bf6 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,67 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
+{
+	struct fscache_cookie *cookie;
+
+	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
+					path, strlen(path),
+					NULL, 0, 0);
+	if (!cookie)
+		return -EINVAL;
+
+	fscache_use_cookie(cookie, false);
+	ctx->cookie = cookie;
+	return 0;
+}
+
+static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
+{
+	struct fscache_cookie *cookie = ctx->cookie;
+
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
+	ctx->cookie = NULL;
+}
+
+/*
+ * erofs_fscache_get - create an fscache context for blob file
+ * @sb:		superblock
+ * @path:	name of blob file
+ *
+ * Return: fscache context on success, ERR_PTR() on failure.
+ */
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
+{
+	struct erofs_fscache *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erofs_fscache_init_cookie(ctx, path);
+	if (ret) {
+		erofs_err(sb, "failed to init cookie");
+		goto err;
+	}
+
+	return ctx;
+err:
+	kfree(ctx);
+	return ERR_PTR(ret);
+}
+
+void erofs_fscache_put(struct erofs_fscache *ctx)
+{
+	if (!ctx)
+		return;
+
+	erofs_fscache_cleanup_cookie(ctx);
+	kfree(ctx);
+}
+
 int __init erofs_init_fscache(void)
 {
 	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45b8b0dd8a27..d4f2b43cedae 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -96,6 +96,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_fscache {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -620,9 +624,19 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
+
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path);
+void erofs_fscache_put(struct erofs_fscache *ctx);
 #else
 static inline int erofs_init_fscache(void) { return 0; }
 static inline void erofs_exit_fscache(void) {}
+
+static inline struct erofs_fscache *erofs_fscache_get(struct super_block *sb,
+						      char *path)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void erofs_fscache_put(struct erofs_fscache *ctx) {}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

