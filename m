Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386F6DAEB8
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6l2FzDz3fYB
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6T6qVCz3fVv
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfXA6.c_1680877034;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfXA6.c_1680877034)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/7] erofs: move packed inode out of the compression part
Date: Fri,  7 Apr 2023 22:17:06 +0800
Message-Id: <20230407141710.113882-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

packed inode could be used in more scenarios which are independent of
compression in the future.

For example, packed inode could be used to keep extra long xattr
prefixes with the help of following patches.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 +-
 fs/erofs/super.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index caea9dc1cd82..8b5168f94dd2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,8 +134,8 @@ struct erofs_sb_info {
 	struct inode *managed_cache;
 
 	struct erofs_sb_lz4_info lz4;
-	struct inode *packed_inode;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 325602820dc8..8f2f8433db61 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -810,7 +810,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
-#ifdef CONFIG_EROFS_FS_ZIP
 	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
 		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
 		if (IS_ERR(sbi->packed_inode)) {
@@ -819,7 +818,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return err;
 		}
 	}
-#endif
 	err = erofs_init_managed_cache(sb);
 	if (err)
 		return err;
@@ -986,9 +984,9 @@ static void erofs_put_super(struct super_block *sb)
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
+#endif
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
-#endif
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
-- 
2.19.1.6.gb485710b

