Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D6965DE0
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 12:04:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwDJY5Cx1z30DR
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 20:04:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725012252;
	cv=none; b=L90Gr4dHMfaTMr/rtP3au9ZZl6gH79ZpmZOshjEeC1/WkVANIUYEWBXEZi0GRk31Y3uiGTUDmI0kLVcF+kmp8Cji1WFBdWPhLMQX76yrqPoZpPfdpwI3s2EbmbLBpNSTmRaOM4wZRp87hydGf3ygIStKTnmRbxVm8IVrddZk5iqQdJ9xlPsRScmw+oc8mDw4EPjVHzkDreYnRijr3aOexVdhqy4+WNDEkIiircxQcB9YXrHPyfTEBOz30q9n/kZxVWNTS8b5G4XxRLQYhVsGNXkh1V+1P0QeZmgA1JTqc4KFhJy7I20E6ks5nXf5JPFuoxBX7wfUxu3MfRSdGR6CQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725012252; c=relaxed/relaxed;
	bh=BnUe0dXSx0FQ7ldNUdmCw2iqXJtCiwN5kQYi8wJkb60=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=gsoXhYlFBRRnZZ81T1F+/uO8p80w65skgUOe5IJFVJ//Y9Sg7RdY8rOwrLZj9+dPwaeKdI1djUJeOP7vK7zqsHNN/BrZeJ4Pcr0kpBSsMz8ElF8SBld1WFU3CNv3XyyLvJIBuwxPQxHXQXhBYyicWDCOfxKjBDzelWdiqcEtcc4RAN8FSRXznnhBICDWUzU2lWUeGf1U2HYO0v16YghUsrfzJ6rI4LkqCWC+DOSeNjFa1Avq6ecRXkhQF3MuSrjvUiiueVLCrRS9FBw5J9lT8qBlAWP3SPs2PldGPDRu8hAlkknBGAz3rdzIK4FsuRHL0R7nPgP4pZ+TvZQoDku3LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nNAR1jWs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nNAR1jWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwDJV5S1Rz306G
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 20:04:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725012244; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BnUe0dXSx0FQ7ldNUdmCw2iqXJtCiwN5kQYi8wJkb60=;
	b=nNAR1jWsmga8zsgemtnvht5txyhQUIjbXz65axsTInJwqZL1UxZU1DVRB/GU+Xn4DiwZVelcO+kaiSP7x/qhfTf4pQFTUzf21jYS/44SLdT7HVbQAqEpRCs12sgqCCgj3QMjNh0VZG8+NO9sacHTvpkXD+xFZHfEwhOeV9Bgzyo=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDwX3ob_1725012242)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 18:04:02 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v5] erofs-utils: fix invalid argument type in erofs_err()
Date: Fri, 30 Aug 2024 18:03:54 +0800
Message-ID: <20240830100354.2093735-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix several issues found by Coverity regarding "Invalid type in argument
for printf format specifier".

Coverity-id: 502374, 502367, 502362, 502348, 502342, 502341,
	     502340, 502358

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v5: Adjusted commit message and made minor changes.
v4: https://lore.kernel.org/all/20240827032240.1869284-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240814045501.1675174-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240814033813.1605825-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240813121003.780870-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c     |  4 ++--
 lib/blobchunk.c |  3 ++-
 lib/compress.c  |  4 ++--
 lib/fragments.c | 10 +++++-----
 lib/super.c     |  3 ++-
 mkfs/main.c     |  2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..89d87fb 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -807,8 +807,8 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	curr_pos = prev_pos;
 
 	if (prev_pos + ctx->de_namelen >= PATH_MAX) {
-		erofs_err("unable to fsck since the path is too long (%u)",
-			  curr_pos + ctx->de_namelen);
+		erofs_err("unable to fsck since the path is too long (%llu)",
+			  (curr_pos + ctx->de_namelen) | 0ULL);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 2835755..33dadd5 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -95,7 +95,8 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 		chunk->device_id = 0;
 	chunk->blkaddr = erofs_blknr(sbi, blkpos);
 
-	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
+	erofs_dbg("Writing chunk (%llu bytes) to %u", chunksize | 0ULL,
+		  chunk->blkaddr);
 	ret = fwrite(buf, chunksize, 1, blobfile);
 	if (ret == 1) {
 		padding = erofs_blkoff(sbi, chunksize);
diff --git a/lib/compress.c b/lib/compress.c
index 8655e78..17e7112 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -497,8 +497,8 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
 	inode->fragmentoff += inode->fragment_size - newsize;
 	inode->fragment_size = newsize;
 
-	erofs_dbg("Reducing fragment size to %u at %llu",
-		  inode->fragment_size, inode->fragmentoff | 0ULL);
+	erofs_dbg("Reducing fragment size to %llu at %llu",
+		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
 
 	/* it's the end */
 	DBG_BUGON(ctx->tail - ctx->head + ctx->remaining != newsize);
diff --git a/lib/fragments.c b/lib/fragments.c
index 7591718..e2d3343 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -138,7 +138,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	inode->fragment_size = deduped;
 	inode->fragmentoff = pos;
 
-	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
+	erofs_dbg("Dedupe %llu tail data at %llu", inode->fragment_size | 0ULL,
 		  inode->fragmentoff | 0ULL);
 out:
 	free(data);
@@ -283,8 +283,8 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 		goto out;
 	}
 
-	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
-		  inode->fragmentoff);
+	erofs_dbg("Recording %llu fragment data at %llu",
+		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
 
 	if (memblock)
 		rc = z_erofs_fragments_dedupe_insert(memblock,
@@ -316,8 +316,8 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	if (fwrite(data, len, 1, packedfile) != 1)
 		return -EIO;
 
-	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
-		  inode->fragmentoff);
+	erofs_dbg("Recording %llu fragment data at %llu",
+		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
 
 	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
 					      tofcrc);
diff --git a/lib/super.c b/lib/super.c
index 32e10cd..d4cea50 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -213,7 +213,8 @@ struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr)
 
 	bh = erofs_balloc(bmgr, META, 0, 0, 0);
 	if (IS_ERR(bh)) {
-		erofs_err("failed to allocate super: %s", PTR_ERR(bh));
+		erofs_err("failed to allocate super: %s",
+			  erofs_strerror(PTR_ERR(bh)));
 		return bh;
 	}
 	bh->op = &erofs_skip_write_bhops;
diff --git a/mkfs/main.c b/mkfs/main.c
index b7129eb..1027fc6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -274,7 +274,7 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 		u64 i = strtoull(val, &endptr, 0);
 
 		if (endptr - val != vallen) {
-			erofs_err("invalid pcluster size %s for the packed file %s", val);
+			erofs_err("invalid pcluster size %s for the packed file", val);
 			return -EINVAL;
 		}
 		pclustersize_packed = i;
-- 
2.43.5

