Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E790FA35706
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 07:24:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvMTM1PHWz30Wg
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:24:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739514261;
	cv=none; b=hESQX3cpNjRXibCO6pFc9/7XHzMzwAWVNCWkTy6eYVG72GpHO6pepCatWpHJC0RJJaf63Uv4tH0r2u8xBj8HUpmCXKNlA/1sshnuatzdcZpKJYgY+zTePCpWATp0xGH7boPxJsuTaXtqKcGAK8Xrgluf13G81y48eHYRQaG2DN7dUzPOcPluhr6vOiXVPKKIiK9+86ogOl6AAsXkyv2flqcPGBtp+EZUOFWTPvvSQJzwKqTurit8MkTzOte4FQrVE19pqPtHrCSWCsAxzjgv84nElaltDwQ7ZUxG7srR931cXeKFcL12mCwyRCK39dJ3bRpK8819+PiPo9HAVQaF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739514261; c=relaxed/relaxed;
	bh=ifDX9sbSNronco/BGV79aGvR3ZbQigHmysUj4PQWcck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faiek5mCuesTX8lvrUAnqoxYBnjminb4qUXffZ2lQR/jmoAuSJtZKAne1YgVTsQi97UUUZB11aqJjAa7OpcwRF8ViqyxJ/d/VuhSwSbT66upfvcscrzFQhVcRWCGG6FKV+ShG8U76I/iq3TNAV1XTcre1HaxGv/9HNP1bcKqgIEY2G3WCt9BjEQ7+Z6nSv8p4EMWI3Xpe0FP2xI3vIxz2aQpWonrz0pbUekzGYhEtFI8NAn4DN09aI+e1RT5768ARKrUg/WYob6N5p4Q4cvOHtLs7MHOFzq4EziGjQaWfgoCKTUsl7fznNnh5BByr1Zpg7djEvfNntGkgnyILedVUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sx0z27L+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sx0z27L+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvMTH3tlWz2yVV
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 17:24:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739514253; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ifDX9sbSNronco/BGV79aGvR3ZbQigHmysUj4PQWcck=;
	b=Sx0z27L+eEsoUjoIPYwIC/IHPyL3kFvFJ4oXCIByv/4CjLBRnTdw/PTHdUpbqZZNKJ6I/QV0hJkOfH32pn0livoGE/KfPCykMSwOeZQfogELNv5znmLnEFpQ/KFMBPCQqqV+5fPN7hrf2PNVFk0lfAsLNkVCYUwxgYAvNrtUi7M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPPo5hW_1739514248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 14:24:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: mkfs: add missing `errno = 0` before strto[u]l
Date: Fri, 14 Feb 2025 14:24:05 +0800
Message-ID: <20250214062407.3281416-1-hsiangkao@linux.alibaba.com>
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

Otherwise, `--workers=` could exit with `invalid worker number`.

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

