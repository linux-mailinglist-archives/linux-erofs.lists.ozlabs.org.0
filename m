Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145E47FD1B
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:56:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyNW1bcvz2ywm
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:56:43 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyNQ5kljz2xBb
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:56:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.xJoRI_1640609699; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.xJoRI_1640609699) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:55:00 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 13/23] erofs: implement fscache-based data read
Date: Mon, 27 Dec 2021 20:54:34 +0800
Message-Id: <20211227125444.21187-14-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading data from bootstrap blob
file over fscache.

Be noted that currently compressed layout is not supported yet.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  6 ++-
 fs/erofs/internal.h |  1 +
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 325f5663836b..bfcec831d58a 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -65,6 +65,97 @@ struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
 	return page;
 }
 
+static inline void do_copy_page(struct page *from, struct page *to,
+				size_t offset, size_t len)
+{
+	char *vfrom, *vto;
+
+	vfrom = kmap_atomic(from);
+	vto = kmap_atomic(to);
+	memcpy(vto, vfrom + offset, len);
+	kunmap_atomic(vto);
+	kunmap_atomic(vfrom);
+}
+
+static int erofs_fscache_do_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct erofs_map_blocks map;
+	erofs_off_t o_la, pa;
+	size_t offset, len;
+	struct page *ipage;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return -EOPNOTSUPP;
+	}
+
+	o_la = page_offset(page);
+	map.m_la = o_la;
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		zero_user(page, 0, PAGE_SIZE);
+		return 0;
+	}
+
+	/*
+	 * 1) For FLAT_PLAIN/FLAT_INLINE layout, the output map.m_la shall be
+	 * equal to o_la, and the output map.m_pa is exactly the physical
+	 * address of o_la.
+	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
+	 * nearest chunk boundary, and the output map.m_pa is actually the
+	 * physical address of this chunk boundary. So we need to recalculate
+	 * the actual physical address of o_la.
+	 */
+	pa = map.m_pa + o_la - map.m_la;
+
+	ipage = erofs_get_meta_page(sb, erofs_blknr(pa));
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	/*
+	 * @offset refers to the page offset inside @ipage.
+	 * 1) Except for the inline layout, the offset shall all be 0, and @pa
+	 * shall be aligned with EROFS_BLKSIZ in this case. Thus we can
+	 * conveniently get the offset from @pa.
+	 * 2) While for the inline layout, the offset may be non-zero. Since
+	 * currently only flat layout supports inline, we can calculate the
+	 * offset from the corresponding physical address.
+	 */
+	offset = erofs_blkoff(pa);
+	len = min_t(u64, map.m_llen, PAGE_SIZE);
+
+	do_copy_page(ipage, page, offset, len);
+
+	unlock_page(ipage);
+	return 0;
+}
+
+static int erofs_fscache_readpage(struct file *file, struct page *page)
+{
+	int ret;
+
+	ret = erofs_fscache_do_readpage(file, page);
+	if (ret)
+		SetPageError(page);
+	else
+		SetPageUptodate(page);
+
+	unlock_page(page);
+	return ret;
+}
+
+const struct address_space_operations erofs_fscache_access_aops = {
+	.readpage = erofs_fscache_readpage,
+};
+
 static int erofs_fscache_init_cookie(struct erofs_cookie_ctx *ctx, char *path)
 {
 	struct fscache_cookie *cookie;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2345f1de438e..452d147277c4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -299,7 +299,11 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		err = z_erofs_fill_inode(inode);
 		goto out_unlock;
 	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+
+	if (inode->i_sb->s_bdev)
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	else
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 
 out_unlock:
 	unlock_page(page);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 10fb7ef26ddf..f3a1aa429a93 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -357,6 +357,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
+extern const struct address_space_operations erofs_fscache_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
 /*
-- 
2.27.0

