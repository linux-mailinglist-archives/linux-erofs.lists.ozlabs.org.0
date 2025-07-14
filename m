Return-Path: <linux-erofs+bounces-612-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19211B03A58
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 11:09:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgc2T6cJQz3bnc;
	Mon, 14 Jul 2025 19:09:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752484161;
	cv=none; b=ky7FSUcisHA/05WznFSlzWYW/ED0EMC1H0mS2kCakqrROXg14idKq+WiL1H5XXOHCxk7FZ9D/QL0rRC/out86UtW7knSggK5DlJ3oDnIUj0eet+KWLP3o2pVUGXYxL+J/vTMZ/VpfmkYFkwzJkOKSD9ykmNOoZmQeVA4xD7scYBqUzkuXgqFpEQ4Pz/afcAClD+PEpyltxbtnvZOMgscqdK8Cz+j/hgqy0KYRpK7q3JuKw/hvwI0l6o51QLlBiu2BkBhYa5glyyFDFOBGoMgrNiKcYfNb959s25sMiV0nqw7kFeAU53dWUErxxNxlDnPiJfBgzYbUN3jrAb9MlRX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752484161; c=relaxed/relaxed;
	bh=6hju1e4Rlp6xKizj0BSYY0eCoMH5DY60nTCownhr7H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmsFZ7mW2HXaFbaIwluhk7M3ms1Q51wNn8O6mKon7bVWZzb+pjjF2JsRW/necHpzJ1e0tvvRMsPjCkDybxKdyDHBlbhSGAQLDr3+Q3ZKD8bShsU2D9lfdWjclyQak9IyYKs6HmGyYWK9kFtpbmjHKh/83qMIP1/VdvcTKR3sP1daCywGle60nYt02xXhV1DYQpZ5yKRVB0BjkPEd61nWHyooIqJ93rz+dZ2POlWNODHisbI784OLA+MGtvNuJSG3G7g+MjiN/m+p3Hy3Ddg7K6ZCGkmdFB5wve99IaMj/2Wqnf2hJ+QpG2uypZTLLm8KZYKzmJ5QcexrVaeM6m90ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Eks2Y6Hc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Eks2Y6Hc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgc2R5v0qz3bmY
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 19:09:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752484154; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6hju1e4Rlp6xKizj0BSYY0eCoMH5DY60nTCownhr7H8=;
	b=Eks2Y6HctGmAUqs/1Svnh2NP2Th69v9DwkO+zvOMSg5R2FYkbTRCOa+BYAOFvU8rjMhpdDW2jao84GmOiAcYnxAxDeXmWWvqrdoKWN6NO2v/li2jkD9G2HR5Fn92W7In173KsRqOP0K4x3wzXAlUgEELjlCHwEUjsBDEkNxqYl0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WissJ6D_1752484148 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 17:09:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: remove need_kmap in erofs_read_metabuf()
Date: Mon, 14 Jul 2025 17:09:06 +0800
Message-ID: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - need_kmap is always true except for a ztailpacking case; thus, just
   open-code that one;

 - The upcoming metadata compression will add a new boolean, so simplify
   this first.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     |  8 ++++----
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  2 +-
 fs/erofs/inode.c    |  8 ++++----
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    |  4 ++--
 fs/erofs/zdata.c    |  5 +++--
 fs/erofs/zmap.c     | 12 ++++++------
 8 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 16e4a6bd9b97..dd7d86809c18 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -65,10 +65,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap)
+			 erofs_off_t offset)
 {
 	erofs_init_metabuf(buf, sb);
-	return erofs_bread(buf, offset, need_kmap);
+	return erofs_bread(buf, offset, true);
 }
 
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
@@ -118,7 +118,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	idx = erofs_read_metabuf(&buf, sb, pos, true);
+	idx = erofs_read_metabuf(&buf, sb, pos);
 	if (IS_ERR(idx)) {
 		err = PTR_ERR(idx);
 		goto out;
@@ -299,7 +299,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa, true);
+		ptr = erofs_read_metabuf(&buf, sb, mdev.m_pa);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 91781718199e..3ee082476c8c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -115,7 +115,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			void *src;
 
 			src = erofs_read_metabuf(&buf, inode->i_sb,
-						 map->m_pa + ofs, true);
+						 map->m_pa + ofs);
 			if (IS_ERR(src)) {
 				err = PTR_ERR(src);
 				break;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 34517ca9df91..9a8ee646e51d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -274,7 +274,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 		size_t size = map.m_llen;
 		void *src;
 
-		src = erofs_read_metabuf(&buf, sb, map.m_pa, true);
+		src = erofs_read_metabuf(&buf, sb, map.m_pa);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a0ae0b4f7b01..47215c5e3385 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -39,10 +39,10 @@ static int erofs_read_inode(struct inode *inode)
 	void *ptr;
 	int err = 0;
 
-	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr));
 	if (IS_ERR(ptr)) {
 		err = PTR_ERR(ptr);
-		erofs_err(sb, "failed to get inode (nid: %llu) page, err %d",
+		erofs_err(sb, "failed to read inode meta block (nid: %llu): %d",
 			  vi->nid, err);
 		goto err_out;
 	}
@@ -78,10 +78,10 @@ static int erofs_read_inode(struct inode *inode)
 
 			memcpy(&copied, dic, gotten);
 			ptr = erofs_read_metabuf(&buf, sb,
-					erofs_pos(sb, blkaddr + 1), true);
+					erofs_pos(sb, blkaddr + 1));
 			if (IS_ERR(ptr)) {
 				err = PTR_ERR(ptr);
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %d",
+				erofs_err(sb, "failed to read inode payload block (nid: %llu): %d",
 					  vi->nid, err);
 				goto err_out;
 			}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06b867d2fc3b..a7699114f6fe 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -385,7 +385,7 @@ void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-			 erofs_off_t offset, bool need_kmap);
+			 erofs_off_t offset);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..bc27fa3bd678 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -141,7 +141,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_deviceslot *dis;
 	struct file *file;
 
-	dis = erofs_read_metabuf(buf, sb, *pos, true);
+	dis = erofs_read_metabuf(buf, sb, *pos);
 	if (IS_ERR(dis))
 		return PTR_ERR(dis);
 
@@ -258,7 +258,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	void *data;
 	int ret;
 
-	data = erofs_read_metabuf(&buf, sb, 0, true);
+	data = erofs_read_metabuf(&buf, sb, 0);
 	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return PTR_ERR(data);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e0240b7b7db..0d1ddd9b15de 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -855,10 +855,11 @@ static int z_erofs_pcluster_begin(struct z_erofs_frontend *fe)
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, false);
+		erofs_init_metabuf(&map->buf, sb);
+		ptr = erofs_bread(&map->buf, map->m_pa, false);
 		if (IS_ERR(ptr)) {
 			ret = PTR_ERR(ptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
+			erofs_err(sb, "failed to get inline folio %d", ret);
 			return ret;
 		}
 		folio_get(page_folio(map->buf.page));
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 312ec54668aa..ff1d0751fc61 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, true);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -146,7 +146,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, true);
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos);
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -530,7 +530,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
@@ -543,7 +543,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			ext = erofs_read_metabuf(&map->buf, sb, pos);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
@@ -563,7 +563,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
 			ext = erofs_read_metabuf(&map->buf, sb,
-						 pos + mid * recsz, true);
+						 pos + mid * recsz);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 
@@ -646,7 +646,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sb, pos, true);
+	h = erofs_read_metabuf(&buf, sb, pos);
 	if (IS_ERR(h)) {
 		err = PTR_ERR(h);
 		goto out_unlock;
-- 
2.43.5


