Return-Path: <linux-erofs+bounces-826-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D9B2AB67
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 16:48:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Fv15rNqz3cZx;
	Tue, 19 Aug 2025 00:47:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755528477;
	cv=none; b=BeMQDbX8lG2BXQ5LcKctnmElU/S5j4i519kd7dukIIr1oFvL4Nvu7IMOgmhKEf7zPKg0SCW0clX4dzDOY71t1zR3fZ440sAQwdyDAMAuFr6fRMBswdOkLsh0+b+Dw36zaWd6Mb961pMNik3UgDOrcX8gaBj7ZWFpeo7kj7iJ38aGLhsXIseCJdQheZIyUgAg6INWKSEsPMhCfYUxEjKYTOayj8N55K6OVpNDFEgJ4aI5TXpM/Hns4x9DkSWJqbXCoP+hEA5pIXxxd3rC1jsL9feoz6FUjSBBjbmpBOK65CYJ/svHViVJGtGr3CfWvSiYvG87rB1lOStgYxP0GsGBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755528477; c=relaxed/relaxed;
	bh=hiVTGGBly1nLLjNGNja6V5dYjZ3woS+qTfyRPehJh2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+q/8/0crZ4PAoPCW8gSK3CFsIJbihugAkjizV5w7ZxuWqmq8RWWuQhl9BpFl4AmNjTnA8XYMnK8Vpcfj1imIvIz/Ff/9r/xKBQo9f2Wv8oW8KCY+B7cw018LH28tQ1OabisUFb3UgwN/krXPdKQiCTF0aRKsHrq5II+JETYzV11U6tvudrGNl3lx9bqG7Ckb+kTpGl3IiZ7IkSezHfvlsltc6qYT9SV4r7zmp64xsfAbZKLGjhG716hvMRa0h5+mUJONckk0FHICIjGtJxjiP4WEwCYTwGO3iEwqxfaN4ce01NBbnbdmazj/Kx5q7oRBjDh012KoTMmZjpZfOrOMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YQ+hGKm3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YQ+hGKm3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Fty2kKwz3cYR
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 00:47:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755528469; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hiVTGGBly1nLLjNGNja6V5dYjZ3woS+qTfyRPehJh2Q=;
	b=YQ+hGKm3Bemcw9mtLSN2p0Uk4284mESUXMfjA/yqnDSD6ubay7F/vsn50F0S1Ht2zr/Xy62HnuNXHfan3n4CgHg+x6CTiK1363IYhdDQN7jrb+m6GY7ZvQnjWBDUUbkvM88ymNoLl8Wh4qZ1BvPIhK0Pr+MbEgyAWSMOxgBhEdQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm0YYdI_1755528467 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 22:47:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/7] erofs-utils: lib: introduce an importer framework
Date: Mon, 18 Aug 2025 22:47:36 +0800
Message-ID: <20250818144741.2586329-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
References: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
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


