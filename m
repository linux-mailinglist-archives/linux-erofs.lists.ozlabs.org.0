Return-Path: <linux-erofs+bounces-984-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B981B49F6F
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 04:54:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLT151LK2z3057;
	Tue,  9 Sep 2025 12:54:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:cf8:acf:41::7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757386441;
	cv=none; b=m3grkWn3S08w5TsJ3lCd1CvGNmziYCWH5dArA9ymR2hKASGAtlc6LijUPTOatnHhrw6A8Yn7DSM+6gTam81RnsXIhHNHiBDhusPozm8TVt0TXk6ZbV2YPrNvlDPwPZOON/tXiYX5w7PT9PSwaQJ33+28m8okCE1ji4ha4FjmETQMhoMSIqtqgVmADYBY3rWdbdFm9Rn/aYmRWvzf10KyS0jIW5Dr4OrLR0BPjewNAtknqBMOUDNWXDDyfF2SIW6WX2cuHaa3yCJMd4q3bYtMDm17+mcr96TLboPkpM6gBKo4eMRlLkAc0IQWUbYNSgSQi/EeytEVYQMMeXLxZVFzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757386441; c=relaxed/relaxed;
	bh=aUbLhIfV5VjpL5YovpOYu/z3oJbNX5W3wr2EvQXergg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmZT9p6Jn5+0w7q1A6gl66KALHgvHhwMIWdbOGzfgxgReIpAk+J31Wp3/SrzF7fEjesEiXP0iml+JfkAaHzivoABkCJy1lL4un9xCn1n9/GM0SBDVUBK/ZWVDrtuori0v3TRt9C15uClkt7WHb3519i2nzl5Qq/hQ312PdZc4Ghqxn8TUDGZvqdadQcxF/N4BZc10Z/Y2BlEiF2N7UFRt7rlN+oBI/acBL0xB6pKrR5Ggf9OcOWHPkDUytV/bsbVsRWxmp7N6VdyNzhZlz6yZn/1T9VhVkPtjiHjncdXAwpMSoSjac+jYx68eqPDKknWcgneRbigSwlE3+aSX489rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=ueIPMt2J; dkim-atps=neutral; spf=pass (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=ueIPMt2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=2001:cf8:acf:41::7; helo=jpms-ob01-os7.noc.sony.co.jp; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [IPv6:2001:cf8:acf:41::7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLT140HrWz3054
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 12:53:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1757386440; x=1788922440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aUbLhIfV5VjpL5YovpOYu/z3oJbNX5W3wr2EvQXergg=;
  b=ueIPMt2JwrWLpffjL0wSnd4yhaneAJe+C/rROPgRT09NXsVjaWSQnpIi
   lcl75pedpJr+DnDlXik2a5aowgx/EsJgWkAAO5Fg5jrJFubWAgdXMa2Qh
   JUeVb8ZTay0n5l5sBj+nzeQfu+1bcvSZGt402da3xNKHlhGDPqK45TZ1W
   yAn0i6+WQTL69rmpa1+OVrHv2wwaSZKZ4felmLnH5/RYv6cHSVMIQxmb8
   l9lgGSho+PLBxGwuU2yN0+11x5e5qizwIv3oUVKnL3wpPaa9hl+Sc+D1z
   jtWS+8GiGmvVC+y4N5mhp6q1QZQ0UCYFH/Ts4zGiIqBKqUXoeEjjhcR8h
   g==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 11:53:53 +0900
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="30246382"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 09 Sep 2025 11:53:53 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
Date: Tue,  9 Sep 2025 10:52:48 +0800
Message-ID: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
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
5. Fix memory leak by calling erofs_put_super().
   In main(), erofs_read_superblock() is called only to get the block
   size. In erofs_mkfs_rebuild_load_trees(), erofs_read_superblock()
   is called again, causing sbi->devs to be overwritten without being
   released.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
---
 lib/compress.c | 2 ++
 lib/inode.c    | 3 +++
 lib/rebuild.c  | 2 +-
 mkfs/main.c    | 3 ++-
 4 files changed, 8 insertions(+), 2 deletions(-)

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
index 7ee6b3d..0882875 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	} else {
 		free(inode->i_link);
 	}
+
+	if (inode->chunkindexes)
+		free(inode->chunkindexes);
 	free(inode);
 	return 0;
 }
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 0358567..18e5204 100644
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
diff --git a/mkfs/main.c b/mkfs/main.c
index 28588db..bcde787 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1702,6 +1702,7 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 		mkfs_blkszbits = src->blkszbits;
+		erofs_put_super(src);
 	}
 
 	if (!incremental_mode)
@@ -1908,7 +1909,7 @@ exit:
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


