Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98D4CFEC4
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 13:33:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KByYp5C7Vz3bdq
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 23:33:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KByYZ1YQBz3bd8
 for <linux-erofs@lists.ozlabs.org>; Mon,  7 Mar 2022 23:33:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V6VlXz9_1646656410; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V6VlXz9_1646656410) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Mar 2022 20:33:31 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 17/21] erofs: implement fscache-based data read for inline
 layout
Date: Mon,  7 Mar 2022 20:33:01 +0800
Message-Id: <20220307123305.79520-18-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading data from bootstrap blob
file over fscache for inline layout.

For the heading non-inline part, the data plane for non-inline layout is
resued, while only the tail packing part needs special handling.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ff69698948ad..4da148cc4484 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -85,8 +85,9 @@ static int erofs_fscache_readpage_noinline(struct page *page,
 {
 	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
 	/*
-	 * 1) For FLAT_PLAIN layout, the output map.m_la shall be equal to o_la,
-	 * and the output map.m_pa is exactly the physical address of o_la.
+	 * 1) For FLAT_PLAIN and FLAT_INLINE (the heading non tail packing part)
+	 * layout, the output map.m_la shall be equal to o_la, and the output
+	 * map.m_pa is exactly the physical address of o_la.
 	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
 	 * nearest chunk boundary, and the output map.m_pa is actually the
 	 * physical address of this chunk boundary. So we need to recalculate
@@ -97,6 +98,40 @@ static int erofs_fscache_readpage_noinline(struct page *page,
 	return erofs_fscache_read_page(cookie, page, start);
 }
 
+static int erofs_fscache_readpage_inline(struct page *page,
+					 struct erofs_fscache_map *fsmap)
+{
+	struct inode *inode = page->mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_blk_t blknr;
+	size_t offset, len;
+	void *src, *dst;
+
+	/*
+	 * For inline (tail packing) layout, the offset may be non-zero, which
+	 * can be calculated from corresponding physical address directly.
+	 * Currently only flat layout supports inline (FLAT_INLINE), and the
+	 * output map.m_pa is exactly the physical address of o_la in this case.
+	 */
+	offset = erofs_blkoff(fsmap->m_pa);
+	blknr = erofs_blknr(fsmap->m_pa);
+	len = fsmap->m_llen;
+
+	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
+
+	dst = kmap(page);
+	memcpy(dst, src + offset, len);
+	memset(dst + len, 0, PAGE_SIZE - len);
+	kunmap(page);
+
+	erofs_put_metabuf(&buf);
+
+	return 0;
+}
+
 static int erofs_fscache_do_readpage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -126,8 +161,12 @@ static int erofs_fscache_do_readpage(struct page *page)
 	if (ret)
 		return ret;
 
+	if (map.m_flags & EROFS_MAP_META)
+		return erofs_fscache_readpage_inline(page, &fsmap);
+
 	switch (vi->datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
 		return erofs_fscache_readpage_noinline(page, &fsmap);
 	default:
-- 
2.27.0

