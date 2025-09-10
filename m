Return-Path: <linux-erofs+bounces-1012-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 573DEB50E33
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 08:42:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMB1x06bDz3clL;
	Wed, 10 Sep 2025 16:42:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757486532;
	cv=none; b=UDvLqrQSeMCnvEzh+VJ/StwfZC+nciSbEJZ2NOyxt95/RlHChrDxjQ/3CYYIQuvt70ttopkI2M9RGlgl47T2KlA0yvYbHdoo1aW/CK0LmE7VaupIH05XTZ/XAgFbiS5YeZd6lCt0dfujQtuGSU6Xt70xauoseyIrovGK9Sglx8ZzlPsZPtJNIyl1DDDWWsqUAA6AL4vx2kn1urq0tcRJM1c9AgoRQG6wh4K3+6+WS2mTEsEpzMDQeWVKZNx8gFlSZY4JbzlUQl3l4xGBB9mjnNfWlM61EO7ChdDsTpMSD5LxOBpKrQMhSxYfyTTFp6HW6OOdpkB8qCh8O1oLI+xz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757486532; c=relaxed/relaxed;
	bh=Zd0pgY3WuLpGCFwM/ZGbtt/M27F5+ZdOXc24M4ip09E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyFrp1iSH+5bd5z816ZnC0gnw9FoVZqjEfBAKuUF3qz2PQLOiuuOnhjzqTlqZRGPcxpCYpltAFuT0rLyezmK1eX4SW4L2pbtuhAS2nQCnNvXemRNN4WpA7pKqGZAGeOz2zfx6hDoFCMDJUq4LIdlKSREB8hztVHg/ukwxkutCNbsTtNOXcaoMOCA5YF1XI1AR4e5oBQamgg1p/Vs8z/gZOsK5q9nJ8i0zg8Q/J9ef6F0Ep6JY90ewCtTVPvcQzEgUyNMevXI0nsAF1CFIbEOo0m88FsaZV1HFOfl7cYdRJL2tQJe1cAx3O5+e+zxAlelncCoIFpJaD0/FF1oFfSBVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=OmirCPep; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=OmirCPep;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMB1v73Qzz3cl0
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 16:42:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1757486532; x=1789022532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zd0pgY3WuLpGCFwM/ZGbtt/M27F5+ZdOXc24M4ip09E=;
  b=OmirCPeplPc4lwsg+a4igK9X5+D+XXZ05wDXHiel0AaEZHKNacHL5lCF
   gNXL5ngzf/331ywwhKVwJqSXjpFrpEoY16HWdhp2Dxj6JhpyKIQoAq7cz
   So+jtYbEhYsgC7k2GMY2nMxhQ3zPs3WoXndpv6onxVhry/igEKqoKwLQT
   PSo07Yrv/KttT9zqwiHsvOUDIXjrzzZbVNXZ2DatH1RmYxxGzQqu0A1Rz
   01Mn5pUjhCOU86bx43bNmqmZ7bWU/P4fGiyqor+ynZODlFWpEMWY40Hok
   hoionLOYioSb99SI0hl5fuSN0isVIvVGzSP9pSVuMzQFejuuIWcQkcN8Z
   g==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 15:42:06 +0900
X-IronPort-AV: E=Sophos;i="6.18,253,1751209200"; 
   d="scan'208";a="30827933"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 10 Sep 2025 15:42:06 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v3] erofs-utils: fix memory leaks and allocation issue
Date: Wed, 10 Sep 2025 14:41:41 +0800
Message-ID: <20250910064140.748443-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch addresses 4 memory leaks and 1 allocation issue to
ensure proper cleanup and allocation:

1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().
2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().
3. Fixed incorrect allocation of chunk index array in
   erofs_rebuild_write_blob_index() to ensure correct array allocation
   and avoid out-of-bounds access.
4. Fixed memory leak of struct erofs_blobchunk not being freed by
   calling erofs_blob_exit() in rebuild mode.
5. Fixed memory leak caused by repeated initialization of the first
   blob device's sbi by checking whether sbi has been initialized.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 include/erofs/internal.h | 1 +
 lib/compress.c           | 2 ++
 lib/inode.c              | 3 +++
 lib/rebuild.c            | 3 ++-
 lib/super.c              | 8 ++++++++
 mkfs/main.c              | 2 +-
 6 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 9a82e06..3e1000d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -153,6 +153,7 @@ struct erofs_sb_info {
 	struct erofs_buffer_head *bh_sb;
 	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
+	bool sb_valid;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/compress.c b/lib/compress.c
index 622a205..dd537ec 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 		}
 #endif
 	}
+
+	free(sbi->zmgr);
 	return 0;
 }
diff --git a/lib/inode.c b/lib/inode.c
index 7ee6b3d..38e2bb2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	} else {
 		free(inode->i_link);
 	}
+
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+		free(inode->chunkindexes);
 	free(inode);
 	return 0;
 }
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 0358567..64779cb 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
 
 	unit = sizeof(struct erofs_inode_chunk_index);
 	inode->extent_isize = count * unit;
-	idx = malloc(max(sizeof(*idx), sizeof(void *)));
+	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
 	if (!idx)
 		return -ENOMEM;
 	inode->chunkindexes = idx;
@@ -428,6 +428,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		erofs_uuid_unparse_lower(sbi->uuid, uuid_str);
 		fsid = uuid_str;
 	}
+
 	ret = erofs_read_superblock(sbi);
 	if (ret) {
 		erofs_err("failed to read superblock of %s", fsid);
diff --git a/lib/super.c b/lib/super.c
index a9ec3aa..4f21efe 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -78,6 +78,9 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	struct erofs_super_block *dsb;
 	int read, ret;
 
+	if (sbi->sb_valid)
+		return 0;
+
 	read = erofs_io_pread(&sbi->bdev, data, EROFS_MAX_BLOCK_SIZE, 0);
 	if (read < EROFS_SUPER_OFFSET + sizeof(*dsb)) {
 		ret = read < 0 ? read : -EIO;
@@ -151,6 +154,9 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		free(sbi->devs);
 		sbi->devs = NULL;
 	}
+
+	sbi->sb_valid = !ret;
+
 	return ret;
 }
 
@@ -170,6 +176,8 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		erofs_buffer_exit(sbi->bmgr);
 		sbi->bmgr = NULL;
 	}
+
+	sbi->sb_valid = false;
 }
 
 int erofs_writesb(struct erofs_sb_info *sbi)
diff --git a/mkfs/main.c b/mkfs/main.c
index 28588db..3dd5815 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1908,7 +1908,7 @@ exit:
 	erofs_dev_close(&g_sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
-	if (cfg.c_chunkbits)
+	if (cfg.c_chunkbits || source_mode == EROFS_MKFS_SOURCE_REBUILD)
 		erofs_blob_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
-- 
2.43.0


