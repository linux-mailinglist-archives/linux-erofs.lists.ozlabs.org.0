Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 847775BA8CC
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 11:00:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTShD3bPsz3bYG
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 19:00:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NrX12gSf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NrX12gSf;
	dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTSh82j21z3blQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 19:00:08 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id t65so19781968pgt.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=NrX12gSf4jM/V8og+yGfMA8n9WCizJr6q4/RjPJveQCFxzOq/adVuIZXBYA/B9vLDt
         0x/1l0dEfCvl2RwRWILujiVCwzHNu6Qc52DlslHRTAUqhUrJ83YIGiiwYJfyFx3ii7wP
         84kROl7lAa2IZv5da5/Wra7jsSE+Nq1JB8i/6MTeT2QHIA4aaH6JNpOUTGiKcpNgc0OZ
         3njd2ohWTBoU+/83MLPTNaxepkYZh9xZLoAafqOjq6XzHKFJiNv/gNb+azEFneT0u7nz
         Ksbul6b3pVvFcy7SifoRae2Lifu+6VDEKSK2psbktytkJALDWk3p4dUZ/MXzph4fWrXg
         rkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=fW/Q2Q3GFH6L6yYFXu2uFhtDZHEzbgvUzB9B65mN9LFzxioU+W9Cq9Z78wyMB1lwH1
         wMkACgRA8E+yypkcPoZOVkNsESb9xnCWKCAIqwR9UYV1YZCsYEFIxV/pBI594hCOFQ+y
         rotTTcftJ0/IG/PQKA50yUZsbKjnjx9rYJd3BH1Nwp4xbVSgPL+v6fp5arO6VPGsVWux
         bX9DIseNVxKrRVPRQh5Es180twQzpjREoHsxgFJWZYdzVUf1za4HhMLq4VOIOOj47C/m
         DYijAQ6SffmgDiKdmLzXwX+mBIsNEOTUfV0WKOeIrGnAFfKqWyZSVhFWtJQKPzdwWz4n
         fNTQ==
X-Gm-Message-State: ACrzQf18SzrH4li7Gusv5GDd7/SEn1XWjACvBci7Z+sRqTLXGOHT6XVe
	5dYjoDFU88BcZcj1inA6Q+q0LSviJjo+9w==
X-Google-Smtp-Source: AMsMyM6uLCJSHd/aLlOffa/l2pS+LnBIaADrHEwm+XOqzcTsyn/mRN93vSiXQewSFGn/YHwiU06BMg==
X-Received: by 2002:a63:ff66:0:b0:434:df48:4c28 with SMTP id s38-20020a63ff66000000b00434df484c28mr3638918pgk.102.1663318805553;
        Fri, 16 Sep 2022 02:00:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:00:05 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V5 4/6] erofs: introduce a pseudo mnt to manage shared cookies
Date: Fri, 16 Sep 2022 16:59:38 +0800
Message-Id: <20220916085940.89392-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
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

