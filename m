Return-Path: <linux-erofs+bounces-2322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zH48MQAvk2lb2QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Feb 2026 15:51:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8E144D21
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Feb 2026 15:51:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fF5MK0Ywgz2ySS;
	Tue, 17 Feb 2026 01:51:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771253501;
	cv=none; b=hSBl+O5vwH4qnvj7Ey8DbFqBid35Ze8gi1Bq9tmFy1ODGikKpke/YWfyu+9F1cFB80Y/XEgV4wSdsDyO5LbSPFHlpvym7USv7JSjb7qn6Hqfnizw4zL0v8VWtKn49hmeDYL29XO5Cp3/PFLeXRL62EbvpN3iBFBxKZscEe7jQc8l0tPOz9ctBPkKSiuZanmmCD9+oc6a0GnLTQy/W+nSJfgQ6rbTdyaDtHAn5vSwuSDojZ5l7CxP7QdRop3OdsUrGxUlndIBYWFO9fQq4bH7sTGTdgciE7VF8UxVL9jelsOVYz1hCEhGcx99az5VuMaWQ/diC2Q2nZ5EfPZP9JGp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771253501; c=relaxed/relaxed;
	bh=zBE/foptVNH37yFH3mw7f6Vz1w1ZaD+YTC9925o4qYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/nqbDvqVg/5edWD2uhwKfChfbJ9nrRDP6HHmEfr8K5O0xkkE4i3+wXXoxkOqtLpHu+WNPROdschTytZ2h6XiOlHazxsNowjbMjSSD2R+z32zQP35wUe9Zpsilnl+o55HaviqIsv2TkeHd4X/TqYNj6aRIlAsuTztdvmX0kwytL1bolKVJkSBbacms/BDkhkxfoqsGLB8aTGhJl7zD/5B646EXEtr9D3HZIPf3j4UUS5HjzX9NO8AWV9/BYScmJuxiFOen4AmlEHbBo/zhUAlRD7WYS1YYnQZw5JFtkIaQvy2N5AYhU/1wstynou1rbuUt6UT9Rpj0pdOC5RnBKeBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Cye9NYk6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Cye9NYk6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fF5MH1Cljz2xlq
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Feb 2026 01:51:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771253494; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zBE/foptVNH37yFH3mw7f6Vz1w1ZaD+YTC9925o4qYA=;
	b=Cye9NYk6j8+tsnDCzIXRGnok4NE+8TPeo3igMneZ0kxmZ8BsNElm91Zmw1rfTZ61QWa3G/1HioDEU+DrkZDA5pH89G+dZe4iLQbrUjo03nxMwo0GOlAl2UfloBnsLYrGK+W4sQKbaUdlRbR7clMawTFi+v0spLEGTENJMz1ZREc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzM2lvG_1771253491 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Feb 2026 22:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: support lc,lp,pb properties for LZMA
Date: Mon, 16 Feb 2026 22:39:18 +0800
Message-ID: <20260216143918.602457-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260216143918.602457-1-hsiangkao@linux.alibaba.com>
References: <20260216143918.602457-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2322-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: DBD8E144D21
X-Rspamd-Action: no action

Add support for specifying LZMA compression parameters lc (literal
context bits), lp (literal position bits), and pb (position bits)
via mkfs.erofs command-line options.

Note that these are all advanced parameters: Default values are used
if not specified.  Users are advised to keep defaults unless they
understand their impact.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 lib/compress.c           | 15 +++++--
 lib/compressor.c         | 70 ++++++++++++++++++++----------
 lib/compressor.h         |  4 +-
 lib/compressor_liblzma.c | 93 ++++++++++++++++++++++++++++++----------
 mkfs/main.c              | 20 ++++++++-
 6 files changed, 150 insertions(+), 53 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3ccae0c7ac86..0a5f6beeb14c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -438,6 +438,7 @@ struct z_erofs_paramset {
 	char *alg;
 	int clevel;
 	u32 dict_size;
+	char *extraopts;
 };
 
 int liberofs_global_init(void);
diff --git a/lib/compress.c b/lib/compress.c
index 1c4aa115641d..bbbf0e43d3fb 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1457,10 +1457,11 @@ void *z_erofs_mt_wq_tls_free(struct erofs_workqueue *wq, void *priv)
 	struct erofs_compress_wq_tls *tls = priv;
 	int i;
 
