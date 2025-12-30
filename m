Return-Path: <linux-erofs+bounces-1654-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96DCE8C56
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 07:18:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgNF20ZRXz2yDk;
	Tue, 30 Dec 2025 17:18:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767075494;
	cv=none; b=J5Hm9fmYC5KJn7DgnPpWeYoWDVMotafLy6X5geibtpmkf22tfMD/7yz6UDE1swu9384s/DTBIH3rSYu8HKJbkY6ALiDHAx4b6ceD6xpZTxOTvcGfBQARX4GswpZnKQhYIHnpHWcwgoIgQFCBb7jZRWfZxVQtTuQ8JvRSih95ycF5kCjLRblRlwKXOlnp41BM6pUzHt3EkL6qnfR5pb3DLqycPG+sCwpAXAYPMTQjkJO23InSptPJCWZu9xA+A4xy+dChGQK9bau8+af9fqJ1n8FjI6y37qRD6fjhibMTC/TYX/iNDCs2BiCd6P7Tj52Y8S7+6vY49m9cixG2C2yALg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767075494; c=relaxed/relaxed;
	bh=Al3d8oTSaNm6PWQZPRhDlvfCeubEwdnhV4qtCgZpPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGY9KtBWXF8h41Xtf70WB2z7eKi24QBX9UYgeyla07rs/grn8306LqUXreIgBfNFJ2SyhScDSNMtf2mzo7waeCSjALOP/NK3/Kgc0hfLmGLbKbmMcfN45veaQYJTw0QwT3wzfZa6m3vxjmgWX4W7Q35mewu+j1V9j0AHR+Gi2bl3SR1Cqxc/j7wM5P8fYdQW5RpTdONx32PMSE57MPeFrWNygj7ROcR3D1W9szZddgbbS7Vc1slb0J+bfqZK2Y0TFrKhnwhpon99msraAHhiFFsigiCG1LyVmPNVX/lMWniMyMSE1lvtebpAApT2J5ntD/4Z1cVTupWKcmzVYrbXqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z9qRMWG6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z9qRMWG6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgNF01yp9z2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 17:18:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767075485; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Al3d8oTSaNm6PWQZPRhDlvfCeubEwdnhV4qtCgZpPUE=;
	b=Z9qRMWG6v/jJa3S98DUwC5PZoTAZU74uUyxOMsEGPLXpZx3Yx6/gDmnvmbRPyqhPzBMpMHbSeRC5D9yvAC5gfNGRmIP9E7yy7Bvo6/XmEk/XOX+nVvxvP0MyqdNmf/g+TfAVGtcT4FDDkbIkp3kG55SrHGxQGEnGo0ymNqQYmfw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvz335r_1767075478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 14:18:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: set LZ4_0PADDING unconditionally
Date: Tue, 30 Dec 2025 14:17:56 +0800
Message-ID: <20251230061756.3971851-1-hsiangkao@linux.alibaba.com>
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

LZ4_0PADDING has been set unconditionally since very early Linux
EROFS versions (kernel < 5.4).

As those pre-5.10 kernels are end-of-life, just drop support for
disabling LZ4_0PADDING now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/importer.h | 1 -
 lib/compress.c           | 3 +--
 mkfs/main.c              | 6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index a9d9c569d157..a525b474f1d5 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -51,7 +51,6 @@ struct erofs_importer_params {
 	bool dot_omitted;
 	bool no_xattrs;			/* don't store extended attributes */
 	bool no_zcompact;
-	bool no_lz4_0padding;
 	bool ztailpacking;
 	char dedupe;
 	bool fragments;
diff --git a/lib/compress.c b/lib/compress.c
index 7a5d4374afe2..58d1f4de09db 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2186,8 +2186,7 @@ int z_erofs_compress_init(struct erofs_importer *im)
 	} else {
 		sbi->available_compr_algs = available_compr_algs;
 
-		if (!params->no_lz4_0padding)
-			erofs_sb_set_lz4_0padding(sbi);
+		erofs_sb_set_lz4_0padding(sbi);
 		if (available_compr_algs & ~(1 << Z_EROFS_COMPRESSION_LZ4))
 			erofs_sb_set_compr_cfgs(sbi);
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index aaa0300bca1b..b45368f301f3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -325,9 +325,9 @@ static int erofs_mkfs_feat_set_legacy_compress(struct erofs_importer_params *par
 {
 	if (vallen)
 		return -EINVAL;
-	/* disable compacted indexes and 0padding */
-	params->no_zcompact = true;
-	params->no_lz4_0padding = true;
+	if (en)
+		erofs_warn("ancient !lz4_0padding layout (< Linux 5.4) is no longer supported");
+	params->no_zcompact = en;
 	return 0;
 }
 
-- 
2.43.5


