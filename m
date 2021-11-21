Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A145820A
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 06:40:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HxfPD6Xxlz301j
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 16:40:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637473200;
	bh=TiI4Vzs6SP6iZu608kC5DLat+4OaUgmWNe1QqQuAl48=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EkcvDqZWk6P0YWRSTFZR7Hbt3OieUKrdLGIgBkqZxzr1MCR/dgWjk5AiAfjrx6jgu
	 oDxQ8eKHhK3ZnrPd0dAZwRRU4ysc3kFiBOreEjAQ+AN/yEe6epLDmynmBCoc6C1vQ5
	 +EmQsL/8lHzjy81gUHvGB6f7qrwhbUY1ML+vh8iVHk80A6yS5o8/OsDoh+KU6JQq9Z
	 uyWSRZLcnTDiUng6UjtRyPh9DdINJD3LNIZkNn5SEFTvG9OglpUOFn6710GSfgGsYq
	 V5yZNTpC1Rc2hFeJiJJxHQkh/9WfOGO6GvNi/PYWRHCi1XnGW3jcbiCKnVo5lukqLf
	 UltiKbP9OA6Ag==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3q9uzyqskc9wxf8leicjtglemmejc.amkjglsv-cpmdqjgqrq.mxj89q.mpe@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=V7b1td5Q; dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HxfPB3yRQz2xv8
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 16:39:58 +1100 (AEDT)
Received: by mail-qk1-x74a.google.com with SMTP id
 az44-20020a05620a172c00b0046a828b4684so10460397qkb.22
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 21:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=TiI4Vzs6SP6iZu608kC5DLat+4OaUgmWNe1QqQuAl48=;
 b=h10KGqXacmVTMpQcKH8OzxtY8UQxeezAnQRCpxKaltyZwhDTm17cTwymFhVESnI19X
 /HkFfFEMsqB3PAZypVUtpTHg6Z3TMsQMT2w3ek/AySxm/f5TdiLlhF6w28+LwGL8Ca8g
 3nFzWChoq4NFGdWE3f7fdZKibP5PX8W1wehimUtaMsOlbcAspR2aY1Y+nZs4R25YATko
 dBN316fOFn24mTdLh4n/9f2Kdd8niGryO3TXPrRWpC1q8llT/K5gm66/tJB5zFg/FrJ3
 MUJPG/0aA1MT4lq65UtMndQ+2FRjx83AshxgYFYL1dKyqnNF/sSFa9mTZ0/GiEpCrlE4
 Syew==
X-Gm-Message-State: AOAM5330zMLTcczADcrdQ4hxZp8PZUMhAnYtfsVwp0dIRIr3W0z4bgRU
 YHpuqUeWUcxKEgmZ36h3+uhNebSuGWbitUDVd3f+qJO0RLpFoRFfhQGUL9QlxqGBcSTu1nIyDRp
 JBIV0g6iQzG2DRUoJkamMZewEbB72RtbNF4y4eG4Hiz1IJhbfPitjsTnllL5LsbODKsvZrfhodb
 XxduTmyFk=
X-Google-Smtp-Source: ABdhPJxpz2brJSaNQI3ccjLB99o7sU+d2Zz14iE9H+qmTLTVV/bxvOeujy0XV20brUn1p4h0eu5toSwn4ARA5xY9XA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:59ce:: with SMTP id
 f14mr20370396qtf.30.1637473195864; Sat, 20 Nov 2021 21:39:55 -0800 (PST)
Date: Sat, 20 Nov 2021 21:39:19 -0800
In-Reply-To: <20211121053920.2580751-1-zhangkelvin@google.com>
Message-Id: <20211121053920.2580751-3-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211121053920.2580751-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 2/4] Mark certain callback function pointers as const
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Li Guifu <bluce.liguifu@huawei.com>, 
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>, Chao Yu <yuchao0@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Global variables aren't bad, until you start mutating them in multiple
places.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/cache.h    | 8 ++++----
 lib/cache.c              | 6 +++---
 lib/compressor.c         | 2 +-
 lib/compressor.h         | 8 ++++----
 lib/compressor_liblzma.c | 2 +-
 lib/compressor_lz4.c     | 2 +-
 lib/compressor_lz4hc.c   | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 051c696..fd13614 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -31,7 +31,7 @@ struct erofs_buffer_head {
 	struct erofs_buffer_block *block;
 
 	erofs_off_t off;
-	struct erofs_bhops *op;
+	const struct erofs_bhops *op;
 
 	void *fsprivate;
 };
