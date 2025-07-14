Return-Path: <linux-erofs+bounces-613-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145CB03AFA
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 11:39:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgcjY0B0dz3bsM;
	Mon, 14 Jul 2025 19:39:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752485984;
	cv=none; b=Z+KxXnTX8XsDHoGv4vQsUyxixVbyX8shHL79rV1ghqoAapMiYjglyEqTNa99+j563Azpcjkr6DrIKBPmhmmbedTkTCuwz7aVnufYqmIsnBbg8YSmJpcGY3bX128FxLE221ZIkKeczb6CVRzEDlg4vbJjVqlDWRqnoDE2by/YKZm33wOGUAzl37kd8NjNyEbb1l0v/mbh9An+KQvYV/x6HG1XdixQDpQNgFxwV+iaD4FZZxBltvvVkABiNw8IaUF7XGkfx6JPtOw9znIAWHYHaaEsTBgut/iqP8wMZWu8wH0I1uppc+rnXRLWOCzfAaCZp4jLqBAX77SBDr0HRFshJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752485984; c=relaxed/relaxed;
	bh=zNm2/1s55g68H47obpXRJTWJGopAdliR0XEPK9/4LPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMtRg3LXossiVkbSo6usHm4C1NkZiAWaDfJQVy5dUt/9CjFbj2hbErTj1xuTRBpNUVZP5JX/1hUvGGrA1fJenh4LuPK3bW/Qf2GtG0lTZJX4M7li6HWnIyrkCYVOU8z/IUnros1T8Ub2lASGzixLyfQzrSHFqIp03jPuTO6ZBdzx5U/k2QbqS+7VoHZcNHZaHg2mGp0fNEa4FRbtRnN4OXHCRrhvRTSCt/3BuJ92JIly2E4Bkah0ozYNKXhPPChxmeLEd6QxP3bG3VsuwgZEu9ZE0o39IZKCx9dVKuHrrXTorhPvmFzqrAJdgYat2MR+56vPLF0Ikowf2sVFJxAV0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lg9+S2UT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lg9+S2UT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgcjX2C5Qz3bqQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 19:39:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AD8545EA4;
	Mon, 14 Jul 2025 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BFC4CEED;
	Mon, 14 Jul 2025 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752485982;
	bh=cQ0TpDO9ZCOEo8C3OLkJivTCTe9XM5S/iXQQdJiXaQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=lg9+S2UTu8r1DfSFfWgiSttKR4mGPbsogToufb1yH4UYTqHgfmYM9qgSiH/PSlm6a
	 dkCWpi/Hkc5RN8oOgA5LDiLXurN5oe7L2XLFhjfF/Wt5B5sE0ugbs/pulsTSpigeGV
	 YGLu3ncijh/24AMqk6fR9eZkG4V5u3qqKPXrWzSmEIhX8i5QD59VEsUONHEEcbZwHt
	 lV20tOG4xqyargOpayFDiH9RU2RbcpQt099Q1P0VPDUc5dogsnXlgGw1M28G1tN/Rc
	 ZAM3bjysKI88DmYLq/kWCZyyoSD5ajtARtVl6eqgtA9GSC8L/XbzthdoYxbyO3S8wB
	 J4l92Nm7UfOEw==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Mon, 14 Jul 2025 17:39:35 +0800
Message-ID: <20250714093935.200749-1-chao@kernel.org>
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

Meanwhile, let's introduces a new sysfs entry to control readahead
bytes to provide more flexible policy for readahead of readdir().
- location: /sys/fs/erofs/<disk>/dir_ra_bytes
- default value: 16384
- disable readahead: set the value to 0

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- add EROFS prefix for macro
- update new sysfs interface to 1) use bytes instead of pages
2) remove upper boundary limitation
- fix bug of pageidx calculation
 Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
 fs/erofs/dir.c                           | 13 +++++++++++++
 fs/erofs/internal.h                      |  4 ++++
 fs/erofs/super.c                         |  2 ++
 fs/erofs/sysfs.c                         |  2 ++
 5 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bf3b6299c15e..85fa56ca092c 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -35,3 +35,11 @@ Description:	Used to set or show hardware accelerators in effect
 		and multiple accelerators are separated by '\n'.
 		Supported accelerator(s): qat_deflate.
 		Disable all accelerators with an empty string (echo > accel).
+
+What:		/sys/fs/erofs/<disk>/dir_ra_bytes
+Date:		July 2025
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	Used to set or show readahead bytes during readdir(), by
+		default the value is 16384.
+
+		- 0: disable readahead.
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 3e4b38bec0aa..950d6b0046f4 100644
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
 
@@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		}
 
+		/* readahead blocks to enhance performance in large directory */
+		if (EROFS_I_SB(dir)->dir_ra_bytes) {
+			unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
+			pgoff_t ra_pages = DIV_ROUND_UP(
+				EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
+
+			if (nr_pages - idx > 1 && !ra_has_index(ra, idx))
+				page_cache_sync_readahead(dir->i_mapping, ra,
+					f, idx, min(nr_pages - idx, ra_pages));
+		}
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..4399b9332307 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -157,6 +157,7 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+	erofs_off_t dir_ra_bytes;
 
 	/* fscache support */
 	struct fscache_volume *volume;
@@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
+/* default readahead size of directory */
+#define EROFS_DIR_RA_BYTES	16384
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1e9f06e8342..38fc4813a896 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -715,6 +715,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	sbi->dir_ra_bytes = EROFS_DIR_RA_BYTES;
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index eed8797a193f..9d9f820a5621 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -65,12 +65,14 @@ EROFS_ATTR_FUNC(drop_caches, 0200);
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
 EROFS_ATTR_FUNC(accel, 0644);
 #endif
+EROFS_ATTR_RW_UI(dir_ra_bytes, erofs_sb_info);
 
 static struct attribute *erofs_sb_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
 	ATTR_LIST(drop_caches),
 #endif
+	ATTR_LIST(dir_ra_bytes),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_sb);
-- 
2.49.0


