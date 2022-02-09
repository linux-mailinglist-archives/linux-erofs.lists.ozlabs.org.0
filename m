Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE24AE9C2
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:01:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5P3bKhz3cJl
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:01:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq5774l8z2yfc
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zwJlp_1644386481; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zwJlp_1644386481) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:22 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 10/22] erofs: add cookie context helper functions
Date: Wed,  9 Feb 2022 14:00:56 +0800
Message-Id: <20220209060108.43051-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce 'struct erofs_cookie_ctx' for managing cookie for backing
file, and the following introduced API for reading from backing file.

Besides, introduce two helper functions for initializing and cleaning
up erofs_cookie_ctx.

struct erofs_cookie_ctx *
erofs_fscache_get_ctx(struct super_block *sb, char *path);

void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 78 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 +++++
 2 files changed, 86 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 9c32f42e1056..c043d7709d65 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,84 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_init_cookie(struct erofs_fscache_context *ctx,
+				     char *path)
+{
+	struct fscache_cookie *cookie;
+
+	/*
+	 * @object_size shall be non-zero to avoid
+	 * FSCACHE_COOKIE_NO_DATA_TO_READ.
+	 */
+	cookie = fscache_acquire_cookie(volume, 0,
+					path, strlen(path),
+					NULL, 0, -1);
+	if (!cookie)
+		return -EINVAL;
+
+	fscache_use_cookie(cookie, false);
+	ctx->cookie = cookie;
+	return 0;
+}
+
+static inline
+void erofs_fscache_cleanup_cookie(struct erofs_fscache_context *ctx)
+{
+	struct fscache_cookie *cookie = ctx->cookie;
+
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
+	ctx->cookie = NULL;
+}
+
+static int erofs_fscache_init_ctx(struct erofs_fscache_context *ctx,
+				  struct super_block *sb, char *path)
+{
+	int ret;
+
+	ret = erofs_fscache_init_cookie(ctx, path);
+	if (ret) {
+		erofs_err(sb, "failed to init cookie");
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline
+void erofs_fscache_cleanup_ctx(struct erofs_fscache_context *ctx)
+{
+	erofs_fscache_cleanup_cookie(ctx);
+}
+
+struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
+						char *path)
+{
+	struct erofs_fscache_context *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erofs_fscache_init_ctx(ctx, sb, path);
+	if (ret) {
+		kfree(ctx);
+		return ERR_PTR(ret);
+	}
+
+	return ctx;
+}
+
+void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx)
+{
+	if (!ctx)
+		return;
+
+	erofs_fscache_cleanup_ctx(ctx);
+	kfree(ctx);
+}
+
 int __init erofs_init_fscache(void)
 {
 	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c2608a469107..1f5bc69e8e9f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -97,6 +97,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_fscache_context {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -621,6 +625,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
+struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
+						char *path);
+void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-- 
2.27.0

