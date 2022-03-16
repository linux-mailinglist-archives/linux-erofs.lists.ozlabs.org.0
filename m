Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A84DB109
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 14:18:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJW6n6nnYz3bVY
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 00:18:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJW6T4QMzz30Jm
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 00:17:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7NEPqz_1647436665; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7NEPqz_1647436665) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 21:17:46 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 15/22] erofs: register cookie context for bootstrap blob
Date: Wed, 16 Mar 2022 21:17:16 +0800
Message-Id: <20220316131723.111553-16-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Registers fscache_cookie for the bootstrap blob file. The bootstrap blob
file can be specified by a new mount option, which is going to be
introduced by a following patch.

Something worth mentioning about the cleanup routine.

1. The init routine is prior to when the root inode gets initialized,
and thus the corresponding cleanup routine shall be placed under
.kill_sb() callback.

2. The init routine will instantiate anonymous inodes under the
super_block, and thus .put_super() callback shall also contain the
cleanup routine. Or we'll get "VFS: Busy inodes after unmount." warning.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 32aaa5ee5e14..cce39339c08e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -75,6 +75,7 @@ struct erofs_mount_opts {
 	unsigned int max_sync_decompress_pages;
 #endif
 	unsigned int mount_opt;
+	char *uuid;
 };
 
 struct erofs_dev_context {
@@ -152,6 +153,8 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+
+	struct erofs_fscache_context *bootstrap;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 798f0c379e35..8c5783c6f71f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -598,6 +598,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
+	if (!erofs_bdev_mode(sb)) {
+		struct erofs_fscache_context *bootstrap;
+
+		bootstrap = erofs_fscache_get_ctx(sb, ctx->opt.uuid, true);
+		if (IS_ERR(bootstrap))
+			return PTR_ERR(bootstrap);
+
+		sbi->bootstrap = bootstrap;
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -753,6 +763,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 
 	erofs_free_dev_context(sbi->devs);
+	erofs_fscache_put_ctx(sbi->bootstrap);
 	fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -771,6 +782,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_put_ctx(sbi->bootstrap);
+	sbi->bootstrap = NULL;
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

