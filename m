Return-Path: <linux-erofs+bounces-395-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2EAD690E
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jun 2025 09:31:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHvNB1ShNz2xPL;
	Thu, 12 Jun 2025 17:31:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749713482;
	cv=none; b=cIqBdYZCHEoNX8Ksdk1eKIJDS8DO2lzNdW+aA4gZph84aiJ8hUPKei7SqbNuMKH484T/EbfGA2yA56fLBJR5qAu6fHgdaNaJRqA9rvjNgQvNAndTixJtxxyQVHMbLiC8H8WFAMzwhLt+wctBslIAfFI7NyYVcnZmUH3YGEQ9yAetcsiDzxGnB3OCs5oEk+vLaAWAY2AOl4DcMUaCm92rNY2mwr+w8FqOduhYN6/XM3wV+Wb2cf5ncNK5vBDTt7Ij+sqXI8SNTlL/QODqAjU4JtWiEV73325I3pZrAWHYhSdIKZ5Ptsfpree9Y5yrMmFUX7i6JwfXfbEAPMYZdQb21g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749713482; c=relaxed/relaxed;
	bh=gdAlUBRnPyf26H5dnzyJ5ydiyt+D8qeRPIe0CyLGlAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8hZRWGGCPZlA5XzwaBRABXBwl48rChrMQZmbBTRI6hlQbQUw1Y/+1iBz80sxMqXapCsaqwDYx9aETX+QXauIerxloWNuJiHLSoQKBVig6t25fgXJBo0HTm4lnNdND6LY7xVqjIlS0MLGA0A/8hWmVSKXlOzzt13k4UIrqkwOZDnTagIcb68chN69oPoOcblm+zxFMury8F0NjMaS6UHwXDfpyd2GU7fddplsiBtlqdcn/SJ+Cynj6F9qFKK22HleRAgNdRfPVLPkPb4ag1DPkYfeO8kcppmi+dZtPu1NK6vb1CqUuJX3G7E9UscFF2CsAEap7KA4kQ1opzdMsJTzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KBiteD8W; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KBiteD8W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHvN569SQz2xGw
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jun 2025 17:31:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749713471; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gdAlUBRnPyf26H5dnzyJ5ydiyt+D8qeRPIe0CyLGlAQ=;
	b=KBiteD8WeQ6aSv4IRojbql4ZREcoYo599Jku/x8eJlLSNju/oWyf3vLK9FKS3+BMThnsb6OB2Mmb/UMYYGqOALGrR3YNNY+Sxzxzu5jF+ScyNHiQqf0/viSwWDjaYe7Wlbw0uGi60ORea9HntG0YKiZW4Z4s9oCsLTePWQBVH8Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdg-kmL_1749713464 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 15:31:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Fabiano Fidencio <fabiano@fidencio.org>,
	Xin Yin <yinxin.x@bytedance.com>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Fupan Li <fupan.lfp@antgroup.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: record source paths for external data
Date: Thu, 12 Jun 2025 15:31:02 +0800
Message-ID: <20250612073103.2538455-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

