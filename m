Return-Path: <linux-erofs+bounces-835-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2865FB2B784
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 05:28:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Zmf5QwXz3clh;
	Tue, 19 Aug 2025 13:28:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755574114;
	cv=none; b=kKcH5z02dgOJ08IVfD4krOYOSPzUWZ7KALbe/x9XntJA/t14djRicSq21+/OVNpTWCf4dDYq9MB9+0MS1FphVEC8cLOaShouCUr//lf7eMoiCrk1SguwOiVKMIsUEsYHX2zfiGUHOAnX3TEOV2FGaq0JnHo8DKZoUWMvpH/nfE1yDDfJ9XZ9OEkYCfGgxsOCbSwUcKw5AY06kiZnkyK3xcyewXj3Kb6ZKX1PutHTYrup+8+lxOxUjD02BFszKVm0lgtlQlsyqmDEdwQUspd5jcApK1ye6sLLGOIRPrQdFGCKju8EKjhWWSIOM0hz0mjIDwYalPa7M1K6re+s7DGkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755574114; c=relaxed/relaxed;
	bh=hiVTGGBly1nLLjNGNja6V5dYjZ3woS+qTfyRPehJh2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnZZRp7UYim+rdnRtQCRH7KQDs1+iz0yYFjSHTlCCLg0amVKtrWXpeonpyW5dxzAeKzVb6+OljJM6q34YtmK4yXgtCrTysL3BcOFZ7zNwhPvJYU3LIczijgqIQAl7ws4SO63CJlVRf7Lv1/TyZmVYdDx7bnYr6PIK1pCemp8nybK9yif0DcX//fAZiaWwLx9qNq1ggjV1WpJClF2HcTcEu+VIZ0NZCbVCxLbKnl9qz+Zgg3+IPN6I6yA9YGRDZNLSrovrV2100zM8LrEjUmlg8XiARTIDjDIlGs/CgHuXSKZQAyU4d8/47fBz0RfXl4NnQIxU0qnCF0Ky7nmmDD8qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BOzZbZG2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BOzZbZG2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5ZmZ6FWNz3clH
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 13:28:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755574106; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hiVTGGBly1nLLjNGNja6V5dYjZ3woS+qTfyRPehJh2Q=;
	b=BOzZbZG2qumDvZ1VI0jOoHhWsRAc3ny45DoAMkdaI79RXxnaJZE025LlQIqcqGOdyFkssgk6f0YG/CyY+30jHcV7ogNa8d4ca2DI9uU+9zZV8ocuaTUNJCdzk0vMsFKE3kfoGP7J1e9TRdYrTNmg2ei/s96CFkUzN0ikELOQWvA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm5DR6F_1755574104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:28:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 2/7] erofs-utils: lib: introduce an importer framework
Date: Tue, 19 Aug 2025 11:28:13 +0800
Message-ID: <20250819032818.3598157-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
References: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Introduce a generic importer mechanism to import data into the EROFS
filesystem tree using specific configuration parameters.

