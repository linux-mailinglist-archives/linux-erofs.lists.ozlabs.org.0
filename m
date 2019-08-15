Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0658E409
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 06:44:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468DQD3VFMzDr3F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 14:44:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468DNJ1QfBzDqZj
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 14:43:11 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 79846BD5822AAB6EBE8F;
 Thu, 15 Aug 2019 12:43:08 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 15 Aug
 2019 12:42:57 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>
Subject: [PATCH v8 18/24] erofs: introduce pagevec for decompression subsystem
Date: Thu, 15 Aug 2019 12:41:49 +0800
Message-ID: <20190815044155.88483-19-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815044155.88483-1-gaoxiang25@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org,
 Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Pavel Machek <pavel@denx.de>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For each physical cluster, there is a straight-forward
way of allocating a fixed or variable-sized array to
record the corresponding file pages for its decompression
if we decide to decompress these pages asynchronously
(eg. read-ahead case), however it will take variable-sized
on-heap memory compared with traditional uncompressed
filesystems.

This patch introduces a pagevec solution to reuse some
allocated file page in the time-sharing approach to store
parts of the array itself in order to minimize the extra
memory overhead, thus only a small-sized constant array
used for booting the whole array itself up will be needed.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zpvec.h | 159 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 fs/erofs/zpvec.h

diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
new file mode 100644
index 000000000000..bb7689e67836
--- /dev/null
+++ b/fs/erofs/zpvec.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/fs/erofs/zpvec.h
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_FS_ZPVEC_H
+#define __EROFS_FS_ZPVEC_H
+
+#include "tagptr.h"
+
+/* page type in pagevec for decompress subsystem */
+enum z_erofs_page_type {
+	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
+	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
+
+	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
+
+	Z_EROFS_VLE_PAGE_TYPE_HEAD,
+	Z_EROFS_VLE_PAGE_TYPE_MAX
+};
+
+extern void __compiletime_error("Z_EROFS_PAGE_TYPE_EXCLUSIVE != 0")
+	__bad_page_type_exclusive(void);
+
+/* pagevec tagged pointer */
+typedef tagptr2_t	erofs_vtptr_t;
+
+/* pagevec collector */
+struct z_erofs_pagevec_ctor {
+	struct page *curr, *next;
+	erofs_vtptr_t *pages;
+
+	unsigned int nr, index;
+};
+
+static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
+					     bool atomic)
+{
+	if (!ctor->curr)
+		return;
+
+	if (atomic)
+		kunmap_atomic(ctor->pages);
+	else
+		kunmap(ctor->curr);
+}
+
+static inline struct page *
+z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
+			       unsigned int nr)
+{
+	unsigned int index;
+
+	/* keep away from occupied pages */
+	if (ctor->next)
+		return ctor->next;
+
+	for (index = 0; index < nr; ++index) {
+		const erofs_vtptr_t t = ctor->pages[index];
+		const unsigned int tags = tagptr_unfold_tags(t);
+
+		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
+			return tagptr_unfold_ptr(t);
+	}
+	DBG_BUGON(nr >= ctor->nr);
+	return NULL;
+}
+
+static inline void
+z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
+			      bool atomic)
+{
+	struct page *next = z_erofs_pagevec_ctor_next_page(ctor, ctor->nr);
+
+	z_erofs_pagevec_ctor_exit(ctor, atomic);
+
+	ctor->curr = next;
+	ctor->next = NULL;
+	ctor->pages = atomic ?
+		kmap_atomic(ctor->curr) : kmap(ctor->curr);
+
+	ctor->nr = PAGE_SIZE / sizeof(struct page *);
+	ctor->index = 0;
+}
+
+static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
+					     unsigned int nr,
+					     erofs_vtptr_t *pages,
+					     unsigned int i)
+{
+	ctor->nr = nr;
+	ctor->curr = ctor->next = NULL;
+	ctor->pages = pages;
+
+	if (i >= nr) {
+		i -= nr;
+		z_erofs_pagevec_ctor_pagedown(ctor, false);
+		while (i > ctor->nr) {
+			i -= ctor->nr;
+			z_erofs_pagevec_ctor_pagedown(ctor, false);
+		}
+	}
+	ctor->next = z_erofs_pagevec_ctor_next_page(ctor, i);
+	ctor->index = i;
+}
+
+static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
+					   struct page *page,
+					   enum z_erofs_page_type type,
+					   bool *occupied)
+{
+	*occupied = false;
+	if (unlikely(!ctor->next && type))
+		if (ctor->index + 1 == ctor->nr)
+			return false;
+
+	if (unlikely(ctor->index >= ctor->nr))
+		z_erofs_pagevec_ctor_pagedown(ctor, false);
+
+	/* exclusive page type must be 0 */
+	if (Z_EROFS_PAGE_TYPE_EXCLUSIVE != (uintptr_t)NULL)
+		__bad_page_type_exclusive();
+
+	/* should remind that collector->next never equal to 1, 2 */
+	if (type == (uintptr_t)ctor->next) {
+		ctor->next = page;
+		*occupied = true;
+	}
+	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
+	return true;
+}
+
+static inline struct page *
+z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
+			enum z_erofs_page_type *type)
+{
+	erofs_vtptr_t t;
+
+	if (unlikely(ctor->index >= ctor->nr)) {
+		DBG_BUGON(!ctor->next);
+		z_erofs_pagevec_ctor_pagedown(ctor, true);
+	}
+
+	t = ctor->pages[ctor->index];
+
+	*type = tagptr_unfold_tags(t);
+
+	/* should remind that collector->next never equal to 1, 2 */
+	if (*type == (uintptr_t)ctor->next)
+		ctor->next = tagptr_unfold_ptr(t);
+
+	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, NULL, 0);
+	return tagptr_unfold_ptr(t);
+}
+#endif
+
-- 
2.17.1

