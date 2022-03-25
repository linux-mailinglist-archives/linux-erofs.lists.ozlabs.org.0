Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD84E7312
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 13:23:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQ1T46PrWz30Gk
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 23:23:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQ1Sz50F7z3Wtr
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Mar 2022 23:22:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V89aFtZ_1648210968; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V89aFtZ_1648210968) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 25 Mar 2022 20:22:49 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 16/22] erofs: implement fscache-based metadata read
Date: Fri, 25 Mar 2022 20:22:17 +0800
Message-Id: <20220325122223.102958-17-jefflexu@linux.alibaba.com>
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

Implements the data plane of reading metadata from bootstrap blob file
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 17 +++++++++++++++--
 fs/erofs/fscache.c  | 34 ++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 ++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6e2a28242453..b4571bea93d5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -31,15 +31,28 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
-	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
+		if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
+		    erofs_is_nodev_mode(sb)) {
+			struct folio *folio;
+
+			folio = erofs_fscache_get_folio(sbi->bootstrap, index);
+			if (IS_ERR(folio))
+				page = (struct page *)folio;
+			else
+				page = folio_page(folio, 0);
+		} else {
+			mapping = sb->s_bdev->bd_inode->i_mapping;
+			page = read_cache_page_gfp(mapping, index,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		}
 		if (IS_ERR(page))
 			return page;
 		/* should already be PageUptodate, no need to lock page */
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 6a55f7b5f883..91377939b4f7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -46,9 +46,43 @@ static inline int erofs_fscache_read_folio(struct fscache_cookie *cookie,
 					 pstart);
 }
 
+static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
+{
+	int ret;
+	struct erofs_fscache *ctx = (struct erofs_fscache *)data;
+	struct folio *folio = page_folio(page);
+
+	ret = erofs_fscache_read_folio(ctx->cookie, folio, folio_pos(folio));
+	if (!ret)
+		folio_mark_uptodate(folio);
+
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
+	.readpage = erofs_fscache_readpage_blob,
 };
 
+/*
+ * erofs_fscache_get_folio - find and read page cache of blob file
+ * @ctx:	the context of the blob file
+ * @index:	the page index
+ *
+ * Get the page cache of the blob file at the index offset. It will find the
+ * page through the address space of the anonymous inode. This function is only
+ * used to read page cache of bootstrap blob file (metadata), since currently
+ * only bootstrap blob file manages an anonymous inode inside the fscache
+ * context.
+ *
+ * Return: up to date page on success, ERR_PTR() on failure.
+ */
+struct folio *erofs_fscache_get_folio(struct erofs_fscache *ctx, pgoff_t index)
+{
+	DBG_BUGON(!ctx->inode);
+	return read_mapping_folio(ctx->inode->i_mapping, index, ctx);
+}
+
 static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
 {
 	struct fscache_cookie *cookie;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d8c886a7491e..fa89a1e3012f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -632,6 +632,8 @@ void erofs_exit_fscache(void);
 struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
 					bool need_inode);
 void erofs_fscache_put(struct erofs_fscache *ctx);
+
+struct folio *erofs_fscache_get_folio(struct erofs_fscache *ctx, pgoff_t index);
 #else
 static inline int erofs_init_fscache(void) { return 0; }
 static inline void erofs_exit_fscache(void) {}
@@ -643,6 +645,12 @@ static inline struct erofs_fscache *erofs_fscache_get(struct super_block *sb,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline void erofs_fscache_put(struct erofs_fscache *ctx) {}
+
+static inline struct folio *erofs_fscache_get_folio(struct erofs_fscache *ctx,
+						    pgoff_t index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

