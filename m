Return-Path: <linux-erofs+bounces-466-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28984ADE788
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jun 2025 11:58:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMfMN0bcDz2xS2;
	Wed, 18 Jun 2025 19:58:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750240719;
	cv=none; b=k32/SGLuotnX0keFz4ybTunaD832mZ3/3eIEWcb+ol9sVMe4QDZWxs7B7/FV+833e1Je+SUEIaMuGp7G759wgTTtYrE/N15OozxIISP+GcduweuCFHgNb36mwh2+4VkaN09Lzmzcf43OTi8C5feH/WNNsXqAGtLqPecjqokHecmBMTjER3/z2PLMBLDPMz0Or30KgAp4Y2MSMKzDOQDYuH3J+sQwSp3U869j1BuZwcR2QiVW9/GjKAoXzuRz3A3A+xVqiEf7L21l/GXXLYR3mWZ9Twuy8U/IIsGP1lbV1xl+20NIC2o/aVLVCRVbzAvngKiUBhwfRnr/G9e9wrC21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750240719; c=relaxed/relaxed;
	bh=HS702DW3mB+zAU3aPOwCwXHQmxZaTNWFVusCiYB31J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kekp5Sj1DqWmoxl2JDrmHD38xrTDtlbEp4nOeBS1OLYrQG9qVdJwQ1GpyXt0Gp94xJeTx/1XTXnZmKnPsDYe9il+iGuUftsisp3o9GeZLDnmnC9tq3QzKUdroDE9dmckoppkrSO81zm0/VTwqbTDlsyTJR+2iXeu4hNxFA6NrYpYPQ4HfFhNYc0D8Srv2LGCPBiSE7EWy9HlH193+NgIW4Q8rXsGgQJ3w8P0CDtSt8nWyxxO844iNglgfFSjOu4eJcL+meI+saKjOax3pe+T0u+7FUe5B090iPYSI/SwZTQeqXAEMfllWa8TURIr+mx4riiIK3FikDCu9YH7TtToeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0T+1xQb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0T+1xQb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMfML0H7Nz2xPc
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 19:58:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750240713; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HS702DW3mB+zAU3aPOwCwXHQmxZaTNWFVusCiYB31J8=;
	b=P0T+1xQb98dfzsTXA4L0HEU6E6f/t4sS2hPuUgAb1lDxHELOwl9ZNSJBPTpJ2jS0iG6ph4Ibhs1UIduyB8JtLFYnLNo5OCxoz7D4d+1MBU6iW+Rh5SPK2TOi5enfSKrm+vDLv20oYsD8QAnLysWFfoakR2HqDYHFhQgd+BlZAXM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeDAHYI_1750240707 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Jun 2025 17:58:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: introduce mutex & rwlock wrappers
Date: Wed, 18 Jun 2025 17:58:25 +0800
Message-ID: <20250618095826.1291494-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

To avoid too many `#ifdef EROFS_MT_ENABLED`s.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/lock.h | 44 +++++++++++++++++++++++++++++++++++++++++++
 lib/fragments.c      | 45 ++++++++++++++------------------------------
 2 files changed, 58 insertions(+), 31 deletions(-)
 create mode 100644 include/erofs/lock.h

diff --git a/include/erofs/lock.h b/include/erofs/lock.h
new file mode 100644
index 0000000..f7a4b47
--- /dev/null
+++ b/include/erofs/lock.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_LOCK_H
+#define __EROFS_LOCK_H
+
+#include "defs.h"
+
+#if defined(HAVE_PTHREAD_H) && defined(EROFS_MT_ENABLED)
+#include <pthread.h>
+
+typedef pthread_mutex_t erofs_mutex_t;
+
+static inline void erofs_mutex_init(erofs_mutex_t *lock)
+{
+	pthread_mutex_init(lock, NULL);
+}
+#define erofs_mutex_lock	pthread_mutex_lock
+#define erofs_mutex_unlock	pthread_mutex_unlock
+
+typedef pthread_rwlock_t erofs_rwsem_t;
+
+static inline void erofs_init_rwsem(erofs_rwsem_t *lock)
+{
+	pthread_rwlock_init(lock, NULL);
+}
+#define erofs_down_read		pthread_rwlock_rdlock
+#define erofs_down_write	pthread_rwlock_wrlock
+#define erofs_up_read		pthread_rwlock_unlock
+#define erofs_up_write		pthread_rwlock_unlock
+#else
+typedef struct {} erofs_mutex_t;
+
+static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
+static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
+static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
+
+typedef struct {} erofs_rwsem_t;
+static inline void erofs_init_rwsem(erofs_rwsem_t *lock) {}
+static inline void erofs_down_read(erofs_rwsem_t *lock) {}
+static inline void erofs_down_write(erofs_rwsem_t *lock) {}
+static inline void erofs_up_read(erofs_rwsem_t *lock) {}
+static inline void erofs_up_write(erofs_rwsem_t *lock) {}
+
+#endif
+#endif
diff --git a/lib/fragments.c b/lib/fragments.c
index 0784a82..28963cd 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -19,6 +19,7 @@
 #include "erofs/internal.h"
 #include "erofs/fragments.h"
 #include "erofs/bitops.h"
