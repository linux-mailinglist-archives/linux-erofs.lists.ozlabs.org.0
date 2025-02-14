Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5353A3633E
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:36:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvd3h2G9Qz3c5B
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 03:36:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739550991;
	cv=none; b=UqU5+kkwvP9513pD9EGaT4lyqZiTBP9rxN8EAX3bjDA1F822256ZDfQWq29zB/ZbAbiKu8wtL0gVDQWpZETEjqQVlH4+GcTSwH9hSaKlcQZ/prUcKaa0NHWqR/EGDCIdYVLHTxy+1SOnGZlwI/k4BaxzfYklZNeqx1//qHrhPdyIvEO7Ra+YI2Rc0hShF459d/DQqxZRZq/W1JQ70Bp2e17MwJOqC5qYlsSslNnuZDFC65SITCa6klHLtnKidKHSmfySnW+zlYbhLRXtQh+UGXKSkDNg7NgwXLPLEwdlSaCAuaGD9VGJx+5BugrZ6dP1cVEvWSDhPnzk2oFCw70jnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739550991; c=relaxed/relaxed;
	bh=yyTDASHc+pPtE6Ts02DQJLMTodxCtqqDk+RpTYx6V4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auyjUpT4Prgk+ua1GKtzyT/rj8WHneK8uLp2ayIREbUeMXa7U6BAuc0k8Bk+GUzd0M4iWHcxI3xXFRoC08K265wkLQ1gKs/3cqmQoNl6/QPMiq6WDiTPj7CYYdXCF+EGzOf475GxpS/JcHVPu3aUdEVJa9Kjwdi1k6hQEQPFeGS7WCo+xHWsuIY/Og3qAVY+9Cvb/6a4BwFWfXtQIqn4GVmAppXwX6ePPssMXNG+3V4lnpnZLXKlUoN8iooW+l8In3+z07YioqFEd1DbVPwcDjh3TtK3tlJkt3aBYDlpXvnT6cHEOvjk7SRkQZCZLzzWcbcZ5wfegnEr/78fbrS6xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yXen3lXX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yXen3lXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yvd3f2Fz0z3bgV
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2025 03:36:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739550986; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yyTDASHc+pPtE6Ts02DQJLMTodxCtqqDk+RpTYx6V4A=;
	b=yXen3lXXW6LZEhL4xhl47Yns7pXqwrblfOZbGxuHnQRpobbrBMTwssLa9H059o14BbYg/XOsd+w88pOl96n8c5Ao7fC4aR/cZck1FIeEx33m61iehFSGvSj38KsVCg82FHouausB2TZB62rk9JUaKCRIQa5bslFDC58xc5ElYKU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPRMubW_1739550983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 00:36:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: avoid overly large temporary buffers for compressed data
Date: Sat, 15 Feb 2025 00:36:21 +0800
Message-ID: <20250214163621.4109215-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250214163621.4109215-1-hsiangkao@linux.alibaba.com>
References: <20250214163621.4109215-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

... and use `EROFS_MAX_BLOCK_SIZE * 2` to avoid potential issues
with buggy compressors.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index e9a4459..da3fded 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -26,6 +26,8 @@
 #include "erofs/workqueue.h"
 #endif
 
+#define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
+
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
 	struct erofs_compress handle;
@@ -554,7 +556,7 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx)
 static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 				  struct z_erofs_inmem_extent *e)
 {
-	static char g_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	static char g_dstbuf[Z_EROFS_DESTBUF_SZ];
 	char *dstbuf = ctx->destbuf ?: g_dstbuf;
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
@@ -1218,8 +1220,7 @@ void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 	if (!tls->queue)
 		goto err_free_priv;
 
-	tls->destbuf = calloc(1, EROFS_CONFIG_COMPR_MAX_SZ +
-			      EROFS_MAX_BLOCK_SIZE);
+	tls->destbuf = calloc(1, Z_EROFS_DESTBUF_SZ);
 	if (!tls->destbuf)
 		goto err_free_queue;
 
@@ -1291,6 +1292,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 		goto out;
 
 	sctx->pclustersize = z_erofs_get_max_pclustersize(inode);
+	DBG_BUGON(sctx->pclustersize > Z_EROFS_PCLUSTER_MAX_SIZE);
 	sctx->queue = tls->queue;
 	sctx->destbuf = tls->destbuf;
 	sctx->chandle = &tls->ccfg[cwork->alg_id].handle;
-- 
2.43.5

