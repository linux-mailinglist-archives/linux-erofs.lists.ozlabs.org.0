Return-Path: <linux-erofs+bounces-607-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B2B034FA
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 05:35:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgScf10Trz3bnm;
	Mon, 14 Jul 2025 13:34:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752464098;
	cv=none; b=Z7h9Bmw1I/Gsk5i52D3qnuScn2pzJPf8a38IdSg04NY0+lhVNbsF7ep8KEStlUWE1zPb2AC2Q5y18aKRamxNxzqLfEM/DakbIqpj9zYNMK2u1Fbvw2kgXnf62yIrhyFB62+lXVquUYYRn60eVsg192GrHSNRsxqWBEIruaQ7w7IL3BDNFItYOk4g94hRo1Hh1gEwLPAaOYVwcx/YZXBOCl11xNYsZfZK0p0gfmGNKj2mL6nDL6UnXATlSXC/adNiI9Aj197lIPhagzNKoeZglIZCP1ks/x78ynDmJ5V7DahHNxb+ZTCEGjj40jpjpg4H7HzfYixVrpMzx3eYU2inFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752464098; c=relaxed/relaxed;
	bh=mLsO1oAiv0Bmw4CsWRmHeIiwhFRYHdvsgV1MS8vSP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFXZTxqGSCUKI/FLgPHOOnNiju2ik/KNuFZ8z7ZWwAfVkVJ/yQRKiPzPJgGHqacVtZxe5QmwrIUOUbCNIeRSJvpjYsUl2eJ8w+XMkjKqIMPtABmY7z0Pplm/Bkme6QmeFZ0Y12xhnWntLMsRcsOdf9CEi+feZFAAvieAFvI7xGiDreqbxXhXJoLiZrybS9qPzO0UWH9G53404dnJQU5tDbGaUka5nd2ZDoAH05GXE+VnGgxFdOEBYMyplog2zmxiDMf0nbQctrokqNvMndpv/TnxzwQkGMOQwgPYoRCoaJNMM6jvt8D2kb0GDdtlCB2qzSXwV6l2RtfP4gpphExBdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qXnOOLTB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qXnOOLTB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgScd0vhfz3bnc
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 13:34:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D1D7A43456;
	Mon, 14 Jul 2025 03:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054EEC4CEED;
	Mon, 14 Jul 2025 03:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752464094;
	bh=YN4t5xHEpPx0nNpI6pE0WEIohgqiEWkY1UOtRx031Xs=;
	h=From:To:Cc:Subject:Date:From;
	b=qXnOOLTBaT9TIIHBL9tztRDFePFG4/S/A+HOF/c6S3wmXvWQGuqC4vKpSohOUtapq
	 4TaeL5PgSDNSY2KeS3VyNmDU8EAqsuu3sSQiSgUvWp0otRfoJ8IkSk7y+iXsKuYCw5
	 Kuj23kmuGLb9cN9joNC3HTIv33DQ2zu7aQFkvZOqCkaErPv/UQ/d0PNJVTlbJdQwuK
	 syw99F6gUV2tVzisbIryf4VVRFSFNGtgGwvSJXcR9jy5J47AV2HAuFVEAMaYSZOQom
	 vXeHdstNzgJ26odalb09YsCF0gm45JH+d825yteWZfGs8GiLaaKtYuaZscA4HMBGAd
	 XqENvzn94njGA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Mon, 14 Jul 2025 11:34:49 +0800
Message-ID: <20250714033450.58298-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch supports to readahead more blocks in erofs_readdir(), it can
enhance readdir performance in large direcotry.

readdir test in a large directory which contains 12000 sub-files.

		files_per_second
Before:		926385.54
After:		2380435.562

Meanwhile, let's introduces a new sysfs entry to control page count
of readahead to provide more flexible policy for readahead of readdir().
- location: /sys/fs/erofs/<disk>/dir_ra_pages
- default value: 4
- range: [0, 128]
- disable readahead: set the value to 0

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- introduce sysfs node to control page count of readahead during
readdir().
 Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
 fs/erofs/dir.c                           | 9 +++++++++
 fs/erofs/internal.h                      | 5 +++++
 fs/erofs/super.c                         | 2 ++
 fs/erofs/sysfs.c                         | 5 +++++
 5 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bf3b6299c15e..500c93484e4c 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -35,3 +35,10 @@ Description:	Used to set or show hardware accelerators in effect
 		and multiple accelerators are separated by '\n'.
 		Supported accelerator(s): qat_deflate.
 		Disable all accelerators with an empty string (echo > accel).
+
+What:		/sys/fs/erofs/<disk>/dir_ra_pages
+Date:		July 2025
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Used to set or show page count of readahead during readdir(),
+		the range of value is [0, 128], by default it is 4, set it to
+		0 to disable readahead.
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 3e4b38bec0aa..40f828d5b670 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
+	struct file_ra_state *ra = &f->f_ra;
 	unsigned long bsz = sb->s_blocksize;
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
+	unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
 	int err = 0;
 	bool initial = true;
 
@@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		}
 
+		/* readahead blocks to enhance performance in large directory */
+		if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&
+		    !ra_has_index(ra, dbstart))
+			page_cache_sync_readahead(dir->i_mapping, ra, f,
+				dbstart, min(nr_pages - dbstart,
+				(pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..f0e5b4273aa8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -157,6 +157,7 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+	unsigned int dir_ra_pages;
 
 	/* fscache support */
 	struct fscache_volume *volume;
@@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
+/* default/maximum readahead pages of directory */
+#define DEFAULT_DIR_RA_PAGES	4
+#define MAX_DIR_RA_PAGES	128
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..90e5ec04a768 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -715,6 +715,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	sbi->dir_ra_pages = DEFAULT_DIR_RA_PAGES;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index eed8797a193f..3e47084e8730 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -65,12 +65,14 @@ EROFS_ATTR_FUNC(drop_caches, 0200);
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
 EROFS_ATTR_FUNC(accel, 0644);
 #endif
+EROFS_ATTR_RW_UI(dir_ra_pages, erofs_sb_info);
 
 static struct attribute *erofs_sb_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
 	ATTR_LIST(drop_caches),
 #endif
+	ATTR_LIST(dir_ra_pages),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_sb);
@@ -171,6 +173,9 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
 			return -EINVAL;
 #endif
+		if (!strcmp(a->attr.name, "dir_ra_pages") &&
+		    (t > MAX_DIR_RA_PAGES))
+			return -EINVAL;
 		*(unsigned int *)ptr = t;
 		return len;
 	case attr_pointer_bool:
-- 
2.49.0


