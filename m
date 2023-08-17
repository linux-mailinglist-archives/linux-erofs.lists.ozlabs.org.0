Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B781977F217
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ774Myjz3bh5
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ703fcDz2yhL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9Qw2_1692260894;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9Qw2_1692260894)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Date: Thu, 17 Aug 2023 16:28:06 +0800
Message-Id: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

A trivial cleanup to make the fragment handling logic more clear.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 53820271e538..dc104add0a99 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -932,34 +932,27 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	return true;
 }
 
-static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
-				 struct page *page, unsigned int pageofs,
-				 unsigned int len)
+static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
+			unsigned int cur, unsigned int end, erofs_off_t pos)
 {
-	struct super_block *sb = inode->i_sb;
-	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
+	struct inode *packed_inode = EROFS_SB(sb)->packed_inode;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	u8 *src, *dst;
-	unsigned int i, cnt;
+	unsigned int cnt;
+	u8 *src;
 
 	if (!packed_inode)
 		return -EFSCORRUPTED;
 
 	buf.inode = packed_inode;
-	pos += EROFS_I(inode)->z_fragmentoff;
-	for (i = 0; i < len; i += cnt) {
-		cnt = min_t(unsigned int, len - i,
+	for (; cur < end; cur += cnt, pos += cnt) {
+		cnt = min_t(unsigned int, end - cur,
 			    sb->s_blocksize - erofs_blkoff(sb, pos));
 		src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
-
-		dst = kmap_local_page(page);
-		memcpy(dst + pageofs + i, src + erofs_blkoff(sb, pos), cnt);
-		kunmap_local(dst);
-		pos += cnt;
+		memcpy_to_page(page, cur, src + erofs_blkoff(sb, pos), cnt);
 	}
 	erofs_put_metabuf(&buf);
 	return 0;
@@ -972,7 +965,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-	unsigned int cur, end, spiltted;
+	unsigned int cur, end, len, spiltted;
 	int err = 0;
 
 	/* register locked file pages as online pages in pack */
@@ -1041,17 +1034,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto next_part;
 	}
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
-		unsigned int pageofs, skip, len;
+		erofs_off_t fpos = offset + cur - map->m_la;
 
-		if (offset > map->m_la) {
-			pageofs = 0;
-			skip = offset - map->m_la;
-		} else {
-			pageofs = map->m_la & ~PAGE_MASK;
-			skip = 0;
-		}
-		len = min_t(unsigned int, map->m_llen - skip, end - cur);
-		err = z_erofs_read_fragment(inode, skip, page, pageofs, len);
+		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
+		err = z_erofs_read_fragment(inode->i_sb, page, cur, cur + len,
+				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		++spiltted;
-- 
2.24.4

