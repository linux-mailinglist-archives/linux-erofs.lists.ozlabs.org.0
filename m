Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D274D5976
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:17:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFCMW42BBz30Gd
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 15:17:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646972263;
	bh=yXHN+D41TnM4dqddPeGTfM+bvOgnt5H9D7bI4rAFNGM=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=gEb5guR//djjhDglPqMLZw4TX57An2n1f5xP0SNBs1euHNHsXFSHhp62PlSbK8x2R
	 lPZ08ALRPzvEfKEpZKY7KEzMg1I3ahTstu3lPjMrRl2DiStaNhadCfyVp1/CdeDk0f
	 b5J7OzNGBMvdRCaN3Wb5NqHXtbayoewle+jsWDDWvOPiiC3+72LMYjBrlcqvgfBUjl
	 oUz0Q7VtS3GIbqerECcqnQUDbJgFN4iZuLHw4pIn1qXv6buOvc02D87O9fzHVnBQW3
	 1SAeZ42VOYXlDBrJ4MCRWqXZUbZNhyAsC9Nr6TwYd1G7Rdu3VzykdHlAhKwDglK43Y
	 c05mnJSu/t2NQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3w80qygckc7gbtylbcpemmejc.amkjglsv-cpmdqjgqrq.mxjyzq.mpe@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=TI3xjZ+c; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFCMK6sW7z2xTq
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 15:17:33 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id
 o133-20020a25738b000000b0062872621d0eso6389988ybc.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 20:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=yXHN+D41TnM4dqddPeGTfM+bvOgnt5H9D7bI4rAFNGM=;
 b=73XLQeTF4bH8KWMtSR1L4/WSPwHEAXLhl1LasemBrY6xbgiimYiK0YRD53wf2TPvoA
 XKhv2F+p9vLh3dN0w/7ISEfut/u0KjmT0qdd+lt2mst4Mag1/Ht3AaI4tQwVx0DGycIN
 g3BEHmIhDEiH5ADjZ266G3wtZAda9eVZ14pkd2TwlAKdnCJuPMF0WmCuaQNKI1hVwcgB
 tmwBUfqaA5tIZdYfmPD0ONukdKbIuTZwTvz7d5QK4naId0dyOQaXTlzmBnpnOq9zDfez
 Buge4ULY/K720qyjuenkT+UBnoAvlmYbDHPR32ZPKxzXK32b6M5cwjOlr3bwWVQY1tF0
 dXeg==
X-Gm-Message-State: AOAM532HmxY12KdTkw8OVoQvxFFX/Jym1gy8lklSzFiYlgbHewUKH0dy
 xDxqv5VvVdLVUo3swxpLr/a90B8T4cPc1ubJgXGw9vzpvIqlmPjSRC61ddwxwmTCbOYI+af/i6L
 o9YPR9XVZjfA4/aOLSczdt7BymQh/5hx8nFWlQAVcaezqgEC4QsiTVhQUyXndTKOHRbXWW08l
X-Google-Smtp-Source: ABdhPJzyFmaMR9aPb7Mc7bUMJ87FTsHOSbmbApsnfgqbQp0HQ58jbNs/gUWUrSfCN+HBDrPG+HJhPIbBoraN
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5102])
 (user=dvander job=sendgmr) by 2002:a25:3c3:0:b0:628:8065:f4ba with SMTP id
 186-20020a2503c3000000b006288065f4bamr6449319ybd.97.1646972251121; Thu, 10
 Mar 2022 20:17:31 -0800 (PST)
Date: Fri, 11 Mar 2022 04:17:24 +0000
In-Reply-To: <20220311041724.3107622-1-dvander@google.com>
Message-Id: <20220311041724.3107622-2-dvander@google.com>
Mime-Version: 1.0
References: <20220311041724.3107622-1-dvander@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 2/2] erofs-utils: mkfs: use mtime instead of ctime
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Change the default timestamp behavior to use modification time rather
than creation time. This will allow more control over the output
timestamps when not using TIMESTAMP_FIXED.

EROFS_FEATURE_COMPAT_MTIME has been added so tooling can detect the
change in timestamp behavior.

Signed-off-by: David Anderson <dvander@google.com>
---
 dump/main.c        | 1 +
 include/erofs_fs.h | 1 +
 lib/inode.c        | 4 ++--
 mkfs/main.c        | 8 +++++---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 6565d35..72761bd 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -84,6 +84,7 @@ struct erofsdump_feature {
 
 static struct erofsdump_feature feature_lists[] = {
 	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
+	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
 	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index e01f5c7..7956a62 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -13,6 +13,7 @@
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME		0x00000002
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
diff --git a/lib/inode.c b/lib/inode.c
index 24f2567..c9fdda1 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -806,8 +806,8 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
-	inode->i_mtime = st->st_ctime;
-	inode->i_mtime_nsec = ST_CTIM_NSEC(st);
+	inode->i_mtime = st->st_mtime;
+	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
diff --git a/mkfs/main.c b/mkfs/main.c
index 3f34450..b1ed187 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -421,6 +421,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid,
 				  erofs_blk_t *blocks)
 {
+	int compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
+		EROFS_FEATURE_COMPAT_MTIME;
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = LOG_BLOCK_SIZE,
@@ -431,8 +433,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = sbi.xattr_blkaddr,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
-		.feature_compat = cpu_to_le32(sbi.feature_compat &
-					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.feature_compat = cpu_to_le32(sbi.feature_compat & ~compat),
 		.extra_devices = cpu_to_le16(sbi.extra_devices),
 		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
@@ -511,7 +512,8 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_legacy_compress = false;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
-	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
+	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
+			     EROFS_FEATURE_COMPAT_MTIME;
 
 	/* generate a default uuid first */
 #ifdef HAVE_LIBUUID
-- 
2.35.1.723.g4982287a31-goog

