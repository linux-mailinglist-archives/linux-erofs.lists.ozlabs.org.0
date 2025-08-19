Return-Path: <linux-erofs+bounces-833-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A126B2B781
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 05:28:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Zmd6LC5z3clf;
	Tue, 19 Aug 2025 13:28:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755574113;
	cv=none; b=bZJP4jSNvOkwP+8D37oj2TYPFuY0CySbA0FmN6VRN8imF6ZI5z3kICwZDscH7d270okFtd+0qqdbpvJasX5dlakBPAFXIkqEohv6xAiWhnhuWVVoLEnwQbV1i7VctULYDI7JAK9kwsZbEW7kadceaI7T9NmG21/N/XgGA8UjCHtS/WIqnGTvMwHyNkHjvCB1jA/LyeD36SD+MWUhKU2gLrdip3q6j/39lfXkjmo1Ukt7kN1TW4ExQ7Et4eABSBK2jrTqF3sLnIhJQK/Lt+Us5LMszhAKOfQqwLhrBmTiTbZRbFpiIfnqLhtreW/3hGa+Mr88/UeLXaCx+KSdMXSwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755574113; c=relaxed/relaxed;
	bh=IOsWX1kk99vF4lb3qqYGFYVs8qtz/bQH+ZQYOPp0veo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYgQOUrKyCPsOHUgo6OPakyaAIuSwTGJ26kVcF3ctBBvBTyjef4knY/Yl0ppjzAUXnRVY3wOFgDlz7U1sf+G1TvhMAIS8H/1nPOOa42lxrmMs2BEsWhg2skAvT8Vs9pAAgEvRN5GOK1HwkMtbb4ieLMvcMsIm1QiF4gmvvJTjPZGwchxVv+p3mzr0vYH/txG0x3peOu+3y4SIlYvxu1BD+JgkZ5roV/fUumJzG4qAPq6ZK2dgdwYM3r0l5sFtQslddPICGuZUI3/E6zGRso/2NPbI0A6tLNk04u67U9bW6UCO4V3tgGJZeYuXpNIk4hfvZ0DwvspJAdenxxWPgRsbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VgfRuXIu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VgfRuXIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Zmb686Zz3clY
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 13:28:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755574107; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IOsWX1kk99vF4lb3qqYGFYVs8qtz/bQH+ZQYOPp0veo=;
	b=VgfRuXIu/nfrT1AMhtlWl6tWyWS71pu3HBy6fNEmAbsT1pGW+W3oMj6Fi2QjXvtZYN6snAO05mIXw/teYHMcGOD4MJOipUM3Hk5UAzoyah/rOD8sI7aEFO8EKuyA/P/1+JnLZ8vx2acfjrsPiAPx5TNsClo4njURJboMUHuE3zo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm5DR77_1755574106 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:28:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 5/7] erofs-utils: lib: migrate `c_mt_async_queue_limit`
Date: Tue, 19 Aug 2025 11:28:16 +0800
Message-ID: <20250819032818.3598157-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
References: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
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

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   | 1 -
 include/erofs/importer.h | 1 +
 lib/inode.c              | 9 +++++++--
 mkfs/main.c              | 7 ++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 418e9b6..40a2011 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -94,7 +94,6 @@ struct erofs_configure {
 #ifdef EROFS_MT_ENABLED
 	u64 c_mkfs_segment_size;
 	u32 c_mt_workers;
-	u32 c_mt_async_queue_limit;
 #endif
 #ifdef WITH_ANDROID
 	char *target_out_path;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 9aa032b..0382913 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -14,6 +14,7 @@ extern "C"
 
 struct erofs_importer_params {
 	char *source;
+	u32 mt_async_queue_limit;
 	bool no_datainline;
 };
 
diff --git a/lib/inode.c b/lib/inode.c
index ae1c39c..9a5b67c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2023,6 +2023,7 @@ static int erofs_get_fdlimit(void)
 static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
 	struct erofs_importer *im = ctx->im;
+	struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_mkfs_dfops *q;
 	int err, err2;
@@ -2032,8 +2033,12 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	if (!q)
 		return -ENOMEM;
 
-	if (cfg.c_mt_async_queue_limit) {
-		q->entries = cfg.c_mt_async_queue_limit;
+	if (params->mt_async_queue_limit) {
+		q->entries = params->mt_async_queue_limit;
+		if (q->entries & (q->entries - 1)) {
+			free(q);
+			return -EINVAL;
+		}
 	} else {
 		err = roundup_pow_of_two(erofs_get_fdlimit()) >> 1;
 		q->entries = err && err < 32768 ? err : 32768;
diff --git a/mkfs/main.c b/mkfs/main.c
index 49284f9..a4ff204 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -860,7 +860,8 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 	return 0;
 }
 
-static int mkfs_parse_options_cfg(int argc, char *argv[])
+static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
+				  int argc, char *argv[])
 {
 	char *endptr;
 	int opt, i, err;
@@ -1195,7 +1196,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 #ifdef EROFS_MT_ENABLED
 		case 530:
-			cfg.c_mt_async_queue_limit = strtoul(optarg, &endptr, 0);
+			params->mt_async_queue_limit = strtoul(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid async-queue-limit %s", optarg);
 				return -EINVAL;
@@ -1497,7 +1498,7 @@ int main(int argc, char **argv)
 	erofs_mkfs_default_options();
 	erofs_importer_preset(&importer_params);
 
-	err = mkfs_parse_options_cfg(argc, argv);
+	err = mkfs_parse_options_cfg(&importer_params, argc, argv);
 	erofs_show_progs(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
-- 
2.43.5


