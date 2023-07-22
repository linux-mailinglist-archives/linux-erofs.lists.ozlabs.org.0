Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A775DD29
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690039263;
	bh=+OoVctKY7ZbH2PDXBPTnxI/tgkhQlzCJ6DEaVVRWMI4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=d20XBHG93tGV5gxjyVxjg5QpohqgZN9Sw2Bo4QwJ7cY16oO3upZTNvscuEDeA+lGR
	 rvtgejeViihTZvfcgUDYyS1Edn7qIRoVkHHbSqBMEJBxaUpNe9J4WEc4A9xo71Jv+h
	 ExHB5AP1ul0lHghC5u8MHemZLogLkojALq8dyKhVgwvKvzNmMkg/+0S6R7cryDMguj
	 D0IiUQWj4QO3EJW4xfYOt0YKd8EwDPfyu6K12BGuGg3IVera9EXuRlhqAfc7pJaZ24
	 rfAcWnkF3vXAfFupSfsZssVTCM5bWAh4j3nEpeNty9u0UDlQiaksAYGqSF0QrpXONW
	 ITcWCSyIf9k2A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7VW26wjVz2yW5
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Jul 2023 01:21:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.154; helo=frasgout12.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 958 seconds by postgrey-1.37 at boromir; Sun, 23 Jul 2023 01:20:55 AEST
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7VVv4hhRz2yW5
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Jul 2023 01:20:53 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R7TsF6f4jz9yFhr
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 22:51:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwCXnVcE8LtkMMq2Cg--.24810S6;
	Sat, 22 Jul 2023 15:04:49 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/4] erofs-utils: dump: add some superblock fields
Date: Sat, 22 Jul 2023 23:04:34 +0800
Message-Id: <20230722150434.2921381-5-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230722150434.2921381-1-guoxuenan@huawei.com>
References: <20230722150434.2921381-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwCXnVcE8LtkMMq2Cg--.24810S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13Zw48KrW5Jr1fur1rJFb_yoW5KFW7p3
	4YkF1fGryrtF10yFs3KFWIgFWrCrWFk3WDG3y8Zw4rZwn2yrWxJF9ayryvkryUWF98Wa4a
	g3WF9a4Yg34xX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c
	8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeT5LUUUUU=
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

dump.erofs show compression algorithms and sb_extslots,
and update feature information.

The proposed super block info is shown as below:
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
---
 dump/main.c              | 11 +++++++++++
 include/erofs/internal.h |  1 +
 lib/super.c              |  6 +++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index 0bbb57d..c4eefd3 100644
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
@@ -607,6 +609,15 @@ static void erofsdump_show_superblock(void)
 	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
+	if (erofs_sb_has_compr_cfgs(&sbi)) {
+		fprintf(stdout, "Filesystem compr_algs:                        ");
+		erofs_print_supported_compressors(stdout, sbi.available_compr_algs);
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
index 04a9a69..a1bf55e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -73,6 +73,7 @@ struct erofs_sb_info {
 	u32 feature_incompat;
 	u64 build_time;
 	u32 build_time_nsec;
+	u8 extslots;
 
 	unsigned char islotbits;
 	unsigned char blkszbits;
diff --git a/lib/super.c b/lib/super.c
index 16a1d62..3acf30b 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -106,11 +106,15 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
-
+	sbi->extslots = dsb->sb_extslots;
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
+	if (erofs_sb_has_compr_cfgs(sbi))
+		sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	else
+		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
 	return erofs_init_devices(sbi, dsb);
 }
 
-- 
2.34.3

