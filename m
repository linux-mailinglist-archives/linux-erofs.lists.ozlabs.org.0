Return-Path: <linux-erofs+bounces-1003-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE5B50CFE
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 07:06:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM7vn1sn9z3cjQ;
	Wed, 10 Sep 2025 15:06:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757480805;
	cv=none; b=nVEFz4u9Bved8Id4dU21yQARGgm6QnpmN1cdP1MJzr5TpvYg8sp2lLyBz0LEESumWhNc/hlehYPG6PbGbldZ7JF1NYGWaDVvssyEJtBBrHEn4kBMxsLNba6/gIasAnyM9hJilLVBCOfowFTfnPXWIqZU7ELPBg1nJybew9tdmF8YD3/a54fiDObcIF7oTPtJ8SkSAYTq49mJLoOssUgNV0SQLvlaR0GJ4DhzbPQA37PZ3mvzrwIk3UIuYEYpPnLKS+SDJU3dRSIGxtgRFXmTPhadfTDFeJS2iM6WPE2CmINN+MdB2GluHnq67kzzHKd8WwboAwTPvTA41qQZXaG9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757480805; c=relaxed/relaxed;
	bh=HNPEvRpgKlRzSoOyuQviI0bF59SESvr15wXc5Hp7O0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhSmds2sPOLZc6k/T5d1tpBtFhN8Ps4IX74WktutZQopVe4LgyPk06bPXFHxgC5mao6zBSCUVfZwQ9UGREZbd/cq1MLXnuyTtHs6+eNsm+Wvn7UVlangUhruduGaEHZq8ke7u/y04WPI+/HwN16EOJDr/+AOHiB2qP3q2uIFduT9YTKXCLYI7Ac1s20Lv57A7pSQhGnuqvPOyOSEvdMLKUpxpqjU5FY+9OqgqdnPR51b5zuY2DSlFFH1PA4fSpX15PbABxmJ7iQ6Xl8aJUrV6eM1V9CtNY/XkDZZIgimkmlcw6zz0IPcw3GPC/naGk0fFVmKWbghWCYue+hmlmuhUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=Jk+/yZgo; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=Jk+/yZgo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::8; helo=jpms-ob02-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM7vm21TNz3cjL
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 15:06:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1757480804; x=1789016804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNPEvRpgKlRzSoOyuQviI0bF59SESvr15wXc5Hp7O0Y=;
  b=Jk+/yZgoMa7Rq697guDWy57T5IfkNlrCIZr1kKP4IFpW/J9Ut3WRBPpv
   HaxR9w5ZvJbMr1oFs7H1dajg3TpplZjK0As+aakUkhH2vZxTyMfVW2IEc
   jcQPQtlsE5W/10/oLuI/q1ekmS/JwkblYNCuYwBZwWDFaOFgY65frWlas
   P2CLer/5+eDlqEKAxTIeGPAPMnXRuz9eby7COZDiqyw1Y1RWU7dAADDKb
   7HgVl7oxmAiClCNacSO25EQJ08ly4jI/qzuxFU6rUJjHcF0slR3lt9iqL
   EqWT00sc7gLt86RowngA01Yz9+RfXqBFb6Fn5V3vUBuQ7WHJKp3X7Zh+J
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:37 +0900
X-IronPort-AV: E=Sophos;i="6.18,253,1751209200"; 
   d="scan'208";a="30785495"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 10 Sep 2025 14:06:37 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
Date: Wed, 10 Sep 2025 13:05:46 +0800
Message-ID: <20250910050545.735649-2-Yuezhang.Mo@sony.com>
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
 lib/compress.c |  2 ++
 lib/inode.c    |  3 +++
 lib/rebuild.c  | 13 ++++++++-----
 mkfs/main.c    |  2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

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
index 0358567..461e18e 100644
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
@@ -428,10 +428,13 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		erofs_uuid_unparse_lower(sbi->uuid, uuid_str);
 		fsid = uuid_str;
 	}
-	ret = erofs_read_superblock(sbi);
-	if (ret) {
-		erofs_err("failed to read superblock of %s", fsid);
-		return ret;
+
+	if (!sbi->devs) {
+		ret = erofs_read_superblock(sbi);
+		if (ret) {
+			erofs_err("failed to read superblock of %s", fsid);
+			return ret;
+		}
 	}
 
 	inode.nid = sbi->root_nid;
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