-	for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++)
-		if (tls->ccfg[i].enable)
-			erofs_compressor_exit(&tls->ccfg[i].handle);
-
+	for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++) {
+		if (!tls->ccfg[i].enable)
+			continue;
+		erofs_compressor_exit(&tls->ccfg[i].handle);
+	}
 	free(tls->ccfg);
 	free(tls->destbuf);
 	free(tls->queue);
@@ -2163,6 +2164,11 @@ int z_erofs_compress_init(struct erofs_importer *im)
 		ccfg->zset.alg = strdup(zset->alg);
 		if (!ccfg->zset.alg)
 			return -ENOMEM;
+		if (zset->extraopts) {
+			ccfg->zset.extraopts = strdup(zset->extraopts);
+			if (!ccfg->zset.extraopts)
+				return -ENOMEM;
+		}
 
 		ret = erofs_compressor_init(sbi, c, &ccfg->zset,
 					    pclustersize_max);
@@ -2264,6 +2270,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 		if (ret)
 			return ret;
 		free(sbi->zmgr->ccfg[i].zset.alg);
+		free(sbi->zmgr->ccfg[i].zset.extraopts);
 	}
 	free(sbi->zmgr);
 	return 0;
diff --git a/lib/compressor.c b/lib/compressor.c
index 79d80372968e..cf55abcf5359 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -96,6 +96,13 @@ int erofs_compress(const struct erofs_compress *c,
 	return c->alg->c->compress(c, src, srcsize, dst, dstcapacity);
 }
 
+int erofs_compressor_exit(struct erofs_compress *c)
+{
+	if (c->alg && c->alg->c->exit)
+		return c->alg->c->exit(c);
+	return 0;
+}
+
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			  const struct z_erofs_paramset *zset,
 			  u32 pclustersize_max)
@@ -117,17 +124,36 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 		if (!erofs_algs[i].c)
 			continue;
 
+		if (!erofs_algs[i].c->setlevel && zset->clevel >= 0) {
+			erofs_err("compression level %d is not supported for %s",
+				  zset->clevel, zset->alg);
+			return -EINVAL;
+		}
+
+		if (!erofs_algs[i].c->setdictsize && zset->dict_size) {
+			erofs_err("unsupported dict size for %s", zset->alg);
+			return -EINVAL;
+		}
+
+		if (!erofs_algs[i].c->setextraopts && zset->extraopts) {
+			erofs_err("invalid compression option %s for %s",
+				  zset->extraopts, zset->alg);
+			return -EINVAL;
+		}
+
+		if (erofs_algs[i].c->preinit) {
+			ret = erofs_algs[i].c->preinit(c);
+			if (ret)
+				return ret;
+		}
+
 		if (erofs_algs[i].c->setlevel) {
 			ret = erofs_algs[i].c->setlevel(c, zset->clevel);
 			if (ret) {
 				erofs_err("failed to set compression level %d for %s",
 					  zset->clevel, zset->alg);
-				return ret;
+				goto fail;
 			}
-		} else if (zset->clevel >= 0) {
-			erofs_err("compression level %d is not supported for %s",
-				  zset->clevel, zset->alg);
-			return -EINVAL;
 		}
 
 		if (erofs_algs[i].c->setdictsize) {
@@ -136,32 +162,30 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			if (ret) {
 				erofs_err("failed to set dict size %u for %s",
 					  zset->dict_size, zset->alg);
-				return ret;
+				goto fail;
 			}
-		} else if (zset->dict_size) {
-			erofs_err("dict size is not supported for %s",
-				  zset->alg);
-			return -EINVAL;
 		}
 
-		ret = erofs_algs[i].c->init(c);
-		if (ret)
-			return ret;
+		if (zset->extraopts && erofs_algs[i].c->setextraopts) {
+			ret = erofs_algs[i].c->setextraopts(c, zset->extraopts);
+			if (ret)
+				goto fail;
+		}
 
-		if (!ret) {
-			c->alg = &erofs_algs[i];
-			return 0;
+		if (erofs_algs[i].c->init) {
+			ret = erofs_algs[i].c->init(c);
+			if (ret)
+				goto fail;
 		}
+		c->alg = &erofs_algs[i];
+		return 0;
 	}
 	erofs_err("Cannot find a valid compressor %s", zset->alg);
 	return ret;
