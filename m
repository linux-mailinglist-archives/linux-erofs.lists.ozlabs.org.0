Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724535B151
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXf04lgz3bpx
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ivrl4Atz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ivrl4Atz; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXc00rYz3bpB
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:49:03 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B535A610E9;
 Sun, 11 Apr 2021 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112942;
 bh=6nUtQZFtLp0mpBZcjnejOCABJ8hS3G5WUa+JlQsPZC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ivrl4AtzGUWH2NIwVgJ3LZ3cyLMAADwXwuajZe0fT6Xbrm50aWcvZ+TrbR3A5Xw0R
 uFKXQp6Rs+B81eIqnEGBUdrf7zPTuMk8obxdXCSg3UKOeLFQhcFkHJwwBQQ9n269rv
 GIVM3Wwb0X8JVNUk6e3n8Ne+LQixMxEUZkF0/jS1D4xqM6lNp7C1xUyiP/Afn/Cz7z
 BkPX/GELw1lCrfMdKXjrQ6hrL6wemmCeCejMeqzixkaUxxrbbzAoohO1Rg9y+A4psl
 LlLF9psU0hmvIr4SSwUC1S0//UwnNVNoOD96gk6AanX92l2ixt2lNf+7KO0BKqWTAa
 X54D2Tbpb29kA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/8] erofs-utils: add big physical cluster definition
Date: Sun, 11 Apr 2021 11:48:40 +0800
Message-Id: <20210411034844.12673-5-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This keeps in sync with the kernel definition.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/internal.h |  1 +
 include/erofs_fs.h       | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6e481faa8c9f..1339341a0792 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -108,6 +108,7 @@ static inline void erofs_sb_clear_##name(void) \
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index a24deb095537..52da7abaac92 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -21,9 +21,11 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
 
 /* 128-byte erofs on-disk super block */
 struct erofs_super_block {
@@ -199,6 +201,9 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
+/* maximum supported size of a physical compression cluster */
+#define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
+
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
@@ -208,17 +213,20 @@ enum {
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
 	__le16 max_distance;
-	u8 reserved[12];
+	__le16 max_pclusterblks;
+	u8 reserved[10];
 } __packed;
 
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
+ * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  */
-#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
-
-#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+#define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 
 struct z_erofs_map_header {
 	__le32	h_reserved1;
@@ -275,6 +283,13 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/*
+ * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
+ * compressed block count of a compressed extent (in logical clusters, aka.
+ * block count of a pcluster).
+ */
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
 	/* where to decompress in the head cluster */
-- 
2.20.1

