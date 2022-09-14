Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890615B86A9
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 12:51:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSHFP2SN4z306K
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 20:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cn0ZpcYX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cn0ZpcYX;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSHFH6wBjz306r
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 20:51:15 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id t3so14742693ply.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=imR5y18ryUCktyAigdc0+MY99yMqYjGRbnJ4cSNTikw=;
        b=cn0ZpcYXk/kqyPdR7OatSX13r/+Xy1i+0/HByaAP+/RcxVpTb8RPtcj5PBdQtxtVlS
         C64alLZznwcghZj0W56bhfqoJUlA8XEOV10Ou1ZNweI//KGA6sHUs//7EeH2oVxaeyfD
         UiKpQ9n71whV8rE5+5TveZz+clfw4t0IWD1tRVEmKlnu3b4xfM1Nmt5GxGigmZIUNwRP
         GPjL7zQYDipgVCtACzlZ9IWv1FBkDYpGuHKckZ0d4czUntdG3yRUE8W086F9IAKJfzZG
         dt+48ozwedhEpIY+yhPYsQeXC3ryQ4SIGmk4i0XT7ArcnMP/R9OnIApGc1Tz5Qh2p6gl
         SSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=imR5y18ryUCktyAigdc0+MY99yMqYjGRbnJ4cSNTikw=;
        b=eHNYB31Sm0wiCluLabl23XypIH7PAvKt8O3xb+kqfGoucAIyzE3Toy516ym3tPhoJA
         g7SnmSnAvMKhNaB4JKo9rgRkuf8qoEMW91aN8dSI9w2VYfS559OQbFQZMRsqXRpdHEQz
         EVB0Xr3OIVCb12VfxLOSinWcqFtZxickS8WJma8em9TULCVwt4gj9A+zQpP0iNjZphY/
         pFJ8WpXULEg9Alj9Ggd4bhtGI4OUMPeCvuHTcOMLO3h3VvwmeR/St2tAuF15jiRuXOWY
         FR6V7OaJiiBb77b+YA9fvYclrIZqA4BOlZ0MWzhKVSB9IpiBdcrQ6k2+4rW4yIhhHMJI
         KUtw==
X-Gm-Message-State: ACgBeo3LDSlhwdIzHPrdFI1PCf4moV9R2MyLTms8vigs6afkSU3gBOV3
	zl0/NTt82IIefT0+JNTEJE+YNM3JxKHHRP6dNh8HNQ==
X-Google-Smtp-Source: AA6agR74HSXRqf39Tac77t/yqR9dwmYkhneSUTjl4+pqYGMp1qcuCe6wUhi5W957o2Y5Qu/FYox1Mg==
X-Received: by 2002:a17:902:edd5:b0:174:a6e6:51f4 with SMTP id q21-20020a170902edd500b00174a6e651f4mr36165450plk.82.1663152673277;
        Wed, 14 Sep 2022 03:51:13 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:51:12 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V3 6/6] erofs: Support sharing cookies in the same domain
Date: Wed, 14 Sep 2022 18:50:41 +0800
Message-Id: <20220914105041.42970-7-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

Users could specify domain_id mount option to create or join into a
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 89 +++++++++++++++++++++++++++++++++++++++++++--
 fs/erofs/internal.h |  4 +-
 2 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4e0a441afb7d..e9ae1ee963e2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
+static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
@@ -504,7 +505,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 
 	domain->volume = sbi->volume;
 	refcount_set(&domain->ref, 1);
-	mutex_init(&domain->mutex);
 	list_add(&domain->list, &erofs_domain_list);
 	return 0;
 out:
@@ -534,8 +534,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 	return err;
 }
 
-struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -585,13 +585,96 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
+static
+struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
+							char *name, bool need_inode)
+{
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+
+	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
+	if (IS_ERR(ctx))
+		return ctx;
+
+	ctx->name = kstrdup(name, GFP_KERNEL);
+	if (!ctx->name)
+		return ERR_PTR(-ENOMEM);
+
+	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
+	if (!inode) {
+		kfree(ctx->name);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
+	erofs_fscache_domain_get(domain);
+	return ctx;
+}
+
+static
+struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
+{
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
+
+	mutex_lock(&erofs_domain_cookies_lock);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx)
+			continue;
+		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
+			igrab(inode);
+			mutex_unlock(&erofs_domain_cookies_lock);
+			return ctx;
+		}
+	}
+	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
+	mutex_unlock(&erofs_domain_cookies_lock);
+	return ctx;
+}
+
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (sbi->opt.domain_id)
+		return erofs_domain_register_cookie(sb, name, need_inode);
+	else
+		return erofs_fscache_acquire_cookie(sb, name, need_inode);
+}
+
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
+	struct erofs_domain *domain;
+
 	if (!ctx)
 		return;
+	domain = ctx->domain;
+	if (domain) {
+		mutex_lock(&erofs_domain_cookies_lock);
+		/* Cookie is still in use */
+		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
+			iput(ctx->anon_inode);
+			mutex_unlock(&erofs_domain_cookies_lock);
+			return;
+		}
+		iput(ctx->anon_inode);
+		kfree(ctx->name);
+		mutex_unlock(&erofs_domain_cookies_lock);
+	}
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
+	erofs_fscache_domain_put(domain);
 	ctx->cookie = NULL;
 
 	iput(ctx->inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4dd0b545755a..8a6f94b27a23 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -101,7 +101,6 @@ struct erofs_sb_lz4_info {
 
 struct erofs_domain {
 	refcount_t ref;
-	struct mutex mutex;
 	struct list_head list;
 	struct fscache_volume *volume;
 	char *domain_id;
@@ -110,6 +109,9 @@ struct erofs_domain {
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
-- 
2.20.1

