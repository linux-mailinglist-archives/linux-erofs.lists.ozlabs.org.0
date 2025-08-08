Return-Path: <linux-erofs+bounces-793-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE08B1E0DE
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 05:15:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byq0W2CVWz3cDN;
	Fri,  8 Aug 2025 13:15:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754622923;
	cv=none; b=kvmjfpcNMKjdbQD3FJz8sICpA3t7VmVRL7j/3NFc9sEP8yXFoKvxUQmclAPo4MtXqdTFAyw4lCY/FwLwFo+B7BZYlbay+uzyramSGe5Qt2lbjPzjo+jCrC54dSBY08UGu7NKELoNzMgKJ9qDH0xr0VleSUpVpS+eeU/vApNvX7Km+ULoti37T9QIsVIalsZ5yCdfGdMpFwibw8opmqKQ/GuWCiZpDUvALmTmG71sN03GeM8XPcEM9xRWkcBn1v67V3dRomIEaMU4gH2wyUaV6qI6VBoDl6j8uh4j3186DTdVTeQJRFod+D/Oh8qJWFmu1gRteBnCA430DDVKk6XiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754622923; c=relaxed/relaxed;
	bh=dn6ACVCadKGzNwvaJWHjx1+209ldC+ceUK6/BxXiyRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhFQcEPS7pAeiXSsM2YPmp5jcVxNF9LsGcrfm9yEcCImE638Nk6i9xhrt9T0Qh698w2gmfv2JOh61J2WNYvWIJBrLsvo+/S+hsXhNT2ggwOgfrO5YsERjwyfbhu56uGzLBnxgSmgMJN7Sj9+K7qA4rX3p+XmyBIm8DlqpE8TEhaV6RSt6Z3XsFR5PyKCz7Gabm25fhWFAKpLxsY0S/TfpEB4vpn6JpLHGvUqULKEMF6gIwU65ROPsv4Px5E38+T0L8Ljaa+RB4iZMjY0j7/Ao/gU4r2UFNZ4tnevnnO4tC1XdMElPxrjZ0xrV+hrQ6wMNrPT73N+UGR5JT4MlzzIAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoV4c6mo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KoV4c6mo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byq0T1Znyz30Vl
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 13:15:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754622915; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dn6ACVCadKGzNwvaJWHjx1+209ldC+ceUK6/BxXiyRY=;
	b=KoV4c6mozssYUjudda8uqh5+UnrcDh/XuWosBm7EpjLqLxtm8zYMgUBEZ3XS4/mGXVCcANW6yQJ4XJSG76db3Y3bIjPlNNyCstzldC6VdIBD2VeEvZsy+o4GrgtAbywZdDsnnS3J9p8oexhxeYGDT7ooeGL/vnI3izysi1bOWLk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlFkAUe_1754622909 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 11:15:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v7 1/4] erofs-utils: mkfs: introduce source_mode enumeration
Date: Fri,  8 Aug 2025 11:15:05 +0800
Message-ID: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Yifan Zhao <zhaoyifan28@huawei.com>

Currently, mkfs controls different image build execution flows through
the global variables `tar_mode` and `rebuild_mode`, while these two
modes together with localdir mode are mutually exclusive.

