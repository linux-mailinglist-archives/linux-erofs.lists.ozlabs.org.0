Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E943D5AA68D
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkR95Mdbz2yx8
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xBMouZC6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xBMouZC6;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkR31K9Tz2xYy
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:30 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so941308pjc.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sr2Wd6yR3mz5619cIGOwnPXQ5QeGOidAclAniAYTKBQ=;
        b=xBMouZC6OH2kkJpibOv1tQN8zSxENxxC5h2KVWxPL6H+zCGNOmaLDbOH0jvTSwyQL4
         7YxXghf2j9Q8nZ9Huczr/yDQh7mq87u2l7kvXp6M/YTK2sDi1sga9WpObRGgaUzBVg7d
         Abpkz/lBP1r38UWwG9XZ8/901g631Ds0DxRJEhdHzYXt+Ch/cMsNSLxlnnEaVFgn5HWo
         y6nsGvLTOmHp4bB4zyMbYvcAcomCpVhxQmK/O8Q9NlKWamVsbqCc8GiLqjOiZxHc9l03
         65nq0v+DC3eKV7MjAg6iA5UC2nE4cj16cFdl8FDdsiZGgd6x3YxdS0sEZp9NjcsmRvRm
         WOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sr2Wd6yR3mz5619cIGOwnPXQ5QeGOidAclAniAYTKBQ=;
        b=NN3auAdq0iWFxBBAlwc9Ni3eR2I3ixLLtDPg2Zhmty9W8cCkxzeTcp/YTh/4LSwYf6
         oq8oh3SLnqIrRSjKKvabTEqU4oOpn8pcc+B5pAIzc4gCWvy8VjKDVZTjP1xs6yKVMQf0
         YgqYeEPTMtFrMwWYFZ33kxqxOB6X/N+CZOVt0JSm7XiOVoS9TGyha85U+Qr4/3v/7Az6
         91/kQVpw/ad8s+KlXhjsm4fAy1uXiiNKFqBQU4WRhgJU5W1LG3u5aPsT66eqWONoaaHp
         KdncpkH7kFfwG47Y6Oai+56Ytwk8IjykF80/N7rveQyuFQBssswTep1BoFbOz3dZVYYD
         lNWg==
X-Gm-Message-State: ACgBeo2beDIpzW/W+OqYyrvMJwl90LY+11GtPAetPUnFBUdk9hU26Nu7
	czJS8zPUlb6KU3LnNZ6CuImSZHil3619/g==
X-Google-Smtp-Source: AA6agR7y/khiEhfD/7DQ3kLKGorQklRk5KRNHXJoxoQsLBObMQE1F4fe4ivJ7i3X+3CAzpY6ZSFh+g==
X-Received: by 2002:a17:902:ea01:b0:175:458e:65be with SMTP id s1-20020a170902ea0100b00175458e65bemr10290462plg.25.1662090508746;
        Thu, 01 Sep 2022 20:48:28 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:28 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 5/5] erofs: support fscache based shared domain
Date: Fri,  2 Sep 2022 11:47:48 +0800
Message-Id: <20220902034748.60868-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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

Users could specify domain_id mount option to create or join into a domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 13 +++++++++
 fs/erofs/super.c    | 10 +++++--
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bf6c9ecabec1..07e5d71e412b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -569,6 +569,8 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 
 	if (!ctx)
 		return;
+	if (ctx->domain && !refcount_dec_and_test(&ctx->ref))
+		return;
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
@@ -576,7 +578,12 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 
 	iput(ctx->inode);
 	ctx->inode = NULL;
+	iput(ctx->anon_inode);
+	ctx->anon_inode = NULL;
+	erofs_fscache_domain_put(ctx->domain);
 
+	kfree(ctx->name);
+	ctx->name = NULL;
 	kfree(ctx);
 	*fscache = NULL;
 }
@@ -616,3 +623,63 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 	sbi->volume = NULL;
 	sbi->domain = NULL;
 }
+
+static int erofs_fscache_domain_init_cookie(struct super_block *sb,
+		struct erofs_fscache **fscache, char *name, bool need_inode)
+{
+	int ret;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+
+	ret = erofs_fscache_register_cookie(sb, &ctx, name, need_inode);
+	if (ret)
+		return ret;
+
+	ctx->name = kstrdup(name, GFP_KERNEL);
+	if (!ctx->name)
+		return -ENOMEM;
+
+	inode = new_inode(domain->mnt->mnt_sb);
+	if (!inode) {
+		kfree(ctx->name);
+		return -ENOMEM;
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
+	refcount_set(&ctx->ref, 1);
+	erofs_fscache_domain_get(domain);
+	*fscache = ctx;
+	return 0;
+}
+
+int erofs_domain_register_cookie(struct super_block *sb,
+	struct erofs_fscache **fscache, char *name, bool need_inode)
+{
+	int err;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+	struct super_block *psb = domain->mnt->mnt_sb;
+
+	mutex_lock(&domain->mutex);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx)
+			continue;
+		if (!strcmp(ctx->name, name)) {
+			*fscache = ctx;
+			refcount_inc(&ctx->ref);
+			mutex_unlock(&domain->mutex);
+			return 0;
+		}
+	}
+	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
+	mutex_unlock(&domain->mutex);
+
+	return err;
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7240a2acaa5c..25e5031ca878 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,8 +109,12 @@ struct erofs_domain {
 };
 
 struct erofs_fscache {
+	refcount_t ref;
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
@@ -626,6 +630,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
+int erofs_domain_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
@@ -647,6 +654,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
 {
 	return -EOPNOTSUPP;
 }
+static inline int erofs_domain_register_cookie(struct super_block *sb,
+						struct erofs_fscache **fscache,
+						char *name, bool need_inode)
+{
+	return -EOPNOTSUPP;
+}
 
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 667a78f0ee70..11c5ba84567c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -245,8 +245,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
-				dif->path, false);
+		if (sbi->opt.domain_id)
+			ret = erofs_domain_register_cookie(sb, &dif->fscache, dif->path,
+					false);
+		else
+			ret = erofs_fscache_register_cookie(sb, &dif->fscache, dif->path,
+					false);
 		if (ret)
 			return ret;
 	} else {
@@ -726,6 +730,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			err = erofs_fscache_register_domain(sb);
 			if (err)
 				return err;
+			err = erofs_domain_register_cookie(sb, &sbi->s_fscache,
+					sbi->opt.fsid, true);
 		} else {
 			err = erofs_fscache_register_fs(sb);
 			if (err)
-- 
2.20.1

