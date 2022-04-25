Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA550E001
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 14:22:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kn4095xnGz3bwT
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 22:22:33 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kn40065j7z3bdZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Apr 2022 22:22:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VBDrnYz_1650889331; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VBDrnYz_1650889331) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Apr 2022 20:22:12 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v10 17/21] erofs: implement fscache-based metadata read
Date: Mon, 25 Apr 2022 20:21:39 +0800
Message-Id: <20220425122143.56815-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
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
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the data plane of reading metadata from primary data blob
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c    | 19 +++++++++++++++----
 fs/erofs/fscache.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 14b64d960541..bb9c1fd48c19 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -6,6 +6,7 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
+#include <linux/sched/mm.h>
 #include <linux/dax.h>
 #include <trace/events/erofs.h>
 
@@ -35,14 +36,20 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
+	struct folio *folio;
+	unsigned int nofs_flag;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
-				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (IS_ERR(page))
-			return page;
+
+		nofs_flag = memalloc_nofs_save();
+		folio = read_cache_folio(mapping, index, NULL, NULL);
+		memalloc_nofs_restore(nofs_flag);
+		if (IS_ERR(folio))
+			return folio;
+
 		/* should already be PageUptodate, no need to lock page */
+		page = folio_file_page(folio, index);
 		buf->page = page;
 	}
 	if (buf->kmap_type == EROFS_NO_KMAP) {
@@ -63,6 +70,10 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	if (erofs_is_fscache_mode(sb))
+		return erofs_bread(buf, EROFS_SB(sb)->s_fscache->inode,
+				   blkaddr, type);
+
 	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ac02af8cce3e..23d7e862eed8 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -59,7 +59,32 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
 	return ret;
 }
 
+static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
+{
+	int ret;
+	struct folio *folio = page_folio(page);
+	struct super_block *sb = folio_mapping(folio)->host->i_sb;
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
+			folio_mapping(folio), folio_pos(folio),
+			folio_size(folio), mdev.m_pa);
+	if (!ret)
+		folio_mark_uptodate(folio);
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
+	.readpage = erofs_fscache_meta_readpage,
 };
 
 int erofs_fscache_register_cookie(struct super_block *sb,
-- 
2.27.0

