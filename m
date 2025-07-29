Return-Path: <linux-erofs+bounces-720-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998CB14D01
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jul 2025 13:26:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brtMN39K0z30WY;
	Tue, 29 Jul 2025 21:26:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753788368;
	cv=none; b=okqqmPGbBlWf5E1F8cK8za/Wvs8VVuW+2nv+xR7jydBuas0iBA1guZZR4yqNnVO/8zVBnJz3zyfnzVMG123ex8d2czp2ERi1MTOwRx1tp1IDiqrjWMkO+WKH7K03pdwlW2BIrNV4FseScHqDvcqNTMfwHHFFKsaqiE+JGNqZtBlIz0gG4O4VP/6sLCFOzJtZ+2BSaz/YoAACSR+PmnWh1+e9v+PBgqDd06y1X7UHZgsEFvikYn1IO4pgJ4MrzLcNuqGWNdTvS3ZK1a0djxYTGiJi1aa1ntfF/fUQHhX24cxywdlpV93CuMG/zdl5Y9aRkDtqGDtFGbbEAGRN3t6weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753788368; c=relaxed/relaxed;
	bh=f1xEie/wuvhR+l+y26rOm/RGsL7J3jhwMz/rq+jiOmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLqHGM8wGSbVTwvzcA+5hkMbKSJ5GiRczMFMCC52pqc1sIvukgCQZ2ayVrCWhiyrIPYmSpwhMzAiVHhyYQlphiN+wDACauGYRFBjr4lDsrsRgUMuBVBQG8Ye7dQ2s4ufs4liJolnDfZMVP+Mv1yNULyo8tzggpzNiPGJiuVqLuHRIndjvGPaGXpluox1ME/eWIXLfEa0wSq70MxMpSqXaJPHBtT3d3fF/YNygFgkrXbpTOI4XNyzX6+RIve6vlihwJ4Sw606UkLy0WplaCJ0LZZlpF9LPa4V+IYhmUlsF986LCh7JMgbNyrh8piTz2IQUz2fGX5lW/qv9T1t1DRHMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brtMM4PHfz30WT
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 21:26:07 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4brsrN2hFszSjgR
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:02:44 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F6E0140156
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:07:19 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 19:07:18 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhurui10@huawei.com>,
	<songgongzheng@huawei.com>, <lihongbo22@huawei.com>, <qinbinjuan@huawei.com>,
	<caihaomin@huawei.com>, <caihe@huawei.com>, zhaoyifan
	<zhaoyifan28@huawei.com>
Subject: [RFC 1/4] erofs-utils: mkfs: introduce source_mode enumeration
Date: Tue, 29 Jul 2025 19:06:07 +0800
Message-ID: <20250729110610.3438246-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
References: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

Currently, mkfs controls different image build execution flows through the
global variables `tar_mode` and `rebuild_mode`, while these two modes together
with default mode (build from local directory) are mutually exclusive.

Let's replace them with a new variable `source_mode` to simplify the logic.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mkfs/main.c | 79 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index e026596..3aa1421 100644
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
 
+enum {
+	EROFS_MKFS_SOURCE_DEFAULT,
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
+	case EROFS_MKFS_SOURCE_DEFAULT:
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
@@ -640,30 +669,14 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
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
+	case EROFS_MKFS_SOURCE_REBUILD:
+	default:
+		erofs_err("unexpected source_mode: %d", source_mode);
+		return -EINVAL;
 	}
 
-	if (rebuild_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		char *srcpath = cfg.c_src_path;
 		struct erofs_sb_info *src;
 
@@ -1083,7 +1096,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		err = mkfs_parse_sources(argc, argv, optind);
 		if (err)
 			return err;
-	} else if (!tar_mode) {
+	} else if (source_mode != EROFS_MKFS_SOURCE_TAR) {
 		erofs_err("missing argument: SOURCE(s)");
 		return -EINVAL;
 	} else {
@@ -1383,7 +1396,7 @@ int main(int argc, char **argv)
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		if (dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
 			erofstar.rvsp_mode = true;
 		erofstar.dev = rebuild_src_count + 1;
@@ -1403,9 +1416,7 @@ int main(int argc, char **argv)
 			g_sbi.blkszbits = 9;
 			tar_index_512b = true;
 		}
-	}
-
-	if (rebuild_mode) {
+	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		struct erofs_sb_info *src;
 
 		erofs_warn("EXPERIMENTAL rebuild mode in use. Use at your own risk!");
@@ -1465,7 +1476,7 @@ int main(int argc, char **argv)
 	else if (!incremental_mode)
 		erofs_uuid_generate(g_sbi.uuid);
 
-	if (tar_mode && !erofstar.index_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1528,7 +1539,7 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
@@ -1543,7 +1554,7 @@ int main(int argc, char **argv)
 		err = erofs_rebuild_dump_tree(root, incremental_mode);
 		if (err < 0)
 			goto exit;
-	} else if (rebuild_mode) {
+	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
@@ -1660,7 +1671,7 @@ exit:
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
 	erofs_exit_configure();
-	if (tar_mode) {
+	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		erofs_iostream_close(&erofstar.ios);
 		if (erofstar.ios.dumpfd >= 0)
 			close(erofstar.ios.dumpfd);
-- 
2.46.0


