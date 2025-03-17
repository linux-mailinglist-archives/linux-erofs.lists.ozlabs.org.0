Return-Path: <linux-erofs+bounces-77-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A25A64020
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Mar 2025 06:49:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGPD72Gbqz2ySZ;
	Mon, 17 Mar 2025 16:48:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742190535;
	cv=none; b=BQlCiXcOXNEqjOb9cIZu7d2/HtgdNBUQRon82KtlDhLhN7Me38UxzNxjReD81DqWZ3/c2KkRxgvz4XZP9LinJ2OYng5x/0uvht4SQHjJVrPHuH2vDq+hbhMX6usaDXAczJz5SjweaD41P8o7CGW/eSWFivk9Bi0Qy/NP56DyLXxBud4EuS7iLZGf+e+pJ6s4dPxP/u6tQHVK2zw5+RVYPM9os4WJLbUtxKfOdMekvKBpVgwffwS1TXBpTnEnOYNHVsvRWvx4vJ2GReeLvXJzCOKVIL+COnKDMrjB4y1pojt82dXsiqio0jhMEqunLZhEHySyPVEdIZJPwz5bnAvVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742190535; c=relaxed/relaxed;
	bh=JH/MtI7nWIdLEx6Tsg9Uphc5JkLI9ry7g3+yzUJaGuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISYfwgVGP+cmfvJBYWh3nlWcqaImLlZOrp7I8rp1n7vzLXmupXNAsppT0jFEbW97pupDCHvCVPeh2eHVpE/CohZeBB3LRBFZZ4d7yUrPx2Toun4oPJkN18XMd9k4QjWWXjq9opKnpW/T0Sb13O3onCOvp5NCHoOaiDKJLxT03k26N3HFNNY4z7yPwxxo4PGayOO98lLMPt+Vu9vcw0HDVhewhdTsGPSTAwa40Bm1lKXxwnFqvJUbLxWdDndyC1WL4ZYubKacdBiPPqDbMK3RS+BlJw8gPAit8SGPhNHeAQiG40n/yiFUCa+1wHdPS4izZ520y+t415FqCy5H68h/qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l+JPYyMe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l+JPYyMe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGPD534Fqz2xdL
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Mar 2025 16:48:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742190527; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JH/MtI7nWIdLEx6Tsg9Uphc5JkLI9ry7g3+yzUJaGuM=;
	b=l+JPYyMeLqCXyKUfKGaeN9Sc3u+qWEA2cCpBbhYYuEQ9iRLGvnnCPIoG6La1dYfgDaT1SUtiZqMVUh2v2ANwfLdP5fOObKGYduyQMGFnnkP6NNRSjV6OCfCZWfBnfybVxePY4r74u1us/iXIMq1jWCW7q6ylgDXfqMjSeBQ6T8I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRZQaGx_1742190521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 13:48:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 06/10] erofs: initialize decompression early
Date: Mon, 17 Mar 2025 13:48:40 +0800
Message-ID: <20250317054840.3483000-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250316170729.2325406-1-hsiangkao@linux.alibaba.com>
References: <20250316170729.2325406-1-hsiangkao@linux.alibaba.com>
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

 - Rename erofs_init_managed_cache() to z_erofs_init_super();
 - Move the initialization of managed_pslots into z_erofs_init_super() too;
 - Move z_erofs_init_super() and packed inode preparation upwards, before
   the root inode initialization.

Therefore, the root directory can also be compressible.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Chao Yu <chao@kernel.org>
---
v3:
 - should handle both .put_super() and .kill_sb(), otherwise VFS will
   report "VFS: Busy inodes after unmount of ..."

 fs/erofs/internal.h |  4 ++--
 fs/erofs/super.c    | 46 ++++++++++++++++++++++-----------------------
 fs/erofs/zdata.c    |  4 ++--
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 91d0b400459c..b35742cf9431 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -436,6 +436,7 @@ int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
+int z_erofs_init_super(struct super_block *sb);
 unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
@@ -445,7 +446,6 @@ void z_erofs_put_gbuf(void *ptr);
 int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
-int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
@@ -454,7 +454,7 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
-static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
+static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 18445dc8597d..563da5213032 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -636,9 +636,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -650,24 +657,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -803,6 +797,16 @@ static int erofs_init_fs_context(struct fs_context *fc)
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
@@ -812,6 +816,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
@@ -822,17 +827,10 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
-	DBG_BUGON(!sbi);
-
+	erofs_drop_internal_inodes(sbi);
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
-#ifdef CONFIG_EROFS_FS_ZIP
-	iput(sbi->managed_cache);
-	sbi->managed_cache = NULL;
-#endif
-	iput(sbi->packed_inode);
-	sbi->packed_inode = NULL;
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e4b65070b86..bc6d6842c5c2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -644,18 +644,18 @@ static const struct address_space_operations z_erofs_cache_aops = {
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
2.43.5


