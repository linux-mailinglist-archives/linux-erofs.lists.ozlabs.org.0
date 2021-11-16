Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630B452E60
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 10:50:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HthBJ0JZMz2yPj
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 20:50:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HthB92Q2Hz2xCt
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 20:50:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UwqPg0-_1637056181; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwqPg0-_1637056181) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 17:49:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 4/6] erofs-utils: dump: support multiple devices
Date: Tue, 16 Nov 2021 17:49:37 +0800
Message-Id: <20211116094939.32246-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
References: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add preliminary multiple device support for dump feature.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              | 55 ++++++++++++++++++++++++++++++----------
 include/erofs/internal.h |  1 +
 man/dump.erofs.1         | 25 +++++-------------
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index d0efe9505317..b7560eca1080 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -70,6 +70,7 @@ static struct erofs_statistics stats;
 static struct option long_options[] = {
 	{"help", no_argument, NULL, 1},
 	{"nid", required_argument, NULL, 2},
+	{"device", required_argument, NULL, 3},
 	{0, 0, 0, 0},
 };
 
@@ -84,6 +85,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
+	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 };
 
 static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
@@ -95,12 +97,13 @@ static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
-	      " -S      show statistic information of the image\n"
-	      " -V      print the version number of dump.erofs and exit.\n"
-	      " -e      show extent info (--nid is required)\n"
-	      " -s      show information about superblock\n"
-	      " --nid=# show the target inode info of nid #\n"
-	      " --help  display this help and exit.\n",
+	      " -S              show statistic information of the image\n"
+	      " -V              print the version number of dump.erofs and exit.\n"
+	      " -e              show extent info (--nid is required)\n"
+	      " -s              show information about superblock\n"
+	      " --device=X      specify an extra device to be used together\n"
+	      " --nid=#         show the target inode info of nid #\n"
+	      " --help          display this help and exit.\n",
 	      stderr);
 }
 
@@ -111,7 +114,7 @@ static void erofsdump_print_version(void)
 
 static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
-	int opt;
+	int opt, err;
 
 	while ((opt = getopt_long(argc, argv, "SVes",
 				  long_options, NULL)) != -1) {
@@ -139,6 +142,12 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 1:
 			usage();
 			exit(0);
+		case 3:
+			err = blob_open_ro(optarg);
+			if (err)
+				return err;
+			++sbi.extra_devices;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -423,6 +432,10 @@ static int erofsdump_map_blocks(struct erofs_inode *inode,
 
 static void erofsdump_show_fileinfo(bool show_extent)
 {
+	const char *ext_fmt[] = {
+		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "\n",
+		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "  # device %u\n"
+	};
 	int err, i;
 	erofs_off_t size;
 	u16 access_mode;
@@ -482,16 +495,29 @@ static void erofsdump_show_fileinfo(bool show_extent)
 
 	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length \n");
 	while (map.m_la < inode.i_size) {
+		struct erofs_map_dev mdev;
+
 		err = erofsdump_map_blocks(&inode, &map,
 				EROFS_GET_BLOCKS_FIEMAP);
 		if (err) {
-			erofs_err("get file blocks range failed");
+			erofs_err("failed to get file blocks range");
 			return;
 		}
 
-		fprintf(stdout, "%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "\n",
-			extent_count++, map.m_la, map.m_la + map.m_llen, map.m_llen,
-			map.m_pa, map.m_pa + map.m_plen, map.m_plen);
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		err = erofs_map_dev(&sbi, &mdev);
+		if (err) {
+			erofs_err("failed to map device");
+			return;
+		}
+
+		fprintf(stdout, ext_fmt[!!mdev.m_deviceid], extent_count++,
+			map.m_la, map.m_la + map.m_llen, map.m_llen,
+			mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
+			mdev.m_deviceid);
 		map.m_la += map.m_llen;
 	}
 	fprintf(stdout, "%s: %d extents found\n", path, extent_count);
@@ -658,7 +684,7 @@ int main(int argc, char **argv)
 	err = erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit;
+		goto exit_dev_close;
 	}
 
 	if (!dumpcfg.totalshow) {
@@ -673,13 +699,16 @@ int main(int argc, char **argv)
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
-		goto exit;
+		goto exit_dev_close;
 	}
 
 	if (dumpcfg.show_inode)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
+exit_dev_close:
+	dev_close();
 exit:
+	blob_closeall();
 	erofs_exit_configure();
 	return err;
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f22a016373ca..93e05bbc8271 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -300,6 +300,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
+int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index 8233c89cdeb0..8efb161b65f1 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -5,24 +5,7 @@
 dump.erofs \- retrieve directory and file entries, show specific file
 or overall disk statistics information from an EROFS-formatted image.
 .SH SYNOPSIS
-.B dump.erofs
-[
-.B \--nid
-.I inode NID
-]
-[
-.B \-e
-]
-[
-.B \-s
-]
-[
-.B \-S
-]
-[
-.B \-V
-]
-.I IMAGE
+\fBdump.erofs\fR [\fIOPTIONS\fR] \fIIMAGE\fR
 .SH DESCRIPTION
 .B dump.erofs
 is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
@@ -32,7 +15,11 @@ is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
 4) file extent information of the given inode NID.
 .SH OPTIONS
 .TP
-.BI \--nid " inode NID"
+.BI "\-\-device=" path
+Specify an extra device to be used together.
+You may give multiple `--device' options in the correct order.
+.TP
+.BI "\-\-nid=" NID
 Specify an inode NID in order to print its file information.
 .TP
 .BI \-e
-- 
2.24.4

