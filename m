Return-Path: <linux-erofs+bounces-853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32BB2EC7D
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 05:59:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6qMV4lNLz2xnM;
	Thu, 21 Aug 2025 13:59:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755748774;
	cv=none; b=G6f5C1LIPwgbzQq16lwLxin+fkkyqvc7+ePr5p/nsDH1s09i3BxKIszYcNTbxZgbaeMhgV55RPphlmjFeKrt+UO5vOJ4L1vABn6Bc6MCI3VZfK4cpB/oUIMUfE867Cj/pGToZuCDLXdctHzIE4TcKkOAMy9VIOyDqzWmVDG8E741AMDURNRAIJcZLW0xQP8A7qbQjpPMG81Pm/mqw6wvO0A8Np0sVuLQy9Ibxvl/eZUUqeAYWUL69EVf1EQbxT8WZQPXVHz2h7zw4TBQjmlUzN1dc36Dlye32aSGaJzfiEb84X9+0rKClIhT41ZEnCiQTfd8kgtHH20BUkKYWDAZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755748774; c=relaxed/relaxed;
	bh=FaKW+wQEiX1Z5Y0AiSZhHXuJNVCRyzzZXBblHtp0wyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Zk8l5IpEEKch9ZugV0QMpTwa2nsCr5lrn9Xx71W4DaO/wNCaaqM8/f4LhqEv5btdJYBviZBD5mWFIQPe7/whkBEQFpFe7z7gnR+kw+ccDwXmUf1bwLhETdhzs8jkFnF34eOthv01uBZvq7OOhagiH+8GxvOofKh7hyRE3l+kxlq0DK356fe++PA+A4OB8po5d/KwBEbl3O3cBQI3J3mDgVNmmiwmvv6+Pi5sCy++dA71Hkx5FJRR6nf8sCTdHgXhZTqDT0vO3xTYpKxwwfkvFRlvC/vwGBNiJi3iPmI2WiVgilNGTBoI/OjDQH3TejYsCkc3maUs0eHulkt/xyvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sxpdse2l; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sxpdse2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6qMS4ZRWz2xc8
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 13:59:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755748767; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FaKW+wQEiX1Z5Y0AiSZhHXuJNVCRyzzZXBblHtp0wyQ=;
	b=Sxpdse2lUXZfwBI8zx7O3T2WZoMaHR/iabR0KDP4Dj6c9uY9hJQg5yszxYtsM4FyhHe8RvyjkzVsLWzWkZLAQd2P6Jko6CRKbyiMt1qaFVnLM2feyXQlvN6c46tGuT+e+TG3DFSUFxrlCDVkBLDHpjC6lNy8EOvMvoDw0OfJkGM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmEbSPG_1755748761 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 11:59:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: dump: display minimum kernel version for ondisk features
Date: Thu, 21 Aug 2025 11:59:21 +0800
Message-ID: <20250821035921.3145249-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806030747.703334-1-hsiangkao@linux.alibaba.com>
References: <20250806030747.703334-1-hsiangkao@linux.alibaba.com>
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
 dump/main.c | 54 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 38cc8a2..b818a4a 100644
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
@@ -666,16 +668,30 @@ static void erofsdump_show_superblock(void)
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
+		minkver = max(minkver, 610U);
+	if (minkver)
+		fprintf(stdout, "\nRequired upstream Linux kernel version:       %u.%u\n",
+			minkver / 100, minkver % 100);
+	else
+		fputs("\n", stdout);
 }
 
 static void erofsdump_show_file_content(void)
-- 
2.43.5


