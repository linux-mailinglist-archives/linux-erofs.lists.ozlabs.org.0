Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335168A92F
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 10:31:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P86hm0yG4z3f72
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 20:31:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P86hY6kmVz3cLh
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Feb 2023 20:30:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VarVFK-_1675503048;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VarVFK-_1675503048)
          by smtp.aliyun-inc.com;
          Sat, 04 Feb 2023 17:30:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 3/6] erofs: remove tagged pointer helpers
Date: Sat,  4 Feb 2023 17:30:37 +0800
Message-Id: <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
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

Just open-code the remaining one to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/tagptr.h | 107 ----------------------------------------------
 fs/erofs/zdata.c  |  26 +++--------
 fs/erofs/zdata.h  |   1 -
 3 files changed, 6 insertions(+), 128 deletions(-)
 delete mode 100644 fs/erofs/tagptr.h

diff --git a/fs/erofs/tagptr.h b/fs/erofs/tagptr.h
deleted file mode 100644
index 64ceb7270b5c..000000000000
--- a/fs/erofs/tagptr.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * A tagged pointer implementation
- */
-#ifndef __EROFS_FS_TAGPTR_H
-#define __EROFS_FS_TAGPTR_H
-
-#include <linux/types.h>
-#include <linux/build_bug.h>
-
-/*
- * the name of tagged pointer types are tagptr{1, 2, 3...}_t
- * avoid directly using the internal structs __tagptr{1, 2, 3...}
- */
-#define __MAKE_TAGPTR(n) \
-typedef struct __tagptr##n {	\
-	uintptr_t v;	\
-} tagptr##n##_t;
-
-__MAKE_TAGPTR(1)
-__MAKE_TAGPTR(2)
-__MAKE_TAGPTR(3)
-__MAKE_TAGPTR(4)
-
-#undef __MAKE_TAGPTR
-
-extern void __compiletime_error("bad tagptr tags")
-	__bad_tagptr_tags(void);
-
-extern void __compiletime_error("bad tagptr type")
-	__bad_tagptr_type(void);
-
-/* fix the broken usage of "#define tagptr2_t tagptr3_t" by users */
-#define __tagptr_mask_1(ptr, n)	\
-	__builtin_types_compatible_p(typeof(ptr), struct __tagptr##n) ? \
-		(1UL << (n)) - 1 :
-
-#define __tagptr_mask(ptr)	(\
-	__tagptr_mask_1(ptr, 1) ( \
-	__tagptr_mask_1(ptr, 2) ( \
-	__tagptr_mask_1(ptr, 3) ( \
-	__tagptr_mask_1(ptr, 4) ( \
-	__bad_tagptr_type(), 0)))))
-
-/* generate a tagged pointer from a raw value */
-#define tagptr_init(type, val) \
-	((typeof(type)){ .v = (uintptr_t)(val) })
-
-/*
- * directly cast a tagged pointer to the native pointer type, which
- * could be used for backward compatibility of existing code.
- */
-#define tagptr_cast_ptr(tptr) ((void *)(tptr).v)
-
-/* encode tagged pointers */
-#define tagptr_fold(type, ptr, _tags) ({ \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
-		__bad_tagptr_tags(); \
-tagptr_init(type, (uintptr_t)(ptr) | tags); })
-
-/* decode tagged pointers */
-#define tagptr_unfold_ptr(tptr) \
-	((void *)((tptr).v & ~__tagptr_mask(tptr)))
-
-#define tagptr_unfold_tags(tptr) \
-	((tptr).v & __tagptr_mask(tptr))
-
-/* operations for the tagger pointer */
-#define tagptr_eq(_tptr1, _tptr2) ({ \
-	typeof(_tptr1) tptr1 = (_tptr1); \
-	typeof(_tptr2) tptr2 = (_tptr2); \
-	(void)(&tptr1 == &tptr2); \
-(tptr1).v == (tptr2).v; })
-
-/* lock-free CAS operation */
-#define tagptr_cmpxchg(_ptptr, _o, _n) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	typeof(_o) o = (_o); \
-	typeof(_n) n = (_n); \
-	(void)(&o == &n); \
-	(void)(&o == ptptr); \
-tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
-
-/* wrap WRITE_ONCE if atomic update is needed */
-#define tagptr_replace_tags(_ptptr, tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	*ptptr = tagptr_fold(*ptptr, tagptr_unfold_ptr(*ptptr), tags); \
-*ptptr; })
-
-#define tagptr_set_tags(_ptptr, _tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
-		__bad_tagptr_tags(); \
-	ptptr->v |= tags; \
-*ptptr; })
-
-#define tagptr_clear_tags(_ptptr, _tags) ({ \
-	typeof(_ptptr) ptptr = (_ptptr); \
-	const typeof(_tags) tags = (_tags); \
-	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
-		__bad_tagptr_tags(); \
-	ptptr->v &= ~tags; \
-*ptptr; })
-
-#endif	/* __EROFS_FS_TAGPTR_H */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f015a90839f6..ae97e3b627cb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -175,15 +175,6 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/*
- * tagged pointer with 1-bit tag for all compressed pages
- * tag 0 - the page is just found with an extra page reference
- */
-typedef tagptr1_t compressed_page_t;
-
-#define tag_compressed_page_justfound(page) \
-	tagptr_fold(compressed_page_t, page, 1)
-
 static struct workqueue_struct *z_erofs_workqueue __read_mostly;
 
 void z_erofs_exit_zip_subsystem(void)
@@ -319,7 +310,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 
 	for (i = 0; i < pcl->pclusterpages; ++i) {
 		struct page *page;
-		compressed_page_t t;
+		void *t;	/* mark pages just found for debugging */
 		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
@@ -329,7 +320,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		page = find_get_page(mc, pcl->obj.index + i);
 
 		if (page) {
-			t = tag_compressed_page_justfound(page);
+			t = (void *)((unsigned long)page | 1);
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
@@ -345,11 +336,10 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			if (!newpage)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
-			t = tag_compressed_page_justfound(newpage);
+			t = (void *)((unsigned long)newpage | 1);
 		}
 
-		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
-				     tagptr_cast_ptr(t)))
+		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL, t))
 			continue;
 
 		if (page)
@@ -1192,8 +1182,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 
 	struct address_space *mapping;
 	struct page *oldpage, *page;
-
-	compressed_page_t t;
 	int justfound;
 
 repeat:
@@ -1203,10 +1191,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (!page)
 		goto out_allocpage;
 
-	/* process the target tagged pointer */
-	t = tagptr_init(compressed_page_t, page);
-	justfound = tagptr_unfold_tags(t);
-	page = tagptr_unfold_ptr(t);
+	justfound = (unsigned long)page & 1UL;
+	page = (struct page *)((unsigned long)page & ~1UL);
 
 	/*
 	 * preallocated cached pages, which is used to avoid direct reclaim
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index b139de5473a9..f196a729c7e8 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -7,7 +7,6 @@
 #define __EROFS_FS_ZDATA_H
 
 #include "internal.h"
-#include "tagptr.h"
 
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
-- 
2.24.4

