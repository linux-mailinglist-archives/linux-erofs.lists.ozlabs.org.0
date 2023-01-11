Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2E66562D
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 09:32:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsLXH6dMfz3ch9
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 19:32:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsLWs685xz3cBj
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 19:32:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMeLr-_1673425925;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMeLr-_1673425925)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 7/7] erofs: introduce 'sharecache' mount option
Date: Wed, 11 Jan 2023 16:31:58 +0800
Message-Id: <20230111083158.23462-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce 'sharecache' mount option to enable page cache sharing in
fscache mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst |  2 ++
 fs/erofs/inode.c                    |  4 ++++
 fs/erofs/internal.h                 |  4 ++++
 fs/erofs/super.c                    | 13 +++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 958cad2c4997..1fe38323a1bb 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -123,6 +123,8 @@ fsid=%s                Specify a filesystem image ID for Fscache back-end.
 domain_id=%s           Specify a domain ID for Fscache back-end.  The blob
                        images are shared among filesystem instances in the same
                        domain.
+(no)sharecache         Enable page cache sharing among filesystem instances in
+                       the same domain.
 ===================    =========================================================
 
 Sysfs Entries
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..31d3ab8443d1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -262,6 +262,10 @@ static int erofs_fill_inode(struct inode *inode)
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		else if (erofs_can_share_page(inode))
+			inode->i_fop = &erofs_fscache_share_file_fops;
+#endif
 		else
 			inode->i_fop = &erofs_file_fops;
 		break;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index adf6be08b47c..c3ac6d613eb1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -181,6 +181,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
+#define EROFS_MOUNT_SHARE_CACHE		0x00000100
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
@@ -373,6 +374,9 @@ static inline bool erofs_can_share_page(struct inode *inode)
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
+	if (!test_opt(&sbi->opt, SHARE_CACHE))
+		return false;
+
 	/* enable page cache sharing only in share domain mode */
 	if (!erofs_is_fscache_mode(inode->i_sb) || !sbi->domain_id)
 		return false;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 835b69c9511b..d05346d34ed8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -456,6 +456,7 @@ enum {
 	Opt_device,
 	Opt_fsid,
 	Opt_domain_id,
+	Opt_sharecache,
 	Opt_err
 };
 
@@ -482,6 +483,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
+	fsparam_flag_no("sharecache",	Opt_sharecache),
 	{}
 };
 
@@ -590,9 +592,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!ctx->domain_id)
 			return -ENOMEM;
 		break;
+	case Opt_sharecache:
+		if (result.boolean)
+			set_opt(&ctx->opt, SHARE_CACHE);
+		else
+			clear_opt(&ctx->opt, SHARE_CACHE);
+		break;
 #else
 	case Opt_fsid:
 	case Opt_domain_id:
+	case Opt_sharecache:
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 		break;
 #endif
@@ -1108,6 +1117,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
+	if (test_opt(opt, SHARE_CACHE))
+		seq_puts(seq, ",sharecache");
+	else
+		seq_puts(seq, ",nosharecache");
 #endif
 	return 0;
 }
-- 
2.19.1.6.gb485710b

