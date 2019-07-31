Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ED37C80D
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 18:01:44 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zJ843ZqlzDqhF
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 02:01:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zJ4b0tryzDqkx
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2019 01:58:38 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 09FD32DD93561FA515BD;
 Wed, 31 Jul 2019 23:58:36 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:26 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu
 <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 14/22] staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM
Date: Wed, 31 Jul 2019 23:57:44 +0800
Message-ID: <20190731155752.210602-15-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731155752.210602-1-gaoxiang25@huawei.com>
References: <20190731155752.210602-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Turn into a module parameter ("use_vmap") as it
can be set at runtime.

Suggested-by: David Sterba <dsterba@suse.cz>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 .../erofs/Documentation/filesystems/erofs.txt |  4 ++++
 drivers/staging/erofs/Kconfig                 |  8 -------
 drivers/staging/erofs/decompressor.c          | 22 +++++++++++--------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
index 74cf84ac48a3..04cf47865c50 100644
--- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
+++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
@@ -66,6 +66,10 @@ fault_injection=%d     Enable fault injection in all supported types with
 (no)acl                Setup POSIX Access Control List. Note: acl is enabled
                        by default if CONFIG_EROFS_FS_POSIX_ACL is selected.
 
+Module parameters
+=================
+use_vmap=[0|1]         Use vmap() instead of vm_map_ram() (default 0).
+
 On-disk details
 ===============
 
diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 747e9eebfaa5..788beebf3f7d 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -63,14 +63,6 @@ config EROFS_FS_SECURITY
 
 	  If you are not using a security module, say N.
 
-config EROFS_FS_USE_VM_MAP_RAM
-	bool "EROFS VM_MAP_RAM Support"
-	depends on EROFS_FS
-	help
-	  use vm_map_ram/vm_unmap_ram instead of vmap/vunmap.
-
-	  If you don't know what these are, say N.
-
 config EROFS_FAULT_INJECTION
 	bool "EROFS fault injection facility"
 	depends on EROFS_FS
diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index 744c43a456e9..5361a2bbedb6 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -7,6 +7,7 @@
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "compress.h"
+#include <linux/module.h>
 #include <linux/lz4.h>
 
 #ifndef LZ4_DISTANCE_MAX	/* history window size */
@@ -29,6 +30,10 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
+static bool use_vmap;
+module_param(use_vmap, bool, 0444);
+MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
+
 static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 				 struct list_head *pagepool)
 {
@@ -219,29 +224,28 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
 
 static void *erofs_vmap(struct page **pages, unsigned int count)
 {
-#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
 	int i = 0;
 
+	if (use_vmap)
+		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
+
 	while (1) {
 		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
+
 		/* retry two more times (totally 3 times) */
 		if (addr || ++i >= 3)
 			return addr;
 		vm_unmap_aliases();
 	}
 	return NULL;
-#else
-	return vmap(pages, count, VM_MAP, PAGE_KERNEL);
-#endif
 }
 
 static void erofs_vunmap(const void *mem, unsigned int count)
 {
-#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
-	vm_unmap_ram(mem, count);
-#else
-	vunmap(mem);
-#endif
+	if (!use_vmap)
+		vm_unmap_ram(mem, count);
+	else
+		vunmap(mem);
 }
 
 static int decompress_generic(struct z_erofs_decompress_req *rq,
-- 
2.17.1

