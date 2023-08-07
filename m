Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC82771ED6
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 12:52:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKCnM6dPnz301V
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 20:52:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKCnB3ZN0z2yVR
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 20:51:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpEy5Fh_1691405510;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpEy5Fh_1691405510)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 18:51:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: dump: print more superblock fields
Date: Mon,  7 Aug 2023 18:51:43 +0800
Message-Id: <20230807105143.80966-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230807105143.80966-1-hsiangkao@linux.alibaba.com>
References: <20230807105143.80966-1-hsiangkao@linux.alibaba.com>
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

From: Guo Xuenan <guoxuenan@huawei.com>

Let's print compression algorithms and sb_extslots as well as update
feature information for dump.erosf

The proposed superblock dump is shown as below:

Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            4624
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lz4, lz4hc, lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       6131
Filesystem created:                           Wed Jun  7 17:15:44 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster
Filesystem UUID:                              not available

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              | 29 +++++++++++++++++++++++++++++
 include/erofs/internal.h |  1 +
 lib/super.c              |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index 409c851..7980f78 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -92,12 +92,14 @@ static struct erofsdump_feature feature_lists[] = {
 	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
+	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
 	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
+	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -588,6 +590,23 @@ static void erofsdump_print_statistic(void)
 	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
 }
 
+static void erofsdump_print_supported_compressors(FILE *f, unsigned int mask)
+{
+	unsigned int i = 0;
+	bool comma = false;
+	const char *s;
+
+	while ((s = z_erofs_list_supported_algorithms(i++, &mask)) != NULL) {
+		if (*s == '\0')
+			continue;
+		if (comma)
+			fputs(", ", f);
+		fputs(s, f);
+		comma = true;
+	}
+	fputc('\n', f);
+}
+
 static void erofsdump_show_superblock(void)
 {
 	time_t time = sbi.build_time;
@@ -607,6 +626,16 @@ static void erofsdump_show_superblock(void)
 	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
+	if (erofs_sb_has_compr_cfgs(&sbi)) {
+		fprintf(stdout, "Filesystem compr_algs:                        ");
+		erofsdump_print_supported_compressors(stdout,
+			sbi.available_compr_algs);
+	} else {
+		fprintf(stdout, "Filesystem lz4_max_distance:                  %u\n",
+			sbi.lz4_max_distance | 0U);
+	}
+	fprintf(stdout, "Filesystem sb_extslots:                       %u\n",
+			sbi.extslots | 0U);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
 			sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 04a9a69..a04e6a6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -74,6 +74,7 @@ struct erofs_sb_info {
 	u64 build_time;
 	u32 build_time_nsec;
 
+	u8  extslots;
 	unsigned char islotbits;
 	unsigned char blkszbits;
 
diff --git a/lib/super.c b/lib/super.c
index 16a1d62..e8e84aa 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -106,11 +106,17 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
+	sbi->extslots = dsb->sb_extslots;
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
+
+	if (erofs_sb_has_compr_cfgs(sbi))
+		sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	else
+		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
 	return erofs_init_devices(sbi, dsb);
 }
 
-- 
2.24.4

