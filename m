Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B16F7AA
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 04:57:57 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sR9t5FmFzDqVn
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 12:57:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sR2Q3ZK6zDqNk
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 12:51:26 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EEA9D1EB6F46BBC47F4D;
 Mon, 22 Jul 2019 10:51:23 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: [PATCH v3 19/24] erofs: add erofs_allocpage()
Date: Mon, 22 Jul 2019 10:50:38 +0800
Message-ID: <20190722025043.166344-20-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduces an temporary _on-stack_ page
pool to reuse the freed page directly as much as
it can for better performance and release all pages
at a time, it also slightly reduces the possibility of
the potential memory allocation failure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/utils.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index dc5c6c5e4885..506a68efe507 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -495,6 +495,8 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c */
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 void *erofs_get_pcpubuf(unsigned int pagenr);
 #define erofs_put_pcpubuf(buf) do { \
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index c430790a02e0..53ee6daa3f70 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -9,6 +9,20 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
+{
+	struct page *page;
+
+	if (!list_empty(pool)) {
+		page = lru_to_page(pool);
+		DBG_BUGON(page_ref_count(page) != 1);
+		list_del(&page->lru);
+	} else {
+		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
+	}
+	return page;
+}
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 static struct {
 	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
-- 
2.17.1

