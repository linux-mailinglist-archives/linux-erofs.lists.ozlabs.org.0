Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DD4ED8DF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 13:58:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KThf54B8pz3c1c
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 22:58:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.16;
 helo=out199-16.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com
 [47.90.199.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KThds590wz305p
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Mar 2022 22:58:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8iijra_1648727896; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8iijra_1648727896) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 31 Mar 2022 19:58:17 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 15/19] erofs: implement fscache-based metadata read
Date: Thu, 31 Mar 2022 19:57:49 +0800
Message-Id: <20220331115753.89431-16-jefflexu@linux.alibaba.com>
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

Implement the data plane of reading metadata from primary data blob
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 20 ++++++++++++++++++--
 fs/erofs/fscache.c  | 38 ++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  9 +++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 14b64d960541..cb8fe299ad67 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -31,15 +31,26 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
-	struct address_space *const mapping = inode->i_mapping;
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
+		if (buf->sb) {
+			struct folio *folio;
+
+			folio = erofs_fscache_get_folio(buf->sb, index);
+			if (IS_ERR(folio))
+				page = ERR_CAST(folio);
+			else
+				page = folio_page(folio, 0);
+		} else {
+			struct address_space *const mapping = inode->i_mapping;
+
+			page = read_cache_page_gfp(mapping, index,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		}
 		if (IS_ERR(page))
 			return page;
 		/* should already be PageUptodate, no need to lock page */
@@ -63,6 +74,11 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	if (erofs_is_fscache_mode(sb)) {
+		buf->sb = sb;
+		return erofs_bread(buf, NULL, blkaddr, type);
+	}
+
 	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d38a6efc8e50..158cc273f8fb 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -34,9 +34,47 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
 	return ret;
 }
 
+static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
+{
+	int ret;
+	struct super_block *sb = (struct super_block *)data;
+	struct folio *folio = page_folio(page);
+	struct erofs_map_dev mdev = {
+		.m_deviceid = 0,
+		.m_pa = folio_pos(folio),
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		goto out;
+
+	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+			folio_file_mapping(folio), folio_pos(folio),
+			folio_size(folio), mdev.m_pa);
+	if (ret)
+		goto out;
+
+	folio_mark_uptodate(folio);
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
+	.readpage = erofs_fscache_meta_readpage,
 };
 
+/*
+ * Get the page cache of data blob at the index offset.
+ * Return: up to date page on success, ERR_PTR() on failure.
+ */
+struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index)
+{
+	struct erofs_fscache *ctx = EROFS_SB(sb)->s_fscache;
+
+	return read_mapping_folio(ctx->inode->i_mapping, index, (void *)sb);
+}
+
 /*
  * Create an fscache context for data blob.
  * Return: 0 on success and allocated fscache context is assigned to @fscache,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 90f7d6286a4f..e186051f0640 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -276,6 +276,7 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
+	struct super_block *sb;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
@@ -639,6 +640,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+
+struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
@@ -653,6 +656,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 {
 }
+
+static inline struct folio *erofs_fscache_get_folio(struct super_block *sb,
+						    pgoff_t index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

