Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F669F2D5
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Feb 2023 11:39:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PMCMm36rWz3c8x
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Feb 2023 21:39:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PMCMh0xbmz2xJ4
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Feb 2023 21:39:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VcGXfA3_1677062364;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcGXfA3_1677062364)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 18:39:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support randomizing algorithms in debugging mode
Date: Wed, 22 Feb 2023 18:39:23 +0800
Message-Id: <20230222103923.10815-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's used for multiple algorithms selftest.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 lib/compress.c         | 11 +++++++++++
 mkfs/main.c            |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 17db98c..7b64d89 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -41,6 +41,7 @@ struct erofs_configure {
 	bool c_legacy_compress;
 #ifndef NDEBUG
 	bool c_random_pclusterblks;
+	bool c_random_algorithms;
 #endif
 	char c_timeinherit;
 	char c_chunkbits;
diff --git a/lib/compress.c b/lib/compress.c
index 012a90c..4c314e7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -860,6 +860,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
+#ifndef NDEBUG
+	if (cfg.c_random_algorithms) {
+		while (1) {
+			inode->z_algorithmtype[0] =
+				rand() % EROFS_MAX_COMPR_CFG;
+			if (erofs_ccfg[inode->z_algorithmtype[0]].enable)
+				break;
+		}
+	}
+#endif
 	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
@@ -1075,6 +1085,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		if (ret < 0)
 			return ret;
 		erofs_ccfg[i].algorithmtype = ret;
+		erofs_ccfg[i].enable = true;
 		sbi.available_compr_algs |= 1 << ret;
 		if (ret != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs();
diff --git a/mkfs/main.c b/mkfs/main.c
index bb3628f..206a669 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -45,6 +45,7 @@ static struct option long_options[] = {
 	{"all-root", no_argument, NULL, 7},
 #ifndef NDEBUG
 	{"random-pclusterblks", no_argument, NULL, 8},
+	{"random-algorithms", no_argument, NULL, 18},
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
 	{"compress-hints", required_argument, NULL, 10},
@@ -111,6 +112,7 @@ static void usage(void)
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
+	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
@@ -370,6 +372,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 8:
 			cfg.c_random_pclusterblks = true;
 			break;
+		case 18:
+			cfg.c_random_algorithms = true;
+			break;
 #endif
 		case 9:
 			cfg.c_max_decompressed_extent_bytes =
-- 
2.36.1

