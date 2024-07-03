Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A30925F84
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:01:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eS4QPytZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdfm16n2z3dHD
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:01:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eS4QPytZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdf93VJkz3cy9
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:01:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008060; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OzCqu1lyuJFA8btdlv52F8u+PmYpJe3BF+hgo4L6GXc=;
	b=eS4QPytZ6fzshbpEW8+0KdO+G6g/NjGxaa3VqqGY8TuoxQ42sD+9uMcwEFP0cvgjjvXzpN9U1Limclm13MCLFJO4bmtwWd7uYSI7Okam5lNyaTBNISE40A33xK+iJaeDIPm4YU0lkr6v4G2zIfX23LxUcQuHUmOkk7ltCjLmn7o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOMh_1720008058;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOMh_1720008058)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:00:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs: teach z_erofs_scan_folios() to handle multi-page folios
Date: Wed,  3 Jul 2024 20:00:50 +0800
Message-ID: <20240703120051.3653452-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
References: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
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

Previously, a folio just contains one page.  In order to enable large
folios, z_erofs_scan_folios() needs to handle multi-page folios.

First, this patch eliminates all gotos.  Instead, the new loop deal
with multiple parts in each folio.  It's simple to handle the parts
which belong to unmapped extents or fragment extents; but for encoded
extents, the page boundaries needs to be considered for `tight` and
`split` to keep inplace I/Os work correctly: when a part crosses the
page boundary, they needs to be reseted properly.

Besides, simplify `tight` derivation since Z_EROFS_PCLUSTER_HOOKED
has been removed for quite a while.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 167 +++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 85 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4b1715d8c122..cb017ca2c7e3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -950,100 +950,97 @@ static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 	return 0;
 }
 
