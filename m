Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636E6B22DB
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 12:26:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXRj522ryz3cdM
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 22:26:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXRhz1gh3z3bhx
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 22:26:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdTT6VY_1678361192;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdTT6VY_1678361192)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 19:26:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: optimize dedupe matching
Date: Thu,  9 Mar 2023 19:26:28 +0800
Message-Id: <20230309112630.74230-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Match in words instead of byte granularity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/dedupe.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/lib/dedupe.c b/lib/dedupe.c
index 7f6e56f..84c323b 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -8,6 +8,45 @@
 #include "rolling_hash.h"
 #include "sha256.h"
 
+inline unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
+				   unsigned long sz)
+{
+	unsigned int n = sz;
+
+	if (sz >= sizeof(long) && ((long)s1 & (sizeof(long) - 1)) ==
+			((long)s2 & (sizeof(long) - 1))) {
+		const unsigned long *a1, *a2;
+
+		while ((long)s1 & (sizeof(long) - 1)) {
+			if (*s1 != *s2)
+				break;
+			++s1;
+			++s2;
+			--sz;
+		}
+
+		a1 = (const unsigned long *)s1;
+		a2 = (const unsigned long *)s2;
+		while (sz >= sizeof(long)) {
+			if (*a1 != *a2)
+				break;
+			++a1;
+			++a2;
+			sz -= sizeof(long);
+		}
+		s1 = (const u8 *)a1;
+		s2 = (const u8 *)a2;
+	}
+	while (sz) {
+		if (*s1 != *s2)
+			break;
+		++s1;
+		++s2;
+		--sz;
+	}
+	return n - sz;
+}
+
 static unsigned int window_size, rollinghash_rm;
 static struct rb_tree *dedupe_tree, *dedupe_subtree;
 
@@ -72,12 +111,9 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 		if (memcmp(sha256, e->prefix_sha256, sizeof(sha256)))
 			continue;
 
-		extra = 0;
-		while (cur + window_size + extra < ctx->end &&
-		       window_size + extra < e->original_length &&
-		       e->extra_data[extra] == cur[window_size + extra])
-			++extra;
-
+		extra = min_t(unsigned int, ctx->end - cur - window_size,
+			      e->original_length - window_size);
+		extra = erofs_memcmp2(cur + window_size, e->extra_data, extra);
 		if (window_size + extra <= ctx->cur - cur)
 			continue;
 		ctx->cur = cur;
-- 
2.24.4

