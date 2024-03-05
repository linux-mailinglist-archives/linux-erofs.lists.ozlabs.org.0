Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E787194E
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 10:15:31 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sJJeWO6R;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpqfT3m8lz3dVf
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 20:15:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sJJeWO6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tpqdy6X9Cz2xb2
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 20:15:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630098; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GFDbGG8sHGCt0S8InIcbIqzI0LPCx+wjhzefgM3ZHC8=;
	b=sJJeWO6RHeJJ7W4CDFPENlVB4WF21HfSPgVRkyc67xApg07HMwixiyEBi69jMPFaZJwr8kzNrjxmXP9rx/wFCiO6zZVYTSqlQzAK5dAAnj1R3RXvfsXspFp7aHRSpSRDr7IDcZUFNMsLxYSKzQYIQS6hbTboj/Fc0+HJV4FtotM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGg5_1709630094;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGg5_1709630094)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/6] erofs: convert z_erofs_do_read_page() to folios
Date: Tue,  5 Mar 2024 17:14:44 +0800
Message-Id: <20240305091448.1384242-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
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

It is a straight-forward conversion. Besides, it's renamed as
z_erofs_scan_folio().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5013fcd4965a..c25074657708 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -955,21 +955,20 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 	return 0;
 }
 
-static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page, bool ra)
+static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
+			      struct folio *folio, bool ra)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
-	const loff_t offset = page_offset(page);
-	const unsigned int bs = i_blocksize(inode);
+	const loff_t offset = folio_pos(folio);
+	const unsigned int bs = i_blocksize(inode), fs = folio_size(folio);
 	bool tight = true, exclusive;
 	unsigned int cur, end, len, split;
 	int err = 0;
 
 	z_erofs_onlinefolio_init(folio);
 	split = 0;
-	end = PAGE_SIZE;
+	end = fs;
 repeat:
 	if (offset + end - 1 < map->m_la ||
 	    offset + end - 1 >= map->m_la + map->m_llen) {
@@ -986,7 +985,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	++split;
 
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
-		zero_user_segment(page, cur, end);
+		folio_zero_segment(folio, cur, end);
 		tight = false;
 		goto next_part;
 	}
@@ -995,8 +994,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		erofs_off_t fpos = offset + cur - map->m_la;
 
 		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
-		err = z_erofs_read_fragment(inode->i_sb, page, cur, cur + len,
-				EROFS_I(inode)->z_fragmentoff + fpos);
+		err = z_erofs_read_fragment(inode->i_sb, &folio->page, cur,
+			cur + len, EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		tight = false;
@@ -1011,18 +1010,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	}
 
 	/*
-	 * Ensure the current partial page belongs to this submit chain rather
+	 * Ensure the current partial folio belongs to this submit chain rather
 	 * than other concurrent submit chains or the noio(bypass) chain since
-	 * those chains are handled asynchronously thus the page cannot be used
+	 * those chains are handled asynchronously thus the folio cannot be used
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
-	exclusive = (!cur && ((split <= 1) || (tight && bs == PAGE_SIZE)));
+	exclusive = (!cur && ((split <= 1) || (tight && bs == fs)));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
-					.page = page,
+					.page = &folio->page,
 					.offset = offset - map->m_la,
 					.end = end,
 				  }), exclusive);
@@ -1789,7 +1788,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page))
 				unlock_page(page);
 			else
-				(void)z_erofs_do_read_page(f, page, !!rac);
+				z_erofs_scan_folio(f, page_folio(page), !!rac);
 			put_page(page);
 		}
 
@@ -1810,7 +1809,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, &folio->page, false);
+	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
@@ -1851,7 +1850,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		folio = head;
 		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, &folio->page, true);
+		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
 			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
 				  folio->index, EROFS_I(inode)->nid);
-- 
2.39.3

