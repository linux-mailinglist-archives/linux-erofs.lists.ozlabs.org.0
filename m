Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D69BDB8
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 14:38:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46FyVb3px2zDrWZ
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 22:38:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3iqfQ1G"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FyVP2VQ2zDrTY
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 22:38:21 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id h3so7287987pls.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=UnlkwixSlOaAQQ0sBV9B2c1hiRpKpzwZeWTtomwDToE=;
 b=H3iqfQ1GywzkNZ849sEcOD5QedOQAf/suwQX8+Aj5E+4G10nCUZKynFNGXrMNSZbob
 NkCvu4kTwzqJHmN6C0Bvm4FcDl5ETDMy0KNbFHnsobAVVeIw5GZrbKWNBM6lZrjA4QkZ
 jXqZWtyvPXW3cPFEdYIyhanbb2lHuvilY+fzNzYKj3Y386dawEazuKc5oKNrDxYA/sRS
 p7Njmpl2LwE/c5cRiiZt5lg/YKCwJ35dzic+CjdvOwKm7EiL7RHm9gRxzsWbdBTBAdZU
 Ut0TVElMsKfvVYTKpM3mRxg3olXwE7CSkERKbcikopymUEWM06nzj8/N0whsLKdHaHMK
 E7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UnlkwixSlOaAQQ0sBV9B2c1hiRpKpzwZeWTtomwDToE=;
 b=Ncr/4NJaqLVjAx4ovcJgIc2xjlP+zDrrTaK3GWKSfsxOksd63iPokYu8B3rb93aROV
 PGcrU9SQTD4xApkdhNtKz5G6eZQ6ospNlyPznzQ9d1dUcC3CesvS/eqy2rDfeKJuruKG
 JD+GXoc9+Saxsza3xG8QWytXwpK7TQZ1vAehmfxDP72PYGRDrBgFf+7ZHzGgEOHNObBp
 Rl6zUrTCQL0XfUub/dQ2Wi5sombv1o710fstmCHtBq042Pj9qbwlua6+/bpaZ5lI9rW5
 abC9PvIC4RC8oMzslMSHZTbeK/kMVYY7e7U+OvYfNnHiS5sBFrx0B89sAQxAeCX73ejV
 Lj3w==
X-Gm-Message-State: APjAAAUj7zyYoqc1cFX1DrqWllqm8CyUXxhWhX0VRaNRtYpX06pU9p8n
 gqMSe/B1+Mj51j7UyXimP60GAlmzodY=
X-Google-Smtp-Source: APXvYqwqBnMGcIN6SHStF7DjTDAFO1OksJALjY1TklluVpD/aoUtpJlHD2gY8QsCryzKVxpsc03kew==
X-Received: by 2002:a17:902:6a:: with SMTP id 97mr9548830pla.5.1566650297109; 
 Sat, 24 Aug 2019 05:38:17 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.130])
 by smtp.gmail.com with ESMTPSA id t11sm5982557pgb.33.2019.08.24.05.38.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Aug 2019 05:38:15 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: code for superblock checksum calculation.
Date: Sat, 24 Aug 2019 18:08:03 +0530
Message-Id: <20190824123803.19797-1-pratikshinde320@gmail.com>
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

incorporated the changes suggested in previous patch.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/config.h |  1 +
 include/erofs_fs.h     | 10 ++++++++
 mkfs/main.c            | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

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
index 601b477..9ac2635 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -20,6 +20,16 @@
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
+/*
+ * feature definations.
+ */
+#define EROFS_DEFAULT_FEATURES		EROFS_FEATURE_SB_CHKSUM
+#define EROFS_FEATURE_SB_CHKSUM		0x0001
+
+
+#define EROFS_HAS_COMPAT_FEATURE(super,mask)	\
+	( le32_to_cpu((super)->features) & (mask) )
+
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
 /*  4 */__le32 checksum;        /* crc32c(super_block) */
diff --git a/mkfs/main.c b/mkfs/main.c
index f127fe1..355fd2c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,45 @@ static void usage(void)
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 }
 
+#define CRCPOLY	0x82F63B78
+static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
+{
+	int i;
+	u32 crc = seed;
+
+	while (len--) {
+		crc ^= *in++;
+		for (i = 0; i < 8; i++) {
+			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
+		}
+	}
+	erofs_dump("calculated crc: 0x%x\n", crc);
+	return crc;
+}
+
+char *feature_opts[] = {
+	"nosbcrc", NULL
+};
+#define O_SB_CKSUM	0
+
+static int parse_feature_subopts(char *opts)
+{
+	char *arg;
+
+	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
+	while (*opts != '\0') {
+		switch(getsubopt(&opts, feature_opts, &arg)) {
+		case O_SB_CKSUM:
+			cfg.c_feature_flags |= (~EROFS_FEATURE_SB_CHKSUM);
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
@@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
+	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
+	while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return opt;
 			break;
 
+		case 'O':
+			opt = parse_feature_subopts(optarg);
+			if (opt)
+				return opt;
+			break;
+
 		default: /* '?' */
 			return -EINVAL;
 		}
@@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
+u32 erofs_superblock_checksum(struct erofs_super_block *sb)
+{
+	u32 crc;
+	crc = crc32c(~0, (const unsigned char *)sb,
+		    sizeof(struct erofs_super_block));
+	erofs_dump("superblock checksum: 0x%x\n", crc);
+	return crc;
+}
+
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid)
 {
@@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
 		.requirements = cpu_to_le32(sbi.requirements),
+		.features = cpu_to_le32(cfg.c_feature_flags),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
 	sb.root_nid     = cpu_to_le16(root_nid);
 
+	if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
+		sb.checksum = 0;
+		u32 crc = erofs_superblock_checksum(&sb);
+		sb.checksum = cpu_to_le32(crc);
+	}
+
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
 		erofs_err("Failed to allocate memory for sb: %s",
-- 
2.9.3