@@ -64,9 +64,9 @@ static inline const int get_alignsize(int type, int *type_ret)
 	return -EINVAL;
 }
 
-extern struct erofs_bhops erofs_drop_directly_bhops;
-extern struct erofs_bhops erofs_skip_write_bhops;
-extern struct erofs_bhops erofs_buf_write_bhops;
+extern const struct erofs_bhops erofs_drop_directly_bhops;
+extern const struct erofs_bhops erofs_skip_write_bhops;
+extern const struct erofs_bhops erofs_buf_write_bhops;
 
 static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 {
diff --git a/lib/cache.c b/lib/cache.c
index bae172c..afb29d0 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -28,7 +28,7 @@ static bool erofs_bh_flush_drop_directly(
 	return erofs_bh_flush_generic_end(bh);
 }
 
-struct erofs_bhops erofs_drop_directly_bhops = {
+const struct erofs_bhops erofs_drop_directly_bhops = {
 	.flush = erofs_bh_flush_drop_directly,
 };
 
@@ -39,7 +39,7 @@ static bool erofs_bh_flush_skip_write(
 	return false;
 }
 
-struct erofs_bhops erofs_skip_write_bhops = {
+const struct erofs_bhops erofs_skip_write_bhops = {
 	.flush = erofs_bh_flush_skip_write,
 };
 
@@ -65,7 +65,7 @@ static bool erofs_bh_flush_buf_write(
 }
 
 
-struct erofs_bhops erofs_buf_write_bhops = {
+const struct erofs_bhops erofs_buf_write_bhops = {
 	.flush = erofs_bh_flush_buf_write,
 };
 
diff --git a/lib/compressor.c b/lib/compressor.c
index ad12cdf..6362825 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -10,7 +10,7 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
-static struct erofs_compressor *compressors[] = {
+static const struct erofs_compressor *compressors[] = {
 #if LZ4_ENABLED
 #if LZ4HC_ENABLED
 		&erofs_compressor_lz4hc,
diff --git a/lib/compressor.h b/lib/compressor.h
index aa85ae0..1ea2724 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -27,7 +27,7 @@ struct erofs_compressor {
 };
 
 struct erofs_compress {
-	struct erofs_compressor *alg;
+	const struct erofs_compressor *alg;
 
 	unsigned int compress_threshold;
 	unsigned int compression_level;
@@ -41,9 +41,9 @@ struct erofs_compress {
 };
 
 /* list of compression algorithms */
-extern struct erofs_compressor erofs_compressor_lz4;
-extern struct erofs_compressor erofs_compressor_lz4hc;
-extern struct erofs_compressor erofs_compressor_lzma;
+extern const struct erofs_compressor erofs_compressor_lz4;
+extern const struct erofs_compressor erofs_compressor_lz4hc;
+extern const struct erofs_compressor erofs_compressor_lzma;
 
 int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 576cdae..3229841 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -96,7 +96,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	return 0;
 }
 
-struct erofs_compressor erofs_compressor_lzma = {
+const struct erofs_compressor erofs_compressor_lzma = {
 	.name = "lzma",
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = LZMA_PRESET_EXTREME,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index f6832be..fc8c23c 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -37,7 +37,7 @@ static int compressor_lz4_init(struct erofs_compress *c)
 	return 0;
 }
 
-struct erofs_compressor erofs_compressor_lz4 = {
+const struct erofs_compressor erofs_compressor_lz4 = {
 	.name = "lz4",
 	.default_level = 0,
 	.best_level = 0,
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index fd801ab..3f68b00 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -59,7 +59,7 @@ static int compressor_lz4hc_setlevel(struct erofs_compress *c,
 	return 0;
 }
 
-struct erofs_compressor erofs_compressor_lz4hc = {
+const struct erofs_compressor erofs_compressor_lz4hc = {
 	.name = "lz4hc",
 	.default_level = LZ4HC_CLEVEL_DEFAULT,
 	.best_level = LZ4HC_CLEVEL_MAX,
-- 
2.34.0.rc2.393.gf8c9666880-goog