...which will be filled into VMDK descriptor files.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   1 +
 lib/super.c              |   5 +
 mkfs/main.c              | 217 ++++++++++++++++++++++-----------------
 3 files changed, 129 insertions(+), 94 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5e86943..8916be1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -61,6 +61,7 @@ struct erofs_buffer_head;
 struct erofs_bufmgr;
 
 struct erofs_device_info {
+	char *src_path;
 	u8 tag[64];
 	u32 blocks;
 	u32 mapped_blkaddr;
diff --git a/lib/super.c b/lib/super.c
index 1541838..beab74e 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -145,6 +145,11 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 void erofs_put_super(struct erofs_sb_info *sbi)
 {
 	if (sbi->devs) {
+		int i;
+
+		DBG_BUGON(!sbi->extra_devices);
+		for (i = 0; i < sbi->extra_devices; ++i)
+			free(sbi->devs[i].src_path);
 		free(sbi->devs);
 		sbi->devs = NULL;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 16de894..ef83f2e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -253,6 +253,7 @@ static u8 fixeduuid[16];
 static bool valid_fixeduuid;
 static unsigned int dsunit;
 static unsigned int fsalignblks = 1;
+static int tarerofs_decoder;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -577,12 +578,93 @@ static void erofs_rebuild_cleanup(void)
 	rebuild_src_count = 0;
 }
 
+static int mkfs_parse_sources(int argc, char *argv[], int optind)
+{
+	struct stat st;
+	int err, fd;
+	char *s;
+
+	if (tar_mode) {
+		cfg.c_src_path = strdup(argv[optind++]);
+		if (!cfg.c_src_path)
+			return -ENOMEM;
+		fd = open(cfg.c_src_path, O_RDONLY);
+		if (fd < 0) {
+			erofs_err("failed to open tar file: %s", cfg.c_src_path);
+			return -errno;
+		}
+		err = erofs_iostream_open(&erofstar.ios, fd,
+					  tarerofs_decoder);
+		if (err)
+			return err;
+
+		if (erofstar.dumpfile) {
+			fd = open(erofstar.dumpfile,
+				  O_WRONLY | O_CREAT | O_TRUNC, 0644);
+			if (fd < 0) {
+				erofs_err("failed to open dumpfile: %s",
+					  erofstar.dumpfile);
+				return -errno;
+			}
+			erofstar.ios.dumpfd = fd;
+		}
+	} else {
+		err = lstat((s = argv[optind++]), &st);
+		if (err) {
+			erofs_err("failed to stat %s: %s", s,
+				  erofs_strerror(-errno));
+			return -ENOENT;
+		}
+		if (S_ISDIR(st.st_mode)) {
+			cfg.c_src_path = realpath(s, NULL);
+			if (!cfg.c_src_path) {
+				erofs_err("failed to parse source directory: %s",
+					  erofs_strerror(-errno));
+				return -ENOENT;
+			}
+			erofs_set_fs_root(cfg.c_src_path);
+		} else {
+			cfg.c_src_path = strdup(s);
+			if (!cfg.c_src_path)
+				return -ENOMEM;
+			rebuild_mode = true;
+		}
+	}
+
+	if (rebuild_mode) {
+		char *srcpath = cfg.c_src_path;
+		struct erofs_sb_info *src;
+
+		do {
+			src = calloc(1, sizeof(struct erofs_sb_info));
+			if (!src) {
+				erofs_rebuild_cleanup();
+				return -ENOMEM;
+			}
+
+			err = erofs_dev_open(src, srcpath, O_RDONLY);
+			if (err) {
+				free(src);
+				erofs_rebuild_cleanup();
+				return err;
+			}
+
+			/* extra device index starts from 1 */
+			src->dev = ++rebuild_src_count;
+			list_add(&src->list, &rebuild_src_list);
+		} while (optind < argc && (srcpath = argv[optind++]));
+	} else if (optind < argc) {
+		erofs_err("unexpected argument: %s\n", argv[optind]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
 	int opt, i, err;
 	bool quiet = false;
-	int tarerofs_decoder = 0;
 	bool has_timestamp = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
@@ -939,93 +1021,28 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	if (!cfg.c_img_path)
 		return -ENOMEM;
 
-	if (optind >= argc) {
-		if (!tar_mode) {
-			erofs_err("missing argument: SOURCE(s)");
-			return -EINVAL;
-		} else {
-			int dupfd;
-
-			dupfd = dup(STDIN_FILENO);
-			if (dupfd < 0) {
-				erofs_err("failed to duplicate STDIN_FILENO: %s",
-					  strerror(errno));
-				return -errno;
-			}
-			err = erofs_iostream_open(&erofstar.ios, dupfd,
-						  tarerofs_decoder);
-			if (err)
-				return err;
-		}
+	if (optind < argc) {
+		err = mkfs_parse_sources(argc, argv, optind);
+		if (err)
+			return err;
+	} else if (!tar_mode) {
+		erofs_err("missing argument: SOURCE(s)");
+		return -EINVAL;
 	} else {
-		struct stat st;
-
-		cfg.c_src_path = realpath(argv[optind++], NULL);
-		if (!cfg.c_src_path) {
-			erofs_err("failed to parse source directory: %s",
-				  erofs_strerror(-errno));
-			return -ENOENT;
-		}
-
-		if (tar_mode) {
-			int fd = open(cfg.c_src_path, O_RDONLY);
-
-			if (fd < 0) {
-				erofs_err("failed to open file: %s", cfg.c_src_path);
-				return -errno;
-			}
-			err = erofs_iostream_open(&erofstar.ios, fd,
-						  tarerofs_decoder);
-			if (err)
-				return err;
+		int dupfd;
 
-			if (erofstar.dumpfile) {
-				fd = open(erofstar.dumpfile,
-					  O_WRONLY | O_CREAT | O_TRUNC, 0644);
-				if (fd < 0) {
-					erofs_err("failed to open dumpfile: %s",
-						  erofstar.dumpfile);
-					return -errno;
-				}
-				erofstar.ios.dumpfd = fd;
-			}
-		} else {
-			err = lstat(cfg.c_src_path, &st);
-			if (err)
-				return -errno;
-			if (S_ISDIR(st.st_mode))
-				erofs_set_fs_root(cfg.c_src_path);
-			else
-				rebuild_mode = true;
-		}
-
-		if (rebuild_mode) {
-			char *srcpath = cfg.c_src_path;
-			struct erofs_sb_info *src;
-
-			do {
-				src = calloc(1, sizeof(struct erofs_sb_info));
-				if (!src) {
-					erofs_rebuild_cleanup();
-					return -ENOMEM;
-				}
-
-				err = erofs_dev_open(src, srcpath, O_RDONLY);
-				if (err) {
-					free(src);
-					erofs_rebuild_cleanup();
-					return err;
-				}
-
-				/* extra device index starts from 1 */
-				src->dev = ++rebuild_src_count;
-				list_add(&src->list, &rebuild_src_list);
-			} while (optind < argc && (srcpath = argv[optind++]));
-		} else if (optind < argc) {
-			erofs_err("unexpected argument: %s\n", argv[optind]);
-			return -EINVAL;
+		dupfd = dup(STDIN_FILENO);
+		if (dupfd < 0) {
+			erofs_err("failed to duplicate STDIN_FILENO: %s",
+				  strerror(errno));
+			return -errno;
 		}
+		err = erofs_iostream_open(&erofstar.ios, dupfd,
+					  tarerofs_decoder);
+		if (err)
+			return err;
 	}
+
 	if (quiet) {
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
@@ -1115,6 +1132,7 @@ void erofs_show_progs(int argc, char *argv[])
 
 static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 {
+	struct erofs_device_info *devs;
 	struct erofs_sb_info *src;
 	unsigned int extra_devices = 0;
 	erofs_blk_t nblocks;
@@ -1163,20 +1181,22 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	if (ret)
 		return ret;
 
+	devs = g_sbi.devs;
 	list_for_each_entry(src, &rebuild_src_list, list) {
 		u8 *tag = NULL;
 
+		DBG_BUGON(src->dev < 1);
+		idx = src->dev - 1;
 		if (extra_devices) {
 			nblocks = src->devs[0].blocks;
 			tag = src->devs[0].tag;
 		} else {
 			nblocks = src->primarydevice_blocks;
+			devs[idx].src_path = strdup(src->devname);
 		}
-		DBG_BUGON(src->dev < 1);
-		idx = src->dev - 1;
-		g_sbi.devs[idx].blocks = nblocks;
+		devs[idx].blocks = nblocks;
 		if (tag && *tag)
-			memcpy(g_sbi.devs[idx].tag, tag, sizeof(g_sbi.devs[0].tag));
+			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
 			sprintf((char *)g_sbi.devs[idx].tag,
@@ -1216,11 +1236,12 @@ static void erofs_mkfs_showsummaries(void)
 
 int main(int argc, char **argv)
 {
-	int err = 0;
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root = NULL;
+	bool tar_index_512b = false;
 	struct timeval t;
 	FILE *blklst = NULL;
+	int err = 0;
 	u32 crc;
 
 	erofs_init_configure();
@@ -1291,12 +1312,13 @@ int main(int argc, char **argv)
 				erofs_err("failed to open %s", erofstar.mapfile);
 				goto exit;
 			}
-		} else if (erofstar.index_mode) {
+		} else if (erofstar.index_mode && !erofstar.headeronly_mode) {
 			/*
 			 * If mapfile is unspecified for tarfs index mode,
 			 * 512-byte block size is enforced here.
 			 */
 			g_sbi.blkszbits = 9;
+			tar_index_512b = true;
 		}
 	}
 
@@ -1412,8 +1434,7 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
-	    !erofstar.mapfile) || cfg.c_blobdev_path) {
+	if (tar_index_512b || cfg.c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&g_sbi, 1);
 		if (err) {
 			erofs_err("failed to generate device table: %s",
@@ -1471,8 +1492,16 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (erofstar.index_mode && g_sbi.extra_devices && !erofstar.mapfile)
-		g_sbi.devs[0].blocks = BLK_ROUND_UP(&g_sbi, erofstar.offset);
+	if (tar_index_512b) {
+		if (!g_sbi.extra_devices) {
+			DBG_BUGON(1);
+		} else {
+			if (cfg.c_src_path)
+				g_sbi.devs[0].src_path = strdup(cfg.c_src_path);
+			g_sbi.devs[0].blocks =
+				BLK_ROUND_UP(&g_sbi, erofstar.offset);
+		}
+	}
 
 	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
 	    erofs_sb_has_fragments(&g_sbi)) {
-- 
2.43.5


