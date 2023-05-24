Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BF70F3D9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 12:13:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR6TW2MD4z3f66
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 20:13:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=so0mpKVW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=so0mpKVW;
	dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR6TP05Hkz3cCn
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 20:13:28 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2536e522e47so57395a91.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684923204; x=1687515204;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vapAR/6EU00paIGYHBQFHRt4cvB1CyiM1SCSQ+Z2hU8=;
        b=so0mpKVWCF8cYXnovBMsyDPJZEGqiHOQ4bmJT5gSVpkt+zc4rKqCMo0yWecT0I5kxx
         CSZzoncB3W45DsdGtdCM31I1OnKR/9pxx3bMJWEr+ACMiZ73quZ3PjFpDIUeqRwhHYMk
         PRgbdAZf3FiegT5kg86vmqFFk153zUDVbkxfibnhPBmViR8Qxmps6RkYxJtkNMZ4K3yS
         4aMddOG0ZHb+ZcSzwfF5sonRxm1Tb4deDTuRZI3r1sB0blpULUQ84HG90J6WfwnkO+06
         a9aRSqyuExcoEW7hTsvoqsCoetGXtt/hAjKM8E/t6wkSv0hFP/TTgQRgK15J5g2N2TXh
         k7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923204; x=1687515204;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vapAR/6EU00paIGYHBQFHRt4cvB1CyiM1SCSQ+Z2hU8=;
        b=FLfRLdDJ4/VEr2cjsqHGYoO7VRy/2zILP+0pCLrr5p992Kc2W0qQ6l/TVb7nmw0k7+
         YSQEC31yeANtD/Yu9K2xfC8wllkQG2CZwA/vknJWCWJEFtUtjlb5Zh3WzE8xFOkWblYm
         t/nzqiUu1x71s95BWRFniRn6FbW37nN1xsBOBMe5Hha5WZ1afrMt4jO6tqxRaKE36hHK
         SkeHvSzj/f5KO5SLVrqRTA+Lp1R11U44y3hmeaT/XfQNXgDc3802RPgd6rbLE9aHaPtZ
         lILdGbRNagSQpxEyPdiAmqVcih7eTsHFj+mIWV2UJCUdU7WPfKCMtSvK0RN5vjfHryzd
         0s8w==
X-Gm-Message-State: AC+VfDy7xFDvzD6ijXj4ius8zybvfUaKwVQESm0AgYcQFNMM2sY+YMoO
	ZZHrg5VFGUXNovGOKCF9vwU=
X-Google-Smtp-Source: ACHHUZ5LeRVvKkhFQ85kE1QNjWyAdmje+WlxaV87/yiqhzr6oFpOEm3bqufe8MgO9SN/ZdvjC530Dg==
X-Received: by 2002:a17:902:ea0f:b0:1ad:c736:2090 with SMTP id s15-20020a170902ea0f00b001adc7362090mr19959331plg.3.1684923203810;
        Wed, 24 May 2023 03:13:23 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001aaed524541sm8336945plb.227.2023.05.24.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:13:23 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove end parameter from z_erofs_pcluster_readmore()
Date: Wed, 24 May 2023 18:13:05 +0800
Message-Id: <20230524101305.22105-1-zbestahu@gmail.com>
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

The `end` argument is pointless if it's not backmost.  And we already
have `headoffset` in struct `*f`, so let's use this offset to get the
`end` for backmost only instead in this function.

Also, remove linux/prefetch.h since it's not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..b7ebdc8f2135 100644
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
@@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
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
+	erofs_off_t cur, end;
 	int err;
 
 	if (backmost) {
+		end = f->headoffset +
+		      rac ? readahead_length(rac) : PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
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

