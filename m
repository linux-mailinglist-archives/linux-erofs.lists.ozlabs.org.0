Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A647FD33
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 14:01:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyVV37NPz2yxm
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 00:01:54 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyVR5ggpz2xMF
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 00:01:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.xJoQp_1640609696; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.xJoQp_1640609696) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:57 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 10/23] erofs: add anonymous inode managing page cache of
 blob file
Date: Mon, 27 Dec 2021 20:54:31 +0800
Message-Id: <20211227125444.21187-11-jefflexu@linux.alibaba.com>
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

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 35 +++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 15c5bb0f8ea5..4dfca7c95710 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -34,6 +34,33 @@ static void erofs_fscache_cleanup_cookie(struct erofs_cookie_ctx *ctx)
 	ctx->cookie = NULL;
 }
 
+static const struct address_space_operations erofs_fscache_aops = {
+};
+
+static int erofs_fscache_get_inode(struct erofs_cookie_ctx *ctx,
+				   struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+
+	inode->i_mapping->a_ops = &erofs_fscache_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	ctx->inode = inode;
+	return 0;
+}
+
+static void erofs_fscache_put_inode(struct erofs_cookie_ctx *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
 				  struct super_block *sb, char *path)
 {
@@ -45,12 +72,20 @@ static int erofs_fscahce_init_ctx(struct erofs_cookie_ctx *ctx,
 		return ret;
 	}
 
+	ret = erofs_fscache_get_inode(ctx, sb);
+	if (ret) {
+		erofs_err(sb, "failed to get anonymous inode\n");
+		erofs_fscache_cleanup_cookie(ctx);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void erofs_fscache_cleanup_ctx(struct erofs_cookie_ctx *ctx)
 {
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 }
 
 struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4179c3dcb7f9..2e4f267b37e7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -93,6 +93,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_cookie_ctx {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
-- 
2.27.0

