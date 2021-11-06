Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 32617446CFA
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Nov 2021 09:13:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HmVVq44H0z2yPp
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Nov 2021 19:13:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.88; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg477.qq.com [59.36.132.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HmVVb0145z2xgN
 for <linux-erofs@lists.ozlabs.org>; Sat,  6 Nov 2021 19:12:53 +1100 (AEDT)
X-QQ-mid: bizesmtp33t1636186279tvwp0k76
Received: from localhost.localdomain (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sat, 06 Nov 2021 16:11:06 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00A0000000
X-QQ-FEAT: 3uawQE1sH+2vGgiHXOOPTcN3eogYudOGeZ0/H+BgLJlyaPqdCmMa2YMLCjtuy
 BrK06CwiB08EFMShwuVeJhFKsnCaL8cPiR39E4EVeP2+IvShdggsaudzG/BTkq3oht7orpo
 2i5Dd9+22wVsRGKcCvinhtGS71ON1gHEGbdYO1/Fjh80lvUEVb7w6ljR82YvPTyJGLUapbS
 Qg9Lh0DkydHpS0cGPdySs0QegZxJIKvaBgUqHHdciNTGGcY5Nx05u4e+u8ZsZTVn5vFFSLm
 FU3USSDoBRihjGiCJLyvtSq4JvyBuLAtPqgYDWOeRP9nvB2pM6p30qO+9yX1FZm9zR8rlDG
 x9cBUrLFMj9RgCcHplp97bKElp5piXPwp/+f+Aw
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove useless cache strategy of DELAYEDALLOC
Date: Sat,  6 Nov 2021 16:11:00 +0800
Message-Id: <20211106081100.21478-1-huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
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
Cc: zhangwen@yulong.com, Yue Hu <huyue2@yulong.com>, geshifei@yulong.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

DELAYEDALLOC is not used at all, remove related dead code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zdata.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..812c7c6ae456 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -96,16 +96,9 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/*
- * a compressed_pages[] placeholder in order to avoid
- * being filled with file pages for in-place decompression.
- */
-#define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
-
 /* how to allocate cached pages for a pcluster */
 enum z_erofs_cache_alloctype {
 	DONTALLOC,	/* don't allocate any cached pages */
-	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
 	/*
 	 * try to use cached I/O if page allocation succeeds or fallback
 	 * to in-place I/O instead to avoid any direct reclaim.
@@ -267,10 +260,6 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
 			switch (type) {
-			case DELAYEDALLOC:
-				t = tagptr_init(compressed_page_t,
-						PAGE_UNALLOCATED);
-				break;
 			case TRYALLOC:
 				newpage = erofs_allocpage(pagepool, gfp);
 				if (!newpage)
@@ -1089,15 +1078,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (!page)
 		goto out_allocpage;
 
-	/*
-	 * the cached page has not been allocated and
-	 * an placeholder is out there, prepare it now.
-	 */
-	if (page == PAGE_UNALLOCATED) {
-		tocache = true;
-		goto out_allocpage;
-	}
-
 	/* process the target tagged pointer */
 	t = tagptr_init(compressed_page_t, page);
 	justfound = tagptr_unfold_tags(t);
-- 
2.17.1



