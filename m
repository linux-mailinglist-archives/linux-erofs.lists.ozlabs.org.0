Return-Path: <linux-erofs+bounces-773-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209AB1BF08
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 05:08:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxZww1z57z30W5;
	Wed,  6 Aug 2025 13:08:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754449680;
	cv=none; b=SZMIovZ5IOYPdxr70osJCgEbyVZvqMfH+qFhJxg5JXskdm5J0B9zNLOY6K5D7OM/kCysiIR5nljvbyUe3u8VsUR8lFtHBch4/oAsc6lgEePscxYP3sJ7Rd4+cSAJxPbBs2Z6tBmYNjQBDo+FlT8Weq0Xnpm7hroIn5FKgT7KDMjRiltvWfasCelY5LCVZdg/tl4TJjK/hEUwta40P1+SsIrFToFp3YdyQbxUHwSMl96AeITmiAVtiuUewuMJb2qzm9OwmmSpjDVaQBcGUqRGa9JPbYG4pe19nLxHupGq2CXYSUz+hrdJGEZil+uU7VmIPN07XQrR7E8N2GovSB3iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754449680; c=relaxed/relaxed;
	bh=MLC1z/gOdwWTeUAqvlnS1WR++U8fc/kGFpOHAjz5Hlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzckhS63aPW1mNnryNUtDJtCwyrq4it2/bO+5dAwr4aARQGJKMGPaS/AOGcPBRx8rEcV+wr3w970ec0ulicmwsqn6A4cjnruVmsN037zWdygD/rIGtS1Hvq0itqqfX+1y+QSfdfeTz7FQ7XPBzA3gB2gcyYrCgONVYOV8ZepOtuvbxWqITIthpjYUse89VB9v6hvDt3tlKKJUF9INWzNqK/epH2EvfIPA7QfX1a1mD8JcuCybp2ofbllJ+yOEEBCbgNnDpPTj02i7hFdkid/bESdyP3WzmqrYuouKVJUKs+Kc1CazJ7IXZmnUyvs1UKsQMPk5q/rfk7zmcz0LBzwEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Hsq29XLF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Hsq29XLF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxZwt3HjYz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Aug 2025 13:07:57 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754449674; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MLC1z/gOdwWTeUAqvlnS1WR++U8fc/kGFpOHAjz5Hlc=;
	b=Hsq29XLFC6SZhDpvMqXGHBXkr12r6cm1VJhvwriX1mWRd39Ffv9TveNcNXSl/219MTIJt91omAnSJ7F7p2wPuKpT6hbVjimQNoiDPpimRax0qu+raHi/BQloqkdYPpRmH5gYt4Tm7yA3GTCQF5xWWfIr7cokLbPzFzyK8UndLBY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl8KUDk_1754449668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 11:07:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: dump: display minimum kernel version for ondisk features
Date: Wed,  6 Aug 2025 11:07:47 +0800
Message-ID: <20250806030747.703334-1-hsiangkao@linux.alibaba.com>
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

Allow users to identify the minimum supported upstream kernel version.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c | 52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 38cc8a2..0388830 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -87,25 +87,26 @@ static struct option long_options[] = {
 
 struct erofsdump_feature {
 	bool compat;
+	u16 lkver;
 	u32 flag;
 	const char *name;
 };
 
 static struct erofsdump_feature feature_lists[] = {
-	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
-	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
-	{ true, EROFS_FEATURE_COMPAT_XATTR_FILTER, "xattr_filter" },
-	{ false, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
-	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
-	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
-	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
-	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
-	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
-	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
-	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
-	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
-	{ false, EROFS_FEATURE_INCOMPAT_48BIT, "48bit" },
-	{ false, EROFS_FEATURE_INCOMPAT_METABOX, "metabox" },
+	{  true,    0, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
+	{  true,    0, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
+	{  true,    0, EROFS_FEATURE_COMPAT_XATTR_FILTER, "xattr_filter" },
+	{ false, 504U, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
+	{ false, 513U, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
+	{ false, 513U, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
+	{ false, 515U, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
+	{ false, 516U, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
+	{ false, 517U, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
+	{ false, 601U, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
+	{ false, 601U, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
+	{ false, 604U, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
+	{ false, 615U, EROFS_FEATURE_INCOMPAT_48BIT, "48bit" },
+	{ false, 617U, EROFS_FEATURE_INCOMPAT_METABOX, "metabox" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -630,8 +631,9 @@ static void erofsdump_print_supported_compressors(FILE *f, unsigned int mask)
 static void erofsdump_show_superblock(void)
 {
 	time_t time = g_sbi.epoch + g_sbi.build_time;
+	unsigned int minkver = 0;
 	char uuid_str[37];
-	int i = 0;
+	int i;
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
@@ -666,16 +668,28 @@ static void erofsdump_show_superblock(void)
 	fprintf(stdout, "Filesystem created:                           %s",
 			ctime(&time));
 	fprintf(stdout, "Filesystem features:                          ");
-	for (; i < ARRAY_SIZE(feature_lists); i++) {
+	for (i = 0; i < ARRAY_SIZE(feature_lists); i++) {
 		u32 feat = le32_to_cpu(feature_lists[i].compat ?
 				       g_sbi.feature_compat :
 				       g_sbi.feature_incompat);
-		if (feat & feature_lists[i].flag)
+		if (feat & feature_lists[i].flag) {
 			fprintf(stdout, "%s ", feature_lists[i].name);
+			if (feature_lists[i].lkver > minkver)
+				minkver = feature_lists[i].lkver;
+		}
 	}
 	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
-	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
-			uuid_str);
+	fprintf(stdout, "\nFilesystem UUID:                              %s",
+		uuid_str);
+	if ((g_sbi.available_compr_algs >> Z_EROFS_COMPRESSION_LZMA) & 1)
+		minkver = max(minkver, 516U);
+	if ((g_sbi.available_compr_algs >> Z_EROFS_COMPRESSION_DEFLATE) & 1)
+		minkver = max(minkver, 606U);
+	if ((g_sbi.available_compr_algs >> Z_EROFS_COMPRESSION_ZSTD) & 1)
+		minkver = max(minkver, 612U);
+	if (minkver)
+		fprintf(stdout, "\nRequired upstream Linux kernel version:       %u.%u\n",
+			minkver / 100, minkver % 100);
 }
 
 static void erofsdump_show_file_content(void)
-- 
2.43.5


