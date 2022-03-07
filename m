Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4254CFECD
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 13:33:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KByYv546Jz3bpL
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 23:33:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KByYg19JZz3bh9
 for <linux-erofs@lists.ozlabs.org>; Mon,  7 Mar 2022 23:33:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R631e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V6VlXzk_1646656415; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V6VlXzk_1646656415) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Mar 2022 20:33:36 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 20/21] erofs: implement fscache-based data readahead
Date: Mon,  7 Mar 2022 20:33:04 +0800
Message-Id: <20220307123305.79520-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

This patch implements fscache-based data readahead. Also registers an
individual bdi for each erofs instance to enable readahead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c   |   4 ++
 2 files changed, 157 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 89c533ad965e..19f44ee01852 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -10,6 +10,13 @@ struct erofs_fscache_map {
 	u64 m_llen;
 };
 
+struct erofs_fscahce_ra_ctx {
+	struct readahead_control *rac;
+	struct address_space *mapping;
+	loff_t start;
+	size_t len, done;
+};
+
 static struct fscache_volume *volume;
 
 /*
@@ -199,12 +206,158 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+static inline size_t erofs_fscache_calc_len(struct erofs_fscahce_ra_ctx *ractx,
+					    struct erofs_fscache_map *fsmap)
+{
+	/*
+	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
+	 * nearest chunk boundary, and the output m_llen actually starts from
+	 * the start of the containing chunk.
+	 * 2) For other cases, the output m_la is equal to o_la.
+	 */
+	size_t len = fsmap->m_llen - (fsmap->o_la - fsmap->m_la);
+
+	return min_t(size_t, len, ractx->len - ractx->done);
+}
+
+static inline void erofs_fscache_unlock_pages(struct readahead_control *rac,
+					      size_t len)
+{
+	while (len) {
+		struct page *page = readahead_page(rac);
+
+		SetPageUptodate(page);
+		unlock_page(page);
+		put_page(page);
+
+		len -= PAGE_SIZE;
+	}
+}
+
+static int erofs_fscache_ra_hole(struct erofs_fscahce_ra_ctx *ractx,
+				 struct erofs_fscache_map *fsmap)
+{
+	struct iov_iter iter;
+	loff_t start = ractx->start + ractx->done;
+	size_t length = erofs_fscache_calc_len(ractx, fsmap);
+
+	iov_iter_xarray(&iter, READ, &ractx->mapping->i_pages, start, length);
+	iov_iter_zero(length, &iter);
+
+	erofs_fscache_unlock_pages(ractx->rac, length);
+	return length;
+}
+
+static int erofs_fscache_ra_noinline(struct erofs_fscahce_ra_ctx *ractx,
+				     struct erofs_fscache_map *fsmap)
+{
+	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
+	loff_t start = ractx->start + ractx->done;
+	size_t length = erofs_fscache_calc_len(ractx, fsmap);
+	loff_t pstart = fsmap->m_pa + (fsmap->o_la - fsmap->m_la);
+	int ret;
+
+	ret = erofs_fscache_read_pages(cookie, ractx->mapping,
+				       start, length, pstart);
+	if (!ret) {
+		erofs_fscache_unlock_pages(ractx->rac, length);
+		ret = length;
+	}
+
+	return ret;
+}
+
+static int erofs_fscache_ra_inline(struct erofs_fscahce_ra_ctx *ractx,
+				   struct erofs_fscache_map *fsmap)
+{
+	struct page *page = readahead_page(ractx->rac);
+	int ret;
+
+	ret = erofs_fscache_readpage_inline(page, fsmap);
+	if (!ret) {
+		SetPageUptodate(page);
+		ret = PAGE_SIZE;
+	}
+
+	unlock_page(page);
+	put_page(page);
+	return ret;
+}
+
+static void erofs_fscache_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct erofs_fscahce_ra_ctx ractx;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return;
+	}
+
+	if (!readahead_count(rac))
+		return;
+
+	ractx = (struct erofs_fscahce_ra_ctx) {
+		.rac = rac,
+		.mapping = rac->mapping,
+		.start = readahead_pos(rac),
+		.len = readahead_length(rac),
+	};
+
+	do {
+		struct erofs_map_blocks map;
+		struct erofs_fscache_map fsmap;
+
+		map.m_la = fsmap.o_la = ractx.start + ractx.done;
+
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+		if (ret)
+			return;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			/*
+			 * Two cases will hit this:
+			 * 1) EOF. Imposibble in readahead routine;
+			 * 2) hole. Only CHUNK_BASED layout supports hole.
+			 */
+			fsmap.m_la   = map.m_la;
+			fsmap.m_llen = map.m_llen;
+			ret = erofs_fscache_ra_hole(&ractx, &fsmap);
+			continue;
+		}
+
+		ret = erofs_fscache_get_map(&fsmap, &map, sb);
+		if (ret)
+			return;
+
+		if (map.m_flags & EROFS_MAP_META) {
+			ret = erofs_fscache_ra_inline(&ractx, &fsmap);
+			continue;
+		}
+
+		switch (vi->datalayout) {
+		case EROFS_INODE_FLAT_PLAIN:
+		case EROFS_INODE_FLAT_INLINE:
+		case EROFS_INODE_CHUNK_BASED:
+			ret = erofs_fscache_ra_noinline(&ractx, &fsmap);
+			break;
+		default:
+			DBG_BUGON(1);
+			return;
+		}
+	} while (ret > 0 && ((ractx.done += ret) < ractx.len));
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 	.readpage = erofs_fscache_readpage_blob,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
 	.readpage = erofs_fscache_readpage,
+	.readahead = erofs_fscache_readahead,
 };
 
 struct page *erofs_fscache_read_cache_page(struct erofs_fscache_context *ctx,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f058a04a00c7..2942029a7049 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -616,6 +616,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return PTR_ERR(bootstrap);
 
 		sbi->bootstrap = bootstrap;
+
+		err = super_setup_bdi(sb);
+		if (err)
+			return err;
 	}
 
 	err = erofs_read_superblock(sb);
-- 
2.27.0

