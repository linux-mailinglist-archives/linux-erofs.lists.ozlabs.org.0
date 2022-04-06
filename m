Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9C4F5717
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Apr 2022 09:57:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYH0Z4NGfz3bpY
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Apr 2022 17:57:02 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYH0M38pQz3bZB
 for <linux-erofs@lists.ozlabs.org>; Wed,  6 Apr 2022 17:56:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R611e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V9L3PF9_1649231800; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9L3PF9_1649231800) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 15:56:41 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 18/20] erofs: implement fscache-based data read for inline
 layout
Date: Wed,  6 Apr 2022 15:56:10 +0800
Message-Id: <20220406075612.60298-19-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
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

Implement the data plane of reading data from data blobs over fscache
for inline layout.

For the heading non-inline part, the data plane for non-inline layout is
reused, while only the tail packing part needs special handling.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 65de1c754e80..d32cb5840c6d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -60,6 +60,40 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	return ret;
 }
 
+static int erofs_fscache_readpage_inline(struct folio *folio,
+					 struct erofs_map_blocks *map)
+{
+	struct inode *inode = folio_file_mapping(folio)->host;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_blk_t blknr;
+	size_t offset, len;
+	void *src, *dst;
+
+	/*
+	 * For inline (tail packing) layout, the offset may be non-zero, which
+	 * can be calculated from corresponding physical address directly.
+	 */
+	offset = erofs_blkoff(map->m_pa);
+	blknr = erofs_blknr(map->m_pa);
+	len = map->m_llen;
+
+	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
+
+	DBG_BUGON(folio_size(folio) != PAGE_SIZE);
+
+	dst = kmap(folio_page(folio, 0));
+	memcpy(dst, src + offset, len);
+	memset(dst + len, 0, PAGE_SIZE - len);
+	kunmap(folio_page(folio, 0));
+
+	erofs_put_metabuf(&buf);
+
+	return 0;
+}
+
 static int erofs_fscache_readpage(struct file *file, struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -85,6 +119,12 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 		goto out_uptodate;
 	}
 
+	/* inline readpage */
+	if (map.m_flags & EROFS_MAP_META) {
+		ret = erofs_fscache_readpage_inline(folio, &map);
+		goto out_uptodate;
+	}
+
 	/* no-inline readpage */
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
-- 
2.27.0

