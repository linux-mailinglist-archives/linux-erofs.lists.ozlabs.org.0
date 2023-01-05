Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4D65E724
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 09:56:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NngLX6xFLz30RT
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 19:56:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NngLS3rcTz2yZd
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Jan 2023 19:56:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VYvI93-_1672908962;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYvI93-_1672908962)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 16:56:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: drop unneeded spaces for alignment
Date: Thu,  5 Jan 2023 16:56:01 +0800
Message-Id: <20230105085601.5319-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I don't think they are useful other than leading to unnecessary
complexity.

Cc: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 56 +++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index bc4e028..f4f0f8d 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -536,24 +536,23 @@ static void erofsdump_file_statistic(void)
 {
 	unsigned int i;
 
-	fprintf(stdout, "Filesystem total file count:		%lu\n",
-			stats.files);
+	fprintf(stdout, "Filesystem total file count: %lu\n", stats.files);
 	for (i = 0; i < EROFS_FT_MAX; i++)
-		fprintf(stdout, "Filesystem %s count:		%lu\n",
+		fprintf(stdout, "Filesystem %s count: %lu\n",
 			file_category_types[i], stats.file_category_stat[i]);
 
 	stats.compress_rate = (double)(100 * stats.files_total_size) /
 		(double)(stats.files_total_origin_size);
-	fprintf(stdout, "Filesystem compressed files:            %lu\n",
-			stats.compressed_files);
-	fprintf(stdout, "Filesystem uncompressed files:          %lu\n",
-			stats.uncompressed_files);
-	fprintf(stdout, "Filesystem total original file size:    %lu Bytes\n",
-			stats.files_total_origin_size);
-	fprintf(stdout, "Filesystem total file size:             %lu Bytes\n",
-			stats.files_total_size);
-	fprintf(stdout, "Filesystem compress rate:               %.2f%%\n",
-			stats.compress_rate);
+	fprintf(stdout, "Filesystem compressed files: %lu\n",
+		stats.compressed_files);
+	fprintf(stdout, "Filesystem uncompressed files: %lu\n",
+		stats.uncompressed_files);
+	fprintf(stdout, "Filesystem total original file size: %lu Bytes\n",
+		stats.files_total_origin_size);
+	fprintf(stdout, "Filesystem total file size: %lu Bytes\n",
+		stats.files_total_size);
+	fprintf(stdout, "Filesystem compress rate: %.2f%%\n",
+		stats.compress_rate);
 }
 
 static void erofsdump_print_statistic(void)
@@ -595,24 +594,22 @@ static void erofsdump_show_superblock(void)
 	char uuid_str[37] = "not available";
 	int i = 0;
 
-	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
-			EROFS_SUPER_MAGIC_V1);
-	fprintf(stdout, "Filesystem blocks:                            %llu\n",
-			sbi.total_blocks | 0ULL);
-	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-			sbi.meta_blkaddr);
+	fprintf(stdout, "Filesystem magic number: 0x%04X\n",
+		EROFS_SUPER_MAGIC_V1);
+	fprintf(stdout, "Filesystem blocks: %llu\n",
+		sbi.total_blocks | 0ULL);
+	fprintf(stdout, "Filesystem inode metadata start block: %u\n",
+		sbi.meta_blkaddr);
 	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
-			sbi.xattr_blkaddr);
-	fprintf(stdout, "Filesystem root nid:                          %llu\n",
-			sbi.root_nid | 0ULL);
+		sbi.xattr_blkaddr);
+	fprintf(stdout, "Filesystem root nid: %llu\n", sbi.root_nid | 0ULL);
 	if (erofs_sb_has_fragments())
-		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
+		fprintf(stdout, "Filesystem packed nid: %llu\n",
 			sbi.packed_nid | 0ULL);
-	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-			sbi.inos | 0ULL);
-	fprintf(stdout, "Filesystem created:                           %s",
-			ctime(&time));
-	fprintf(stdout, "Filesystem features:                          ");
+	fprintf(stdout, "Filesystem inode count: %llu\n",
+		sbi.inos | 0ULL);
+	fprintf(stdout, "Filesystem created: %s", ctime(&time));
+	fprintf(stdout, "Filesystem features: ");
 	for (; i < ARRAY_SIZE(feature_lists); i++) {
 		u32 feat = le32_to_cpu(feature_lists[i].compat ?
 				       sbi.feature_compat :
@@ -623,8 +620,7 @@ static void erofsdump_show_superblock(void)
 #ifdef HAVE_LIBUUID
 	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
-	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
-			uuid_str);
+	fprintf(stdout, "\nFilesystem UUID: %s\n", uuid_str);
 }
 
 int main(int argc, char **argv)
-- 
2.24.4

