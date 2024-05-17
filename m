Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A88F58C8457
	for <lists+linux-erofs@lfdr.de>; Fri, 17 May 2024 11:57:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U+Ci/E41;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vgj6v0lDNz30VR
	for <lists+linux-erofs@lfdr.de>; Fri, 17 May 2024 19:57:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U+Ci/E41;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vgj6m0WgWz2xjM
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 May 2024 19:57:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715939816; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hdb/3TvARJVZ7RhOX63ITgXZ/E5Lk4N24+C/9grOEmc=;
	b=U+Ci/E41PF/xqnRab1QfZiNmUjD9shSgASCMJFPgZZhXGq2Vj9EOpLVWLzcp8/hzF67gcz70diwEFSRhWwlPOreQPPY5Y0PnveY28BDPjsZnKfy416NdlrzEO3ROXoSMA6N0QNmJeB9G5NRAl3xw47SERMVspjw2L72XAbRtKZg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eF9U7_1715939813;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W6eF9U7_1715939813)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:56:55 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up erofs_show_options()
Date: Fri, 17 May 2024 17:56:52 +0800
Message-Id: <20240517095652.2282972-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Avoid unnecessary #ifdefs and simplify the code a bit.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 ---
 fs/erofs/super.c    | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..16097d95501a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -64,15 +64,12 @@ enum {
 };
 
 struct erofs_mount_opts {
-#ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
 	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
 	unsigned int sync_decompress;
-
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
-#endif
 	unsigned int mount_opt;
 };
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 69308fd73e4a..14822642e2f6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -948,26 +948,14 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
 	struct erofs_mount_opts *opt = &sbi->opt;
 
-#ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(opt, XATTR_USER))
-		seq_puts(seq, ",user_xattr");
-	else
-		seq_puts(seq, ",nouser_xattr");
-#endif
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(opt, POSIX_ACL))
-		seq_puts(seq, ",acl");
-	else
-		seq_puts(seq, ",noacl");
-#endif
-#ifdef CONFIG_EROFS_FS_ZIP
-	if (opt->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
-		seq_puts(seq, ",cache_strategy=disabled");
-	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
-		seq_puts(seq, ",cache_strategy=readahead");
-	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
-		seq_puts(seq, ",cache_strategy=readaround");
-#endif
+	if (IS_ENABLED(CONFIG_EROFS_FS_XATTR))
+		seq_puts(seq, test_opt(opt, XATTR_USER) ?
+				",user_xattr" : ",nouser_xattr");
+	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
+		seq_puts(seq, test_opt(opt, POSIX_ACL) ? ",acl" : ",noacl");
+	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+		seq_printf(seq, ",cache_strategy=%s",
+			  erofs_param_cache_strategy[opt->cache_strategy].name);
 	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
-- 
2.39.3

