Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A760F283
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 10:36:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MyfCr0vBLz3cGT
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 19:36:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MyfCQ69zzz3cBP
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Oct 2022 19:36:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAkmCy_1666859758;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAkmCy_1666859758)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:59 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 8/9] fscache,netfs: move PageFsCache() family helpers to fscache.h
Date: Thu, 27 Oct 2022 16:35:46 +0800
Message-Id: <20221027083547.46933-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Later all structures transformed with "fscache_" prefix will be moved to
fscache.h from netfs.h, and then netfs.h will include fscache.h rather
than the other way around.  If that's the case, the PageFsCache() family
helpers also needs to be moved to fscache.h, since end_page_fscache() is
referenced inside fscache.

Besides, it's also quite reasonable to move these helpers to fscache.h
given their names.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/linux/fscache.h | 90 +++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h   | 89 ----------------------------------------
 2 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9df2988be804..034d009c0de7 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/netfs.h>
 #include <linux/writeback.h>
+#include <linux/pagemap.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
 #define __fscache_available (1)
@@ -695,4 +696,93 @@ void fscache_note_page_release(struct fscache_cookie *cookie)
 		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 }
 
+/*
+ * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
+ * a page is currently backed by a local disk cache
+ */
+#define folio_test_fscache(folio)	folio_test_private_2(folio)
+#define PageFsCache(page)		PagePrivate2((page))
+#define SetPageFsCache(page)		SetPagePrivate2((page))
+#define ClearPageFsCache(page)		ClearPagePrivate2((page))
+#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
+#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
+
+/**
+ * folio_start_fscache - Start an fscache write on a folio.
+ * @folio: The folio.
+ *
+ * Call this function before writing a folio to a local cache.  Starting a
+ * second write before the first one finishes is not allowed.
+ */
+static inline void folio_start_fscache(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
+	folio_get(folio);
+	folio_set_private_2(folio);
+}
+
+/**
+ * folio_end_fscache - End an fscache write on a folio.
+ * @folio: The folio.
+ *
+ * Call this function after the folio has been written to the local cache.
+ * This will wake any sleepers waiting on this folio.
+ */
+static inline void folio_end_fscache(struct folio *folio)
+{
+	folio_end_private_2(folio);
+}
+
+/**
+ * folio_wait_fscache - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
+ *
+ * If this folio is currently being written to a local cache, wait for
+ * the write to finish.  Another write may start after this one finishes,
+ * unless the caller holds the folio lock.
+ */
+static inline void folio_wait_fscache(struct folio *folio)
+{
+	folio_wait_private_2(folio);
+}
+
+/**
+ * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
+ *
+ * If this folio is currently being written to a local cache, wait
+ * for the write to finish or for a fatal signal to be received.
+ * Another write may start after this one finishes, unless the caller
+ * holds the folio lock.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+static inline int folio_wait_fscache_killable(struct folio *folio)
+{
+	return folio_wait_private_2_killable(folio);
+}
+
+static inline void set_page_fscache(struct page *page)
+{
+	folio_start_fscache(page_folio(page));
+}
+
+static inline void end_page_fscache(struct page *page)
+{
+	folio_end_private_2(page_folio(page));
+}
+
+static inline void wait_on_page_fscache(struct page *page)
+{
+	folio_wait_private_2(page_folio(page));
+}
+
+static inline int wait_on_page_fscache_killable(struct page *page)
+{
+	return folio_wait_private_2_killable(page_folio(page));
+}
+
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 146a13e6a9d2..2ad4e1e88106 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -16,98 +16,9 @@
 
 #include <linux/workqueue.h>
 #include <linux/fs.h>
-#include <linux/pagemap.h>
 
 enum netfs_sreq_ref_trace;
 
-/*
- * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
- * a page is currently backed by a local disk cache
- */
-#define folio_test_fscache(folio)	folio_test_private_2(folio)
-#define PageFsCache(page)		PagePrivate2((page))
-#define SetPageFsCache(page)		SetPagePrivate2((page))
-#define ClearPageFsCache(page)		ClearPagePrivate2((page))
-#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
-#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
-
-/**
- * folio_start_fscache - Start an fscache write on a folio.
- * @folio: The folio.
- *
- * Call this function before writing a folio to a local cache.  Starting a
- * second write before the first one finishes is not allowed.
- */
-static inline void folio_start_fscache(struct folio *folio)
-{
-	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
-	folio_get(folio);
-	folio_set_private_2(folio);
-}
-
-/**
- * folio_end_fscache - End an fscache write on a folio.
- * @folio: The folio.
- *
- * Call this function after the folio has been written to the local cache.
- * This will wake any sleepers waiting on this folio.
- */
-static inline void folio_end_fscache(struct folio *folio)
-{
-	folio_end_private_2(folio);
-}
-
-/**
- * folio_wait_fscache - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait for
- * the write to finish.  Another write may start after this one finishes,
- * unless the caller holds the folio lock.
- */
-static inline void folio_wait_fscache(struct folio *folio)
-{
-	folio_wait_private_2(folio);
-}
-
-/**
- * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait
- * for the write to finish or for a fatal signal to be received.
- * Another write may start after this one finishes, unless the caller
- * holds the folio lock.
- *
- * Return:
- * - 0 if successful.
- * - -EINTR if a fatal signal was encountered.
- */
-static inline int folio_wait_fscache_killable(struct folio *folio)
-{
-	return folio_wait_private_2_killable(folio);
-}
-
-static inline void set_page_fscache(struct page *page)
-{
-	folio_start_fscache(page_folio(page));
-}
-
-static inline void end_page_fscache(struct page *page)
-{
-	folio_end_private_2(page_folio(page));
-}
-
-static inline void wait_on_page_fscache(struct page *page)
-{
-	folio_wait_private_2(page_folio(page));
-}
-
-static inline int wait_on_page_fscache_killable(struct page *page)
-{
-	return folio_wait_private_2_killable(page_folio(page));
-}
-
 enum fscache_io_source {
 	FSCACHE_FILL_WITH_ZEROES,
 	FSCACHE_DOWNLOAD_FROM_SERVER,
-- 
2.19.1.6.gb485710b

