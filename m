Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C16AF77F219
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ7F56c6z3cNP
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ723cGPz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R.b_1692260902;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R.b_1692260902)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/8] erofs: move preparation logic into z_erofs_pcluster_begin()
Date: Thu, 17 Aug 2023 16:28:08 +0800
Message-Id: <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Some preparation logic should be part of z_erofs_pcluster_begin()
instead of z_erofs_do_read_page().  Let's move now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 59 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4ed99346c4e1..30ecdfe41836 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -852,7 +852,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
+	struct super_block *sb = fe->inode->i_sb;
+	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct erofs_workgroup *grp = NULL;
+	void *mptr;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -861,8 +864,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
-		grp = erofs_find_workgroup(fe->inode->i_sb,
-					   map->m_pa >> PAGE_SHIFT);
+		grp = erofs_find_workgroup(sb, blknr);
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
@@ -881,9 +883,24 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	} else if (ret) {
 		return ret;
 	}
+
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
-	/* since file-backed online pages are traversed in reverse order */
+	if (!z_erofs_is_inline_pcluster(fe->pcl)) {
+		/* bind cache first when cached decompression is preferred */
+		z_erofs_bind_cache(fe);
+	} else {
+		mptr = erofs_read_metabuf(&map->buf, sb, blknr, EROFS_NO_KMAP);
+		if (IS_ERR(mptr)) {
+			ret = PTR_ERR(mptr);
+			erofs_err(sb, "failed to get inline data %d", ret);
+			return ret;
+		}
+		get_page(map->buf.page);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
+	}
+	/* file-backed inplace I/O pages are traversed in reverse order */
 	fe->icur = z_erofs_pclusterpages(fe->pcl);
 	return 0;
 }
@@ -982,39 +999,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		err = z_erofs_map_blocks_iter(inode, map, 0);
 		if (err)
 			goto out;
-	} else {
-		if (fe->pcl)
-			goto hitted;
-		/* didn't get a valid pcluster previously (very rare) */
-	}
-
-	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
-	    map->m_flags & EROFS_MAP_FRAGMENT)
+	} else if (fe->pcl) {
 		goto hitted;
+	}
 
-	err = z_erofs_pcluster_begin(fe);
-	if (err)
-		goto out;
-
-	if (z_erofs_is_inline_pcluster(fe->pcl)) {
-		void *mp;
-
-		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
-					erofs_blknr(inode->i_sb, map->m_pa),
-					EROFS_NO_KMAP);
-		if (IS_ERR(mp)) {
-			err = PTR_ERR(mp);
-			erofs_err(inode->i_sb,
-				  "failed to get inline page, err %d", err);
+	if ((map->m_flags & EROFS_MAP_MAPPED) &&
+	    !(map->m_flags & EROFS_MAP_FRAGMENT)) {
+		err = z_erofs_pcluster_begin(fe);
+		if (err)
 			goto out;
-		}
-		get_page(fe->map.buf.page);
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
-			   fe->map.buf.page);
-		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
-	} else {
-		/* bind cache first when cached decompression is preferred */
-		z_erofs_bind_cache(fe);
 	}
 hitted:
 	/*
-- 
2.24.4

