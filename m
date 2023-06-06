Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046B7235F7
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 05:56:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZxVS6zRNz3ffy
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 13:56:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686023793;
	bh=NlKyWcxEovIfYtAw3ZP4nPPUwiFvq84SR0BwcKHm6SI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=I9c8CkQCMEAwGz8nMo5r1PLqWiW9eF8kQ796ZSWLl1wh8DR9I/TXnBx4CHWqyvfBy
	 aiJMwV9A+yIfu2pB0PxS9+QgTOhMG5GBapmPZttTZT+RSVkPwh+MFjw5wP/4CiV4mc
	 2tPVvdl2bbvisFkBbqd1pQjaJANNnwutSqT9A2fC3pDjGYnlvajTeVlNWoH8Dd+2vJ
	 aZrFZGQw4XOe7643nBIxTr+VCqPKnrKBqXPmKsfQuXcYvZGboyaEDnN/yl+UdFmV7j
	 hzo9RmKRMsASxu8yMPkCZ85xc+joFzYuT0LsF1dxlXivwnj+GrJS17DbE+4/e3MdqU
	 S88UAuartdPgA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZxTL2PTFz3f6g
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 13:55:32 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZxFC2YsdzB1B8H
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 11:45:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP1 (Coremail) with SMTP id 76C_BwD3j2Mgrn5kHjxtCA--.22318S2;
	Tue, 06 Jun 2023 03:55:17 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: add some superblock fields display
Date: Tue,  6 Jun 2023 11:55:11 +0800
Message-Id: <20230606035511.1114101-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 76C_BwD3j2Mgrn5kHjxtCA--.22318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17tr4fXr43tr13ZryxXwb_yoWrCF4Upw
	1Ykr1fGrWFq3WIyFs3tFW09FyrCrZYyF1DG397Aw4rZrn3trZ7JFn3tF9YyryDWF98Wa4a
	g3WFva4Yga1IvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK
	6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUz3kuDUUUU
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

dump.erofs show compression algothrims and sb_exslots,
and update feature information.

th current super block info displayed as follows:
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            4637
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lz4 lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       36
Filesystem created:                           Tue Jun  6 10:23:02 2023
Filesystem features:                          sb_csum mtime lz4_0padding compr_cfgs big_pcluster
Filesystem UUID:                              not available

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 dump/main.c              | 34 +++++++++++++++++++++++++++++++++-
 include/erofs/internal.h |  1 +
 lib/super.c              |  5 +++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index efbc82b..20e1456 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -93,13 +93,25 @@ struct erofsdump_feature {
 static struct erofsdump_feature feature_lists[] = {
 	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
-	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
+	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "lz4_0padding" },
+	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
 	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
+	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
+};
+
+struct available_alg {
+	int type;
+	const char *name;
+};
+
+static struct available_alg compr_cfgs[] = {
+	{ Z_EROFS_COMPRESSION_LZ4, "lz4" },
+	{ Z_EROFS_COMPRESSION_LZMA, "lzma" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -590,6 +602,17 @@ static void erofsdump_print_statistic(void)
 	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
 }
 
+static void erofsdump_show_comprcfgs(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(compr_cfgs); i++) {
+		if (sbi.available_compr_algs & (1 << compr_cfgs[i].type))
+			fprintf(stdout, "%s ", compr_cfgs[i].name);
+	}
+	fprintf(stdout, "\n");
+}
+
 static void erofsdump_show_superblock(void)
 {
 	time_t time = sbi.build_time;
@@ -609,6 +632,15 @@ static void erofsdump_show_superblock(void)
 	if (erofs_sb_has_fragments() && sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
+	if (erofs_sb_has_compr_cfgs()) {
+		fprintf(stdout, "Filesystem compr_algs:                        ");
+		erofsdump_show_comprcfgs();
+	} else {
+		fprintf(stdout, "Filesystem lz4_max_dist:                      %u\n",
+		sbi.lz4_max_distance | 0U);
+	}
+	fprintf(stdout, "Filesystem sb_extslots:                       %u\n",
+			sbi.extslots | 0U);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
 			sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 370cfac..a404008 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -74,6 +74,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+	u8 extslots;
 
 	unsigned char islotbits;
 	unsigned char blkszbits;
diff --git a/lib/super.c b/lib/super.c
index 5f70686..f511b7d 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -105,11 +105,16 @@ int erofs_read_superblock(void)
 	sbi.packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
+	sbi.extslots = dsb->sb_extslots;
 
 	sbi.build_time = le64_to_cpu(dsb->build_time);
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
+	if (erofs_sb_has_compr_cfgs())
+		sbi.available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	else
+		sbi.lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
 	return erofs_init_devices(&sbi, dsb);
 }
 
-- 
2.31.1