-}
-
-int erofs_compressor_exit(struct erofs_compress *c)
-{
-	if (c->alg && c->alg->c->exit)
-		return c->alg->c->exit(c);
-	return 0;
+fail:
+	if (erofs_algs[i].c->preinit && erofs_algs[i].c->exit)
+		erofs_algs[i].c->exit(c);
+	return ret;
 }
 
 void erofs_compressor_reset(struct erofs_compress *c)
diff --git a/lib/compressor.h b/lib/compressor.h
index c679466759d3..86b45a759874 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -17,12 +17,14 @@ struct erofs_compressor {
 	u32 default_dictsize;
 	u32 max_dictsize;
 
-	int (*init)(struct erofs_compress *c);
+	int (*preinit)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
 	void (*reset)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
 	int (*setdictsize)(struct erofs_compress *c, u32 dict_size,
 			   u32 pclustersize_max);
+	int (*setextraopts)(struct erofs_compress *c, const char *extraopts);
+	int (*init)(struct erofs_compress *c);
 
 	int (*compress_destsize)(const struct erofs_compress *c,
 				 const void *src, unsigned int *srcsize,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index e6026b26bc58..49a90a23525a 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -50,19 +50,43 @@ static int erofs_compressor_liblzma_exit(struct erofs_compress *c)
 
 	lzma_end(&ctx->strm);
 	free(ctx);
+	c->private_data = NULL;
+	return 0;
+}
+
+static int erofs_compressor_liblzma_preinit(struct erofs_compress *c)
+{
+	struct erofs_liblzma_context *ctx;
+
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
+	DBG_BUGON(c->private_data);
+	c->private_data = ctx;
 	return 0;
 }
 
 static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 					     int compression_level)
 {
-	if (compression_level < 0)
-		compression_level = erofs_compressor_lzma.default_level;
+	struct erofs_liblzma_context *ctx = c->private_data;
+	u32 preset;
 
 	if (compression_level > erofs_compressor_lzma.best_level) {
 		erofs_err("invalid compression level %d", compression_level);
 		return -EINVAL;
 	}
+
+	if (compression_level < 0)
+		preset = LZMA_PRESET_DEFAULT;
+	else if (compression_level >= 100)
+		preset = (compression_level - 100) | LZMA_PRESET_EXTREME;
+	else
+		preset = compression_level;
+
+	if (lzma_lzma_preset(&ctx->opt, preset))
+		return -EINVAL;
 	c->compression_level = compression_level;
 	return 0;
 }