Let's replace them with a new variable `source_mode` to simplify the
logic.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 78 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index dc2df06..ab27b77 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -244,7 +244,7 @@ static int pclustersize_metabox = -1;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
-static bool tar_mode, rebuild_mode, incremental_mode;
+static bool incremental_mode;
 static u8 metabox_algorithmid;
 
 enum {
@@ -254,6 +254,12 @@ enum {
 	EROFS_MKFS_DATA_IMPORT_SPARSE,
 } dataimport_mode;
 
+static enum {
+	EROFS_MKFS_SOURCE_LOCALDIR,
+	EROFS_MKFS_SOURCE_TAR,
+	EROFS_MKFS_SOURCE_REBUILD,
+} source_mode;
+
 static unsigned int rebuild_src_count, total_ccfgs;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
@@ -499,7 +505,7 @@ static void mkfs_parse_tar_cfg(char *cfg)
 {
 	char *p;
 
-	tar_mode = true;
+	source_mode = EROFS_MKFS_SOURCE_TAR;
 	if (!cfg)
 		return;
 	p = strchr(cfg, ',');
@@ -616,7 +622,30 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 	int err, fd;
 	char *s;
 
-	if (tar_mode) {
+	switch (source_mode) {
+	case EROFS_MKFS_SOURCE_LOCALDIR:
+		err = lstat((s = argv[optind++]), &st);
+		if (err) {
+			erofs_err("failed to stat %s: %s", s,
+				  erofs_strerror(-errno));
+			return -ENOENT;
+		}
+		if (S_ISDIR(st.st_mode)) {
+			cfg.c_src_path = realpath(s, NULL);
+			if (!cfg.c_src_path) {
+				erofs_err("failed to parse source directory: %s",
+					  erofs_strerror(-errno));
+				return -ENOENT;
+			}
+			erofs_set_fs_root(cfg.c_src_path);
+		} else {
+			cfg.c_src_path = strdup(s);
+			if (!cfg.c_src_path)
+				return -ENOMEM;
+			source_mode = EROFS_MKFS_SOURCE_REBUILD;
+		}
+		break;
+	case EROFS_MKFS_SOURCE_TAR:
 		cfg.c_src_path = strdup(argv[optind++]);
 		if (!cfg.c_src_path)
 			return -ENOMEM;
@@ -640,30 +669,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 			}
 			erofstar.ios.dumpfd = fd;
 		}
-	} else {
-		err = lstat((s = argv[optind++]), &st);
-		if (err) {
-			erofs_err("failed to stat %s: %s", s,
-				  erofs_strerror(-errno));
-			return -ENOENT;
-		}
-		if (S_ISDIR(st.st_mode)) {
-			cfg.c_src_path = realpath(s, NULL);
-			if (!cfg.c_src_path) {
-				erofs_err("failed to parse source directory: %s",
-					  erofs_strerror(-errno));
-				return -ENOENT;
-			}
-			erofs_set_fs_root(cfg.c_src_path);
-		} else {
-			cfg.c_src_path = strdup(s);
-			if (!cfg.c_src_path)
-				return -ENOMEM;
-			rebuild_mode = true;
-		}
+		break;
+	default:
+		erofs_err("unexpected source_mode: %d", source_mode);
+		return -EINVAL;
 	}
 
-	if (rebuild_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		char *srcpath = cfg.c_src_path;
 		struct erofs_sb_info *src;
 
@@ -1083,7 +1095,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		err = mkfs_parse_sources(argc, argv, optind);
 		if (err)
 			return err;
-	} else if (!tar_mode) {
+	} else if (source_mode != EROFS_MKFS_SOURCE_TAR) {
 		erofs_err("missing argument: SOURCE(s)");
 		return -EINVAL;
 	} else {
@@ -1383,7 +1395,7 @@ int main(int argc, char **argv)
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		if (dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
 			erofstar.rvsp_mode = true;
 		erofstar.dev = rebuild_src_count + 1;
@@ -1403,9 +1415,7 @@ int main(int argc, char **argv)
 			g_sbi.blkszbits = 9;
 			tar_index_512b = true;
 		}
-	}
-
-	if (rebuild_mode) {
+	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		struct erofs_sb_info *src;
 
 		erofs_warn("EXPERIMENTAL rebuild mode in use. Use at your own risk!");
@@ -1465,7 +1475,7 @@ int main(int argc, char **argv)
 	else if (!incremental_mode)
 		erofs_uuid_generate(g_sbi.uuid);
 
-	if (tar_mode && !erofstar.index_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1528,7 +1538,7 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
@@ -1543,7 +1553,7 @@ int main(int argc, char **argv)
 		err = erofs_rebuild_dump_tree(root, incremental_mode);
 		if (err < 0)
 			goto exit;
-	} else if (rebuild_mode) {
+	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
@@ -1663,7 +1673,7 @@ exit:
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
 	erofs_exit_configure();
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		erofs_iostream_close(&erofstar.ios);
 		if (erofstar.ios.dumpfd >= 0)
 			close(erofstar.ios.dumpfd);
-- 
2.43.5


