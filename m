Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AAE4E7328
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 13:23:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQ1TF12p3z3bVZ
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 23:23:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQ1T95G3bz3bXK
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Mar 2022 23:23:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V89qR2m_1648210978; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V89qR2m_1648210978) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 25 Mar 2022 20:22:59 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 22/22] erofs: add 'tag' mount option
Date: Fri, 25 Mar 2022 20:22:23 +0800
Message-Id: <20220325122223.102958-23-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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

Introduce 'tag' mount option to enable on-demand read sementics. In
this case, erofs could be mounted from blob files instead of blkdev.
By then users could specify the name of bootstrap blob file containing
the complete erofs image.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8ac400581784..6ea83f36842c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -403,6 +403,7 @@ enum {
 	Opt_dax,
 	Opt_dax_enum,
 	Opt_device,
+	Opt_tag,
 	Opt_err
 };
 
@@ -427,6 +428,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+	fsparam_string("tag",		Opt_tag),
 	{}
 };
 
@@ -522,6 +524,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
+	case Opt_tag:
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		kfree(ctx->opt.tag);
+		ctx->opt.tag = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.tag)
+			return -ENOMEM;
+#else
+		errorfc(fc, "tag option not supported");
+#endif
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -596,9 +608,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
-	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-		erofs_err(sb, "failed to set erofs blksize");
-		return -EINVAL;
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && erofs_is_nodev_mode(sb)) {
+		sb->s_blocksize = EROFS_BLKSIZ;
+		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+	} else {
+		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
+			erofs_err(sb, "failed to set erofs blksize");
+			return -EINVAL;
+		}
 	}
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
@@ -607,7 +624,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -623,6 +639,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
+
+		sbi->dax_dev = NULL;
+	} else {
+		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -685,6 +705,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.tag)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
 
@@ -734,6 +759,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	struct erofs_fs_context *ctx = fc->fs_private;
 
 	erofs_free_dev_context(ctx->devs);
+	kfree(ctx->opt.tag);
 	kfree(ctx);
 }
 
@@ -774,7 +800,10 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
-	kill_block_super(sb);
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && erofs_is_nodev_mode(sb))
+		generic_shutdown_super(sb);
+	else
+		kill_block_super(sb);
 
 	sbi = EROFS_SB(sb);
 	if (!sbi)
@@ -896,7 +925,10 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+	u64 id = 0;
+
+	if (!IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) || !erofs_is_nodev_mode(sb))
+		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
-- 
2.27.0

