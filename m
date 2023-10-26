Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3C7D7ACB
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 04:16:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SG8Yt72g6z3c5k
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 13:16:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SG8Yp63Q4z3c4M
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Oct 2023 13:16:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vuw8irE_1698286599;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vuw8irE_1698286599)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 10:16:43 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: tidy up redundant includes
Date: Thu, 26 Oct 2023 10:16:27 +0800
Message-Id: <20231026021627.23284-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231026021627.23284-1-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

- Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;

- Move common includes into "internal.h".

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/data.c                 | 2 --
 fs/erofs/decompressor.c         | 1 -
 fs/erofs/decompressor_deflate.c | 1 -
 fs/erofs/decompressor_lzma.c    | 1 -
 fs/erofs/internal.h             | 2 ++
 fs/erofs/super.c                | 3 ---
 6 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0c2c99c58b5e..ceb6c248bf40 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,9 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
-#include <linux/prefetch.h>
 #include <linux/sched/mm.h>
-#include <linux/dax.h>
 #include <trace/events/erofs.h>
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 332ec5f74002..29d539481a2b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -4,7 +4,6 @@
  *             https://www.huawei.com/
  */
 #include "compress.h"
-#include <linux/module.h>
 #include <linux/lz4.h>
 
 #ifndef LZ4_DISTANCE_MAX	/* history window size */
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 19e5bdeb30b6..c15ce24d51df 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-#include <linux/module.h>
 #include <linux/zlib.h>
 #include "compress.h"
 
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index dee10d22ada9..72a202740cdb 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/xz.h>
-#include <linux/module.h>
 #include "compress.h"
 
 struct z_erofs_lzma {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ca7d85958450..3551a5734e89 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -8,8 +8,10 @@
 #define __EROFS_INTERNAL_H
 
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include <linux/dcache.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/magic.h>
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 019229eb2ef6..f38ff2d63364 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -4,14 +4,11 @@
  *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
-#include <linux/module.h>
 #include <linux/statfs.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
-#include <linux/dax.h>
 #include <linux/exportfs.h>
 #include "xattr.h"
 
-- 
2.19.1.6.gb485710b

