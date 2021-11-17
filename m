Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4B453DF6
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 02:58:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hv5gR1rJkz2yPj
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 12:58:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=au1tqJVK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=au1tqJVK; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hv5gJ3XyMz2yKF
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 12:58:20 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 483A861507;
 Wed, 17 Nov 2021 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637114297;
 bh=PRJryqcWA510OeZ9+pEAM5ITo2Z6coa+TrWWWXs+4x8=;
 h=From:To:Cc:Subject:Date:From;
 b=au1tqJVKH/AaO289/+g0UP5TyRkfU2QG2/4LW2ZBu5rMa/8d3qbhKXWQruXsxftWQ
 ijMzhC0ZYcCNslcA4Ej9q15HwPiQeqV7Q6B9/xB1tv6OIJ8qOVESaVQu20LUwGxs3c
 CNP01GuqkzniJo24Az5KucaUpKzv6cacLdfzypFCBh8WSHSLnQ1JfkmIv63CFpi70R
 rHRG2HZnsRkakVgTpOEEmc8dZnkGukXdkp1e1s+PbswtteoRnk5YTcb8tJFLRfFJpw
 wrsCUpPUFtF5Sv0fv9rPgooxr8Rs1S25Z4Rv0warBptGxLtTavcTHvM2mS5+W0movu
 T0Vj/0u3GM1ZQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: mkfs: enable block map chunk format
Date: Wed, 17 Nov 2021 09:57:56 +0800
Message-Id: <20211117015757.3323-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Use 4-byte block map format by default unless a blob device is
given or chunk index format is forcely specified.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  8 +++++++-
 lib/blobchunk.c        | 12 +++++++-----
 lib/inode.c            |  5 ++++-
 man/mkfs.erofs.1       |  6 ++++++
 mkfs/main.c            | 20 ++++++++++++++++++++
 5 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8d459c692dac..2040dc6ff154 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -27,6 +27,11 @@ enum {
 	FORCE_INODE_EXTENDED,
 };
 
+enum {
+	FORCE_INODE_BLOCK_MAP = 1,
+	FORCE_INODE_CHUNK_INDEXES,
+};
+
 enum {
 	TIMESTAMP_NONE,
 	TIMESTAMP_FIXED,
@@ -55,7 +60,8 @@ struct erofs_configure {
 	char *c_compress_hints_file;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
-	int c_force_inodeversion;
+	char c_force_inodeversion;
+	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a10ca8cc8750..5cbb8315b277 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -110,16 +110,18 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	bool first_extent = true;
 	erofs_blk_t base_blkaddr = 0;
 
+	if (multidev) {
+		idx.device_id = 1;
+		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
+	} else {
+		base_blkaddr = remapped_base;
+	}
+
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
 	else
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
-	if (multidev)
-		idx.device_id = 1;
-	else
-		base_blkaddr = remapped_base;
-
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
 		struct erofs_blobchunk *chunk;
diff --git a/lib/inode.c b/lib/inode.c
index 855a0383f31e..5cbfc780e45f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -390,7 +390,10 @@ int erofs_write_file(struct erofs_inode *inode)
 
 	if (cfg.c_chunkbits) {
 		inode->u.chunkbits = cfg.c_chunkbits;
-		inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
+		/* chunk indexes when explicitly specified */
+		inode->u.chunkformat = 0;
+		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
+			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
 		return erofs_blob_write_chunked_file(inode);
 	}
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 71a26d88121a..f2e7d690c215 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -51,6 +51,12 @@ Forcely generate compact inodes (32-byte inodes) to output.
 .TP
 .BI force-inode-extended
 Forcely generate extended inodes (64-byte inodes) to output.
+.TP
+.BI force-inode-blockmap
+Forcely generate inode chunk format in 4-byte block address array.
+.TP
+.BI force-chunk-indexes
+Forcely generate inode chunk format in 8-byte chunk indexes (with device id).
 .RE
 .TP
 .BI "\-T " #
diff --git a/mkfs/main.c b/mkfs/main.c
index 29042c801794..58a64411b868 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -174,6 +174,18 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_noinline_data = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
+		}
+
+		if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
+		}
 	}
 	return 0;
 }
@@ -369,6 +381,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
+
+	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
+	if (cfg.c_blobdev_path &&
+	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
+		erofs_err("--blobdev cannot work with block map currently");
+		return -EINVAL;
+	}
+
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
-- 
2.20.1

