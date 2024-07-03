Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44360925F7E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:01:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jx/m8Coi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdfJ6gS9z3dBZ
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:01:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jx/m8Coi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdf85Ykyz3cZy
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:01:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008059; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1i4erAiWQKdAm3mPcp8cVYibLOdhqUaMMMiBWx4rFII=;
	b=Jx/m8Coi7SM//iSh9IJKT90JUpKWobcUauF0xWPZeRCe9y4OGaI2xJYX7kDkdGRaFZB97dy5KsgEXMxSIhMvpZ1k2vnRcAsAatpGRquadxd5yEstzWrvguETYSF9PxP/B4kprBjkJuuzerNvFCN15NLNqa9JYJt4LA3FH4ySe6A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOML_1720008057;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOML_1720008057)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:00:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs: convert z_erofs_read_fragment() to folios
Date: Wed,  3 Jul 2024 20:00:49 +0800
Message-ID: <20240703120051.3653452-2-hsiangkao@linux.alibaba.com>
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

Just a straight-forward conversion.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 14cf96fcefe4..4b1715d8c122 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -925,7 +925,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	fe->pcl = NULL;
 }
 
-static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
+static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 			unsigned int cur, unsigned int end, erofs_off_t pos)
 {
 	struct inode *packed_inode = EROFS_SB(sb)->packed_inode;
@@ -938,14 +938,13 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 
 	buf.mapping = packed_inode->i_mapping;
 	for (; cur < end; cur += cnt, pos += cnt) {
-		cnt = min_t(unsigned int, end - cur,
-			    sb->s_blocksize - erofs_blkoff(sb, pos));
+		cnt = min(end - cur, sb->s_blocksize - erofs_blkoff(sb, pos));
 		src = erofs_bread(&buf, pos, EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
-		memcpy_to_page(page, cur, src, cnt);
+		memcpy_to_folio(folio, cur, src, cnt);
 	}
 	erofs_put_metabuf(&buf);
 	return 0;
@@ -959,7 +958,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
 	const loff_t offset = folio_pos(folio);
 	const unsigned int bs = i_blocksize(inode), fs = folio_size(folio);
 	bool tight = true, exclusive;
-	unsigned int cur, end, len, split;
+	unsigned int cur, end, split;
 	int err = 0;
 
 	z_erofs_onlinefolio_init(folio);
@@ -989,9 +988,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
 		erofs_off_t fpos = offset + cur - map->m_la;
 
-		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
-		err = z_erofs_read_fragment(inode->i_sb, &folio->page, cur,
-			cur + len, EROFS_I(inode)->z_fragmentoff + fpos);
+		err = z_erofs_read_fragment(inode->i_sb, folio, cur,
+				cur + min(map->m_llen - fpos, end - cur),
+				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		tight = false;
-- 
2.43.5

