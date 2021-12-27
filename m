Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5447FD17
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:56:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyMk6NRNz3bSn
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:56:02 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyMh07dbz2yn3
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:55:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.w7GYT_1640609702; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.w7GYT_1640609702) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:55:02 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 15/23] erofs: implement fscache-based data read for data
 blobs
Date: Mon, 27 Dec 2021 20:54:36 +0800
Message-Id: <20211227125444.21187-16-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading data from data blob file
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     |  3 +++
 fs/erofs/fscache.c  | 25 +++++++++++++++++++++++--
 fs/erofs/internal.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f0857c285fac..621769ab5753 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -166,6 +166,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
+	map->m_ctx = EROFS_SB(sb)->bootstrap;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -176,6 +177,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
+		map->m_ctx = dif->ctx;
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices) {
 		down_read(&devs->rwsem);
@@ -192,6 +194,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 				map->m_pa -= startoff;
 				map->m_bdev = dif->bdev;
 				map->m_daxdev = dif->dax_dev;
+				map->m_ctx = dif->ctx;
 				break;
 			}
 		}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bfcec831d58a..7d4f6682e521 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -77,12 +77,24 @@ static inline void do_copy_page(struct page *from, struct page *to,
 	kunmap_atomic(vfrom);
 }
 
+static struct page *erofs_fscache_get_page(struct erofs_cookie_ctx *ctx,
+					   erofs_blk_t blkaddr)
+{
+	struct page *page;
+
+	page = erofs_readpage_from_fscache(ctx, blkaddr);
+	if (!IS_ERR(page))
+		lock_page(page);
+	return page;
+}
+
 static int erofs_fscache_do_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
+	struct erofs_map_dev mdev;
 	erofs_off_t o_la, pa;
 	size_t offset, len;
 	struct page *ipage;
@@ -105,6 +117,15 @@ static int erofs_fscache_do_readpage(struct file *file, struct page *page)
 		return 0;
 	}
 
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+
+	ret = erofs_map_dev(inode->i_sb, &mdev);
+	if (ret)
+		return ret;
+
 	/*
 	 * 1) For FLAT_PLAIN/FLAT_INLINE layout, the output map.m_la shall be
 	 * equal to o_la, and the output map.m_pa is exactly the physical
@@ -114,9 +135,9 @@ static int erofs_fscache_do_readpage(struct file *file, struct page *page)
 	 * physical address of this chunk boundary. So we need to recalculate
 	 * the actual physical address of o_la.
 	 */
-	pa = map.m_pa + o_la - map.m_la;
+	pa = mdev.m_pa + o_la - map.m_la;
 
-	ipage = erofs_get_meta_page(sb, erofs_blknr(pa));
+	ipage = erofs_fscache_get_page(mdev.m_ctx, erofs_blknr(pa));
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f60577a7aade..b21c3751e88d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -447,6 +447,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 struct erofs_map_dev {
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
+	struct erofs_cookie_ctx *m_ctx;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.27.0

