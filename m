Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF845B9B25
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 14:42:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSxgS6wktz3byL
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 22:42:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=yMB1ygNr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=yMB1ygNr;
	dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSxgN6Cyfz3bpr
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 22:42:40 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so17228806pgb.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=t5M7NGDngN2+Zs7ekggybVds5iPQe8oTPjWTdXRHUpI=;
        b=yMB1ygNra22/dbB0LtinX5144RnJbP9QRbAMuXVq5qwgke2ZDqiUIlIkg373jaw409
         ky5nHLN+VRcOUPJKsbcqA6nX6ejCJDGnV/EZJx9Mdqiuc1HnEaMEwLMr0iCRD0aIftj+
         L7Trba18ZKseDR23Wwn2d0kJP/GdzkOvXi8Ao1b5rZ4NOf8X63ggOtslfSgJ3eN0csts
         sKDusv3Mk0t0UUcRn+Bze7XLFmwVgjmv8Pn7Q7iW2gy5ZKCSjy9trv3ugk6E24JZPoYb
         l9gPP7E67+SsDIvX8LXpLpLW98y4QmgeuyDvyp3a5Pp6srZEK71u4IBrHSKl+eKM3Suk
         Wemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t5M7NGDngN2+Zs7ekggybVds5iPQe8oTPjWTdXRHUpI=;
        b=mbCMuf6B+PwfUGm91e7V7fpNnHBLK+ItGPGNkVO+J/BkNoMUvt3LeMsYL4eo2jfVjz
         SLz0zesZ51LrLrBOEpk69UAnjgR1MYtYRBMDO7NVbTsFjamxcTzdagJXOzIqyiYl0kcU
         56W64vnngK0KJ1Gkc6WXI4mDowulKhvcfvnJ5JLME5B3T2qGugG+H24wD8ZuCEWfWtJ2
         EEgEge6PdRfYrf4AabIo/1TVRdBoXOfYstZZwsSx6m3ok6kWYLiyqlwch9QURSGpdl/3
         y/2lX5FfGpP1IkVTxKX3NvvAAKqThwoEWFahIXEV9UlxXzQUS5QZuUsi/Sz7DBOjPTCN
         A5AQ==
X-Gm-Message-State: ACgBeo13RPHXTmFxFeihXgifnniMqEyCxA8GstVkNPOSqBY8F8duOoSt
	2HP5QChU9tUulLkNYT39LqPCAtuZsWCzRA==
X-Google-Smtp-Source: AA6agR6/XAjdH9+npfmFldAa27FSTWW5L+DsOFy757wu75dK8NFSHbGVIh2sRGCJTxkzf4PehyCZ/g==
X-Received: by 2002:a63:8848:0:b0:434:b5d7:b4fa with SMTP id l69-20020a638848000000b00434b5d7b4famr35413685pgd.181.1663245757953;
        Thu, 15 Sep 2022 05:42:37 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:37 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V4 2/6] erofs: code clean up for fscache
Date: Thu, 15 Sep 2022 20:42:09 +0800
Message-Id: <20220915124213.25767-3-zhujia.zj@bytedance.com>
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

Some cleanups. No logic changes.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 36 ++++++++++++++++++------------------
 fs/erofs/internal.h | 17 ++++++++---------
 fs/erofs/super.c    | 22 +++++++++-------------
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..d72e2a7ea6ab 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -417,9 +417,8 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -428,7 +427,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -458,40 +457,32 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 		ctx->inode = inode;
 	}
 
-	*fscache = ctx;
-	return 0;
+	return ctx;
 
 err_cookie:
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
-	ctx->cookie = NULL;
 err:
 	kfree(ctx);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
-	struct erofs_fscache *ctx = *fscache;
-
 	if (!ctx)
 		return;
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
-	ctx->cookie = NULL;
-
 	iput(ctx->inode);
-	ctx->inode = NULL;
-
 	kfree(ctx);
-	*fscache = NULL;
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct fscache_volume *volume;
+	struct erofs_fscache *fscache;
 	char *name;
 	int ret = 0;
 
@@ -502,12 +493,19 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	volume = fscache_acquire_volume(name, NULL, NULL, 0);
 	if (IS_ERR_OR_NULL(volume)) {
 		erofs_err(sb, "failed to register volume for %s", name);
-		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
-		volume = NULL;
+		kfree(name);
+		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
 	}
 
 	sbi->volume = volume;
 	kfree(name);
+
+	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
+	/* acquired volume will be relinquished in kill_sb() */
+	if (IS_ERR(fscache))
+		return PTR_ERR(fscache);
+
+	sbi->s_fscache = fscache;
 	return ret;
 }
 
@@ -515,6 +513,8 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
+	erofs_fscache_unregister_cookie(sbi->s_fscache);
 	fscache_relinquish_volume(sbi->volume, NULL, false);
+	sbi->s_fscache = NULL;
 	sbi->volume = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..aa71eb65e965 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -610,27 +610,26 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode);
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode);
+void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
-static inline int erofs_fscache_register_cookie(struct super_block *sb,
-						struct erofs_fscache **fscache,
-						char *name, bool need_inode)
+static inline
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
 {
 }
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9716d355a63e..79e871c04fe2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -224,10 +224,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			     struct erofs_device_info *dif, erofs_off_t *pos)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct block_device *bdev;
 	void *ptr;
-	int ret;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
 	if (IS_ERR(ptr))
@@ -245,10 +245,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
-				dif->path, false);
-		if (ret)
-			return ret;
+		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
+		if (IS_ERR(fscache))
+			return PTR_ERR(fscache);
+		dif->fscache = fscache;
 	} else {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
@@ -706,11 +706,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 
-		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
-						    sbi->opt.fsid, true);
-		if (err)
-			return err;
-
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
@@ -817,7 +812,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-	erofs_fscache_unregister_cookie(&dif->fscache);
+	erofs_fscache_unregister_cookie(dif->fscache);
+	dif->fscache = NULL;
 	kfree(dif->path);
 	kfree(dif);
 	return 0;
@@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
 	kfree(sbi);
@@ -909,7 +904,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
+	erofs_fscache_unregister_fs(sb);
+	sbi->s_fscache = NULL;
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.20.1

