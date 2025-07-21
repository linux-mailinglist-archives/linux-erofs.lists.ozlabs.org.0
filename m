Return-Path: <linux-erofs+bounces-682-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03AB0B9ED
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 04:14:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blkVD3M59z2yZ6;
	Mon, 21 Jul 2025 12:14:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753064052;
	cv=none; b=P5jW5xll0oTbNL4shyywjMzKt1WLNjvOFRDoFNqrDfg0ELLUIwYuSgUNGU3IIESBFo7exuXWHHu0Tvan85brZQjunrl//xJDIosZUkfPUDChX6kZArkK+0y4bTKarIcdxc94ZUaHdL3Dlh71gKdBz1ZO1JR1n8zMt6RjQBuPnGpKWykk+UhnasuxAjdSMO/BCZQhBACakkaAoApXGEBJlVYjVc+MG3Pu+v36YiiMLJ1wAC2WjWadRrR5+aQePKP2TJTJkJsIYYZUieCuinqei/0FaPtGfzNqw8At3kTLjsS2jMT5NLFMas5UvhJIFWGNCiWLfkLLpQ46l/dQ/f7P8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753064052; c=relaxed/relaxed;
	bh=zd8xSIPULHPVfmAxq7ARf2FJdzUDH/wsvW5FDulqCx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ux89lka4s804PUfhR5mJ46/elS1kOper9uBpAsdDXwLMue1fcFtgP+2nl0pDm+hXJpoU0DC+9XREGOObqLqK/HRxhoh9go84qW35QsjNkDB0l6ScwtXf3x88EayFrsmlPXbd+Wtn6gMfC9O2oUZu3J6ChMc5FSjn5xZLO26eyr/fvW/hnvMndQl9ksiuuezyZiwdccqe/5dSG9gSXV35i+WQ/EsCxtUltbCr9f6PDZVxpZJj9LzP8+Y7KdPAekth0Jws1rNJeLSfA9+G4vXxsa7kLfY2N1PYcDxheP0WwrfI2MHw7ljalp9IubPHXTj4yN9qfwtF135+qavEugELKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hN63Xhh9; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hN63Xhh9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blkVC3wkBz2yFP
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 12:14:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 53A125C576A;
	Mon, 21 Jul 2025 02:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A9FC4CEE7;
	Mon, 21 Jul 2025 02:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064049;
	bh=bXdrSCzVGyERWLaj+SxFuNiWIdAvQDaET3Ilr8mDXME=;
	h=From:To:Cc:Subject:Date:From;
	b=hN63Xhh9JT+U1GvHxt65UyY7zvku4uKdxAQbtNBBsa7VcwvlIhS591PS3ph6gJksB
	 YJ1gG0Wd6XyGIHMJgKcRCBx1KH3Kn42L/iunnlGiA+wHcjya/vR4SAL+/LsZnxksvu
	 V0nT3Dx1Qg7erFFv2QF9+ltnBUPfPTY89pmHIHHffTOB01dUxtxiljw+ZOuYWzvsk6
	 XOpBJNOCjVLAWsYGNmtQHe/IN857NaeDfF32zPAb7JayiKi9acVqY196mP1eJG1HVu
	 QPySSZH1kKVo8VReU03vWwp44sFfuD5ptQ+eCJnGsXsbXPFYz6/qYdcLwc85BjwQ4J
	 b5b6IAuzuocKA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Mon, 21 Jul 2025 10:13:52 +0800
Message-ID: <20250721021352.2495371-1-chao@kernel.org>
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
v4:
- clean up codes and comments
 Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
 fs/erofs/dir.c                           | 14 ++++++++++++++
 fs/erofs/internal.h                      |  4 ++++
 fs/erofs/super.c                         |  2 ++
 fs/erofs/sysfs.c                         |  2 ++
 5 files changed, 30 insertions(+)

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
index 3e4b38bec0aa..99745c272b60 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
+	struct file_ra_state *ra = &f->f_ra;
 	unsigned long bsz = sb->s_blocksize;
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
+	pgoff_t ra_pages = DIV_ROUND_UP_POW2(
+			EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
+	pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
 	int err = 0;
 	bool initial = true;
 
@@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		}
 
+		/* readahead blocks to enhance performance in large directory */
+		if (ra_pages) {
+			pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
+			pgoff_t pages = min(nr_pages - idx, ra_pages);
+
+			if (pages > 1 && !ra_has_index(ra, idx))
+				page_cache_sync_readahead(dir->i_mapping, ra,
+							f, idx, pages);
+		}
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..8b1372521790 100644
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
 
+/* default readahead size of directories */
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