-static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
+static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			      struct folio *folio, bool ra)
 {
-	struct inode *const inode = fe->inode;
-	struct erofs_map_blocks *const map = &fe->map;
+	struct inode *const inode = f->inode;
+	struct erofs_map_blocks *const map = &f->map;
 	const loff_t offset = folio_pos(folio);
-	const unsigned int bs = i_blocksize(inode), fs = folio_size(folio);
-	bool tight = true, exclusive;
-	unsigned int cur, end, split;
-	int err = 0;
+	const unsigned int bs = i_blocksize(inode);
+	unsigned int end = folio_size(folio), split = 0, cur, pgs;
+	bool tight, excl;
+	int err;
 
+	tight = (bs == PAGE_SIZE);
 	z_erofs_onlinefolio_init(folio);
-	split = 0;
-	end = fs;
-repeat:
-	if (offset + end - 1 < map->m_la ||
-	    offset + end - 1 >= map->m_la + map->m_llen) {
-		z_erofs_pcluster_end(fe);
-		map->m_la = offset + end - 1;
-		map->m_llen = 0;
-		err = z_erofs_map_blocks_iter(inode, map, 0);
-		if (err)
-			goto out;
-	}
-
-	cur = offset > map->m_la ? 0 : map->m_la - offset;
-	/* bump split parts first to avoid several separate cases */
-	++split;
-
-	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
-		folio_zero_segment(folio, cur, end);
-		tight = false;
-		goto next_part;
-	}
-
-	if (map->m_flags & EROFS_MAP_FRAGMENT) {
-		erofs_off_t fpos = offset + cur - map->m_la;
+	do {
+		if (offset + end - 1 < map->m_la ||
+		    offset + end - 1 >= map->m_la + map->m_llen) {
+			z_erofs_pcluster_end(f);
+			map->m_la = offset + end - 1;
+			map->m_llen = 0;
+			err = z_erofs_map_blocks_iter(inode, map, 0);
+			if (err)
+				break;
+		}
 
-		err = z_erofs_read_fragment(inode->i_sb, folio, cur,
-				cur + min(map->m_llen - fpos, end - cur),
-				EROFS_I(inode)->z_fragmentoff + fpos);
-		if (err)
-			goto out;
-		tight = false;
-		goto next_part;
-	}
+		cur = offset > map->m_la ? 0 : map->m_la - offset;
+		pgs = round_down(cur, PAGE_SIZE);
+		/* bump split parts first to avoid several separate cases */
+		++split;
+
+		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			folio_zero_segment(folio, cur, end);
+			tight = false;
+		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+			erofs_off_t fpos = offset + cur - map->m_la;
+
+			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
+					cur + min(map->m_llen - fpos, end - cur),
+					EROFS_I(inode)->z_fragmentoff + fpos);
+			if (err)
+				break;
+			tight = false;
+		} else {
+			if (!f->pcl) {
+				err = z_erofs_pcluster_begin(f);
+				if (err)
+					break;
+				f->pcl->besteffort |= !ra;
+			}
 
-	if (!fe->pcl) {
-		err = z_erofs_pcluster_begin(fe);
-		if (err)
-			goto out;
-		fe->pcl->besteffort |= !ra;
-	}
+			pgs = round_down(end - 1, PAGE_SIZE);
+			/*
+			 * Ensure this partial page belongs to this submit chain
+			 * rather than other concurrent submit chains or
+			 * noio(bypass) chains since those chains are handled
+			 * asynchronously thus it cannot be used for inplace I/O
+			 * or bvpage (should be processed in the strict order.)
+			 */
+			tight &= (f->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
+			excl = false;
+			if (cur <= pgs) {
+				excl = (split <= 1) || tight;
+				cur = pgs;
+			}
 
-	/*
-	 * Ensure the current partial folio belongs to this submit chain rather
-	 * than other concurrent submit chains or the noio(bypass) chain since
-	 * those chains are handled asynchronously thus the folio cannot be used
-	 * for inplace I/O or bvpage (should be processed in a strict order.)
-	 */
-	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
-	exclusive = (!cur && ((split <= 1) || (tight && bs == fs)));
-	if (cur)
-		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
-
-	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
-					.page = &folio->page,
-					.offset = offset - map->m_la,
-					.end = end,
-				  }), exclusive);
-	if (err)
-		goto out;
-
-	z_erofs_onlinefolio_split(folio);
-	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
-		fe->pcl->multibases = true;
-	if (fe->pcl->length < offset + end - map->m_la) {
-		fe->pcl->length = offset + end - map->m_la;
-		fe->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
-	}
-	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
-	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
-	    fe->pcl->length == map->m_llen)
-		fe->pcl->partial = false;
-next_part:
-	/* shorten the remaining extent to update progress */
-	map->m_llen = offset + cur - map->m_la;
-	map->m_flags &= ~EROFS_MAP_FULL_MAPPED;
-
-	end = cur;
-	if (end > 0)
-		goto repeat;
+			err = z_erofs_attach_page(f, &((struct z_erofs_bvec) {
+				.page = folio_page(folio, pgs >> PAGE_SHIFT),
+				.offset = offset + pgs - map->m_la,
+				.end = end - pgs, }), excl);
+			if (err)
+				break;
 
-out:
+			z_erofs_onlinefolio_split(folio);
+			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
+				f->pcl->multibases = true;
+			if (f->pcl->length < offset + end - map->m_la) {
+				f->pcl->length = offset + end - map->m_la;
+				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
+			}
+			if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
+			    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
+			    f->pcl->length == map->m_llen)
+				f->pcl->partial = false;
+		}
+		/* shorten the remaining extent to update progress */
+		map->m_llen = offset + cur - map->m_la;
+		map->m_flags &= ~EROFS_MAP_FULL_MAPPED;
+		if (cur <= pgs) {
+			split = cur < pgs;
+			tight = (bs == PAGE_SIZE);
+		}
+	} while ((end = cur) > 0);
 	z_erofs_onlinefolio_end(folio, err);
 	return err;
 }
-- 
2.43.5