@@ -70,6 +94,8 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 						u32 dict_size, u32 pclustersize_max)
 {
+	struct erofs_liblzma_context *ctx = c->private_data;
+
 	if (!dict_size) {
 		if (erofs_compressor_lzma.default_dictsize) {
 			dict_size = erofs_compressor_lzma.default_dictsize;
@@ -85,32 +111,52 @@ static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 		erofs_err("invalid dictionary size %u", dict_size);
 		return -EINVAL;
 	}
-	c->dict_size = dict_size;
+	ctx->opt.dict_size = c->dict_size = dict_size;
 	return 0;
 }
 
-static int erofs_compressor_liblzma_init(struct erofs_compress *c)
+static int erofs_compressor_liblzma_setextraopts(struct erofs_compress *c,
+						 const char *extraopts)
 {
-	struct erofs_liblzma_context *ctx;
-	u32 preset;
-
-	ctx = malloc(sizeof(*ctx));
-	if (!ctx)
-		return -ENOMEM;
-	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
-
-	if (c->compression_level < 0)
-		preset = LZMA_PRESET_DEFAULT;
-	else if (c->compression_level >= 100)
-		preset = (c->compression_level - 100) | LZMA_PRESET_EXTREME;
-	else
-		preset = c->compression_level;
+	struct erofs_liblzma_context *ctx = c->private_data;
+	const char *token, *next;
+
+	for (token = extraopts; *token != '\0'; token = next) {
+		const char *p = strchr(token, ',');
+		const char *rhs;
+		char *endptr;
+		unsigned long val;
+		uint32_t *key;
+
+		next = NULL;
+		if (p) {
+			next = p + 1;
+		} else {
+			p = token + strlen(token);
+			next = p;
+		}
 
-	if (lzma_lzma_preset(&ctx->opt, preset))
-		return -EINVAL;
-	ctx->opt.dict_size = c->dict_size;
+		if (!strncmp(token, "lc=", sizeof("lc=") - 1)) {
+			key = &ctx->opt.lc;
+			rhs = token + sizeof("lc=") - 1;
+		} else if (!strncmp(token, "lp=", sizeof("lp=") - 1)) {
+			key = &ctx->opt.lp;
+			rhs = token + sizeof("lp=") - 1;
+		} else if (!strncmp(token, "pb=", sizeof("pb=") - 1)) {
+			key = &ctx->opt.pb;
+			rhs = token + sizeof("pb=") - 1;
+		} else {
+			erofs_err("unknown extra options %s", extraopts);
+			return -EINVAL;
+		}
 
-	c->private_data = ctx;
+		val = strtoul(rhs, &endptr, 0);
+		if (val == ULONG_MAX || endptr != p) {
+			erofs_err("invalid option %.*s", p - token, token);
+			return -EINVAL;
+		}
+		*key = val;
+	}
 	return 0;
 }
 
@@ -118,10 +164,11 @@ const struct erofs_compressor erofs_compressor_lzma = {
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
 	.max_dictsize = Z_EROFS_LZMA_MAX_DICT_SIZE,
-	.init = erofs_compressor_liblzma_init,
+	.preinit = erofs_compressor_liblzma_preinit,
 	.exit = erofs_compressor_liblzma_exit,
 	.setlevel = erofs_compressor_liblzma_setlevel,
 	.setdictsize = erofs_compressor_liblzma_setdictsize,
+	.setextraopts = erofs_compressor_liblzma_setextraopts,
 	.compress_destsize = erofs_liblzma_compress_destsize,
 };
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 326c332d37af..ee23944f3ebd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -166,6 +166,12 @@ static void usage(int argc, char **argv)
 				printf("%s  [,dictsize=<dictsize>]\t(default=<auto>, max=%u)\n",
 				       spaces, s->c->max_dictsize);
 		}
+		if (!strcmp(s->name, "lzma")) {
+			printf("\n%s  LZMA advanced options (do not specify if unsure):\n", spaces);
+			printf("%s  [,lc=<n>]  n = number of literal context bits\n", spaces);
+			printf("%s  [,lp=<n>]  n = number of literal position bits\n", spaces);
+			printf("%s  [,pb=<n>]  n = number of position bits\n", spaces);
+		}
 	}
 	printf(
 		" -C#                    specify the size of compress physical cluster in bytes\n"
@@ -845,7 +851,9 @@ unsigned int erofs_mkfs_total_ccfgs;
 static int mkfs_parse_one_compress_alg(char *alg)
 {
 	struct z_erofs_paramset *zset = mkfscfg.zcfgs + mkfscfg.total_zcfgs;
+	char extraopts[48];
 	char *p, *q, *opt, *endptr;
+	int i, j;
 
 	if (zset >= erofs_mkfs_zparams + ARRAY_SIZE(erofs_mkfs_zparams)) {
 		erofs_err("too many algorithm types");
@@ -854,6 +862,7 @@ static int mkfs_parse_one_compress_alg(char *alg)
 	zset->clevel = -1;
 	zset->dict_size = 0;
 
+	i = 0;
 	p = strchr(alg, ',');
 	if (!p) {
 		zset->alg = alg;
@@ -891,13 +900,20 @@ static int mkfs_parse_one_compress_alg(char *alg)
 						return -EINVAL;
 					}
 				} else {
-					erofs_err("invalid compression option %s", opt);
-					return -EINVAL;
+					if (i)
+						j = snprintf(extraopts + i, sizeof(extraopts) - i, ",%s", opt);
+					else
+						j = snprintf(extraopts, sizeof(extraopts), "%s", opt);
+					if (j < 0)
+						return -ERANGE;
+					i += j;
 				}
 				opt = q ? q + 1 : NULL;
 			}
 		}
 	}
+	if (i)
+		zset->extraopts = strdup(extraopts);
 	return mkfscfg.total_zcfgs++;
 }
 
-- 
2.43.5


