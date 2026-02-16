Return-Path: <linux-erofs+bounces-2323-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKA8LQAvk2ke2QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2323-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Feb 2026 15:51:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6B144D22
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Feb 2026 15:51:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fF5MK2c75z2xlq;
	Tue, 17 Feb 2026 01:51:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771253501;
	cv=none; b=kBT5/LF60WdxJpPgBsKV1zQpfEEncfmcJ2jP/WJNpiTph5Zhk1DAco4pVaopdfG1HBcc5bRjgnvOHwsMWP90G5KRC14QQnECMyK0awKnfvqsCigLHsD8JwJjyQZ3yO5/6u3dVdGmtynZJXRd9ltBNNkJlhUcfDhw6Eb0uBYzuxJjpEjgV4mfnn0YdtACLkdl/8smRMdFwOoUV55opJEOQ5wy9mB4PGTMqCepCRN7gk2Z77REzL1HJNamQJImYveEXQuW6aAJvgeAkqMF4Ms/J6G6P2qs0DhtDtZaA1A4dYCNyT/HS+iC+ZLhwIZG1s7Mnk9DF5eKXbLiZFGllhwtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771253501; c=relaxed/relaxed;
	bh=cf0FLtOfq/vI6PDgIFIrbGChkoaX5QChl4BBHeZBrJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBdIErk/4lI2bY+iGzSWZG8VyoPV9nxlayNl81lfB8/THBw46JkH/3muDm+HAPajCm95GIPYLvLBdJjWbj5r8U1Lz1SDuyXnLGg7uZaaij1GOGomVTawNN9tnqlQYicPUz6GmKoTc3eIsKdR5vzf7XdwzXY5e9EKpJrduhwSgH5MXiGjmhS7v1rmx60jE3HSXpO186c//YIFMx/d7798QGFrWZzbcku7ga1N2V1E9RpI8SU9dM8dj0htt373ftcRpkj0KHlqorgeeV3Vb3RpCRgy2TOX7G0XftBG8E4iO6GdfeGqdK6zd6vUHj38DvKhYzvV5QO0V4cmbFMAflixTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NY4+JfCO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NY4+JfCO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fF5MG3rBQz2xVT
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Feb 2026 01:51:37 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771253493; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cf0FLtOfq/vI6PDgIFIrbGChkoaX5QChl4BBHeZBrJE=;
	b=NY4+JfCOuzlFqfC6vojarIFWpZo9lC3Zv9UxXEsv/u0wo3XGhcyD4poqwrZ5pBaxk9XB13lPoOXByUXSnbMLJDN09JZ8rZo3Kz5YJrV/y0em4a+pnjXaz+/ELKmim1oy7u0lMNPq2+uHymtmmC1WXxUMlQAIkHROpVfHnWwAhv0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzM2lr-_1771253486 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Feb 2026 22:51:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: migrate `c_compr_opts`
Date: Mon, 16 Feb 2026 22:39:17 +0800
Message-ID: <20260216143918.602457-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2323-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: E2C6B144D22
X-Rspamd-Action: no action

