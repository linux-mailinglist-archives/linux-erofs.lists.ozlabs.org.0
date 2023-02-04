Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7E68A935
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 10:31:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P86hq646hz3cdC
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 20:31:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P86hb12LBz3cLh
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Feb 2023 20:30:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VarVFKV_1675503049;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VarVFKV_1675503049)
          by smtp.aliyun-inc.com;
          Sat, 04 Feb 2023 17:30:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 4/6] erofs: move zdata.h into zdata.c
Date: Sat,  4 Feb 2023 17:30:38 +0800
Message-Id: <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
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

Definitions in zdata.h are only used in zdata.c and for internal
use only.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 166 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zdata.h | 177 -----------------------------------------------
 2 files changed, 165 insertions(+), 178 deletions(-)
 delete mode 100644 fs/erofs/zdata.h

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ae97e3b627cb..384f64292f73 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -4,13 +4,177 @@
  *             https://www.huawei.com/
  * Copyright (C) 2022 Alibaba Cloud
  */
-#include "zdata.h"
 #include "compress.h"
 #include <linux/prefetch.h>
 #include <linux/psi.h>
 
 #include <trace/events/erofs.h>
 
+#define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
+#define Z_EROFS_INLINE_BVECS		2
+
+/*
+ * let's leave a type here in case of introducing
+ * another tagged pointer later.
+ */
+typedef void *z_erofs_next_pcluster_t;
+
+struct z_erofs_bvec {
+	struct page *page;
+	int offset;
+	unsigned int end;
+};
+
+#define __Z_EROFS_BVSET(name, total) \
+struct name { \
+	/* point to the next page which contains the following bvecs */ \
+	struct page *nextpage; \
+	struct z_erofs_bvec bvec[total]; \
+}
+__Z_EROFS_BVSET(z_erofs_bvset,);
+__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
+
+/*
+ * Structure fields follow one of the following exclusion rules.
+ *
+ * I: Modifiable by initialization/destruction paths and read-only
+ *    for everyone else;
+ *
+ * L: Field should be protected by the pcluster lock;
+ *
+ * A: Field should be accessed / updated in atomic for parallelized code.
+ */
+struct z_erofs_pcluster {
+	struct erofs_workgroup obj;
+	struct mutex lock;
+
+	/* A: point to next chained pcluster or TAILs */
+	z_erofs_next_pcluster_t next;
+
+	/* L: the maximum decompression size of this round */
+	unsigned int length;
+
+	/* L: total number of bvecs */
+	unsigned int vcnt;
+
+	/* I: page offset of start position of decompression */
+	unsigned short pageofs_out;
+
+	/* I: page offset of inline compressed data */
+	unsigned short pageofs_in;
+
+	union {
+		/* L: inline a certain number of bvec for bootstrap */
+		struct z_erofs_bvset_inline bvset;
+
+		/* I: can be used to free the pcluster by RCU. */
+		struct rcu_head rcu;
+	};
+
+	union {
+		/* I: physical cluster size in pages */
+		unsigned short pclusterpages;
+
+		/* I: tailpacking inline compressed size */
+		unsigned short tailpacking_size;
+	};
+
+	/* I: compression algorithm format */
+	unsigned char algorithmformat;
+
+	/* L: whether partial decompression or not */
+	bool partial;
+
+	/* L: indicate several pageofs_outs or not */
+	bool multibases;
+
+	/* A: compressed bvecs (can be cached or inplaced pages) */
+	struct z_erofs_bvec compressed_bvecs[];
+};
+
+/* let's avoid the valid 32-bit kernel addresses */
+
+/* the chained workgroup has't submitted io (still open) */
+#define Z_EROFS_PCLUSTER_TAIL           ((void *)0x5F0ECAFE)
+/* the chained workgroup has already submitted io */
+#define Z_EROFS_PCLUSTER_TAIL_CLOSED    ((void *)0x5F0EDEAD)
+
+#define Z_EROFS_PCLUSTER_NIL            (NULL)
+
+struct z_erofs_decompressqueue {
+	struct super_block *sb;
+	atomic_t pending_bios;
+	z_erofs_next_pcluster_t head;
+
+	union {
+		struct completion done;
+		struct work_struct work;
+	} u;
+	bool eio, sync;
+};
+
+static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
+{
+	return !pcl->obj.index;
+}
+
+static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
+{
+	if (z_erofs_is_inline_pcluster(pcl))
+		return 1;
+	return pcl->pclusterpages;
+}
+
+/*
+ * bit 30: I/O error occurred on this page
+ * bit 0 - 29: remaining parts to complete this page
+ */
+#define Z_EROFS_PAGE_EIO			(1 << 30)
+
+static inline void z_erofs_onlinepage_init(struct page *page)
+{
+	union {
+		atomic_t o;
+		unsigned long v;
+	} u = { .o = ATOMIC_INIT(1) };
+
+	set_page_private(page, u.v);
+	smp_wmb();
+	SetPagePrivate(page);
+}
+
+static inline void z_erofs_onlinepage_split(struct page *page)
+{
+	atomic_inc((atomic_t *)&page->private);
+}
+
+static inline void z_erofs_page_mark_eio(struct page *page)
+{
+	int orig;
+
+	do {
+		orig = atomic_read((atomic_t *)&page->private);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
+				orig | Z_EROFS_PAGE_EIO) != orig);
+}
+
+static inline void z_erofs_onlinepage_endio(struct page *page)
+{
+	unsigned int v;
+
+	DBG_BUGON(!PagePrivate(page));
+	v = atomic_dec_return((atomic_t *)&page->private);
+	if (!(v & ~Z_EROFS_PAGE_EIO)) {
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+		if (!(v & Z_EROFS_PAGE_EIO))
+			SetPageUptodate(page);
+		unlock_page(page);
+	}
+}
+
+#define Z_EROFS_ONSTACK_PAGES		32
+
 /*
  * since pclustersize is variable for big pcluster feature, introduce slab
  * pools implementation for different pcluster sizes.
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
deleted file mode 100644
index f196a729c7e8..000000000000
--- a/fs/erofs/zdata.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2018 HUAWEI, Inc.
- *             https://www.huawei.com/
- */
-#ifndef __EROFS_FS_ZDATA_H
-#define __EROFS_FS_ZDATA_H
-
-#include "internal.h"
-
-#define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
-#define Z_EROFS_INLINE_BVECS		2
-
-/*
- * let's leave a type here in case of introducing
- * another tagged pointer later.
- */
-typedef void *z_erofs_next_pcluster_t;
-
-struct z_erofs_bvec {
-	struct page *page;
-	int offset;
-	unsigned int end;
-};
-
-#define __Z_EROFS_BVSET(name, total) \
-struct name { \
-	/* point to the next page which contains the following bvecs */ \
-	struct page *nextpage; \
-	struct z_erofs_bvec bvec[total]; \
-}
-__Z_EROFS_BVSET(z_erofs_bvset,);
-__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
-
-/*
- * Structure fields follow one of the following exclusion rules.
- *
- * I: Modifiable by initialization/destruction paths and read-only
- *    for everyone else;
- *
- * L: Field should be protected by the pcluster lock;
- *
- * A: Field should be accessed / updated in atomic for parallelized code.
- */
-struct z_erofs_pcluster {
-	struct erofs_workgroup obj;
-	struct mutex lock;
-
-	/* A: point to next chained pcluster or TAILs */
-	z_erofs_next_pcluster_t next;
-
-	/* L: the maximum decompression size of this round */
-	unsigned int length;
-
-	/* L: total number of bvecs */
-	unsigned int vcnt;
-
-	/* I: page offset of start position of decompression */
-	unsigned short pageofs_out;
-
-	/* I: page offset of inline compressed data */
-	unsigned short pageofs_in;
-
-	union {
-		/* L: inline a certain number of bvec for bootstrap */
-		struct z_erofs_bvset_inline bvset;
-
-		/* I: can be used to free the pcluster by RCU. */
-		struct rcu_head rcu;
-	};
-
-	union {
-		/* I: physical cluster size in pages */
-		unsigned short pclusterpages;
-
-		/* I: tailpacking inline compressed size */
-		unsigned short tailpacking_size;
-	};
-
-	/* I: compression algorithm format */
-	unsigned char algorithmformat;
-
-	/* L: whether partial decompression or not */
-	bool partial;
-
-	/* L: indicate several pageofs_outs or not */
-	bool multibases;
-
-	/* A: compressed bvecs (can be cached or inplaced pages) */
-	struct z_erofs_bvec compressed_bvecs[];
-};
-
-/* let's avoid the valid 32-bit kernel addresses */
-
-/* the chained workgroup has't submitted io (still open) */
-#define Z_EROFS_PCLUSTER_TAIL           ((void *)0x5F0ECAFE)
-/* the chained workgroup has already submitted io */
-#define Z_EROFS_PCLUSTER_TAIL_CLOSED    ((void *)0x5F0EDEAD)
-
-#define Z_EROFS_PCLUSTER_NIL            (NULL)
-
-struct z_erofs_decompressqueue {
-	struct super_block *sb;
-	atomic_t pending_bios;
-	z_erofs_next_pcluster_t head;
-
-	union {
-		struct completion done;
-		struct work_struct work;
-	} u;
-
-	bool eio, sync;
-};
-
-static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
-{
-	return !pcl->obj.index;
-}
-
-static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
-{
-	if (z_erofs_is_inline_pcluster(pcl))
-		return 1;
-	return pcl->pclusterpages;
-}
-
-/*
- * bit 30: I/O error occurred on this page
- * bit 0 - 29: remaining parts to complete this page
- */
-#define Z_EROFS_PAGE_EIO			(1 << 30)
-
-static inline void z_erofs_onlinepage_init(struct page *page)
-{
-	union {
-		atomic_t o;
-		unsigned long v;
-	} u = { .o = ATOMIC_INIT(1) };
-
-	set_page_private(page, u.v);
-	smp_wmb();
-	SetPagePrivate(page);
-}
-
-static inline void z_erofs_onlinepage_split(struct page *page)
-{
-	atomic_inc((atomic_t *)&page->private);
-}
-
-static inline void z_erofs_page_mark_eio(struct page *page)
-{
-	int orig;
-
-	do {
-		orig = atomic_read((atomic_t *)&page->private);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
-				orig | Z_EROFS_PAGE_EIO) != orig);
-}
-
-static inline void z_erofs_onlinepage_endio(struct page *page)
-{
-	unsigned int v;
-
-	DBG_BUGON(!PagePrivate(page));
-	v = atomic_dec_return((atomic_t *)&page->private);
-	if (!(v & ~Z_EROFS_PAGE_EIO)) {
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		if (!(v & Z_EROFS_PAGE_EIO))
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
-}
-
-#define Z_EROFS_ONSTACK_PAGES		32
-
-#endif
-- 
2.24.4

