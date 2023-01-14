Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1766A879
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 02:58:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nv1ff5Pycz3fB8
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 12:58:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nv1fT3G2Bz3cBP
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 12:58:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZWAukk_1673661515;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZWAukk_1673661515)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 09:58:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: remove linux/buffer_head.h dependency
Date: Sat, 14 Jan 2023 09:58:12 +0800
Message-Id: <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
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

EROFS actually never uses buffer heads, therefore just get rid of
BH_xxx definitions and linux/buffer_head.h inclusive.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 20 ++++++--------------
 fs/erofs/super.c    |  1 -
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 168c21f16383..b4cc40fa3803 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
-#include <linux/buffer_head.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -388,25 +387,18 @@ extern struct file_system_type erofs_fs_type;
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
-enum {
-	BH_Encoded = BH_PrivateStart,
-	BH_FullMapped,
-	BH_Fragment,
-	BH_Partialref,
-};
-
 /* Has a disk mapping */
-#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+#define EROFS_MAP_MAPPED	0x0001
 /* Located in metadata (could be copied from bd_inode) */
-#define EROFS_MAP_META		(1 << BH_Meta)
+#define EROFS_MAP_META		0x0002
 /* The extent is encoded */
-#define EROFS_MAP_ENCODED	(1 << BH_Encoded)
+#define EROFS_MAP_ENCODED	0x0004
 /* The length of extent is full */
-#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+#define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
+#define EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
-#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
+#define EROFS_MAP_PARTIAL_REF	0x0020
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 481788c24a68..36b795f1ad44 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include <linux/module.h>
-#include <linux/buffer_head.h>
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-- 
2.24.4

