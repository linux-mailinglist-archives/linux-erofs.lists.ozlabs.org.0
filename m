Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63775433207
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 11:18:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYSpS0MWVz2ybK
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 20:18:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYSpJ6mZzz2xfM
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Oct 2021 20:18:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0UstKif-_1634635074; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UstKif-_1634635074) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 17:17:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: introduce --quiet option
Date: Tue, 19 Oct 2021 17:17:49 +0800
Message-Id: <20211019091749.24528-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <YW1luAmReW8HpbHn@B-P7TQMD6M-0146.local>
References: <YW1luAmReW8HpbHn@B-P7TQMD6M-0146.local>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, nl6720 <nl6720@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a preliminary quiet mode as described in
https://gitlab.archlinux.org/archlinux/archiso/-/issues/148

Suggested-by: nl6720 <nl6720@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - simplify erofs_show_progs().

 lib/config.c |  4 +++-
 mkfs/main.c  | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index 6d751715fcf2..363dcc5a0525 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -16,7 +16,7 @@ void erofs_init_configure(void)
 {
 	memset(&cfg, 0, sizeof(cfg));
 
-	cfg.c_dbg_lvl  = 2;
+	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
 	cfg.c_compr_level_master = -1;
@@ -34,6 +34,8 @@ void erofs_show_config(void)
 {
 	const struct erofs_configure *c = &cfg;
 
+	if (c->c_dbg_lvl < EROFS_WARN)
+		return;
 	erofs_dump("\tc_version:           [%8s]\n", c->c_version);
 	erofs_dump("\tc_dbg_lvl:           [%8d]\n", c->c_dbg_lvl);
 	erofs_dump("\tc_dry_run:           [%8d]\n", c->c_dry_run);
diff --git a/mkfs/main.c b/mkfs/main.c
index 1c8dea55f0cd..055d077988e9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -46,6 +46,7 @@ static struct option long_options[] = {
 	{"max-extent-bytes", required_argument, NULL, 9},
 	{"compress-hints", required_argument, NULL, 10},
 	{"chunksize", required_argument, NULL, 11},
+	{"quiet", no_argument, 0, 12},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -93,6 +94,7 @@ static void usage(void)
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -179,6 +181,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
 	int opt, i;
+	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
 				 long_options, NULL)) != -1) {
@@ -342,9 +345,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			erofs_sb_set_chunked_file();
-			erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 			break;
-
+		case 12:
+			quiet = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -377,6 +381,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		erofs_err("Unexpected argument: %s\n", argv[optind]);
 		return -EINVAL;
 	}
+	if (quiet)
+		cfg.c_dbg_lvl = EROFS_ERR;
 	return 0;
 }
 
@@ -522,6 +528,12 @@ int parse_source_date_epoch(void)
 	return 0;
 }
 
+void erofs_show_progs(int argc, char *argv[])
+{
+	if (cfg.c_dbg_lvl >= EROFS_WARN)
+		fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -534,11 +546,10 @@ int main(int argc, char **argv)
 	char uuid_str[37] = "not available";
 
 	erofs_init_configure();
-	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
-
 	erofs_mkfs_default_options();
 
 	err = mkfs_parse_options_cfg(argc, argv);
+	erofs_show_progs(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
 			usage();
@@ -593,8 +604,9 @@ int main(int argc, char **argv)
 		return 1;
 	}
 #endif
-
 	erofs_show_config();
+	if (erofs_sb_has_chunked_file())
+		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
-- 
2.24.4

