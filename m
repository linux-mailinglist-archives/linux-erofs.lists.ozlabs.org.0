Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C06775281
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 08:06:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLKMN0jQwz2yxX
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 16:06:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLKMJ2MTZz2xG9
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Aug 2023 16:06:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpNfuZA_1691561198;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VpNfuZA_1691561198)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 14:06:43 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: refine warning messages for data I/Os
Date: Wed,  9 Aug 2023 14:06:37 +0800
Message-Id: <20230809060637.21311-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Don't warn users since -EINTR is returned due to user interruption.
Also suppress warning messages of readmore.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/zdata.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index de4f12152b62..53820271e538 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1848,15 +1848,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
 		if (page) {
-			if (PageUptodate(page)) {
+			if (PageUptodate(page))
 				unlock_page(page);
-			} else {
-				err = z_erofs_do_read_page(f, page);
-				if (err)
-					erofs_err(inode->i_sb,
-						  "readmore error at page %lu @ nid %llu",
-						  index, EROFS_I(inode)->nid);
-			}
+			else
+				(void)z_erofs_do_read_page(f, page);
 			put_page(page);
 		}
 
@@ -1885,8 +1880,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	/* if some compressed cluster ready, need submit them anyway */
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
 
-	if (err)
-		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
+	if (err && err != -EINTR)
+		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
+			  err, folio->index, EROFS_I(inode)->nid);
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
@@ -1920,10 +1916,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		head = (void *)page_private(page);
 
 		err = z_erofs_do_read_page(&f, page);
-		if (err)
-			erofs_err(inode->i_sb,
-				  "readahead error at page %lu @ nid %llu",
-				  page->index, EROFS_I(inode)->nid);
+		if (err && err != -EINTR)
+			erofs_err(inode->i_sb, "readahead error %d @ %lu of nid %llu",
+				  err, page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
-- 
2.19.1.6.gb485710b

