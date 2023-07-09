Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C974C6FB
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Jul 2023 20:25:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzbCz3rDJz3bWS
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 04:25:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzbCn3rGPz30dp
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 04:25:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vmvroi3_1688927118;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmvroi3_1688927118)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 02:25:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: switch to effective unaligned access
Date: Mon, 10 Jul 2023 02:25:08 +0800
Message-Id: <20230709182511.96954-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
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

In order to prepare for LZ77 matchfinder.  Note that erofs_memcmp2()
is still not quite effective.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h     | 24 ++++++++++++++++++++++--
 include/erofs/internal.h |  2 --
 lib/dedupe.c             | 23 ++++++++++++++++++-----
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index e5aa23c..44af557 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -179,9 +179,29 @@ typedef int64_t         s64;
 #define __maybe_unused      __attribute__((__unused__))
 #endif
 
-static inline u32 get_unaligned_le32(const u8 *p)
+#define __packed __attribute__((__packed__))
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
+#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpu(__get_unaligned_t(__le32, p));
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
 {
-	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
+	__put_unaligned_t(__le32, cpu_to_le32(val), p);
 }
 
 /**
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ab964d4..aad2115 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -17,8 +17,6 @@ extern "C"
 
 typedef unsigned short umode_t;
 
-#define __packed __attribute__((__packed__))
-
 #include "erofs_fs.h"
 #include <fcntl.h>
 #include <sys/types.h> /* for off_t definition */
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 0a69b8f..17da452 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -11,12 +11,14 @@
 unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
 			    unsigned long sz)
 {
+	const unsigned long *a1, *a2;
 	unsigned long n = sz;
 
-	if (sz >= sizeof(long) && ((long)s1 & (sizeof(long) - 1)) ==
-			((long)s2 & (sizeof(long) - 1))) {
-		const unsigned long *a1, *a2;
+	if (sz < sizeof(long))
+		goto out_bytes;
 
+	if (((long)s1 & (sizeof(long) - 1)) ==
+			((long)s2 & (sizeof(long) - 1))) {
 		while ((long)s1 & (sizeof(long) - 1)) {
 			if (*s1 != *s2)
 				break;
@@ -34,9 +36,20 @@ unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
 			++a2;
 			sz -= sizeof(long);
 		}
-		s1 = (const u8 *)a1;
-		s2 = (const u8 *)a2;
+	} else {
+		a1 = (const unsigned long *)s1;
+		a2 = (const unsigned long *)s2;
+		do {
+			if (get_unaligned(a1) != get_unaligned(a2))
+				break;
+			++a1;
+			++a2;
+			sz -= sizeof(long);
+		} while (sz >= sizeof(long));
 	}
+	s1 = (const u8 *)a1;
+	s2 = (const u8 *)a2;
+out_bytes:
 	while (sz) {
 		if (*s1 != *s2)
 			break;
-- 
2.24.4

