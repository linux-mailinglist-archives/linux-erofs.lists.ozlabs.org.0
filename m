Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4997102BC
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 04:14:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRWpS3t69z3f67
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 12:14:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=DcGMR9DB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=DcGMR9DB;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRWpN6MsWz3bT1
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 12:14:34 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-530638a60e1so921103a12.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684980870; x=1687572870;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzBlJLFAfyWSWb9nUXk9FvhTpGSd0CozzP+TkVxRg2s=;
        b=DcGMR9DBSVzrk5auQ81PVyyXqY8c/vFLnhHRdHPhhPmZz0vtzbwzTvIOJjrTT0zIKZ
         bG9JjhgNIS9oX2kG0Sa805UV4jYkp+MfUjb0VCp8XZAj+kQ7WKnOFOJI+bT++XPYQLtb
         +0sINuIAfwJhxEwF9LT/NBBRTEv4AejT+ozTzIijOSfml1JNZajVMKsCcowJg1JcxrSe
         m2IAOHXsiTAHzD6xiKvulAa0TbKcaYgArLYYZ5BDkiiSC2TSqiFVdZHxgZx/f8ZsBdu7
         a7z8boqqtBLe8OQg1kV/5ze9dvsm7gtQAaKQbBeM1oC5X4mwe4ceKHPK6QacXs+LgxaP
         /UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684980870; x=1687572870;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzBlJLFAfyWSWb9nUXk9FvhTpGSd0CozzP+TkVxRg2s=;
        b=cuVQa/4Ysk4wz3bs5gWhPM6EDSuVrV+VosZCfFNzvzvTGAPoVyJubmK4pjxzeWmVTi
         IA5+8eBFlGBXk+dJjwcHlsJ1zoK6MwJMU0MbTNa0I4y/+npexL9u2pvE4bbgboLUiPwe
         SMhUW/c1cURGWV2edASLdXrTPckE/iO66+BV0voI84TnPTwa6nfTcb1s6prnKoEqwMAv
         e8a3t0Qvl8vj0HsMWMFZu0tFkkwUDgncrmAtJHHckBLnjZxFp9nqccs9K12m0wOL2u5R
         hwzAnFnAEvO8g1TkzwnGSGjavPjtZ1EsJYTIHaL9XNy1PnVIBdi90Oa0uHCdF2OsdQHA
         C7tQ==
X-Gm-Message-State: AC+VfDynjbwmmXBBDY1LHDk3nXZAdBFpCYcQ6pDKkNXAOXXAqbTdIQll
	c3myBQyzvnFZDcIMN8yZywA=
X-Google-Smtp-Source: ACHHUZ43FYWuhk0l+Ak68yTcquXM88HZT1KFK0hTwq6+94J/kpjUCgMfXykuPcsBujVQAY4P4jFEpg==
X-Received: by 2002:a17:90b:4b04:b0:253:5728:f631 with SMTP id lx4-20020a17090b4b0400b002535728f631mr19992pjb.15.1684980870426;
        Wed, 24 May 2023 19:14:30 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t30-20020a63225e000000b0051afa49e07asm8419929pgm.50.2023.05.24.19.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 19:14:29 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: remove end parameter from z_erofs_pcluster_readmore()
Date: Thu, 25 May 2023 10:14:15 +0800
Message-Id: <20230525021415.8594-1-zbestahu@gmail.com>
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

Also, remove linux/prefetch.h that is not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2:
 - change to use if-else to obtain end value
 - minor commit message update

 fs/erofs/zdata.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..874fee35af32 100644
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
@@ -1825,16 +1824,18 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
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
+		if (rac)
+			end = f->headoffset + readahead_length(rac) - 1;
+		else
+			end = f->headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
@@ -1894,10 +1895,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
-				  &pagepool, true);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, false);
 
 	(void)z_erofs_collector_end(&f);
 
@@ -1923,8 +1923,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
-				  readahead_length(rac) - 1, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1947,7 +1946,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, false);
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-- 
2.17.1

