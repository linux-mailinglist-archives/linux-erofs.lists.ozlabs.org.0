Return-Path: <linux-erofs+bounces-2327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4gIsMQZGlWnaNwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2327-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 05:54:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E7153136
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 05:54:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG41F2ZJ9z2yFc;
	Wed, 18 Feb 2026 15:54:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771390465;
	cv=none; b=ZC+BIjb3ATuwxYvm1JTlt4wTZs0bVTIY4kZfDB56eoXXwZHDCv4m51y8Y0j73fp9hSXMSLR78NTTxikMQb5mydXH7TFPTP9aah+xTcCQAqpbVHQ955sH+Y6ELk1NYAgJ+u3C0RTafTiba/UAhBh2G4Wx75Zt37UQhv76aT6Z0ToyBkLfhlhg5P/incT57NYq2qgpYH7ZPqRTonrD1f0R5CR09BJsJp/UVUL6ykVT/576WbeOgnpTRWogJQXh1Oqm2GheTHLKzL9Oqum6hctWZBakNBefmq7Pj+j2Y9PoLh4vf/7+GKGcaHdUTpDdRxaQrNx+hwR4JZYCZLOOT/C7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771390465; c=relaxed/relaxed;
	bh=V9FLepweUBxr80zkVLkEUYIGus/UU10Tvw27EihL1eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=av7icCigvDFnT/j79l4jqHQg3MfKd3J+/XVJGhHIeoXYOb8Z8lYQJBfAJRDNy9Dhkg0Bh87ZO38pNobk8zS5RAOKDvzfxt/AZkqLyCMzNEV8ZakI65B9jEL2qQ2jrAS+zD9McJBkIpeGffUN0O/r6kDGG/r26oJcdZcAkw8S0Ea4+drgMYHEVSiBb2nJBjTsBhYzWsmd/gDZ2EcSEGVW7Ub9DzA31C3KOxcuqnge5I28OKKeaOA5E0omo4vS1TRnVNbW2e+TXJz9OwKPFZIQAimZL1fjlH7GORy+6wRjUu1mWnSYrWgvJ8l145QsiN3n6zphyUdKxyZ0bDJcIQKyIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AM67X4KZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AM67X4KZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG418722cz2xSG
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 15:54:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771390453; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V9FLepweUBxr80zkVLkEUYIGus/UU10Tvw27EihL1eM=;
	b=AM67X4KZ02EXFZ8K0gUSwAfl/g2uwb+mF02uyUzJb2eqfU8GJDwjXHY/WKD0Qssq2ag+HWPSlNUtBp4tQVKfI57IdHoMJcvQox1rOSc1ZRz5lJpOs4YR5pdzYWz/CSz7O1iTliW30j5yWTaMKOqqGSs+GRAjQaJASQ/oNe/MLI8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRkwJm_1771390448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 12:54:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: migrate `c_max_decompressed_extent_bytes`
