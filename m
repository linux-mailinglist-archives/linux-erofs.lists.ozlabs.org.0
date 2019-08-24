Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B39BC65
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 09:42:33 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Fqx24WzgzDrdQ
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 17:42:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlJEwSuO"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Fqwr0txgzDrNf
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 17:42:19 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id y200so492716pfb.6
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=xU+HPk4pQ/wG8hgiknFZLix+HmnGmBLenWDz7QhtSvo=;
 b=UlJEwSuOLkqNjvL3tYzFII500Zz5NoGDhIsbUYkPjDnJZlcy3llXWbAgrjmVd29zEX
 B0Dj/JtwW5v9nRDjKV7/orKCP93AfkHZmu+feBfxtQvxurHZ7Z144UcVtSbhrnT4lN+L
 KBRu92/wO5V6do958Yd8ExM1GMBZHmTSLOQXTk06t+FFex8B/7B3JOZhqXhB2ilX3Ti8
 5cNgi6U7UKyoZPuvWXtT6R/MVC+uxWr48Gdqd4cdn6ilPZbEHMH1btP4WOtbRgL0yNQP
 2p6qBYszHG+B1SnDdr5acMtoTX82rleYrts9x+WakxRZuNYqy33STTXalOcFAswcYMNc
 s7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xU+HPk4pQ/wG8hgiknFZLix+HmnGmBLenWDz7QhtSvo=;
 b=pFamVaCHMtUt8Udsu71YjNUo1B+gYgwq9obVNvkE6+3vx8WX4NuWFnU4xw7vKRK0/F
 SNGOnUVSUYuwX2BM1TksDpqT2m0+MS3JNt8eD6DbI1eXwFc9WLE0SG0FYyo5f2o+Vuxc
 FkHgkFzSwok9aG/zed9Fxdc1+u1ZX0vrm2zpeI2zPwfGPpVbzCrkrT6rtwfErxTT3TsX
 wdmbsj0yJoyetwVmaabV/cUqQijksxP9ZVRBDZipWRJfgtS+oKQUraAOPLhgXA0RYy1r
 W78CXapyAVAO2o6OYXrgFkv8xtjWypv++N4V/Amns4yqYF4O9Vvkv3fqqs64LGTjOipD
 51aw==
X-Gm-Message-State: APjAAAVSQficxoh8SJKN96Xcpqi7nesWZqp/UN65fJDyqwCWWTH+SxHu
 noa8nRM31FHz6HiGqPasQb6+vIEPbQI=
X-Google-Smtp-Source: APXvYqxrk30ZKmQssHm5tRcN3aFEt9nbO0D+moKR0BuQ/NstVI3TjCCExhMDV7JugHuYzxI9ItflOw==
X-Received: by 2002:a63:f304:: with SMTP id l4mr7277736pgh.66.1566632534076;
 Sat, 24 Aug 2019 00:42:14 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.130])
 by smtp.gmail.com with ESMTPSA id y14sm3833373pge.7.2019.08.24.00.42.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Aug 2019 00:42:12 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: code for superblock checksum calculation.
Date: Sat, 24 Aug 2019 13:11:58 +0530
Message-Id: <20190824074158.16254-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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

Adding code for superblock checksum calculation.

This patch adds following things:
1)Handle suboptions('-o') to mkfs utility.
2)Add superblock checksum calculation(-o sb_cksum) as suboption.
3)Calculate superblock checksum if feature is enabled.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/config.h |  1 +
 include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
 mkfs/main.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 05fe6b2..40cd466 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -22,6 +22,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
+	int c_feature_flags;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 601b477..c9ef057 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -20,25 +20,31 @@
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
+/*
+ * feature definations.
+ */
+#define EROFS_FEATURE_SB_CHKSUM		0x0001
+
+#define EROFS_HAS_COMPAT_FEATURE(super,mask)	\
+	( le32_to_cpu((super)->features) & (mask) )
+
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
-/*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;        /* (aka. feature_compat) */
-/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-/* 13 */__u8 reserved;
-
-/* 14 */__le16 root_nid;
-/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-/* 24 */__le64 build_time;      /* inode v1 time derivation */
-/* 32 */__le32 build_time_nsec;
-/* 36 */__le32 blocks;          /* used for statfs */
-/* 40 */__le32 meta_blkaddr;
-/* 44 */__le32 xattr_blkaddr;
-/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
-/* 64 */__u8 volume_name[16];   /* volume name */
-/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
-
+/*  4 */__le32 features;        /* (aka. feature_compat) */
+/*  8 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+/*  9 */__u8 reserved;
+
+/* 10 */__le16 root_nid;
+/* 12 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+/* 20 */__le64 build_time;      /* inode v1 time derivation */
+/* 28 */__le32 build_time_nsec;
+/* 32 */__le32 blocks;          /* used for statfs */
+/* 36 */__le32 meta_blkaddr;
+/* 40 */__le32 xattr_blkaddr;
+/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
+/* 60 */__u8 volume_name[16];   /* volume name */
+/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
+/* 80 */__le32 checksum;        /* crc32c(super_block) */
 /* 84 */__u8 reserved2[44];
 } __packed;                     /* 128 bytes */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index f127fe1..26e14a3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -13,12 +13,14 @@
 #include <limits.h>
 #include <libgen.h>
 #include <sys/stat.h>
+#include <zlib.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/defs.h"
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
 
@@ -31,6 +33,28 @@ static void usage(void)
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 }
 
+char *feature_opts[] = {
+	"sb_cksum", NULL
+};
+#define O_SB_CKSUM	0
+
+static int parse_feature_subopts(char *opts)
+{
+	char *arg;
+
+	while (*opts != '\0') {
+		switch(getsubopt(&opts, feature_opts, &arg)) {
+		case O_SB_CKSUM:
+			cfg.c_feature_flags |= EROFS_FEATURE_SB_CHKSUM;
+			break;
+		default:
+			erofs_err("incorrect suboption");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
@@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return opt;
 			break;
 
+		case 'o':
+			opt = parse_feature_subopts(optarg);
+			if (opt)
+				return opt;
+			break;
+
 		default: /* '?' */
 			return -EINVAL;
 		}
@@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
+u32 erofs_superblock_checksum(struct erofs_super_block *sb)
+{
+	int offset;
+	u32 crc;
+
+	offset = offsetof(struct erofs_super_block, checksum);
+	if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
+		erofs_err("Invalid offset of checksum field: %d", offset);
+		return -1;
+	}
+	crc = crc32(~0, (const unsigned char *)sb,(size_t)offset);
+	erofs_dump("superblock checksum: 0x%x\n", crc);
+	return 0;
+}
+
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid)
 {
@@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
 		.requirements = cpu_to_le32(sbi.requirements),
+		.features = cpu_to_le32(cfg.c_feature_flags),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
 	sb.root_nid     = cpu_to_le16(root_nid);
 
+	if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
+		u32 crc = erofs_superblock_checksum(&sb);
+		sb.checksum = cpu_to_le32(crc);
+	}
+
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
 		erofs_err("Failed to allocate memory for sb: %s",
-- 
2.9.3

