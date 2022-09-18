Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B05BBBAA
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 06:35:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MVZjr02qbz3bSW
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 14:35:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Omx/AStH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Omx/AStH;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MVZjb3GZPz2xKh
	for <linux-erofs@lists.ozlabs.org>; Sun, 18 Sep 2022 14:35:15 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id v1so25071585plo.9
        for <linux-erofs@lists.ozlabs.org>; Sat, 17 Sep 2022 21:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=Omx/AStHDVgnuuMGtA4QKr8D4JqpEFOSMifYkwBBlHe5o2WFqrLFvpkUGRUzNT2u52
         KWe9paJQb/9+2gFTAcFqwH51Cj90SXr4tPwhda/E+I8BXJr9sMfeUfyvzdQP4NAbZJ/e
         4qqePmzMtQ5SC505Mr0+rywrt2rxERFPQ741ma8WrotmJSyBtBRZw5epbrrFyyD3YMmQ
         zOWc3+8K+codgL0X8nwLfBLvTXmAUZw/G5Yed7TFhiSn1beadVMkVeleSlYKgqw/y+fQ
         jrwK5KKqgLbA64eqoIEi27bN3He+bbIGj59ZYufIo+FyiaIVvPrTvxRYo8cZAvUgbG5z
         HI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=aPoXolRMGpjg/+sYlZaMhQfQIycWkx2i+pMwt1iQioAxomgmAJCSXCkPrenqlexA19
         LoRyXMJxW7ONPP8nKF7ZkOj3t8IypML4vTnAv9azYsWv4TbwhG4om5/+Ta0n2euP+eQf
         NGH+qt2317u7m3nw8SL0X3WrGbbt7u2AVhhDTipKR4CDLIiUdv+AXjrkJgq1AxIuffAA
         0Pi3ObNX0hGv06dlWVkZYtLbfpimRcqlcdYKY0aCwXx1kUz8/JFoHgpYg4hw5HaF7l88
         NotwGyjLZDQGRqB3zx2QcwlNjNsgMAJF+uFY1gAtWnNnygVD9tokWGpJ1h9v2JgZ4EZJ
         hHBg==
X-Gm-Message-State: ACrzQf12hPW5sqG7cwrvLwtc02wuM0Zh1OLfrI9vl+B7dN0Bf58p/Ylt
	LsLt4Cb0hwywjAwNVQqjjsUhKrm0LFbnLCft
X-Google-Smtp-Source: AMsMyM5oX0r429mRm3f6dArn+jaI0JIlsOoInPWK9gObBdp0a+c0KzhrT2Q03NIVwGJ3ziTbgCjuAA==
X-Received: by 2002:a17:90a:e7d1:b0:200:94fd:967a with SMTP id kb17-20020a17090ae7d100b0020094fd967amr13055990pjb.57.1663475712889;
        Sat, 17 Sep 2022 21:35:12 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:12 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V6 4/6] erofs: introduce a pseudo mnt to manage shared cookies
Date: Sun, 18 Sep 2022 12:34:54 +0800
Message-Id: <20220918043456.147-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 13 +++++++++++++
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 9c82284e66ee..4a7346b9fa73 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -8,6 +8,7 @@
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
+static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
@@ -428,6 +429,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
+		if (list_empty(&erofs_domain_list)) {
+			kern_unmount(erofs_pseudo_mnt);
+			erofs_pseudo_mnt = NULL;
+		}
 		mutex_unlock(&erofs_domain_list_lock);
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		kfree(domain->domain_id);
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
index 4c11313a072f..273fb35170e2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -402,6 +402,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 884e7ed3d760..ab746181ae08 100644
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
@@ -844,10 +856,21 @@ static const struct fs_context_operations erofs_context_ops = {
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
+	/* pseudo mount for anon inodes */
+	if (fc->sb_flags & SB_KERNMOUNT) {
+		fc->ops = &erofs_anon_context_ops;
+		return 0;
+	}
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
@@ -874,6 +897,12 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	/* pseudo mount for anon inodes */
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_anon_super(sb);
+		return;
+	}
+
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -907,7 +936,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

