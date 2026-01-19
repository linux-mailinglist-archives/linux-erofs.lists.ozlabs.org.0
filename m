Return-Path: <linux-erofs+bounces-1981-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2CD39F15
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 07:55:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvh7K38b4z2xjb;
	Mon, 19 Jan 2026 17:55:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768805757;
	cv=none; b=brybbuc/8iKJjwwCfYznA+qV4URDzreb9w45A3pqVgOBrWuGDZtBNgmUjpKEffRNgBRfb7sGsIWh+3YTIdOwPsZl683Xt4Kc/xwG8isPY9hC/+joDd4FMI695L2KOh28up079rGucoA3+mJyvWNaDK0H0wmjqhPQfl6qbDWJ+428OhFGsYenmHWNGZjlHQY3MniUXTUaSjtSSkzz/o5zrH44X/5Adw090DlmuegXlle7UxVYzFH74y5uunaurqCKKbmaH1YQY73y5B+rrLzdFKHdcmh4BUvGl1whiuyA0X0tzI+PoKbR5ynrjzVJl7CBC1qOS4i+8+PvCjusjKBF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768805757; c=relaxed/relaxed;
	bh=XR0A1vzjmpAVfbuMlQZ0BIPPUMuy+393RBoLvlQRDRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSC2OLkZ+BZMJeUn0iKxDBMJMl8bA30sduNwHULgUzciYaJNDDFfS0/WgkULPFa8Mu5+pI6vVtWZHdDHAknVaSUTdfmZoFFpx562AS7xSdGtWIzAreyMmVinzUDoVhzl7Bpv997BKP9D4ATE6dhNIzpHNTKipLXzkSUSH83iDtZ1SrL56J03pKVXiteWYGH6BNOhS7HgPNf7iMImUIGdeMDvls43fYTgqtbxjTCqDOXMjcM4mTIQme1GCKzzlA+o5/Q8MlMbYXGKLrov+SxoPduluvNt/QgSf56sMPznooXJcnEGtbMrL3E3eudYLg/QZRIAskam82HZWa7VQqkoOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edJIZmYq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edJIZmYq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvh7G4Wdxz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 17:55:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768805746; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XR0A1vzjmpAVfbuMlQZ0BIPPUMuy+393RBoLvlQRDRw=;
	b=edJIZmYqWgpxJ0mzpMT6t5YDj8s0j6jAp387cqF3dme67DDoMQh8EWedTpVgTS6H6OjeFangMaX+lV51JtUNazbqmMvl1+0wQYHKdwtUOc7XbiaPDXNErEgdspUKgAn5qIutwsoNoXRLDW//PWN6r71J0H4KfbaWDwJ57rh+BBM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxJFJZ2_1768805737 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 14:55:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5] erofs-utils: lib: fix incorrect mtime under -Edot-omitted
Date: Mon, 19 Jan 2026 14:55:36 +0800
Message-ID: <20260119065536.2779283-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <9c9312c9-1a0e-4c39-aad5-c805e1641a36@linux.alibaba.com>
References: <9c9312c9-1a0e-4c39-aad5-c805e1641a36@linux.alibaba.com>
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

From: Yifan Zhao <zhaoyifan28@huawei.com>

`-Edot-omitted` enables `-E48bits`, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves time initialization logic into `erofs_importer_init()`
to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
it seems the previous reply version was broken due to invalid formats.

 include/erofs/config.h   |  1 -
 include/erofs/importer.h |  1 +
 lib/config.c             |  1 -
 lib/importer.c           | 11 +++++++++++
 mkfs/main.c              | 26 +++++++++++---------------
 5 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 525a8cd5ebfb..2a84fb515868 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,7 +58,6 @@ struct erofs_configure {
 	char c_force_chunkformat;
 	u8 c_mkfs_metabox_algid;
 	u32 c_max_decompressed_extent_bytes;
-	u64 c_unix_timestamp;
 	const char *mount_point;
 	u32 c_root_xattr_isize;
 #ifdef EROFS_MT_ENABLED
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index a525b474f1d5..15e247e51b9c 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -41,6 +41,7 @@ struct erofs_importer_params {
 	u32 pclusterblks_def;
 	u32 pclusterblks_packed;
 	s32 pclusterblks_metabox;
+	s64 build_time;
 	char force_inodeversion;
 	bool ignore_mtime;
 	bool no_datainline;
diff --git a/lib/config.c b/lib/config.c
index 16b34fa840d3..5eb0ddeaa851 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -29,7 +29,6 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
-	cfg.c_unix_timestamp = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
diff --git a/lib/importer.c b/lib/importer.c
index 958a433b9eaa..d686c519676b 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -23,6 +23,7 @@ void erofs_importer_preset(struct erofs_importer_params *params)
 		.fixed_uid = -1,
 		.fixed_gid = -1,
 		.fsalignblks = 1,
+		.build_time = -1,
 	};
 }
 
@@ -83,6 +84,16 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	if (params->dot_omitted)
 		erofs_sb_set_48bit(sbi);
+
+	if (params->build_time != -1) {
+		if (erofs_sb_has_48bit(sbi)) {
+			sbi->epoch = max_t(s64, 0, params->build_time - UINT32_MAX);
+			sbi->build_time = params->build_time - sbi->epoch;
+		} else {
+			sbi->epoch = params->build_time;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/mkfs/main.c b/mkfs/main.c
index b45368f301f3..683c650db519 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -274,8 +274,10 @@ static struct erofsmkfs_cfg {
 	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
 	long inlinexattr_tolerance;
 	bool inode_metazone;
+	u64 unix_timestamp;
 } mkfscfg = {
 	.inlinexattr_tolerance = 2,
+	.unix_timestamp = -1,
 };
 
 static unsigned int pclustersize_packed, pclustersize_max;
@@ -1096,8 +1098,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 
 		case 'T':
-			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
-			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
+			mkfscfg.unix_timestamp = strtoull(optarg, &endptr, 0);
+			if (mkfscfg.unix_timestamp == -1 || *endptr != '\0') {
 				erofs_err("invalid UNIX timestamp %s", optarg);
 				return -EINVAL;
 			}
@@ -1576,7 +1578,7 @@ int parse_source_date_epoch(void)
 			  source_date_epoch);
 		return -EINVAL;
 	}
-	cfg.c_unix_timestamp = epoch;
+	mkfscfg.unix_timestamp = epoch;
 	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
 	return 0;
 }
@@ -1702,7 +1704,6 @@ int main(int argc, char **argv)
 	bool tar_index_512b = false;
 	struct timeval t;
 	FILE *blklst = NULL;
-	s64 mkfs_time = 0;
 	int err;
 	u32 crc;
 
@@ -1727,17 +1728,12 @@ int main(int argc, char **argv)
 	}
 
 	g_sbi.fixed_nsec = 0;
-	if (cfg.c_unix_timestamp != -1) {
-		mkfs_time = cfg.c_unix_timestamp;
-	} else if (!gettimeofday(&t, NULL)) {
-		mkfs_time = t.tv_sec;
-	}
-	if (erofs_sb_has_48bit(&g_sbi)) {
-		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
-		g_sbi.build_time = mkfs_time - g_sbi.epoch;
-	} else {
-		g_sbi.epoch = mkfs_time;
-	}
+	if (mkfscfg.unix_timestamp != -1)
+		importer_params.build_time = mkfscfg.unix_timestamp;
+	else if (!gettimeofday(&t, NULL))
+		importer_params.build_time = t.tv_sec;
+	else
+		importer_params.build_time = 0;
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
-- 
2.43.5


