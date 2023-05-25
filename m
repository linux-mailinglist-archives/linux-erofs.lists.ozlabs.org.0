Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388B710644
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 09:26:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRfkB08Gdz3f7H
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 17:26:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=f5ZL36ok;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=f5ZL36ok;
	dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRfk645tbz3cM3
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 17:26:21 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-528cdc9576cso916737a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684999578; x=1687591578;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SJbCVUIsT35lU+xRPnFefGg51IAUFGSv1jqsyRTZiM=;
        b=f5ZL36ok/3gXEzE4fhHCkfw4YlVUBqqfrYaIGoQ5ab96Vf7QOaFKHooBgNCgfSPu6g
         8wI7+ESiSgCgg4ouND4fHXMM0a2PmppNw0PmqiI/J54vHxZOFKABgFSykbHXiF7boQ11
         vQnqJAdATQZ1rL86eI5SDhsESspq4BKZ+oTXYKZzNlTf9u16hujkLWb/UPbzxQZix97O
         r5/N55HsKRFGH4BUn8Dh6nD+TAbt8iQ8fzmjtPH8l+s95SVhG2XPySMUtho7GQvIOj7K
         pn7Fy/2EyFfp78HlgakUr9YEWGBzmqG9WCBMK73J5wXdz9tNi62gDOEwdhZOXb2E4l7a
         MF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684999578; x=1687591578;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SJbCVUIsT35lU+xRPnFefGg51IAUFGSv1jqsyRTZiM=;
        b=JrFWc+JLMM2Qy5CVdUQ97gEXNGy7hnigWkWdyL4qoAnoE3mxHtxAxFYJspVgR6CRTw
         Leja/swW/I2RP7Bb4ZgPhwzxMW+Zo9UHyIbW12bLmRLJPwIaRRlmKOJMPIvsiz1KeLEh
         uJar9gzFEo0bczxsZ7p2jyngbAAs/lamoGHidUwEWJz/0w6y/Ny9ZJhd0eYsgVSCZyri
         y1wdr0G2Gfu+nWy66yROpWilrioLCsEf5xLM6b6cZmxIKq4KraJKHIxNyagwDleQE3Q9
         9wyvbrKAd3nqs2Lu2oN7sBRR3J6wmC2BqOsPitDuZVCyCGUay8fUUD5RLncnWK4l3km0
         mqUw==
X-Gm-Message-State: AC+VfDwxJqLFRlKh1ulLlAW0vaG0kKdeBUFDvK0hIuhSGEKWpBtOLghW
	SE7hmRp/otcS3+CR3IsMamE=
X-Google-Smtp-Source: ACHHUZ5fJoS4o+wP556Zv5XjmhbFm5S1ET3O0EOwC9y5gVxg43wKVXRRqW4ZqpuqECM/qcZDH6P+Jg==
X-Received: by 2002:a17:902:7b82:b0:1ae:4553:edfa with SMTP id w2-20020a1709027b8200b001ae4553edfamr647078pll.29.1684999578400;
        Thu, 25 May 2023 00:26:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001ac2c3e436asm684225plg.186.2023.05.25.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:26:18 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up z_erofs_pcluster_readmore()
Date: Thu, 25 May 2023 15:26:05 +0800
Message-Id: <20230525072605.17857-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

No need end parameter since it's pointless for !backmost, we can get it
for backmost internally.  And we only expand the trailing edge, so the
newstart can be replaced with ->headoffset.

Also, remove linux/prefetch.h that is not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..bab8dcb8e848 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
-#include <linux/prefetch.h>
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
@@ -1825,28 +1824,28 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  */
 static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 				      struct readahead_control *rac,
-				      erofs_off_t end,
-				      struct page **pagepool,
-				      bool backmost)
+				      struct page **pagepool, bool backmost)
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
-	erofs_off_t cur;
+	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
 	if (backmost) {
+		if (rac)
+			end = headoffset + readahead_length(rac) - 1;
+		else
+			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
-		/* expend ra for the trailing edge if readahead */
+		/* expand ra for the trailing edge if readahead */
 		if (rac) {
-			loff_t newstart = readahead_pos(rac);
-
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
-			readahead_expand(rac, newstart, cur - newstart);
+			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
 		}
 		end = round_up(end, PAGE_SIZE);
@@ -1894,10 +1893,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
-				  &pagepool, true);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, false);
 
 	(void)z_erofs_collector_end(&f);
 
@@ -1923,8 +1921,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
-				  readahead_length(rac) - 1, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1947,7 +1944,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, false);
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-- 
2.17.1

