Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DA47FD1C
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:56:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyNX28RCz305P
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:56:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyMx5vCxz2xMw
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:56:12 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.wf8ne_1640609695; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.wf8ne_1640609695) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:55 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 09/23] erofs: add cookie context helper functions
Date: Mon, 27 Dec 2021 20:54:30 +0800
Message-Id: <20211227125444.21187-10-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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

Introduce 'struct erofs_cookie_ctx' for managing cookie for backing
file, and the following introduced API for reading from backing file.

Besides, introduce two helper functions for initializing and cleaning
up erofs_cookie_ctx.

struct erofs_cookie_ctx *
erofs_fscache_get_ctx(struct super_block *sb, char *path);

void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 75 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 +++++
 2 files changed, 83 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index cdbbe3f15a20..15c5bb0f8ea5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,81 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_fscache_init_cookie(struct erofs_cookie_ctx *ctx, char *path)
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
+static void erofs_fscache_cleanup_cookie(struct erofs_cookie_ctx *ctx)
+{
+	struct fscache_cookie *cookie = ctx->cookie;
+
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
+	ctx->cookie = NULL;
+}
+
+static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
+				  struct super_block *sb, char *path)
+{
+	int ret;
+
+	ret = erofs_fscache_init_cookie(ctx, path);
+	if (ret) {
+		erofs_err(sb, "failed to init cookie\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void erofs_fscache_cleanup_ctx(struct erofs_cookie_ctx *ctx)
+{
+	erofs_fscache_cleanup_cookie(ctx);
+}
+
+struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
+					       char *path)
+{
+	struct erofs_cookie_ctx *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ret = erofs_fscahce_init_ctx(ctx, sb, path);
+	if (ret) {
+		kfree(ctx);
+		return ERR_PTR(ret);
+	}
+
+	return ctx;
+}
+
+void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	erofs_fscache_cleanup_ctx(ctx);
+	kfree(ctx);
+}
+
 int __init erofs_fscache_init(void)
 {
 	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d464642e9d35..4179c3dcb7f9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -91,6 +91,10 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_cookie_ctx {
+	struct fscache_cookie *cookie;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -574,6 +578,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_init(void);
 void erofs_fscache_cleanup(void);
 
+struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
+					       char *path);
+void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
-- 
2.27.0

