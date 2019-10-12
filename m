Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F903D4C2B
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 04:41:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qpwX6tQNzDqYd
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 13:41:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qpwS2KVYzDqVq
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 13:40:55 +1100 (AEDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 57B9724C629F2D510FB4
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 10:40:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 12 Oct
 2019 10:40:42 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: fix old kernel compatibility for non-lz4
 compression
Date: Sat, 12 Oct 2019 10:43:45 +0800
Message-ID: <20191012024345.181737-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If primary algorithm is not lz4 (e.g. compression
off), clear EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
for old kernel (upstream kernel <= 5.2.y) compatibility.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

It isn't really clean for the long term, but we can wrap it later
after more compression algorithms integrated.

 lib/compress.c | 14 +++++++++++++-
 lib/config.c   |  2 --
 mkfs/main.c    |  3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 7f65e5e26938..fdf093b69891 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -504,9 +504,21 @@ int z_erofs_compress_init(void)
 	/* initialize for primary compression algorithm */
 	int ret = erofs_compressor_init(&compresshandle,
 					cfg.c_compr_alg_master);
-	if (ret || !cfg.c_compr_alg_master)
+
+	if (ret)
 		return ret;
 
+	/*
+	 * if primary algorithm is not lz4* (e.g. compression off),
+	 * clear LZ4_0PADDING feature for old kernel compatibility.
+	 */
+	if (!cfg.c_compr_alg_master ||
+	    strncmp(cfg.c_compr_alg_master, "lz4", 3))
+		sbi.feature_incompat &= ~EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+
+	if (!cfg.c_compr_alg_master)
+		return 0;
+
 	compressionlevel = cfg.c_compr_level_master < 0 ?
 		compresshandle.alg->default_level :
 		cfg.c_compr_level_master;
diff --git a/lib/config.c b/lib/config.c
index 4cddc252b46a..46625d7c61c7 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -19,9 +19,7 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = 0;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
-	cfg.c_legacy_compress = false;
 	cfg.c_compr_level_master = -1;
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_unix_timestamp = -1;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 1df69d74b633..536b784eec01 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -215,6 +215,9 @@ int main(int argc, char **argv)
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
 
+	cfg.c_legacy_compress = false;
+	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+
 	err = mkfs_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
-- 
2.17.1

