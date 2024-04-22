Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E248AC26D
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:35:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U97SeULQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5rV5Rphz3cSd
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:35:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U97SeULQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5rP1QwXz3bTt
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:35:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA4DA60C07;
	Mon, 22 Apr 2024 00:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706C4C113CE;
	Mon, 22 Apr 2024 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746130;
	bh=d9SkvCVIdBDLu+jTB3Jz/ywbUfcy+/+yN/31VZylbg0=;
	h=From:To:Cc:Subject:Date:From;
	b=U97SeULQuwo/hNtwd2j7/f+pr7ssM901vYbPR7A8fiZsg9Dq8mXZ03dtGiCYffvGw
	 7jQHcYX2032Ys/ZO59NCyzIO/h1cpCQMJbUIh2XDjj1YV6fs5yCE55OOmJ4OKoV8fO
	 oY4gV74St9+DUIl5kmMFbr2eJsJkcryNMi/xPg86Pi6EpMyD1b8DpMx9mDYr/PREJI
	 rFIgm52jzgLzM0bXVoDL8tMQlJmD7XQULQsZUNOsoBVY7g1f5tcvFP3TXS19ECXif4
	 YDHAFcytOJPOVXUZ9VLuQ7fL5TMLMkxNjAzmw0zTXb0X+f/qPd0mt2g3fNiyPH9+TO
	 cbd3wgMsQY+tA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/8] erofs-utils: use erofs_atomic_t for inode->i_count
Date: Mon, 22 Apr 2024 08:34:43 +0800
Message-Id: <20240422003450.19132-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Since `inode->i_count` can be touched for more than one thread if
multi-threading is enabled.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
patchset v1->v2:
 - Fix `--all-fragments` functionality;
 - Fix issues pointed out by Yifan. 

 include/erofs/atomic.h   | 10 ++++++++++
 include/erofs/inode.h    |  2 +-
 include/erofs/internal.h |  3 ++-
 lib/inode.c              |  5 +++--
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
index 214cdb1..f28687e 100644
--- a/include/erofs/atomic.h
+++ b/include/erofs/atomic.h
@@ -25,4 +25,14 @@ __n;})
 #define erofs_atomic_test_and_set(ptr) \
 	__atomic_test_and_set(ptr, __ATOMIC_RELAXED)
 
+#define erofs_atomic_add_return(ptr, i) \
+	__atomic_add_fetch(ptr, i, __ATOMIC_RELAXED)
+
+#define erofs_atomic_sub_return(ptr, i) \
+	__atomic_sub_fetch(ptr, i, __ATOMIC_RELAXED)
+
+#define erofs_atomic_inc_return(ptr) erofs_atomic_add_return(ptr, 1)
+
+#define erofs_atomic_dec_return(ptr) erofs_atomic_sub_return(ptr, 1)
+
 #endif
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index d5a732a..5d6bc98 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -17,7 +17,7 @@ extern "C"
 
 static inline struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
 {
-	++inode->i_count;
+	(void)erofs_atomic_inc_return(&inode->i_count);
 	return inode;
 }
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 4cd2059..f31e548 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -25,6 +25,7 @@ typedef unsigned short umode_t;
 #ifdef HAVE_PTHREAD_H
 #include <pthread.h>
 #endif
+#include "atomic.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -169,7 +170,7 @@ struct erofs_inode {
 		/* (mkfs.erofs) next pointer for directory dumping */
 		struct erofs_inode *next_dirwrite;
 	};
-	unsigned int i_count;
+	erofs_atomic_t i_count;
 	struct erofs_sb_info *sbi;
 	struct erofs_inode *i_parent;
 
diff --git a/lib/inode.c b/lib/inode.c
index 7508c74..55969d9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -129,9 +129,10 @@ struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid)
 unsigned int erofs_iput(struct erofs_inode *inode)
 {
 	struct erofs_dentry *d, *t;
+	unsigned long got = erofs_atomic_dec_return(&inode->i_count);
 
-	if (inode->i_count > 1)
-		return --inode->i_count;
+	if (got >= 1)
+		return got;
 
 	list_for_each_entry_safe(d, t, &inode->i_subdirs, d_child)
 		free(d);
-- 
2.30.2

