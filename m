Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E85B9B28
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 14:42:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSxgZ2xQWz3bZC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 22:42:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=CHGyfbuD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=CHGyfbuD;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSxgW3XwGz3c18
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 22:42:47 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id c2so18228040plo.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=N+8Ic9syGTC1u0a/MXotLVtHNCtWkf7iFn7tvbMZmlY=;
        b=CHGyfbuDxEYsmMOBtJ5Xs/wDe6c91lFi6Xew7HSn99TcDb2lO22OKPoyVOtbn3MS/1
         Bo73PbLBArqJ0Sa+pDi19plOEapcqrlfeXff+lTxwRhp3tH9lnBF0OR2sS0KjbuhfAp9
         n2/LkHyiCaKigFN/GBELZWSLM9R3IacTlcu7eptgFVKWJak3WylBP3MkZGRvTXL41DBO
         2RxDXhpjM91fR9BWYAkfEy1m51pLajgNOvLpoTBOBQ9bSImNQJZ14NuOdV4MLu1oQOQ+
         kuiTkouHlmwyNkmGXfSiiDkhPLDlOgtsTWyg3vXtG7wz9yxvM4tF1D5kKGDrGi7/XE/9
         FIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N+8Ic9syGTC1u0a/MXotLVtHNCtWkf7iFn7tvbMZmlY=;
        b=Hr3pSKWdyqiDhRVQFqjCmH2ZrsrzUtSBX00B1BZgPIclw4AovrvHTmt5AfAEeZXhrm
         W/tWFnc3ibZEz57kuNLhokGiDDSpovBHRwCt0xYprKOdR8+xRpAGmgKDbYQKT64364nR
         Jm6z9LlSV6+Q1sgR2H6F1V2ui87LYLsh4mLc80ozeTnk/fkP9LsPpbQLgd4rA7Ihd0gA
         KEYFfgBRbp2OYLPNL+dKS6+cqVeOhhwoqUw2tShHbmNujnGJ5eCMIEflb93mcXcR1jNQ
         8WQpkgfgxSNPyUhYlTi/RLyh9Fed465XsSjUdqTsXdJYXxaPwO6uxllRxxTsXcjabNJ/
         PBAQ==
X-Gm-Message-State: ACrzQf3vNhwzF76zMt27DLntyVtBFknsbJVkG2gP22bvFCORvtHFS4CQ
	hcmZMxbeBoHzR5s+ulKBF8NwM/FBMgRzxg==
X-Google-Smtp-Source: AMsMyM6LaCBySorEeXuS16yk8C5aL7BUcb/n97QGo/YbEfpMk60hXSn1IPytvrKulSbxhuXVxleeFg==
X-Received: by 2002:a17:90a:c70b:b0:200:4366:d047 with SMTP id o11-20020a17090ac70b00b002004366d047mr10660743pjt.240.1663245765338;
        Thu, 15 Sep 2022 05:42:45 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:44 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V4 4/6] erofs: introduce a pseudo mnt to manage shared cookies
Date: Thu, 15 Sep 2022 20:42:11 +0800
Message-Id: <20220915124213.25767-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use a pseudo mnt to manage shared cookies.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 13 +++++++++++++
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 31 +++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 10d3f0511f15..ff8382df493e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -8,6 +8,7 @@
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
+static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
@@ -429,6 +430,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
 		fscache_relinquish_volume(domain->volume, NULL, false);
+		if (list_empty(&erofs_domain_list)) {
+			kern_unmount(erofs_pseudo_mnt);
+			erofs_pseudo_mnt = NULL;
+		}
 		mutex_unlock(&erofs_domain_list_lock);
 		kfree(domain->domain_id);
 		kfree(domain);
@@ -482,6 +487,14 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	if (err)
 		goto out;
 
+	if (!erofs_pseudo_mnt) {
+		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
+		if (IS_ERR(erofs_pseudo_mnt)) {
+			err = PTR_ERR(erofs_pseudo_mnt);
+			goto out;
+		}
+	}
+
 	domain->volume = sbi->volume;
 	refcount_set(&domain->ref, 1);
 	list_add(&domain->list, &erofs_domain_list);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7f0939f4005b..88c1a46867b3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -402,6 +402,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 79e871c04fe2..24bac58285e8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -676,6 +676,13 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
+static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+
+	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -776,6 +783,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+static int erofs_fc_anon_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
+}
+
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
@@ -844,10 +856,20 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
+static const struct fs_context_operations erofs_anon_context_ops = {
+	.get_tree       = erofs_fc_anon_get_tree,
+};
+
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	struct erofs_fs_context *ctx;
+
+	if (fc->sb_flags & SB_KERNMOUNT) {
+		fc->ops = &erofs_anon_context_ops;
+		return 0;
+	}
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
@@ -874,6 +896,11 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_litter_super(sb);
+		return;
+	}
+
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -908,7 +935,7 @@ static void erofs_put_super(struct super_block *sb)
 	sbi->s_fscache = NULL;
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

