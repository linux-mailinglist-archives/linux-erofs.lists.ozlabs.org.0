Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1151F57D
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:41:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY524d7Wz3cKX
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:41:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4w1kmzz3cCk
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:41:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCgwzEf_1652082057; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCgwzEf_1652082057) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:58 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 18/22] erofs: implement fscache-based data read for
 non-inline layout
Date: Mon,  9 May 2022 15:40:24 +0800
Message-Id: <20220509074028.74954-19-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the data plane of reading data from data blobs over fscache
for non-inline layout.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  4 ++++
 fs/erofs/internal.h |  2 ++
 3 files changed, 57 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 23d7e862eed8..b3af72af7c88 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -83,10 +83,61 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	return ret;
 }
 
+static int erofs_fscache_readpage(struct file *file, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio_mapping(folio)->host;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_map_blocks map;
+	struct erofs_map_dev mdev;
+	erofs_off_t pos;
+	loff_t pstart;
+	int ret;
+
+	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
+
+	pos = folio_pos(folio);
+	map.m_la = pos;
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		goto out_unlock;
+
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		folio_zero_range(folio, 0, folio_size(folio));
+		goto out_uptodate;
+	}
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		goto out_unlock;
+
+	pstart = mdev.m_pa + (pos - map.m_la);
+	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+			folio_mapping(folio), folio_pos(folio),
+			folio_size(folio), pstart);
+
+out_uptodate:
+	if (!ret)
+		folio_mark_uptodate(folio);
+out_unlock:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
 	.readpage = erofs_fscache_meta_readpage,
 };
 
+const struct address_space_operations erofs_fscache_access_aops = {
+	.readpage = erofs_fscache_readpage,
+};
+
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e8b37ba5e9ad..8d3f56c6469b 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -297,6 +297,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+	if (erofs_is_fscache_mode(inode->i_sb))
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
 
 out_unlock:
 	erofs_put_metabuf(&buf);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fa488af8dfcf..c8f6ac910976 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -639,6 +639,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+
+extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-- 
2.27.0