It's also used to prepare for extra compression option support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |   7 ---
 include/erofs/importer.h |   1 +
 include/erofs/internal.h |   6 ++
 lib/compress.c           |  53 +++++++++--------
 lib/compress_hints.c     |   2 +-
 lib/compressor.c         |  29 ++++------
 lib/compressor.h         |   2 +-
 lib/config.c             |   4 --
 lib/inode.c              |   4 +-
 lib/remotes/s3.c         |   2 +-
 lib/tar.c                |   2 +-
 mkfs/main.c              | 120 +++++++++++++++++++--------------------
 12 files changed, 113 insertions(+), 119 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2a84fb515868..3758cc7c198e 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -29,12 +29,6 @@ enum {
 
 #define EROFS_MAX_COMPR_CFGS		64
 
-struct erofs_compr_opts {
-	char *alg;
-	int level;
-	u32 dict_size;
-};
-
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
@@ -54,7 +48,6 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_blobdev_path;
 	char *c_compress_hints_file;
-	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
 	char c_force_chunkformat;
 	u8 c_mkfs_metabox_algid;
 	u32 c_max_decompressed_extent_bytes;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index adeea7230447..a7a540d4d182 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -30,6 +30,7 @@ enum {
 };
 
 struct erofs_importer_params {
+	struct z_erofs_paramset *z_paramsets;
 	char *source;
 	u32 mt_async_queue_limit;
 	u32 fixed_uid;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3f1e4ffa2b52..3ccae0c7ac86 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -434,6 +434,12 @@ struct erofs_map_dev {
 	unsigned int m_deviceid;
 };
 
+struct z_erofs_paramset {
+	char *alg;
+	int clevel;
+	u32 dict_size;
+};
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
diff --git a/lib/compress.c b/lib/compress.c
index 222e380cdcd7..1c4aa115641d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -100,11 +100,7 @@ struct erofs_compress_work {
 	struct z_erofs_compress_sctx ctx;
 	pthread_cond_t cond;
 	struct erofs_compress_work *next;
-
-	unsigned int alg_id;
-	char *alg_name;
-	unsigned int comp_level;
-	unsigned int dict_size;
+	struct z_erofs_paramset *zset;
 
 	int errcode;
 };
@@ -126,7 +122,8 @@ struct z_erofs_compress_fslot {
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
 	struct erofs_compress handle;
-	unsigned int algorithmtype;
+	struct z_erofs_paramset zset;
+	int algorithmtype;
 	bool enable;
 };
 
@@ -1479,19 +1476,22 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct z_erofs_compress_ictx *ictx = sctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	struct erofs_compress_cfg *lc = &tls->ccfg[cwork->alg_id];
+	int zsetno = container_of(cwork->zset, struct erofs_compress_cfg, zset)
+			- sbi->zmgr->ccfg;
+	struct erofs_compress_cfg *lc = &tls->ccfg[zsetno];
 	int ret;
 
 	if (__erofs_unlikely(!lc->enable)) {
 		unsigned int pclustersize_max =
 			ictx->im->params->pclusterblks_max << sbi->blkszbits;
 
-		ret = erofs_compressor_init(sbi, &lc->handle,
-					    cwork->alg_name, cwork->comp_level,
-					    cwork->dict_size, pclustersize_max);
+		lc->zset = *cwork->zset;
+		ret = erofs_compressor_init(sbi, &lc->handle, &lc->zset,
+					    pclustersize_max);
 		if (ret)
 			goto out;
-		lc->algorithmtype = cwork->alg_id;
+		lc->algorithmtype =
+			z_erofs_get_compress_algorithm_id(&lc->handle);
 		lc->enable = true;
 	}
 
@@ -1499,7 +1499,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	DBG_BUGON(sctx->pclustersize > Z_EROFS_PCLUSTER_MAX_SIZE);
 	sctx->queue = tls->queue;
 	sctx->destbuf = tls->destbuf;
-	sctx->chandle = &tls->ccfg[cwork->alg_id].handle;
+	sctx->chandle = &lc->handle;
 	erofs_compressor_reset(sctx->chandle);
 	sctx->membuf = malloc(round_up(sctx->remaining, erofs_blksiz(sbi)));
 	if (!sctx->membuf) {
@@ -1639,10 +1639,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		};
 		init_list_head(&cur->ctx.extents);
 
-		cur->alg_id = ccfg->handle.alg->id;
-		cur->alg_name = ccfg->handle.alg->name;
-		cur->comp_level = ccfg->handle.compression_level;
-		cur->dict_size = ccfg->handle.dict_size;
+		cur->zset = &ccfg->zset;
 		cur->errcode = 1;	/* mark as "in progress" */
 
 		if (i >= nsegs - 1) {
@@ -2154,13 +2151,20 @@ int z_erofs_compress_init(struct erofs_importer *im)
 		newzmgr = true;
 	}
 
-	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; params->z_paramsets[i].alg; ++i) {
 		struct erofs_compress_cfg *ccfg = &sbi->zmgr->ccfg[i];
 		struct erofs_compress *c = &ccfg->handle;
+		const struct z_erofs_paramset *zset = &params->z_paramsets[i];
+
+		if (ccfg->enable)
+			return -EINVAL;
 
-		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
-					    cfg.c_compr_opts[i].level,
-					    cfg.c_compr_opts[i].dict_size,
+		ccfg->zset = *zset;
+		ccfg->zset.alg = strdup(zset->alg);
+		if (!ccfg->zset.alg)
+			return -ENOMEM;
+
+		ret = erofs_compressor_init(sbi, c, &ccfg->zset,
 					    pclustersize_max);
 		if (ret)
 			return ret;
@@ -2168,8 +2172,8 @@ int z_erofs_compress_init(struct erofs_importer *im)
 		id = z_erofs_get_compress_algorithm_id(c);
 		ccfg->algorithmtype = id;
 		ccfg->enable = true;
-		available_compr_algs |= 1 << ccfg->algorithmtype;
-		if (ccfg->algorithmtype != Z_EROFS_COMPRESSION_LZ4)
+		available_compr_algs |= 1 << id;
+		if (id != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
 		if (c->dict_size > max_dict_size[id])
 			max_dict_size[id] = c->dict_size;
@@ -2253,10 +2257,13 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 	if (!sbi->zmgr)
 		return 0;
 
-	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; i < ARRAY_SIZE(sbi->zmgr->ccfg); ++i) {
+		if (!sbi->zmgr->ccfg[i].enable)
+			continue;
 		ret = erofs_compressor_exit(&sbi->zmgr->ccfg[i].handle);
 		if (ret)
 			return ret;
+		free(sbi->zmgr->ccfg[i].zset.alg);
 	}
 	free(sbi->zmgr);
 	return 0;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 15f3e54c2ce4..322ec97f474a 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -129,7 +129,7 @@ int erofs_load_compress_hints(struct erofs_importer *im,
 		} else {
 			ccfg = atoi(alg);
 			if (ccfg >= EROFS_MAX_COMPR_CFGS ||
-			    !cfg.c_compr_opts[ccfg].alg) {
+			    !params->z_paramsets[ccfg].alg) {
 				erofs_err("invalid compressing configuration \"%s\" at line %u",
 					  alg, line);
 				ret = -EINVAL;
diff --git a/lib/compressor.c b/lib/compressor.c
index efcead1b1f29..79d80372968e 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -97,8 +97,8 @@ int erofs_compress(const struct erofs_compress *c,
 }
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level,
-			  u32 dict_size, u32 pclustersize_max)
+			  const struct z_erofs_paramset *zset,
+			  u32 pclustersize_max)
 {
 	int ret, i;
 
@@ -109,43 +109,38 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 	c->compression_level = -1;
 	c->dict_size = 0;
 
-	if (!alg_name) {
-		c->alg = NULL;
-		return 0;
-	}
-
 	ret = -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(erofs_algs); ++i) {
-		if (alg_name && strcmp(alg_name, erofs_algs[i].name))
+		if (strcmp(zset->alg, erofs_algs[i].name))
 			continue;
 
 		if (!erofs_algs[i].c)
 			continue;
 
 		if (erofs_algs[i].c->setlevel) {
-			ret = erofs_algs[i].c->setlevel(c, compression_level);
+			ret = erofs_algs[i].c->setlevel(c, zset->clevel);
 			if (ret) {
 				erofs_err("failed to set compression level %d for %s",
-					  compression_level, alg_name);
+					  zset->clevel, zset->alg);
 				return ret;
 			}
-		} else if (compression_level >= 0) {
+		} else if (zset->clevel >= 0) {
 			erofs_err("compression level %d is not supported for %s",
-				  compression_level, alg_name);
+				  zset->clevel, zset->alg);
 			return -EINVAL;
 		}
 
 		if (erofs_algs[i].c->setdictsize) {
-			ret = erofs_algs[i].c->setdictsize(c, dict_size,
+			ret = erofs_algs[i].c->setdictsize(c, zset->dict_size,
 							   pclustersize_max);
 			if (ret) {
 				erofs_err("failed to set dict size %u for %s",
-					  dict_size, alg_name);
+					  zset->dict_size, zset->alg);
 				return ret;
 			}
-		} else if (dict_size) {
+		} else if (zset->dict_size) {
 			erofs_err("dict size is not supported for %s",
-				  alg_name);
+				  zset->alg);
 			return -EINVAL;
 		}
 
