Return-Path: <linux-erofs+bounces-825-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780CB2AB66
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 16:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Fv13fdMz3cZp;
	Tue, 19 Aug 2025 00:47:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755528477;
	cv=none; b=FeevjCSBXhbivuSUFwcGPuamyjDb5mmUSGbcibo0c5jlg2ASLZtIssJhdCrfIWqcz9F2OhaOucZab0MYQIl9uEvR3+dj3cg10gOdJ5XmFLIzJkG60LD5icr2JRk5YIRjUHB3XHKlXEe4xnzyreVBTPM5jT/Co/FlY9RkDMsW14AjSTjVERV9+4M4kA5JdA+iOmrCR/JKrsuLa5k4rYvZPDI7JoVfWL06sumwc7pKsckCz7kaGwP/vNwDMb5eBv3ycM9dfr8AxYRx9sVioO+hqy4lNqsIp8YYYUGOgz8gTZdq/hUO4L1jQYiNAB0oiwFRauLn02i/+rihoIIV+aFyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755528477; c=relaxed/relaxed;
	bh=zj1Gpm0PEUnLUt2PMtMiv6VeN3nzinPDRmDoIIGHPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYVp5oLP6kMHex7nnM//c1BLPPzS6e5Op4AIoFn8iY2R2t1qAvMpvh5qtjJtoAXimwK7COojM+iHc1zBoJq9MyM4ZnHEsEhJUDbtsPye17rzxuqSqGt3n+rBHnPSyQr9P1yq9sYMjHms30QTXB2MKlZoUc1N+ubk1SY8lvCgXrmGtRjjh2YM75CrHXa3wq6l8ncwJnY5X4XfZmpsfaFQ1A6YH1CgBEuCGzUMX4eck7pM0xh95a733uwcdue650ZBYgqdYF09AJXHpD5VaBfNGVXR56uvVFr1w+RqcWJYXXfHfBzlbH5DW4qDgbfYE/R2pSADGELo5/Mm9CFiV/v2xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lxc4Qyay; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lxc4Qyay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Ftz629tz3cZx
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 00:47:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755528471; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zj1Gpm0PEUnLUt2PMtMiv6VeN3nzinPDRmDoIIGHPE0=;
	b=lxc4QyayfSbGq9RjU/f9KbsE0pl//tBt63h5UuEWZMmbUAvMGGnzaRKUR0Kb4VO9VY0jAF60G+PifbKaxTOkfG/8WtQ3SD5iK9eqq+zKUIOzoTMRWlXSFadM/2W6CsEQpo8HjYEaI9wgMzb61RB5aaZT6AQZO8LB3jb5hvMiVT4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm0YYe4_1755528470 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 22:47:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/7] erofs-utils: lib: migrate `c_mt_async_queue_limit`
Date: Mon, 18 Aug 2025 22:47:39 +0800
Message-ID: <20250818144741.2586329-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
References: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
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
index 2040b62..bf2aa47 100644
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


