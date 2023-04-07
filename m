Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F56DAEB2
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6Z5vWnz3fXJ
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6Q6FJPz3fSD
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX8evk_1680877033;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX8evk_1680877033)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:13 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/7] erofs: initialize packed inode after root inode is assigned
Date: Fri,  7 Apr 2023 22:17:05 +0800
Message-Id: <20230407141710.113882-3-jefflexu@linux.alibaba.com>
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

As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
fill_super()"), move the initialization of packed inode after root
inode is assigned, so that the iput() in .put_super() is adequate as
the failure handling.

Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
fails halfway.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2bcff3194e4a..caea9dc1cd82 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -157,6 +157,7 @@ struct erofs_sb_info {
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
+	erofs_nid_t packed_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 58ffbf410bfb..325602820dc8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -388,17 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
-#ifdef CONFIG_EROFS_FS_ZIP
-	sbi->packed_inode = NULL;
-	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
-		sbi->packed_inode =
-			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
-		if (IS_ERR(sbi->packed_inode)) {
-			ret = PTR_ERR(sbi->packed_inode);
-			goto out;
-		}
-	}
-#endif
+	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
@@ -820,6 +810,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
+#ifdef CONFIG_EROFS_FS_ZIP
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
+		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
+		if (IS_ERR(sbi->packed_inode)) {
+			err = PTR_ERR(sbi->packed_inode);
+			sbi->packed_inode = NULL;
+			return err;
+		}
+	}
+#endif
 	err = erofs_init_managed_cache(sb);
 	if (err)
 		return err;
-- 
2.19.1.6.gb485710b

