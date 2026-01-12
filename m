Return-Path: <linux-erofs+bounces-1818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E523D10801
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 04:43:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqJBq06Ysz2yY9;
	Mon, 12 Jan 2026 14:43:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768189426;
	cv=none; b=KPhQKLM3PX0wC+jTJmhJN/A6nMM+NkOJsLOQx1760Q6AC+3NgKEpY59L8ffIhj7Hy1hDtXa5M7/hgcAgt9b8DzkdJc6hEp6WXEdKAhiPm2HmB38A7ZZ/1b3QxjwGVIYmQCVz5/wRMZbuIeFu5Mg8dvkWutybG3Wo+F+QCPbhlDaRR2Id+R9MgYUb7Kj3ZuwrJ5ZgmuiEUEMRBRHQDhvP7WdRO7Ghs+bQHkszZEYgsEmXQG40z5V3S3Brduyp7cpCH1SABGfpwICV3W5aaU3xJsgQ3OdE8Bp6PPrdp9Hfv7/mg7sJ15Gr+SW+lffo/4119okrqaho38JQGgDEUKQcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768189426; c=relaxed/relaxed;
	bh=fcD6lxrDQmpimeq1+NcWJZC2p8y038Y9kp/asgOJYQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLQIDb8q8FkGF727Cgxc51Lu/z+Qn4plN1yNKnb9J01drTtWR9KeSzFVVsXix2qEk7yJIQxE1jXY5FLM6ZuxryUoVSFFKL+LLxiMQQbQU0QTCuE9VsV3Bijr48JPo6IOjnMo6fc187KYZ13KulyG/djthMer5uXCIVaamASbVdUZ9BwGcR+CBRH4Gz/aMs7x8rnIPC75oMXJM0ta8C2Cc3W8OYorDkBwo8dAAK0OL+DaCbfTM0S02L0ymGJDmD9SeWaxD6Z3ZG241hEzTDisuyFmmmCQ2PdevTNt3TAZkWLpPREgZoyrDb5rpLZ2I4PNM/hH3M+h+1U9H3tIiv1RLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cea5YZGA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cea5YZGA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqJBl1VM1z2yY1
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 14:43:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768189416; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fcD6lxrDQmpimeq1+NcWJZC2p8y038Y9kp/asgOJYQI=;
	b=cea5YZGANjy9BilWGHFsMJk/TrnPOtI4NFL/skm2tba8J2kChEFww5r8vg+yxPqGs2X6q15WbYS8aIQeKwc3DRn0g5IZ2lPkUsA9oQcfS+ya8caH+DUFTZ5UYO3BqCiidbijTlbURrio9A8ti7oKltnFBagjUU97YQl8l/LSQAA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwnmgzf_1768189411 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:43:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: tidy up synchronous decompression
Date: Mon, 12 Jan 2026 11:43:30 +0800
Message-ID: <20260112034330.2263034-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - Get rid of `sbi->opt.max_sync_decompress_pages` since it's fixed as
   3 all the time;

 - Add Z_EROFS_MAX_SYNC_DECOMPRESS_BYTES in bytes instead of in pages,
   since for non-4K pages, 3-page limitation makes no sense;

 - Move `sync_decompress` to sbi to avoid unexpected remount impact;

 - Fold z_erofs_is_sync_decompress() into its caller;

 - Better description of sysfs entry `sync_decompress`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 14 ++++++----
 fs/erofs/internal.h                      |  5 +---
 fs/erofs/super.c                         |  3 +-
 fs/erofs/sysfs.c                         |  2 +-
 fs/erofs/zdata.c                         | 35 +++++++++---------------
 5 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 76d9808ed581..b9243c7f28d7 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -10,12 +10,16 @@ Description:	Shows all enabled kernel features.
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
 Contact:	"Huang Jianan" <huangjianan@oppo.com>
