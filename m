Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1F862AC5
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 15:28:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjR2J5Qxhz3cDt
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 01:28:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TjR2F6wgsz30Kd
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 01:28:53 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id AA0EE10089E43;
	Sun, 25 Feb 2024 22:28:06 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id CB47537C986;
	Sun, 25 Feb 2024 22:28:05 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v3 3/4] erofs-utils: mkfs: add --worker=# parameter
Date: Sun, 25 Feb 2024 22:27:58 +0800
Message-ID: <20240225142759.340165-4-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduces a --worker=# parameter for the incoming
multi-threaded compression support. It also introduces a segment size
used in multi-threaded compression, which has the default value 16MB
and cannot be modified.

It also introduces a concept called `segment size` to split large files
for multi-threading, which has the default value 16MB for now.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 include/erofs/config.h |  4 ++++
 lib/config.c           |  4 ++++
 mkfs/main.c            | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 73e3ac2..d2f91ff 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -75,6 +75,10 @@ struct erofs_configure {
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
+#ifdef EROFS_MT_ENABLED
+	u64 c_segment_size;
+	u32 c_mt_workers;
+#endif
 
 	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
 	u32 c_max_decompressed_extent_bytes;
diff --git a/lib/config.c b/lib/config.c
index 947a183..2530274 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -38,6 +38,10 @@ void erofs_init_configure(void)
 	cfg.c_pclusterblks_max = 1;
 	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
+#ifdef EROFS_MT_ENABLED
+	cfg.c_segment_size = 16ULL * 1024 * 1024;
+	cfg.c_mt_workers = 1;
+#endif
 
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 7aea64a..c5cdaf9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -73,6 +73,9 @@ static struct option long_options[] = {
 	{"gzip", no_argument, NULL, 517},
 #endif
 	{"offset", required_argument, NULL, 518},
+#ifdef EROFS_MT_ENABLED
+	{"workers", required_argument, NULL, 519},
+#endif
 	{0, 0, 0, 0},
 };
 
@@ -175,6 +178,9 @@ static void usage(int argc, char **argv)
 		" --product-out=X       X=product_out directory\n"
 		" --fs-config-file=X    X=fs_config file\n"
 		" --block-list-file=X   X=block_list file\n"
+#endif
+#ifdef EROFS_MT_ENABLED
+		" --workers=#            set the number of worker threads to # (default=1)\n"
 #endif
 		);
 }
@@ -404,6 +410,13 @@ static void erofs_rebuild_cleanup(void)
 	rebuild_src_count = 0;
 }
 
+#ifdef EROFS_MT_ENABLED
+static u32 mkfs_max_worker_num() {
+	u32 ncpu = erofs_get_available_processors();
+	return ncpu ? ncpu : 16;
+}
+#endif
+
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
@@ -642,6 +655,21 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+#ifdef EROFS_MT_ENABLED
+		case 519:
+			cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
+			if (errno || *endptr != '\0') {
+				erofs_err("invalid worker number %s", optarg);
+				return -EINVAL;
+			}
+			if (cfg.c_mt_workers > mkfs_max_worker_num()) {
+				erofs_warn(
+					"worker number %s is too large, setting to %ud",
+					optarg, mkfs_max_worker_num());
+				cfg.c_mt_workers = mkfs_max_worker_num();
+			}
+			break;
+#endif
 		case 'V':
 			version();
 			exit(0);
@@ -784,6 +812,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
+
+#ifdef EROFS_MT_ENABLED
+	if (cfg.c_mt_workers > 1 &&
+	    (cfg.c_dedupe || cfg.c_fragments || cfg.c_ztailpacking)) {
+		cfg.c_mt_workers = 1;
+		erofs_warn("Please note that dedupe/fragments/ztailpacking"
+			   "is NOT supported in multi-threaded mode now, using worker=1.");
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.44.0

