Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1B6DADAE
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 15:38:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtKFV3VZ3z3c8G
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 23:38:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtKFQ3QNvz3fFV
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Apr 2023 23:38:17 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfWxuzn_1680874686;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfWxuzn_1680874686)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 21:38:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: get rid of erofs_buf_write_bhops
Date: Fri,  7 Apr 2023 21:38:03 +0800
Message-Id: <20230407133805.60975-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

`nbh->off - bh->off` in erofs_bh_flush_generic_write() is
problematic due to erofs_bdrop(bh, false).

Let's avoid generic erofs_buf_write_bhops instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  1 -
 lib/cache.c           | 23 -----------------------
 mkfs/main.c           |  8 +++++---
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index b04eb47..8c3bd46 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -80,7 +80,6 @@ static inline const int get_alignsize(int type, int *type_ret)
 
 extern const struct erofs_bhops erofs_drop_directly_bhops;
 extern const struct erofs_bhops erofs_skip_write_bhops;
-extern const struct erofs_bhops erofs_buf_write_bhops;
 
 static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 {
diff --git a/lib/cache.c b/lib/cache.c
index 9eb0394..178bd5a 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -39,29 +39,6 @@ const struct erofs_bhops erofs_skip_write_bhops = {
 	.flush = erofs_bh_flush_skip_write,
 };
 
-int erofs_bh_flush_generic_write(struct erofs_buffer_head *bh, void *buf)
-{
-	struct erofs_buffer_head *nbh = list_next_entry(bh, list);
-	erofs_off_t offset = erofs_btell(bh, false);
-
-	DBG_BUGON(nbh->off < bh->off);
-	return dev_write(buf, offset, nbh->off - bh->off);
-}
-
-static bool erofs_bh_flush_buf_write(struct erofs_buffer_head *bh)
-{
-	int err = erofs_bh_flush_generic_write(bh, bh->fsprivate);
-
-	if (err)
-		return false;
-	free(bh->fsprivate);
-	return erofs_bh_flush_generic_end(bh);
-}
-
-const struct erofs_bhops erofs_buf_write_bhops = {
-	.flush = erofs_bh_flush_buf_write,
-};
-
 /* return buffer_head of erofs super block (with size 0) */
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index 65d3df6..05db4c8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -580,6 +580,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	};
 	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz());
 	char *buf;
+	int ret;
 
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
@@ -601,9 +602,10 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	}
 	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
 
-	bh->fsprivate = buf;
-	bh->op = &erofs_buf_write_bhops;
-	return 0;
+	ret = dev_write(buf, erofs_btell(bh, false), sb_blksize);
+	free(buf);
+	erofs_bdrop(bh, false);
+	return ret;
 }
 
 static int erofs_mkfs_superblock_csum_set(void)
-- 
2.24.4

