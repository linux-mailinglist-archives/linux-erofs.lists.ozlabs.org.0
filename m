Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A272977F24A
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:39:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJND3gByz3bWy
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:39:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJN75cdkz2yhL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:39:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpzBcn4_1692261583;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpzBcn4_1692261583)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:39:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 8/8] erofs: adapt folios for z_erofs_read_folio()
Date: Thu, 17 Aug 2023 16:39:42 +0800
Message-Id: <20230817083942.103303-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
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

It's a straight-forward conversion and no logic changes (except that
it renames the corresponding tracepoint.)

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - folio->index is still indexed in the page unit, so PAGE_SHIFT is needed.

 fs/erofs/zdata.c             |  9 ++++-----
 include/trace/events/erofs.h | 16 ++++++++--------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 79cadb88e8bf..ace727bfe5b2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1821,17 +1821,16 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *const inode = page->mapping->host;
+	struct inode *const inode = folio->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
 
-	trace_erofs_readpage(page, false);
-	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
+	trace_erofs_read_folio(folio, false);
+	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, page);
+	err = z_erofs_do_read_page(&f, &folio->page);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 71dbe8bfa7db..e18684b02c3d 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -80,11 +80,11 @@ TRACE_EVENT(erofs_fill_inode,
 		  __entry->blkaddr, __entry->ofs)
 );
 
-TRACE_EVENT(erofs_readpage,
+TRACE_EVENT(erofs_read_folio,
 
-	TP_PROTO(struct page *page, bool raw),
+	TP_PROTO(struct folio *folio, bool raw),
 
-	TP_ARGS(page, raw),
+	TP_ARGS(folio, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -96,11 +96,11 @@ TRACE_EVENT(erofs_readpage,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_I(page->mapping->host)->nid;
-		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
-		__entry->index	= page->index;
-		__entry->uptodate = PageUptodate(page);
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->nid	= EROFS_I(folio->mapping->host)->nid;
+		__entry->dir	= S_ISDIR(folio->mapping->host->i_mode);
+		__entry->index	= folio->index;
+		__entry->uptodate = folio_test_uptodate(folio);
 		__entry->raw = raw;
 	),
 
-- 
2.24.4