Date: Wed, 18 Feb 2026 12:54:06 +0800
Message-ID: <20260218045407.3783915-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2327-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: D58E7153136
X-Rspamd-Action: no action

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  1 -
 include/erofs/importer.h |  3 +++
 lib/compress.c           | 45 ++++++++++++++++++++++++++++++++++++----
 lib/config.c             |  1 -
 lib/importer.c           |  2 ++
 mkfs/main.c              |  8 +++----
 6 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 3758cc7c198e..bb303c48a0db 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -50,7 +50,6 @@ struct erofs_configure {
 	char *c_compress_hints_file;
 	char c_force_chunkformat;
 	u8 c_mkfs_metabox_algid;
-	u32 c_max_decompressed_extent_bytes;
 	const char *mount_point;
 	u32 c_root_xattr_isize;
 #ifdef EROFS_MT_ENABLED
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index a7a540d4d182..920488453c34 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -29,6 +29,8 @@ enum {
 	EROFS_FRAGDEDUPE_OFF,
 };
 
+#define EROFS_COMPRESSED_EXTENT_UNSPECIFIED	0
+
 struct erofs_importer_params {
 	struct z_erofs_paramset *z_paramsets;
 	char *source;
@@ -42,6 +44,7 @@ struct erofs_importer_params {
 	u32 pclusterblks_def;
 	u32 pclusterblks_packed;
 	s32 pclusterblks_metabox;
+	s32 max_compressed_extent_size;
 	s64 build_time;
 	char force_inodeversion;
 	bool ignore_mtime;
diff --git a/lib/compress.c b/lib/compress.c
index bbbf0e43d3fb..995bc602b145 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -53,6 +53,7 @@ struct z_erofs_compress_ictx {		/* inode context */
 	struct list_head extents;
 	u16 clusterofs;
 	int seg_num;
+	u32 max_compressed_extent_size;
 
 #if EROFS_MT_ENABLED
 	pthread_mutex_t mutex;
@@ -595,7 +596,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			goto nocompression;
 	}
 
-	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
+	e->length = min(len, ictx->max_compressed_extent_size);
 	if (data_unaligned) {
 		ret = erofs_compress(h, ctx->queue + ctx->head, e->length,
 				     dst, ctx->pclustersize);
@@ -1847,9 +1848,45 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 		ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
-	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
-		cfg.c_max_decompressed_extent_bytes <=
-			z_erofs_get_pclustersize(ictx);
+
+	if (params->max_compressed_extent_size ==
+	    EROFS_COMPRESSED_EXTENT_UNSPECIFIED) {
+		if (erofs_sb_has_48bit(sbi) && ictx->ccfg->handle.alg->c->compress) {
+			ictx->max_compressed_extent_size =
+				z_erofs_get_pclustersize(ictx);
+			ictx->data_unaligned = true;
+		} else {
+			ictx->max_compressed_extent_size = UINT32_MAX;
+			ictx->data_unaligned = false;
+		}
+	} else if (params->max_compressed_extent_size <=
+		   (s32)z_erofs_get_pclustersize(ictx)) {
+		if (params->max_compressed_extent_size < 0) {
+			ictx->max_compressed_extent_size =
+				-params->max_compressed_extent_size;
+			if (!erofs_sb_has_48bit(sbi)) {
+				erofs_err("Unaligned compressed extents must be used with the 48bit encoded extent layout",
+					  ictx->max_compressed_extent_size);
+				free(ictx);
+				return ERR_PTR(-EINVAL);
+			}
+			ictx->data_unaligned = true;
+		} else {
+			ictx->max_compressed_extent_size =
+				params->max_compressed_extent_size;
+			if (erofs_sb_has_48bit(sbi))
+				ictx->data_unaligned = true;
+		}
+		if (ictx->max_compressed_extent_size < erofs_blksiz(sbi)) {
+			erofs_err("Maximum compressed extent size (%u) must be at least the block size (%u)",
+				  ictx->max_compressed_extent_size, erofs_blksiz(sbi));
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		ictx->max_compressed_extent_size =
+			params->max_compressed_extent_size;
+		ictx->data_unaligned = false;
+	}
 	if (params->fragments && params->dedupe == EROFS_DEDUPE_FORCE_OFF &&
 	    !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
diff --git a/lib/config.c b/lib/config.c
index 3398ded56ac1..ab7eb01e1914 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -29,7 +29,6 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
-	cfg.c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
diff --git a/lib/importer.c b/lib/importer.c
index d686c519676b..26c86a0b0098 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -24,6 +24,8 @@ void erofs_importer_preset(struct erofs_importer_params *params)
 		.fixed_gid = -1,
 		.fsalignblks = 1,
 		.build_time = -1,
+		.max_compressed_extent_size =
+			EROFS_COMPRESSED_EXTENT_UNSPECIFIED,
 	};
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index ee23944f3ebd..fb51cf87ef48 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1179,13 +1179,13 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 #endif
 		case 9:
-			cfg.c_max_decompressed_extent_bytes =
-				strtoul(optarg, &endptr, 0);
-			if (*endptr != '\0') {
-				erofs_err("invalid maximum uncompressed extent size %s",
+			i = strtol(optarg, &endptr, 0);
+			if (*endptr != '\0' || i > INT32_MAX || i < INT32_MIN) {
+				erofs_err("invalid maximum compressed extent size %s",
 					  optarg);
 				return -EINVAL;
 			}
+			params->max_compressed_extent_size = i;
 			break;
 		case 10:
 			cfg.c_compress_hints_file = optarg;
-- 
2.43.5


