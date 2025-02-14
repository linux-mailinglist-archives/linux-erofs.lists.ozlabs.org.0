Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CE6A35531
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 04:07:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvH5V4qFGz30WJ
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 14:06:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739502413;
	cv=none; b=EFA00ZYSeI0GAwhP6rTK5b9FDYSFlYVcV9/mu0IRJRjnOMu66wuySMPmjCoKCFzKe2y35XzCk9AA7rSJBXCrJJkhOrkbO0ac6tMAObRzFfRx4gd53yffQoPbBvTzIWCRm17xWXPDhbSp34BHiJswMBBWGt8QQwEyoM8MLvNLM3oEEqQPjdqwXXqDLaVq9atpjUFcXgoc6N6futfnj9bjJ8m3359f0H37zBEJEI6rTXcAN+wPONQvhJZjUB8WiopevF5p2ZaLx1mbVdoPgHw5nDemyUxr3uRAh0GMAsDHrUW8H0s+vzBRw2XSioZzTdWFT0J6K9JBwq4wQfITstSGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739502413; c=relaxed/relaxed;
	bh=gCSZgzCAVbA4MLRQ7B8kMEEuSlpSqL1XT+VktFKgDJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzYvY7JKoOqqD5smMSq/IPgMOjLUdB8/qsW3ID3Ih/S/gQL4IZ7gemf+K66rhA3Y3nJydRD64KrnaSnOTxVgKh2MM0Hcqeh0d/YLsuKIwMq4rNDXUtGYVTuRiU9GSrn/x4tt1vpRTzAWmOvU0+RxKcH9YG9sd9/yfTo1wgqUhB0u9L1z/KHtoli+EDEiO3vUU3iMeKkLL5zMGGNT6DUyzdDS7YeNlRxejaPKvSarcaUAKG+yhBOruXYLIFfbUACt7xVSDwQRFxrbF/dB99DpXfovshKQ6HJiFhT4AG/jQMPx5jwqMPw37L36ZQI0JICuoGg/o3kV1oCANBGV2+QPNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tE9JzWEq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tE9JzWEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvH5R3xSnz2ywC
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 14:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739502396; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gCSZgzCAVbA4MLRQ7B8kMEEuSlpSqL1XT+VktFKgDJ0=;
	b=tE9JzWEqj+TPiuUFvUFb0zow+KbJJrMzxRPEZvqJu7gYS67ArtcOO7+2aeCADBJTJYR1kG9ZYqKKB1crfI2FYEUqZxjXA0dMgYtEl+cFfRQnmdq27jNCb0y5wN7XJOapHnWmHTEwq1YeIGFEide+E5aM5RpMZBt18osH+cEgnSU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPPJPsW_1739502390 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 11:06:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add missing `errno = 0` before strto[u]l
Date: Fri, 14 Feb 2025 11:06:29 +0800
Message-ID: <20250214030629.3030009-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

strtoull(3) says:

```
Since strtoul() can legitimately return 0 or ULONG_MAX (ULLONG_MAX for
strtoull()) on both success and failure, the calling program should set
errno to 0 before the call, and then determine if an error occurred by
checking whether errno has a nonzero value after the call.
```

Othewise, `--workers=` could exit with `invalid worker number`.

Fixes: 7894301e1a80 ("erofs-utils: mkfs: add `--workers=#` parameter")
Fixes: 0132cb5ea7d0 ("erofs-utils: mkfs: add `--zfeature-bits` option")
Fixes: 7550a30c332c ("erofs-utils: enable incremental builds")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index a0fce35..9d6a0f2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -817,6 +817,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 520: {
 			unsigned int processors;
 
+			errno = 0;
 			cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid worker number %s", optarg);
@@ -831,6 +832,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 #endif
 		case 521:
+			errno = 0;
 			i = strtol(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid zfeature bits %s", optarg);
@@ -847,6 +849,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			} else if (!strcmp(optarg, "rvsp")) {
 				dataimport_mode = EROFS_MKFS_DATA_IMPORT_RVSP;
 			} else {
+				errno = 0;
 				dataimport_mode = strtol(optarg, &endptr, 0);
 				if (errno || *endptr != '\0') {
 					erofs_err("invalid --%s=%s",
-- 
2.43.5