This allows mkfs parameters to be moved out of `struct erofs_configure`
and configured per instance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/importer.h | 31 ++++++++++++++++
 lib/Makefile.am          |  3 +-
 lib/importer.c           | 79 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              | 44 ++++++----------------
 4 files changed, 123 insertions(+), 34 deletions(-)
 create mode 100644 include/erofs/importer.h
 create mode 100644 lib/importer.c

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
new file mode 100644
index 0000000..7c29e03
--- /dev/null
+++ b/include/erofs/importer.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#ifndef __EROFS_IMPORTER_H
+#define __EROFS_IMPORTER_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "internal.h"
+
+struct erofs_importer_params {
+};
+
+struct erofs_importer {
+	struct erofs_importer_params *params;
+	struct erofs_sb_info *sbi;
+};
+
+void erofs_importer_preset(struct erofs_importer_params *params);
+int erofs_importer_init(struct erofs_importer *im);
+void erofs_importer_exit(struct erofs_importer *im);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index a3972b1..f485440 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,6 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/rebuild.h \
+      $(top_srcdir)/include/erofs/importer.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
@@ -38,7 +39,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
-		      vmdk.c metabox.c global.c
+		      vmdk.c metabox.c global.c importer.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/importer.c b/lib/importer.c
new file mode 100644
index 0000000..74bd24a
--- /dev/null
+++ b/lib/importer.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#include "erofs/fragments.h"
+#include "erofs/importer.h"
+#include "erofs/config.h"
+#include "erofs/dedupe.h"
+#include "erofs/inode.h"
+#include "erofs/print.h"
+#include "erofs/lock.h"
+#include "liberofs_metabox.h"
+
+static EROFS_DEFINE_MUTEX(erofs_importer_global_mutex);
+static bool erofs_importer_global_initialized;
+
+void erofs_importer_preset(struct erofs_importer_params *params)
+{
+	*params = (struct erofs_importer_params) {};
+}
+
+void erofs_importer_global_init(void)
+{
+	if (erofs_importer_global_initialized)
+		return;
+	erofs_mutex_lock(&erofs_importer_global_mutex);
+	if (!erofs_importer_global_initialized) {
+		erofs_inode_manager_init();
+		erofs_importer_global_initialized = true;
+	}
+	erofs_mutex_unlock(&erofs_importer_global_mutex);
+}
+
+int erofs_importer_init(struct erofs_importer *im)
+{
+	struct erofs_sb_info *sbi = im->sbi;
+	const char *subsys = NULL;
+	int err;
+
+	erofs_importer_global_init();
+
+	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
+		subsys = "packedfile";
+		if (!cfg.c_mkfs_pclustersize_packed)
+			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
+
+		err = erofs_packedfile_init(sbi, cfg.c_fragments);
+		if (err)
+			goto out_err;
+	}
+
+	if (cfg.c_mkfs_pclustersize_metabox >= 0) {
+		subsys = "metabox";
+		err = erofs_metabox_init(sbi);
+		if (err)
+			goto out_err;
+	}
+
+	if (cfg.c_fragments) {
+		subsys = "dedupe_ext";
+		err = z_erofs_dedupe_ext_init();
+		if (err)
+			goto out_err;
+	}
+	return 0;
+
+out_err:
+	erofs_err("failed to initialize %s: %s", subsys, erofs_strerror(-err));
+	return err;
+}
+
+void erofs_importer_exit(struct erofs_importer *im)
+{
+	struct erofs_sb_info *sbi = im->sbi;
+
+	z_erofs_dedupe_ext_exit();
+	erofs_metabox_exit(sbi);
+	erofs_packedfile_exit(sbi);
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index b8773fd..8b18b35 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -16,6 +16,7 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
+#include "erofs/importer.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/tar.h"
@@ -1475,6 +1476,11 @@ static void erofs_mkfs_showsummaries(void)
 
 int main(int argc, char **argv)
 {
+	struct erofs_importer_params importer_params;
+	struct erofs_importer importer = {
+		.params = &importer_params,
+		.sbi = &g_sbi,
+	};
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root = NULL;
 	bool tar_index_512b = false;
@@ -1488,6 +1494,7 @@ int main(int argc, char **argv)
 	if (err)
 		return 1;
 	erofs_mkfs_default_options();
+	erofs_importer_preset(&importer_params);
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	erofs_show_progs(argc, argv);
@@ -1534,26 +1541,10 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
-		if (!cfg.c_mkfs_pclustersize_packed)
-			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
 
-		err = erofs_packedfile_init(&g_sbi, cfg.c_fragments);
-		if (err) {
-			erofs_err("failed to initialize packedfile: %s",
-				  strerror(-err));
-			goto exit;
-		}
-	}
-
-	if (cfg.c_mkfs_pclustersize_metabox >= 0) {
-		err = erofs_metabox_init(&g_sbi);
-		if (err) {
-			erofs_err("failed to initialize metabox: %s",
-				  erofs_strerror(err));
-			goto exit;
-		}
-	}
+	err = erofs_importer_init(&importer);
+	if (err)
+		goto exit;
 
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
@@ -1677,15 +1668,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (cfg.c_fragments) {
-		err = z_erofs_dedupe_ext_init();
-		if (err) {
-			erofs_err("failed to initialize extent deduplication: %s",
-				  erofs_strerror(err));
-			goto exit;
-		}
-	}
-
 	if (cfg.c_chunkbits) {
 		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
@@ -1701,8 +1683,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	erofs_inode_manager_init();
-
 	if (source_mode == EROFS_MKFS_SOURCE_LOCALDIR) {
 		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
 		if (err) {
@@ -1837,10 +1817,8 @@ int main(int argc, char **argv)
 exit:
 	if (root)
 		erofs_iput(root);
-	erofs_metabox_exit(&g_sbi);
 	z_erofs_compress_exit(&g_sbi);
 	z_erofs_dedupe_exit();
-	z_erofs_dedupe_ext_exit();
 	blklst = erofs_blocklist_close();
 	if (blklst)
 		fclose(blklst);
@@ -1849,7 +1827,6 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
-	erofs_packedfile_exit(&g_sbi);
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
@@ -1858,6 +1835,7 @@ exit:
 		if (erofstar.ios.dumpfd >= 0)
 			close(erofstar.ios.dumpfd);
 	}
+	erofs_importer_exit(&importer);
 
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
-- 
2.43.5


