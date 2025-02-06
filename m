Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85841A2A8CC
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR227zBz30Pp
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846251;
	cv=none; b=XMcEmLPD4Upz1tA5nD5pD1BgTJpTEuFu5GE3AA+QC8l7Bj9Z53gZ/Gm7Fgcs+GleH4EMlOOjdmGix48bg3and6JsKy/Cdm9mLfHV8CHxpyYuVlGCCKstl1jjrAOJKNB/yzKlO0kbURihm3scX8nKnUg3VdZ5nGFFiLXEzcSJCLJX1XUGVaf5/fvLvsZgh5oEbY38Ol7JsQakpUOJrWyK+z5m+7s2jnUbGcIET7hCSGbsxe/FbRqYqWiM0ZI6/XCkc1J4cb4tS3RwQZ9aQbTK5kbC2wsC4eFxKbzO+0kc+FGoZDBpghikBR9ztvh5568iauB9qzKTEBH4YsgRcK44rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846251; c=relaxed/relaxed;
	bh=NIfRX+yueKvU5weC79ObXAMTFAuFRey/MknqUTKpng0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZZTvv2dCf+W53WOHizK68vxCbPUso3GuZB8eA6t/xjiL0+n9ygHLV85l/yL2LIW3AYdWF3uD2IVZW1sq+TjL+mC7ptDMepq/y1Upok6Ps19NtCWVK6qFM1iQymo36n/z3H3jeNgjVI9JN6rq6wb4w8lpcwaNWbCP7/y6a1kAqxKqfMDXGBfrTQ12PQmtw7TA96VZa2NKja8Ov4/seqGhsljVwiNh0PQSeV2Yq4SPdZ9j5tsLCUNLaXJJqkbJ8atyk+Furbo4CLze1TNWMJNuK8VgSFfB+YCs22axSsSV9hCplBq9dZSgia/grH5BtHwxOrEQFJjgbqBTwwFsCfZbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UI0HDuDn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UI0HDuDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcQy1lVqz30DD
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846246; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NIfRX+yueKvU5weC79ObXAMTFAuFRey/MknqUTKpng0=;
	b=UI0HDuDnQd9PNgjOm9iA2819zZ1FMbQUqMvtXTlHO0bzQjHvuDvqjqiWekjCb5lGPMFkpJA3Mo1g952s2SUcTAcbjmIAcp4jQu2n7G11y+wqMCdkVvMhWhdFSbYeYqwtvGtNRAiPIlVkStKtypszdU11TFlKWFBc8r0KoNL0qho=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl46_1738846243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/9] erofs-utils: lib: get rid of z_erofs_do_map_blocks() forward declaration
Date: Thu,  6 Feb 2025 20:50:27 +0800
Message-ID: <20250206125034.1462966-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
References: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 999f2f9a63f475192d837a2b8595eb0962984d21
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 158 ++++++++++++++++++++++++++---------------------------
 1 file changed, 77 insertions(+), 81 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index f1cdc66..74c0033 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,10 +10,6 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 
-static int z_erofs_do_map_blocks(struct erofs_inode *vi,
-				 struct erofs_map_blocks *map,
-				 int flags);
-
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
@@ -31,83 +27,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
-{
-	int ret;
-	erofs_off_t pos;
-	struct z_erofs_map_header *h;
-	char buf[sizeof(struct z_erofs_map_header)];
-	struct erofs_sb_info *sbi = vi->sbi;
-
-	if (vi->flags & EROFS_I_Z_INITED)
-		return 0;
-
-	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
-	if (ret < 0)
-		return -EIO;
-
-	h = (struct z_erofs_map_header *)buf;
-	/*
-	 * if the highest bit of the 8-byte map header is set, the whole file
-	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
-	 */
-	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
-		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
-		vi->z_tailextent_headlcn = 0;
-		goto out;
-	}
-
-	vi->z_advise = le16_to_cpu(h->h_advise);
-	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
-
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err("unknown compression format %u for nid %llu",
-			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
-		return -EOPNOTSUPP;
-	}
-
-	vi->z_logical_clusterbits = sbi->blkszbits + (h->h_clusterbits & 7);
-	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-			  vi->nid * 1ULL);
-		return -EFSCORRUPTED;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
-
-		vi->idata_size = le16_to_cpu(h->h_idata_size);
-		ret = z_erofs_do_map_blocks(vi, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (!map.m_plen ||
-		    erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
-			erofs_err("invalid tail-packing pclustersize %llu",
-				  map.m_plen | 0ULL);
-			return -EFSCORRUPTED;
-		}
-		if (ret < 0)
-			return ret;
-	}
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
-
-		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		ret = z_erofs_do_map_blocks(vi, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (ret < 0)
-			return ret;
-	}
-out:
-	vi->flags |= EROFS_I_Z_INITED;
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct erofs_inode *inode;
 	struct erofs_map_blocks *map;
@@ -668,6 +587,83 @@ out:
 	return err;
 }
 
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[sizeof(struct z_erofs_map_header)];
+	struct erofs_sb_info *sbi = vi->sbi;
+
+	if (vi->flags & EROFS_I_Z_INITED)
+		return 0;
+
+	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
+	ret = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
+	if (ret < 0)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto out;
+	}
+
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err("unknown compression format %u for nid %llu",
+			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = sbi->blkszbits + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid * 1ULL);
+		return -EFSCORRUPTED;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->idata_size = le16_to_cpu(h->h_idata_size);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (!map.m_plen ||
+		    erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
+			erofs_err("invalid tail-packing pclustersize %llu",
+				  map.m_plen | 0ULL);
+			return -EFSCORRUPTED;
+		}
+		if (ret < 0)
+			return ret;
+	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret < 0)
+			return ret;
+	}
+out:
+	vi->flags |= EROFS_I_Z_INITED;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map,
 			    int flags)
-- 
2.43.5

