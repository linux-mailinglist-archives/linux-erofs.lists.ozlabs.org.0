Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21568A4805
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 08:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713162430;
	bh=VQxgddiWlw2XZc1Xxo/TDMOxDI4rNtc7QVjE06gGA+A=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=nUyCBBwY+AUagxNGYakKO4Xm2LHsl2oToNaqjOwP4tebqb9wf5sN1Utz7pQ9Hg2LP
	 GG7eL2egkipY24o9mnrzMZm1Kz6fcKiI//1FEuK0R4PfPbHtr+4rNJXkr8yahn+1g9
	 mzzfCHku2pLSUp7zoXHvbfF3h+hzSPBef36lZvrynDAoNf1WY7A3BTnBQ2KdaySrkl
	 nyjQbDFNCKXF+hjfIh8MILsd9pHZtfu1MU/vkjqxr3ew2NYA23Zgrd0h1W19Q/UnX5
	 e9ngeorpjYgN0x4wFzh8z0XobxDg6O27RBgvKZILg26WowWvb8OahtkRvnodxXRkUL
	 BKBvU0oVLn+cA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VHxzL1D95z3dRl
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 16:27:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=180.101.52.140; helo=njjs-sys-mailin01.njjs.baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 428 seconds by postgrey-1.37 at boromir; Mon, 15 Apr 2024 16:27:01 AEST
Received: from njjs-sys-mailin01.njjs.baidu.com (mx313.baidu.com [180.101.52.140])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VHxz924n9z3bmN
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 16:26:57 +1000 (AEST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id D482F7F00047;
	Mon, 15 Apr 2024 14:19:42 +0800 (CST)
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: Consider NUMA affinity when allocating memory for per-CPU pcpubuf
Date: Mon, 15 Apr 2024 14:19:40 +0800
Message-Id: <20240415061940.56864-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
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
From: Li RongQing via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li RongQing <lirongqing@baidu.com>
Cc: Li RongQing <lirongqing@baidu.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

per-CPU pcpubufs are dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/pcpubuf.c  |  5 +++--
 fs/erofs/utils.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c6711..94c8b62 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -446,6 +446,7 @@ int __init erofs_init_sysfs(void);
 void erofs_exit_sysfs(void);
 
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
+struct page *erofs_allocpage_node(struct page **pagepool, gfp_t gfp, int nid);
 static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 {
 	set_page_private(page, (unsigned long)*pagepool);
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
index c7a4b1d..b0b05a3 100644
--- a/fs/erofs/pcpubuf.c
+++ b/fs/erofs/pcpubuf.c
@@ -62,16 +62,17 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
 	for_each_possible_cpu(cpu) {
 		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
 		struct page **pages, **oldpages;
+		int nid = cpu_to_node(cpu);
 		void *ptr, *old_ptr;
 
-		pages = kmalloc_array(nrpages, sizeof(*pages), GFP_KERNEL);
+		pages = kmalloc_array_node(nrpages, sizeof(*pages), GFP_KERNEL, nid);
 		if (!pages) {
 			ret = -ENOMEM;
 			break;
 		}
 
 		for (i = 0; i < nrpages; ++i) {
-			pages[i] = erofs_allocpage(&pagepool, GFP_KERNEL);
+			pages[i] = erofs_allocpage_node(&pagepool, GFP_KERNEL, nid);
 			if (!pages[i]) {
 				ret = -ENOMEM;
 				oldpages = pages;
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 518bdd6..ba5ba68 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -18,6 +18,20 @@ struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 	return page;
 }
 
+
+struct page *erofs_allocpage_node(struct page **pagepool, gfp_t gfp, int nid)
+{
+	struct page *page = *pagepool;
+
+	if (page) {
+		DBG_BUGON(page_ref_count(page) != 1);
+		*pagepool = (struct page *)page_private(page);
+	} else {
+		page = alloc_pages_node(nid, gfp, 0);
+	}
+	return page;
+}
+
 void erofs_release_pages(struct page **pagepool)
 {
 	while (*pagepool) {
-- 
2.9.4

