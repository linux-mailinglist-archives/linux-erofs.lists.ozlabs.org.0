Return-Path: <linux-erofs+bounces-275-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFBAAA10D
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 00:43:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZrxPd0zCwz2xrJ;
	Tue,  6 May 2025 08:43:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746484981;
	cv=none; b=IvmJ/WRVW/aDLAZX8HYoqEgGfPbZKbxGJu421wQMXuP4MDIs53TnlfiHZZYz0PPsBjXmsWeP4kYH8YuyU52sXBrXX3oFgEJJNgkTGk8n6kyO2Dc9MvqyULrTDfcDlO4gCpZ+8FlSYc7LTKeyc3MddRDhsIkUDMYi49Od5vwlPBrVbClhApHGKZZ5vP2qJ0+lUMnqxlY4c6KE2AgNI2euB8YIrXH188h0TIg8SPlsXFuVHpZJAtkK2lXnr+lCPSaiXS02dH4QC8/V8mCiVMcRxGhRQedY3TNvFI31ejDiKSl/N6hi/75WxFtd4fCVnn/vml/GaHtMSlxsDVDdVRKmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746484981; c=relaxed/relaxed;
	bh=cmxLPzDbAqP0SnYwFIOIN6SRDvH6axd2dlcfAK0tNXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/RaTWgAwkplvbhOq0GP8TxB6y+DuVY+G0vMLtSrtNhOPwMaNFRMPhbtYLplcMqZ+ITqpb9h2KHSH7T4mBRiGP1rVJplKhPg7FCRivS0ZzmqLVWcVGMNVfN2Jw/YeuFLSBuYq1ao3YzwwHsMNQOcIVNPpWLrpuhPNV7tgJGJRuMWkkJWZNIGOVvwLgASrGpC3koWHIEE8XcNzAHYjqERigiCLLfgE/6/uZJlxxAi+0JnoTc++wb3Gv1FumTSlHm/25ExFOdjWdhQruoNVNCBSCoPprzkPz+rFyObbyutobtCdgPd4JuDszgv09au8pdQskrN5v4k9tmSndkEyXCRjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MbVyNPnA; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MbVyNPnA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZrxPc237jz2xqJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 May 2025 08:43:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4BC3AA4D028;
	Mon,  5 May 2025 22:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3FFC4CEED;
	Mon,  5 May 2025 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484977;
	bh=UKEizzzMsktLF3NcTYi3eQTZ/2D24KrnT2ZJgK1rMWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbVyNPnAUbCAQiArYD3aeFzEuW9GnE+Zcfawx/q9XcfPCz6F3vVlY0Q2kLQpwQgdX
	 hROOF28m3QPH/2qXGtu6+4Zk56431JaDGBbc8wuAa9TOl6x/dC+LADKY8J5n56MdnS
	 7ka5WqxgYG/9OzVId1ARXK1/GV8Cbld6qUjR/ISyVfVZObRzMuurg1GXOvrAbySe0Y
	 WDqbxOV0OC99A848ujZTlfwOIOCwrFFW9eqAI622Evc+emeP606FWvki8Hs+Y3SBoR
	 z3vqldHeemclvZP/O+a6z10zdyKRM9dv3g4eceXh/sYA1ksA3yLTNK0qDfukA9Elt+
	 CqY0Sk0ptt7JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.12 107/486] erofs: initialize decompression early
Date: Mon,  5 May 2025 18:33:03 -0400
Message-Id: <20250505223922.2682012-107-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit fe1e57d44d7f106df9048e815e4862cf63921220 ]

 - Rename erofs_init_managed_cache() to z_erofs_init_super();
 - Move the initialization of managed_pslots into z_erofs_init_super() too;
 - Move z_erofs_init_super() and packed inode preparation upwards, before
   the root inode initialization.

Therefore, the root directory can also be compressible.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20250317054840.3483000-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h |  4 ++--
 fs/erofs/super.c    | 46 ++++++++++++++++++++++-----------------------
 fs/erofs/zdata.c    |  4 ++--
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index edbabb3256c9a..2c11e8f3048e9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -453,6 +453,7 @@ int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
+int z_erofs_init_super(struct super_block *sb);
 unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
@@ -462,7 +463,6 @@ void z_erofs_put_gbuf(void *ptr);
 int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
-int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
@@ -471,7 +471,7 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
-static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
+static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5b279977c9d5d..3421448fef0e3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -664,9 +664,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-#ifdef CONFIG_EROFS_FS_ZIP
-	xa_init(&sbi->managed_pslots);
-#endif
+	err = z_erofs_init_super(sb);
+	if (err)
+		return err;
+
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
+		inode = erofs_iget(sb, sbi->packed_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->packed_inode = inode;
+	}
 
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
@@ -678,24 +685,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		iput(inode);
 		return -EINVAL;
 	}
-
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
-	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
-		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
-		if (IS_ERR(sbi->packed_inode)) {
-			err = PTR_ERR(sbi->packed_inode);
-			sbi->packed_inode = NULL;
-			return err;
-		}
-	}
-	err = erofs_init_managed_cache(sb);
-	if (err)
-		return err;
-
 	err = erofs_xattr_prefixes_init(sb);
 	if (err)
 		return err;
@@ -831,6 +825,16 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
+{
+	iput(sbi->packed_inode);
+	sbi->packed_inode = NULL;
+#ifdef CONFIG_EROFS_FS_ZIP
+	iput(sbi->managed_cache);
+	sbi->managed_cache = NULL;
+#endif
+}
+
 static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -840,6 +844,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
@@ -850,17 +855,10 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
-	DBG_BUGON(!sbi);
-
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
-#ifdef CONFIG_EROFS_FS_ZIP
-	iput(sbi->managed_cache);
-	sbi->managed_cache = NULL;
-#endif
-	iput(sbi->packed_inode);
-	sbi->packed_inode = NULL;
+	erofs_drop_internal_inodes(sbi);
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a8fb4b525f544..cef2aa9226315 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -666,18 +666,18 @@ static const struct address_space_operations z_erofs_cache_aops = {
 	.invalidate_folio = z_erofs_cache_invalidate_folio,
 };
 
-int erofs_init_managed_cache(struct super_block *sb)
+int z_erofs_init_super(struct super_block *sb)
 {
 	struct inode *const inode = new_inode(sb);
 
 	if (!inode)
 		return -ENOMEM;
-
 	set_nlink(inode, 1);
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &z_erofs_cache_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	EROFS_SB(sb)->managed_cache = inode;
+	xa_init(&EROFS_SB(sb)->managed_pslots);
 	return 0;
 }
 
-- 
2.39.5