@@ -158,7 +153,7 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			return 0;
 		}
 	}
-	erofs_err("Cannot find a valid compressor %s", alg_name);
+	erofs_err("Cannot find a valid compressor %s", zset->alg);
 	return ret;
 }
 
diff --git a/lib/compressor.h b/lib/compressor.h
index c008206a489d..c679466759d3 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -69,7 +69,7 @@ int erofs_compress(const struct erofs_compress *c,
 		   void *dst, unsigned int dstcapacity);
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level, u32 dict_size,
+			  const struct z_erofs_paramset *zset,
 			  u32 pclustersize_max);
 int erofs_compressor_exit(struct erofs_compress *c);
 void erofs_compressor_reset(struct erofs_compress *c);
diff --git a/lib/config.c b/lib/config.c
index 5eb0ddeaa851..3398ded56ac1 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -46,8 +46,6 @@ void erofs_show_config(void)
 
 void erofs_exit_configure(void)
 {
-	int i;
-
 #ifdef HAVE_LIBSELINUX
 	if (cfg.sehnd)
 		selabel_close(cfg.sehnd);
@@ -56,8 +54,6 @@ void erofs_exit_configure(void)
 		free(cfg.c_img_path);
 	if (cfg.c_src_path)
 		free(cfg.c_src_path);
-	for (i = 0; i < EROFS_MAX_COMPR_CFGS && cfg.c_compr_opts[i].alg; i++)
-		free(cfg.c_compr_opts[i].alg);
 }
 
 struct erofs_configure *erofs_get_configure()
