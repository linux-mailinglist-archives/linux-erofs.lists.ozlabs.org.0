Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037547FCFB
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:55:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyMD5t4cz3bXv
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:55:36 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyM40fMwz2yms
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:55:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.vxTJW_1640609698; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.vxTJW_1640609698) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:59 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 12/23] erofs: implement fscache-based metadata read
Date: Mon, 27 Dec 2021 20:54:33 +0800
Message-Id: <20211227125444.21187-13-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading metadata from bootstrap
blob file over fscache.

Be noted that currently it only supports the scenario where the backing
file has no hole. Once it hits a hole of the backing file, erofs will
fail the IO with -EOPNOTSUPP for now. The following patch will fix this
issue, i.e. implementing the demand reading mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     |  4 +--
 fs/erofs/fscache.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  7 ++----
 4 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 61fa431d0713..f0857c285fac 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -19,8 +19,8 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 		page = read_cache_page_gfp(mapping, blkaddr,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
 	} else {
-		/* TODO: data path in nodev mode */
-		page = ERR_PTR(-EINVAL);
+		page = erofs_readpage_from_fscache(EROFS_SB(sb)->bootstrap,
+						   blkaddr);
 	}
 
 	/* should already be PageUptodate */
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4dfca7c95710..325f5663836b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,65 @@
 
 static struct fscache_volume *volume;
 
+static int erofs_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	return fscache_begin_read_operation(&rreq->cache_resources,
+					    rreq->netfs_priv);
+}
+
+static void erofs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
+{
+}
+
+static void erofs_issue_op(struct netfs_read_subrequest *subreq)
+{
+	/*
+	 * TODO: implement demand-read logic later.
+	 * We rely on user daemon to prepare blob files under corresponding
+	 * directory, and we can reach here if blob files don't exist.
+	 */
+
+	netfs_subreq_terminated(subreq, -EOPNOTSUPP, false);
+}
+
+const struct netfs_read_request_ops erofs_req_ops = {
+	.begin_cache_operation  = erofs_begin_cache_operation,
+	.cleanup		= erofs_priv_cleanup,
+	.issue_op		= erofs_issue_op,
+};
+
+struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
+					 pgoff_t index)
+{
+	struct folio *folio;
+	struct page *page;
+	struct super_block *sb = ctx->inode->i_sb;
+	int ret;
+
+	page = find_or_create_page(ctx->inode->i_mapping, index, GFP_KERNEL);
+	if (unlikely(!page)) {
+		erofs_err(sb, "failed to allocate page");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* The content is already buffered in the address space */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		return page;
+	}
+
+	/* Or a new page cache is created, then read the content from fscache */
+	folio = page_folio(page);
+
+	ret = netfs_readpage(NULL, folio, &erofs_req_ops, ctx->cookie);
+	if (unlikely(ret || !PageUptodate(page))) {
+		erofs_err(sb, "failed to read from fscache");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return page;
+}
+
 static int erofs_fscache_init_cookie(struct erofs_cookie_ctx *ctx, char *path)
 {
 	struct fscache_cookie *cookie;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ee4ff6774ba..10fb7ef26ddf 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -585,6 +585,9 @@ struct erofs_cookie_ctx *erofs_fscache_get_ctx(struct super_block *sb,
 					       char *path);
 void erofs_fscache_put_ctx(struct erofs_cookie_ctx *ctx);
 
+struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
+					 pgoff_t index);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 141cabd01d32..0e5964d8b24b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -334,25 +334,22 @@ static int erofs_init_devices(struct super_block *sb,
 
 static int erofs_read_superblock(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct page *page;
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	void *data;
 	int ret;
 
-	/* TODO: metadata path in nodev mode */
 	if (sb->s_bdev)
 		page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
 	else
-		page = ERR_PTR(-EOPNOTSUPP);
+		page = erofs_readpage_from_fscache(sbi->bootstrap, 0);
 	if (IS_ERR(page)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(page);
 	}
 
-	sbi = EROFS_SB(sb);
-
 	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
-- 
2.27.0

