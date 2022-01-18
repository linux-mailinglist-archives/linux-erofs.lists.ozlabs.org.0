Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54534926DA
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jan 2022 14:13:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JdTjq4W8Fz3bN7
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 00:13:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JdTj43sJ3z302S
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jan 2022 00:12:56 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2C5Cov_1642511555; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2C5Cov_1642511555) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Jan 2022 21:12:36 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 16/20] erofs: implement fscache-based data read for inline
 layout
Date: Tue, 18 Jan 2022 21:12:12 +0800
Message-Id: <20220118131216.85338-17-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch implements the data plane of reading data from bootstrap blob
file over fscache for inline layout.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 588c33ab6a90..8c56bd54b2af 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -100,6 +100,45 @@ static int erofs_fscache_readpage_noinline(struct page *page,
 	return netfs_readpage(NULL, folio, &erofs_req_ops, &priv);
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
+	 * For inline (tail packing) layout, the offset may be non-zero, while
+	 * the offset can be calculated from corresponding physical address
+	 * directly.
+	 * Currently only flat layout supports inline (FLAT_INLINE), and the
+	 * output map.m_pa is exactly the physical address of o_la in this case.
+	 */
+	offset = erofs_blkoff(fsmap->m_pa);
+	blknr = erofs_blknr(fsmap->m_pa);
+	len = fsmap->m_llen;
+
+	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+	if (IS_ERR(src)) {
+		SetPageError(page);
+		unlock_page(page);
+		return PTR_ERR(src);
+	}
+
+	dst = kmap(page);
+	memcpy(dst, src + offset, len);
+	kunmap(page);
+
+	erofs_put_metabuf(&buf);
+
+	SetPageUptodate(page);
+	unlock_page(page);
+	return 0;
+}
+
 static int erofs_fscache_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -138,6 +177,8 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_CHUNK_BASED:
 		return erofs_fscache_readpage_noinline(page, &fsmap);
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_fscache_readpage_inline(page, &fsmap);
 	default:
 		DBG_BUGON(1);
 		ret = -EOPNOTSUPP;
-- 
2.27.0