diff --git a/lib/inode.c b/lib/inode.c
index 79e5d3bae573..4a214f91cbb2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2023,7 +2023,7 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 				return ret;
 		}
 
-		if (cfg.c_compr_opts[0].alg &&
+		if (inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
@@ -2352,7 +2352,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		return ERR_PTR(ret);
 	}
 
-	if (cfg.c_compr_opts[0].alg &&
+	if (sbi->available_compr_algs &&
 	    erofs_file_is_compressible(im, inode)) {
 		ictx = erofs_prepare_compressed_file(im, inode);
 		if (IS_ERR(ictx))
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 73db4b786c41..5e4e9d39ab24 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1028,7 +1028,7 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 		return -EIO;
 
 	resp.pos = 0;
-	if (!cfg.c_compr_opts[0].alg && im->params->no_datainline) {
+	if (!sbi->available_compr_algs && im->params->no_datainline) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 		inode->idata_size = 0;
 		ret = erofs_allocate_inode_bh_data(inode,
diff --git a/lib/tar.c b/lib/tar.c
index 1f3092566bd9..178f843c905c 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1105,7 +1105,7 @@ new_inode:
 								 inode->i_size))
 					ret = -EIO;
 			} else if (tar->try_no_reorder &&
-				   !cfg.c_compr_opts[0].alg &&
+				   !sbi->available_compr_algs &&
 				   params->no_datainline) {
 				ret = tarerofs_write_uncompressed_file(inode, tar);
 			} else {
diff --git a/mkfs/main.c b/mkfs/main.c
index a948b2e1febd..326c332d37af 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -273,10 +273,12 @@ static void version(void)
 }
 
 static struct erofsmkfs_cfg {
+	struct z_erofs_paramset zcfgs[EROFS_MAX_COMPR_CFGS + 1];
 	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
 	long inlinexattr_tolerance;
 	bool inode_metazone;
 	u64 unix_timestamp;
+	unsigned int total_zcfgs;
 } mkfscfg = {
 	.inlinexattr_tolerance = 2,
 	.unix_timestamp = -1,
@@ -314,7 +316,7 @@ static enum {
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
-static unsigned int rebuild_src_count, total_ccfgs;
+static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
@@ -837,66 +839,66 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 }
 #endif
 
-static int mkfs_parse_one_compress_alg(char *alg,
-				       struct erofs_compr_opts *copts)
+struct z_erofs_paramset erofs_mkfs_zparams[EROFS_MAX_COMPR_CFGS + 1];
+unsigned int erofs_mkfs_total_ccfgs;
+
+static int mkfs_parse_one_compress_alg(char *alg)
 {
+	struct z_erofs_paramset *zset = mkfscfg.zcfgs + mkfscfg.total_zcfgs;
 	char *p, *q, *opt, *endptr;
 
-	copts->level = -1;
-	copts->dict_size = 0;
+	if (zset >= erofs_mkfs_zparams + ARRAY_SIZE(erofs_mkfs_zparams)) {
+		erofs_err("too many algorithm types");
+		return -EINVAL;
+	}
+	zset->clevel = -1;
+	zset->dict_size = 0;
 
 	p = strchr(alg, ',');
-	if (p) {
-		copts->alg = strndup(alg, p - alg);
-
-		/* support old '-zlzma,9' form */
-		if (isdigit(*(p + 1))) {
-			copts->level = strtol(p + 1, &endptr, 10);
-			if (*endptr && *endptr != ',') {
-				erofs_err("invalid compression level %s",
-					  p + 1);
-				return -EINVAL;
-			}
-			return 0;
-		}
+	if (!p) {
+		zset->alg = alg;
 	} else {
-		copts->alg = strdup(alg);
-		return 0;
-	}
-
-	opt = p + 1;
-	while (opt) {
-		q = strchr(opt, ',');
-		if (q)
-			*q = '\0';
-
-		if ((p = strstr(opt, "level="))) {
-			p += strlen("level=");
-			copts->level = strtol(p, &endptr, 10);
-			if ((endptr == p) || (*endptr && *endptr != ',')) {
+		*p++ = '\0';
+		zset->alg = alg;
+		if (isdigit(*p)) {	/* support old '-zlzma,9' form */
+			zset->clevel = strtol(p, &endptr, 10);
+			if (*endptr && *endptr != ',') {
 				erofs_err("invalid compression level %s", p);
 				return -EINVAL;
 			}
-		} else if ((p = strstr(opt, "dictsize="))) {
-			p += strlen("dictsize=");
-			copts->dict_size = strtoul(p, &endptr, 10);
-			if (*endptr == 'k' || *endptr == 'K')
-				copts->dict_size <<= 10;
-			else if (*endptr == 'm' || *endptr == 'M')
-				copts->dict_size <<= 20;
-			else if ((endptr == p) || (*endptr && *endptr != ',')) {
-				erofs_err("invalid compression dictsize %s", p);
-				return -EINVAL;
-			}
 		} else {
-			erofs_err("invalid compression option %s", opt);
-			return -EINVAL;
+			for (opt = p; opt;) {
+				q = strchr(opt, ',');
+				if (q)
+					*q = '\0';
+
+				if ((p = strstr(opt, "level="))) {
+					p += strlen("level=");
+					zset->clevel = strtol(p, &endptr, 10);
+					if ((endptr == p) || (*endptr && *endptr != ',')) {
+						erofs_err("invalid compression level %s", p);
+						return -EINVAL;
+					}
+				} else if ((p = strstr(opt, "dictsize="))) {
+					p += strlen("dictsize=");
+					zset->dict_size = strtoul(p, &endptr, 10);
+					if (*endptr == 'k' || *endptr == 'K')
+						zset->dict_size <<= 10;
+					else if (*endptr == 'm' || *endptr == 'M')
+						zset->dict_size <<= 20;
+					else if ((endptr == p) || (*endptr && *endptr != ',')) {
+						erofs_err("invalid compression dictsize %s", p);
+						return -EINVAL;
+					}
+				} else {
+					erofs_err("invalid compression option %s", opt);
+					return -EINVAL;
+				}
+				opt = q ? q + 1 : NULL;
+			}
 		}
-
-		opt = q ? q + 1 : NULL;
 	}
-
-	return 0;
+	return mkfscfg.total_zcfgs++;
 }
 
 static int mkfs_parse_compress_algs(char *algs)
@@ -905,15 +907,9 @@ static int mkfs_parse_compress_algs(char *algs)
 	int ret;
 
 	for (s = strtok(algs, ":"); s; s = strtok(NULL, ":")) {
-		if (total_ccfgs >= EROFS_MAX_COMPR_CFGS - 1) {
-			erofs_err("too many algorithm types");
-			return -EINVAL;
-		}
-
-		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[total_ccfgs]);
-		if (ret)
+		ret = mkfs_parse_one_compress_alg(s);
+		if (ret < 0)
 			return ret;
-		++total_ccfgs;
 	}
 	return 0;
 }
@@ -1210,11 +1206,10 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				metabox_algorithmid =
 					strtoul(algid + 1, &endptr, 0);
 				if (*endptr != '\0') {
-					err = mkfs_parse_one_compress_alg(algid + 1,
-							&cfg.c_compr_opts[total_ccfgs]);
-					if (err)
+					err = mkfs_parse_one_compress_alg(algid + 1);
+					if (err < 0)
 						return err;
-					metabox_algorithmid = total_ccfgs++;
+					metabox_algorithmid = err;
 				}
 			}
 			pclustersize_metabox = atoi(optarg);
@@ -1856,6 +1851,7 @@ int main(int argc, char **argv)
 
 	if (mkfscfg.inlinexattr_tolerance < 0)
 		importer_params.no_xattrs = true;
+	importer_params.z_paramsets = mkfscfg.zcfgs;
 	importer_params.source = cfg.c_src_path;
 	importer_params.no_datainline = mkfs_no_datainline;
 	importer_params.dot_omitted = mkfs_dot_omitted;
@@ -1864,7 +1860,7 @@ int main(int argc, char **argv)
 		goto exit;
 
 	if (importer_params.dedupe == EROFS_DEDUPE_FORCE_ON) {
-		if (!cfg.c_compr_opts[0].alg) {
+		if (!g_sbi.available_compr_algs) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = g_sbi.blkszbits;
 		} else {
-- 
2.43.5


