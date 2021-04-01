Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B7350D13
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbX60Jzz30BK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oV7GUgfi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oV7GUgfi; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbV5FTcz309c
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:14 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB416610D0;
 Thu,  1 Apr 2021 03:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247813;
 bh=e3ltakU8Qa1bsgU6gEhQQ7DHA82eXpVVBXlX6iVuWfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oV7GUgfiYqSQDBcF5B3e4xuyBkT5cZjTxoCUc6L6y4OYcntWfYbVnxYO6ughE+jPA
 i/qOmawmF56JrJjARGiPjuJeitU4844iDzyy7aR70sksXJjSz45chuiET2JRE5fkp5
 r+51OLItYm1ymEQ+Wpf6Py5YBFJv/9XpJfs+qFOyTjG+UolDDKmlrMxUdNGc0VHQ2P
 aixxcO4AGap0Zx4Aj/tfqeKZk6cgyQ4FVxITsGD1QDKQAMEN+FzjdG/sQGf0WqL94g
 LQy9KIppQI/kd4oGxiJxhjbNZWy/dgfD8Iges4KkUrlG83XxdNA9KPbNzMKglw33lR
 b4ieqSw6te5TQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 05/10] erofs: add big physical cluster definition
Date: Thu,  1 Apr 2021 11:29:49 +0800
Message-Id: <20210401032954.20555-6-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Big pcluster indicates the size of compressed data for each physical
pcluster is no longer fixed as block size, but could be more than 1
block (more accurately, 1 logical pcluster)

When big pcluster feature is enabled for head0/1, delta0 of the 1st
non-head lcluster index will keep block count of this pcluster in
lcluster size instead of 1. Or, the compressed size of pcluster
should be 1 lcluster if pcluster has no non-head lcluster index.

Also note that BIG_PCLUSTER feature reuses COMPR_CFGS feature since
it depends on COMPR_CFGS and will be released together.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h | 19 +++++++++++++++----
 fs/erofs/internal.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 76777673eb63..ecc3a0ea0bc4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -19,6 +19,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
 #define EROFS_SB_EXTSLOT_SIZE	16
@@ -214,17 +215,20 @@ enum {
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
@@ -279,6 +283,13 @@ enum {
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
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06c294929069..c4b3938a7e56 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -230,6 +230,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
-- 
2.20.1

