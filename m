Return-Path: <linux-erofs+bounces-149-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A2A7CCA8
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Apr 2025 05:49:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVdcR1gDSz2yNG;
	Sun,  6 Apr 2025 13:48:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743911335;
	cv=none; b=RFK8T8VCbEkmNY77axGWiSqpVsKue2GljSrBIDIMtpl44ublX17CcIauIKsv3yvLtt/AZxWLs6ezUr7uNNnH0PFneKBF5bmZnn3o34N6QGBVYUkZ2yRZ/OsWEGODjm+DTUJ1sbTIyOnfydVQEUJW39SN+A+5DfTctJl89udWMSy2YlSajjPJNyny/CxOjU5Dq8y7pn1oaYTRDDRNamc1QFhg2WD6a8KQO2E+TryOE8oUMYSqtiYPE6iee/PjBLuecYnBpf1XvVNc6mIysrOXDwxIKNh/XlhWeuRCrBUJNZfoMU0hlUto/1DgpemBKtr6Lz4ht3NC7IJzrJGF/iPJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743911335; c=relaxed/relaxed;
	bh=XEecAMyjFckUHQOa2nuFktf6pNQiDYrLzcHPcob3l20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kanvh3JhoPSePgPdEhZbgUyHwu8hJq7VdLIaMQeyHMgd+ZrvADv6EaOKunwQm5FxjyggumYw4ix5i9TZ8e4R6W3bQYs+JlYfCXZgFvnlq5H2stCSaVSkr/S6szl8m36rlnorejLaPwCDf2zeWbRNsxdNZxDTrK/Gx6TijPIixwCJSrygAl0L2rnG4h5ODHPiBs2KqDFizgfXmH1WWbbQyZg04Epr1zCWtZmFIAmjJcpgKvY01HzsTZT2XuX2S3DgoeqX3qPTlzLD07JSPRT1RpbzZFApXrt9tSGmEJb+e+Ui5BKj8B2T+KgXKJ1KVeuaGqS2uWHKI7WZ8tDrnFYYJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kzzDVidq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kzzDVidq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVdcP5Dvbz2xs7
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 13:48:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743911328; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XEecAMyjFckUHQOa2nuFktf6pNQiDYrLzcHPcob3l20=;
	b=kzzDVidq7v1U6MqWeMNw2BjRoMLrHnuASLfwnYGwXsvJ2e+OwHG+MARVASKCgSj6KPvs6wigEuSjfrREo+/MhDqS+REpkLICiIp6vtEjc89Fe6EsUiFuURFf7kUQ4GVDgB1xDSQHcHs4/fdOKe0SmYwke6kK/LV+/Ca5tSFrt5I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVRu7SS_1743911322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Apr 2025 11:48:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix `fragmentoff` larger than 4GiB
Date: Sun,  6 Apr 2025 11:48:41 +0800
Message-ID: <20250406034841.3931822-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The `EROFS_INODE_COMPRESSED_FULL` datalayout should be used forcibly.

Fixes: cf04b8b78f09 ("erofs-utils: mkfs: implement extent-based deduplication")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/fragments.h |  1 -
 lib/compress.c            | 13 +++++++++++--
 lib/fragments.c           | 25 ++++++-------------------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index ccfdd9b..a57b63c 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -17,7 +17,6 @@ extern const char *erofs_frags_packedname;
 
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
 
-void z_erofs_fragments_commit(struct erofs_inode *inode);
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
diff --git a/lib/compress.c b/lib/compress.c
index 9f71022..1742529 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1004,7 +1004,13 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	struct z_erofs_extent_item *ei, *n;
 	void *metabuf;
 
-	if (!cfg.c_legacy_compress && !ctx->dedupe &&
+	/*
+	 * If the packed inode is larger than 4GiB, the full fragmentoff
+	 * will be recorded by switching to the noncompact layout anyway.
+	 */
+	if (inode->fragment_size && inode->fragmentoff >> 32) {
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+	} else if (!cfg.c_legacy_compress && !ctx->dedupe &&
 	    inode->z_logical_clusterbits <= 14) {
 		if (inode->z_logical_clusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
@@ -1165,7 +1171,10 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	u8 *compressmeta;
 	int ret;
 
-	z_erofs_fragments_commit(inode);
+	if (inode->fragment_size) {
+		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		erofs_sb_set_fragments(inode->sbi);
+	}
 
 	/* fall back to no compression mode */
 	DBG_BUGON(pstart < (!!inode->idata_size) << bbits);
diff --git a/lib/fragments.c b/lib/fragments.c
index 41b9912..9dfe0e3 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -179,21 +179,6 @@ static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
 	return 0;
 }
 
-void z_erofs_fragments_commit(struct erofs_inode *inode)
-{
-	if (!inode->fragment_size)
-		return;
-	/*
-	 * If the packed inode is larger than 4GiB, the full fragmentoff
-	 * will be recorded by switching to the noncompact layout anyway.
-	 */
-	if (inode->fragmentoff >> 32)
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-
-	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-	erofs_sb_set_fragments(inode->sbi);
-}
-
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
@@ -250,8 +235,9 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 		}
 	}
 
-	erofs_dbg("Recording %llu fragment data at %llu",
-		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
+	erofs_dbg("Recording %llu fragment data at %llu of %s",
+		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL,
+		  inode->i_srcpath);
 
 	if (memblock)
 		rc = z_erofs_fragments_dedupe_insert(
@@ -289,8 +275,9 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 		return -EIO;
 	}
 
-	erofs_dbg("Recording %llu fragment data at %llu",
-		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
+	erofs_dbg("Recording %llu fragment data at %llu of %s",
+		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL,
+		  inode->i_srcpath);
 
 	ret = z_erofs_fragments_dedupe_insert(&epi->hash[FRAGMENT_HASH(tofcrc)],
 					      data, len, inode->fragmentoff);
-- 
2.43.5


