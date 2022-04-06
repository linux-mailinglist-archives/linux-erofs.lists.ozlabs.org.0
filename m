Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51C4F5713
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Apr 2022 09:56:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYH0S2Rd8z2yn1
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Apr 2022 17:56:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYH0G0SZVz3bWm
 for <linux-erofs@lists.ozlabs.org>; Wed,  6 Apr 2022 17:56:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V9LC885_1649231794; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9LC885_1649231794) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 15:56:35 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 14/20] erofs: register fscache context for primary data blob
Date: Wed,  6 Apr 2022 15:56:06 +0800
Message-Id: <20220406075612.60298-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Registers fscache context for primary data blob. Also move the
initialization of s_op and related fields forward, since anonymous
inode will be allocated under the super block when registering the
fscache context.

Something worth mentioning about the cleanup routine.

1. The fscache context will instantiate anonymous inodes under the super
block. Release these anonymous inodes when .put_super() is called, or
we'll get "VFS: Busy inodes after unmount." warning.

2. The fscache context is initialized prior to the root inode. If
.kill_sb() is called when mount failed, .put_super() won't be called
when root inode has not been initialized yet. Thus .kill_sb() shall
also contain the cleanup routine.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3a4a344cfed3..eb37b33bce37 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -155,6 +155,7 @@ struct erofs_sb_info {
 
 	/* fscache support */
 	struct fscache_volume *volume;
+	struct erofs_fscache *s_fscache;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6590ed1b7d3b..9498b899b73b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -585,6 +585,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_op = &erofs_sops;
 
 	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 		erofs_err(sb, "failed to set erofs blksize");
@@ -605,6 +608,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = erofs_fscache_register_fs(sb);
 		if (err)
 			return err;
+
+		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
+						    sbi->opt.fsid, true);
+		if (err)
+			return err;
 	}
 
 	err = erofs_read_superblock(sb);
@@ -619,11 +627,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			clear_opt(&sbi->opt, DAX_ALWAYS);
 		}
 	}
-	sb->s_flags |= SB_RDONLY | SB_NOATIME;
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_time_gran = 1;
 
-	sb->s_op = &erofs_sops;
+	sb->s_time_gran = 1;
 	sb->s_xattr = erofs_xattr_handlers;
 
 	if (test_opt(&sbi->opt, POSIX_ACL))
@@ -763,6 +768,7 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -781,6 +787,7 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

