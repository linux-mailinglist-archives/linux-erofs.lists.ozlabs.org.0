Return-Path: <linux-erofs+bounces-1136-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F93BABAC4
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 08:39:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbT122JJ8z3cZx;
	Tue, 30 Sep 2025 16:39:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759214342;
	cv=none; b=D7m+0JBLpmOxe7z4Sw7rdssisr3Htvj/QAjRZ64EtwPxfpLwrknWRLG3icc5FX44708iDPc5Y7e/73GAIERuFvz8kJ2SweDDoVSxRbGuV21iFN/0mVqH3jLZ98tcsqesiKg1oI+/Od5sJyv8S/DdmVP58lX5JZ5jA4aF5ACOvxK5GVCAce3KF5DkRFGYMoSOpZh0YfAFuVM9T89CwbpvGSL+FiJqNg7bK06Yrt9pDnAoN1VS+O6S6Qw8GilH2QLI1qPBEcx5jGa4ul+Xu++rk8D73CcpDVmV7BJNarfM0Ol0pTcCSqzFNDI+uiWQr9PfzCWG/N/CUy+IPl14jOAqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759214342; c=relaxed/relaxed;
	bh=HjUYKMOXqPjeOuz19mPykrt8vxFzlSgtXFznV1pgqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2tPxVNFmUARhE/y7fFCDvamO/86BezwI7cy943uLT5cgbHjlUvb0KyHqg8sAwjcqUOQyEuSSzoIrD5hqh3BSbGkjv+4sOKRarKWHZ8OkKnNyYItnLXHMMaBPfFhJKyJc/ElaSJClwy19iizM8U0tuqf4++eFkXX016bW3W+44vnZ9jF6wmueF/8rZuVE29F8mNIJUqWkhBt3VJ3Q5cJS6M3Ylian1wbvDxpL1Rp+nW/36yiHIWTHv/x41whRdz17MKh4BUZLrM2Use1Y50qIwDB8355iyX6DC+GND4Cz+zYSD1dGiJqvn9EkiJiSJInttN9Tzd9A3+6ZmJkE4IkJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IigQ+Ym1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IigQ+Ym1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbT101f41z2yPd
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:38:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759214334; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HjUYKMOXqPjeOuz19mPykrt8vxFzlSgtXFznV1pgqjc=;
	b=IigQ+Ym1fu1arAeS1DShO6A2p+191tZ1Cgz4GQdUWea56Zb/HOGeVuXWX2mg3IyolAickEeEb5jvv48DsWm7JkA4S9JMT9e+P8OCncuLKu3u+5XmBwgoMBWagIuI+NePae8cB3u1xKh4bBcaBVqLesLRCtfgK1b4GXaCegHE++s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpARbj5_1759214328 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 14:38:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/5] erofs-utils: lib: migrate and split `c_legacy_compress`
Date: Tue, 30 Sep 2025 14:38:43 +0800
Message-ID: <20250930063847.2143732-1-hsiangkao@linux.alibaba.com>
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

Split it into `no_zcompact` and `no_lz4_0padding` meta-switches.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   | 1 -
 include/erofs/importer.h | 2 ++
 lib/compress.c           | 5 +++--
 mkfs/main.c              | 4 ++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 3b1438f..153315b 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -39,7 +39,6 @@ struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
 	bool c_dry_run;
-	bool c_legacy_compress;
 	char c_timeinherit;
 	char c_chunkbits;
 	bool c_showprogress;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 3153732..dbb87be 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -41,6 +41,8 @@ struct erofs_importer_params {
 	bool hard_dereference;
 	bool ovlfs_strip;
 	bool dot_omitted;
+	bool no_zcompact;
+	bool no_lz4_0padding;
 	bool ztailpacking;
 	bool dedupe;
 	bool fragments;
diff --git a/lib/compress.c b/lib/compress.c
index f879d3e..b7ca3ad 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1144,6 +1144,7 @@ static void *z_erofs_write_extents(struct z_erofs_compress_ictx *ctx)
 
 static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 {
+	const struct erofs_importer_params *params = ctx->im->params;
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei, *n;
@@ -1165,7 +1166,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	 */
 	if (inode->fragment_size && inode->fragmentoff >> 32) {
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-	} else if (!cfg.c_legacy_compress && !ctx->dedupe &&
+	} else if (!params->no_zcompact && !ctx->dedupe &&
 		   inode->z_lclusterbits <= 14) {
 		if (inode->z_lclusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
@@ -2120,7 +2121,7 @@ int z_erofs_compress_init(struct erofs_importer *im)
 	} else {
 		sbi->available_compr_algs = available_compr_algs;
 
-		if (!cfg.c_legacy_compress)
+		if (!params->no_lz4_0padding)
 			erofs_sb_set_lz4_0padding(sbi);
 		if (available_compr_algs & ~(1 << Z_EROFS_COMPRESSION_LZ4))
 			erofs_sb_set_compr_cfgs(sbi);
diff --git a/mkfs/main.c b/mkfs/main.c
index f3cf24e..25f28ee 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -312,7 +312,8 @@ static int erofs_mkfs_feat_set_legacy_compress(struct erofs_importer_params *par
 	if (vallen)
 		return -EINVAL;
 	/* disable compacted indexes and 0padding */
-	cfg.c_legacy_compress = en;
+	params->no_zcompact = true;
+	params->no_lz4_0padding = true;
 	return 0;
 }
 
@@ -1501,7 +1502,6 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 static void erofs_mkfs_default_options(struct erofs_importer_params *params)
 {
 	cfg.c_showprogress = true;
-	cfg.c_legacy_compress = false;
 	cfg.c_xattr_name_filter = true;
 #ifdef EROFS_MT_ENABLED
 	cfg.c_mt_workers = erofs_get_available_processors();
-- 
2.43.5


