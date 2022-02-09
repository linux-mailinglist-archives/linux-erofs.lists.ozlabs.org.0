Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435684AEA0B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:06:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtqCG6XHPz30Mn
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:06:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.9;
 helo=out199-9.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com
 [47.90.199.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtqCD1H5hz2x9S
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:06:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zd5nv_1644386493; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zd5nv_1644386493) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:34 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 19/22] erofs: implement fscache-based data readahead for
 hole
Date: Wed,  9 Feb 2022 14:01:05 +0800
Message-Id: <20220209060108.43051-20-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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

Implement fscache-based data readahead. This patch only supports
readahead for hole, while the following patches will handle other cases.

Besides this patch also registers an individual bdi for each erofs
instance, so that readahead can be enabled.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c   |  4 +++
 2 files changed, 87 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c7762e154064..c8a0851230e5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -195,12 +195,95 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+enum erofs_fscache_readahead_type {
+	EROFS_FSCACHE_READAHEAD_TYPE_HOLE,
+};
+
+static int erofs_fscache_do_readahead(struct readahead_control *rac,
+				      struct erofs_fscache_map *fsmap,
+				      enum erofs_fscache_readahead_type type)
+{
+	size_t offset, length, done;
+	struct page *page;
+
+	/*
+	 * 1) For CHUNK_BASED (HOLE), the output map.m_la is rounded down to
+	 *    the nearest chunk boundary, and thus offset will be non-zero.
+	 */
+	offset = fsmap->o_la - fsmap->m_la;
+	length = fsmap->m_llen - offset;
+
+	for (done = 0; done < length; done += PAGE_SIZE) {
+		page = readahead_page(rac);
+		if (!page)
+			break;
+
+		switch (type) {
+		case EROFS_FSCACHE_READAHEAD_TYPE_HOLE:
+			zero_user(page, 0, PAGE_SIZE);
+			break;
+		default:
+			DBG_BUGON(1);
+			return -EINVAL;
+		}
+
+		SetPageUptodate(page);
+		unlock_page(page);
+	}
+
+	return done;
+}
+
+static void erofs_fscache_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	size_t length = readahead_length(rac);
+	struct erofs_map_blocks map;
+	struct erofs_fscache_map fsmap;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return;
+	}
+
+	while (length) {
+		map.m_la = fsmap.o_la = readahead_pos(rac);
+
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+		if (ret)
+			return;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			/* Only CHUNK_BASED layout supports hole. */
+			fsmap.m_la   = map.m_la;
+			fsmap.m_llen = map.m_llen;
+			ret = erofs_fscache_do_readahead(rac, &fsmap,
+					EROFS_FSCACHE_READAHEAD_TYPE_HOLE);
+		} else {
+			switch (vi->datalayout) {
+			default:
+				DBG_BUGON(1);
+				return;
+			}
+		}
+
+		if (ret <= 0)
+			return;
+
+		length -= ret;
+	}
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

