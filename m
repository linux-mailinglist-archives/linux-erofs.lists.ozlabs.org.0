Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 964AA9389B5
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 09:12:04 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NZ3mjRrE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSBKt3pL4z3cSn
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 17:12:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NZ3mjRrE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSBKd2vq6z3c75
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 17:11:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721632303; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LJkfJ4cDKLy+LBQYqj6mWU0wVVBAPAQNTqyxsXIlgLA=;
	b=NZ3mjRrEg2EtiUFCpCqET+/bxXrXmsGzFBgfAVcaJ5rXCUJYFbZiLLo3PiOAZVK9Em1z/cczOHCi0htavE7/t8gOR3uMcYnrYbgM8nPicSgzhBx9vC2VKzqqH3Dh6OJjUsXMt8EW4noaum3kMyhdzYfDF19VUTINdEQ5bA4zgX8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WB-pINd_1721632302;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WB-pINd_1721632302)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 15:11:43 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/3] erofs-utils: lib: add bitops header
Date: Mon, 22 Jul 2024 15:11:38 +0800
Message-ID: <20240722071140.1416782-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add bitops header for subsequent bloom filter implementation.
This is borrowed from a part of the previous patch. See:
https://lore.kernel.org/all/20230802091750.74181-3-jefflexu@linux.alibaba.com/.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Rename the bitops functions.
v1: https://lore.kernel.org/all/20240718054025.427439-1-hongzhen@linux.alibaba.com/
---
 include/erofs/bitops.h | 37 +++++++++++++++++++++++++++++++++++++
 lib/Makefile.am        |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 include/erofs/bitops.h

diff --git a/include/erofs/bitops.h b/include/erofs/bitops.h
new file mode 100644
index 0000000..fa31934
--- /dev/null
+++ b/include/erofs/bitops.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_BITOPS_H
+#define __EROFS_BITOPS_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "defs.h"
+
+static inline void __set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	*p  |= mask;
+}
+
+static inline void __clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	*p &= ~mask;
+}
+
+static inline int __test_bit(int nr, const volatile unsigned long *addr)
+{
+	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 2cb4cab..6b52470 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -20,6 +20,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/io.h \
       $(top_srcdir)/include/erofs/list.h \
       $(top_srcdir)/include/erofs/print.h \
+      $(top_srcdir)/include/erofs/bitops.h \
       $(top_srcdir)/include/erofs/tar.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
-- 
2.43.5

