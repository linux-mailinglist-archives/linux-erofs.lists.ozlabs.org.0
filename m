Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F150599E
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Apr 2022 16:21:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Khpyt4NlXz2yg7
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Apr 2022 00:21:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Khpyn4nf7z2xD3
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Apr 2022 00:21:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0VAQFSW._1650291679; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VAQFSW._1650291679) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 18 Apr 2022 22:21:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: support listing sub-directories
Date: Mon, 18 Apr 2022 22:21:17 +0800
Message-Id: <20220418142117.96109-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a new option helper to list sub-directories.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c      | 40 ++++++++++++++++++++++++++++++++++++++--
 man/dump.erofs.1 |  5 ++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b431e18..49ff2b7 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -26,6 +26,7 @@ struct erofsdump_cfg {
 	bool show_extent;
 	bool show_superblock;
 	bool show_statistics;
+	bool show_subdirectories;
 	erofs_nid_t nid;
 	const char *inode_path;
 };
@@ -77,6 +78,7 @@ static struct option long_options[] = {
 	{"nid", required_argument, NULL, 2},
 	{"device", required_argument, NULL, 3},
 	{"path", required_argument, NULL, 4},
+	{"ls", no_argument, NULL, 5},
 	{0, 0, 0, 0},
 };
 
@@ -103,9 +105,10 @@ static void usage(void)
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
 	      " -S              show statistic information of the image\n"
 	      " -V              print the version number of dump.erofs and exit.\n"
-	      " -e              show extent info (--nid is required)\n"
+	      " -e              show extent info (INODE required)\n"
 	      " -s              show information about superblock\n"
 	      " --device=X      specify an extra device to be used together\n"
+	      " --ls            show directory contents (INODE required)\n"
 	      " --nid=#         show the target inode info of nid #\n"
 	      " --path=X        show the target inode info of path X\n"
 	      " --help          display this help and exit.\n",
@@ -158,6 +161,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			dumpcfg.show_inode = true;
 			++dumpcfg.totalshow;
 			break;
+		case 5:
+			dumpcfg.show_subdirectories = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -250,6 +256,17 @@ static void update_file_size_statatics(erofs_off_t occupied_size,
 		stats.file_comp_size[occupied_size_mark]++;
 }
 
+static int erofsdump_ls_dirent_iter(struct erofs_dir_context *ctx)
+{
+	char fname[EROFS_NAME_LEN + 1];
+
+	strncpy(fname, ctx->dname, ctx->de_namelen);
+	fname[ctx->de_namelen] = '\0';
+	fprintf(stdout, "%10llu    %u  %s\n",  ctx->de_nid | 0ULL,
+		ctx->de_ftype, fname);
+	return 0;
+}
+
 static int erofsdump_dirent_iter(struct erofs_dir_context *ctx)
 {
 	/* skip "." and ".." dentry */
@@ -376,10 +393,29 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	fprintf(stdout, "Access: %04o/%s\n", access_mode, access_mode_str);
 	fprintf(stdout, "Timestamp: %s.%09d\n", timebuf, inode.i_mtime_nsec);
 
+	if (dumpcfg.show_subdirectories) {
+		struct erofs_dir_context ctx = {
+			.flags = EROFS_READDIR_VALID_PNID,
+			.pnid = inode.nid,
+			.dir = &inode,
+			.cb = erofsdump_ls_dirent_iter,
+			.de_nid = 0,
+			.dname = "",
+			.de_namelen = 0,
+		};
+
+		fprintf(stdout, "\n       NID TYPE  FILENAME\n");
+		err = erofs_iterate_dir(&ctx, false);
+		if (err) {
+			erofs_err("failed to list directory contents");
+			return;
+		}
+	}
+
 	if (!dumpcfg.show_extent)
 		return;
 
-	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length \n");
+	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length\n");
 	while (map.m_la < inode.i_size) {
 		struct erofs_map_dev mdev;
 
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index fd437cf..209e5f9 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -19,6 +19,9 @@ is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
 Specify an extra device to be used together.
 You may give multiple `--device' options in the correct order.
 .TP
+.BI "\-\-ls"
+List directory contents. An inode should be specified together.
+.TP
 .BI "\-\-nid=" NID
 Specify an inode NID in order to print its file information.
 .TP
@@ -26,7 +29,7 @@ Specify an inode NID in order to print its file information.
 Specify an inode path in order to print its file information.
 .TP
 .BI \-e
-Show the file extent information. The option depends on option --nid to specify NID.
+Show the file extent information. An inode should be specified together.
 .TP
 .BI \-V
 Print the version number and exit.
-- 
2.24.4