+#include "erofs/lock.h"
 #include "liberofs_private.h"
 #ifdef HAVE_SYS_SENDFILE_H
 #include <sys/sendfile.h>
@@ -38,18 +39,14 @@ struct erofs_fragmentitem {
 
 struct erofs_fragment_bucket {
 	struct list_head hash;
-#ifdef EROFS_MT_ENABLED
-	pthread_rwlock_t lock;
-#endif
+	erofs_rwsem_t lock;
 };
 
 struct erofs_packed_inode {
 	struct erofs_fragment_bucket *bks;
 	int fd;
 	unsigned long *uptodate;
-#if EROFS_MT_ENABLED
-	pthread_mutex_t mutex;
-#endif
+	erofs_mutex_t mutex;
 	u64 uptodate_bits;
 };
 
@@ -146,9 +143,7 @@ int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
 	e1 = s1 - EROFS_TOF_HASHLEN;
 	deduped = 0;
 
-#ifdef EROFS_MT_ENABLED
-	pthread_rwlock_rdlock(&bk->lock);
-#endif
+	erofs_down_read(&bk->lock);
 	list_for_each_entry(cur, &bk->hash, list) {
 		unsigned int e2, mn;
 		erofs_off_t inmax, i;
@@ -181,9 +176,7 @@ int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
 		if (deduped == inode->i_size)
 			break;
 	}
-#ifdef EROFS_MT_ENABLED
-	pthread_rwlock_unlock(&bk->lock);
-#endif
+	erofs_up_read(&bk->lock);
 	free(data);
 	if (deduped) {
 		DBG_BUGON(!fi);
@@ -348,30 +341,23 @@ int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh)
 	offset += fi->length;
 
 	if (!list_empty(&fi->list)) {
-#ifdef EROFS_MT_ENABLED
 		struct erofs_fragment_bucket *bk = &epi->bks[FRAGMENT_HASH(tofh)];
-#endif
 		void *nb;
 
 		sz = min_t(u64, fi->length, EROFS_FRAGMENT_INMEM_SZ_MAX);
-#ifdef EROFS_MT_ENABLED
-		pthread_rwlock_wrlock(&bk->lock);
-#endif
+
+		erofs_down_write(&bk->lock);
 		memmove(fi->data, fi->data + fi->length - sz, sz);
 
 		nb = realloc(fi->data, sz);
 		if (!nb) {
-#ifdef EROFS_MT_ENABLED
-			pthread_rwlock_unlock(&bk->lock);
-#endif
+			erofs_up_write(&bk->lock);
 			fi->data = NULL;
 			return -ENOMEM;
 		}
 		fi->data = nb;
 		fi->pos = (erofs_off_t)offset;
-#ifdef EROFS_MT_ENABLED
-		pthread_rwlock_unlock(&bk->lock);
-#endif
+		erofs_up_write(&bk->lock);
 		inode->fragmentoff = fi->pos - len;
 		return 0;
 	}
@@ -451,9 +437,7 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 		}
 		for (i = 0; i < FRAGMENT_HASHSIZE; ++i) {
 			init_list_head(&epi->bks[i].hash);
-#ifdef EROFS_MT_ENABLED
-			pthread_rwlock_init(&epi->bks[i].lock, NULL);
-#endif
+			erofs_init_rwsem(&epi->bks[i].lock);
 		}
 	}
 
@@ -489,6 +473,7 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			err = -ENOMEM;
 			goto err_out;
 		}
+		erofs_mutex_init(&epi->mutex);
 	}
 	return 0;
 
@@ -616,23 +601,21 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			uptodate = __erofs_test_bit(bnr, epi->uptodate);
 			if (!uptodate) {
 #if EROFS_MT_ENABLED
-				pthread_mutex_lock(&epi->mutex);
+				erofs_mutex_lock(&epi->mutex);
 				uptodate = __erofs_test_bit(bnr, epi->uptodate);
 				if (!uptodate) {
 #endif
 					free(buffer);
 					buffer = erofs_packedfile_preload(&pi, &map);
 					if (IS_ERR(buffer)) {
-#if EROFS_MT_ENABLED
-						pthread_mutex_unlock(&epi->mutex);
-#endif
+						erofs_mutex_unlock(&epi->mutex);
 						buffer = NULL;
 						goto fallback;
 					}
 
 #if EROFS_MT_ENABLED
 				}
-				pthread_mutex_unlock(&epi->mutex);
+				erofs_mutex_unlock(&epi->mutex);
 #endif
 			}
 
-- 
2.43.5