-Description:	Control strategy of sync decompression:
+Description:	Control strategy of synchronous decompression. Synchronous
+		decompression tries to decompress in the reader thread for
+		synchronous reads and small asynchronous reads (<= 12 KiB):
 
-		- 0 (default, auto): enable for readpage, and enable for
-		  readahead on atomic contexts only.
-		- 1 (force on): enable for readpage and readahead.
-		- 2 (force off): disable for all situations.
+		- 0 (auto, default): apply to synchronous reads only, but will
+		                     switch to 1 (force on) if any decompression
+		                     request is detected in atomic contexts;
+		- 1 (force on): apply to synchronous reads and small
+		                asynchronous reads;
+		- 2 (force off): disable synchronous decompression completely.
 
 What:		/sys/fs/erofs/<disk>/drop_caches
 Date:		November 2024
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..87edbb4366d1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -59,10 +59,6 @@ enum {
 struct erofs_mount_opts {
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
-	unsigned int sync_decompress;
-	/* threshold for decompression synchronously */
-	unsigned int max_sync_decompress_pages;
 	unsigned int mount_opt;
 };
 
@@ -116,6 +112,7 @@ struct erofs_sb_info {
 	/* managed XArray arranged in physical block number */
 	struct xarray managed_pslots;
 
+	unsigned int sync_decompress;	/* strategy for sync decompression */
 	unsigned int shrinker_run_no;
 	u16 available_compr_algs;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..9f90d410ab94 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -372,8 +372,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
 	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	sbi->opt.max_sync_decompress_pages = 3;
-	sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
+	sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&sbi->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 1e0658a1d95b..86b22b9f0c19 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -59,7 +59,7 @@ static struct erofs_attr erofs_attr_##_name = {			\
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
 #ifdef CONFIG_EROFS_FS_ZIP
-EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+EROFS_ATTR_RW_UI(sync_decompress, erofs_sb_info);
 EROFS_ATTR_FUNC(drop_caches, 0200);
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..f07f9db3b019 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -9,6 +9,7 @@
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
 
+#define Z_EROFS_MAX_SYNC_DECOMPRESS_BYTES	12288
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS		2
 
@@ -1095,21 +1096,6 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 	return err;
 }
 
-static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
-				       unsigned int readahead_pages)
-{
-	/* auto: enable for read_folio, disable for readahead */
-	if ((sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO) &&
-	    !readahead_pages)
-		return true;
-
-	if ((sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON) &&
-	    (readahead_pages <= sbi->opt.max_sync_decompress_pages))
-		return true;
-
-	return false;
-}
-
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
 	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
@@ -1483,9 +1469,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 #else
 		queue_work(z_erofs_workqueue, &io->u.work);
 #endif
-		/* enable sync decompression for readahead */
-		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
-			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
+		/* See `sync_decompress` in sysfs-fs-erofs for more details */
+		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1802,16 +1788,21 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
-static int z_erofs_runqueue(struct z_erofs_frontend *f, unsigned int rapages)
+static int z_erofs_runqueue(struct z_erofs_frontend *f, unsigned int rabytes)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
-	bool force_fg = z_erofs_is_sync_decompress(sbi, rapages);
+	int syncmode = sbi->sync_decompress;
+	bool force_fg;
 	int err;
 
+	force_fg = (syncmode == EROFS_SYNC_DECOMPRESS_AUTO && !rabytes) ||
+		(syncmode == EROFS_SYNC_DECOMPRESS_FORCE_ON &&
+			(rabytes <= Z_EROFS_MAX_SYNC_DECOMPRESS_BYTES));
+
 	if (f->head == Z_EROFS_PCLUSTER_TAIL)
 		return 0;
-	z_erofs_submit_queue(f, io, &force_fg, !!rapages);
+	z_erofs_submit_queue(f, io, &force_fg, !!rabytes);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	err = z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
@@ -1932,7 +1923,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	(void)z_erofs_runqueue(&f, nrpages);
+	(void)z_erofs_runqueue(&f, nrpages << PAGE_SHIFT);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.43.5


