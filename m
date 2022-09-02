Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFB95AACE5
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 12:54:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJvtn6J4Gz2ymS
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 20:54:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tMZC6ljQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tMZC6ljQ;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJvtf3pL9z308B
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 20:54:34 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so5120326pjq.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Sep 2022 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=l4+dx0/DUjpRvb0jfu2V1EYJ8pnYiC4nCrgUYZUGywU=;
        b=tMZC6ljQ/8gi9Jph6jESoxaGzBhUEKBu46ntA4lY1CAjffDzI68/+QKa8mWhfaY+QS
         H6Hdkl5udm0HIOJIVg1gb1BhiE1dz90rQbQ6fBuF+DocdTMwUirhIB4f09RuhIc/62x6
         ty1a0xQSRgl97M8YG/zN4kcx4RODxhXLmNsk26nYWSuYBlzN6CQpjZVvYyR3eqKaOu5B
         Y/XaJfZ91xpqbDUzrAJg4yHkp7BTZQJsvZnj63QDu9081EC9fF/X1lJporKqY/rEaYtx
         UTCalW+4S+hXWiiqMgfJtPHSkP/+OqMFYiVrEzUeTMFTjtLak3MyHuzrHusfYkE7wfqM
         jbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l4+dx0/DUjpRvb0jfu2V1EYJ8pnYiC4nCrgUYZUGywU=;
        b=WFQb+MZJd3Rc5kVNJekBukyyKkxT218Bl693heo03LbEkZarxAg8+oVXkdwNSqPumC
         v9lefd+5YeEmJD/nHN8iLCCyRW9PlIOA/B2LLGk59J+JB6hJavTu9tuHICeeSi/Pp1qJ
         K3R9VN7o2dqf2bdW+EVJisuAW2awZ5U0W/D/udivdUtVlp+v97DcsRoOAqHSOuQJX8de
         aIa8Om99ze5SsnVPsoNbTba2SEPqwcMpJ3IasWsS6YXG2DN/aS3P+rkkGhuEVLOV/LRg
         7mXfd6jZLtllXWaA4Gg9LkLn6FC0kW3D1YfWF9q7Wzk0+A7eFTRy+NwYTrp2X8RoxxtB
         vo6Q==
X-Gm-Message-State: ACgBeo2ztZkP7YOeldLbKC/oa7C+XTYNOOcUoTuSKa0DzuC+rVxObfcP
	1lTUrenUHBzUEtDOLjxm9zE59XTLXWVIMQ==
X-Google-Smtp-Source: AA6agR5ys7kCNuYBLszHsMp707kVrAarVSZrzYdKxepFPo9Ogdt9dOBDXKfD0986/w+xjOMoXqlXOQ==
X-Received: by 2002:a17:902:8e88:b0:172:d1f8:efcb with SMTP id bg8-20020a1709028e8800b00172d1f8efcbmr34060235plb.27.1662116071906;
        Fri, 02 Sep 2022 03:54:31 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:31 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V2 5/5] erofs: support fscache based shared domain
Date: Fri,  2 Sep 2022 18:53:05 +0800
Message-Id: <20220902105305.79687-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
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
 fs/erofs/fscache.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h | 12 ++++++++
 fs/erofs/super.c    | 10 +++++--
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 439dd3cc096a..c01845808ede 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -559,12 +559,27 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 {
 	struct erofs_fscache *ctx = *fscache;
+	struct erofs_domain *domain;
 
 	if (!ctx)
 		return;
+	domain = ctx->domain;
+	if (domain) {
+		mutex_lock(&domain->mutex);
+		/* Cookie is still in use */
+		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
+			iput(ctx->anon_inode);
+			mutex_unlock(&domain->mutex);
+			return;
+		}
+		iput(ctx->anon_inode);
+		kfree(ctx->name);
+		mutex_unlock(&domain->mutex);
+	}
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
+	erofs_fscache_domain_put(domain);
 	ctx->cookie = NULL;
 
 	iput(ctx->inode);
@@ -609,3 +624,61 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
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
+	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
+	if (!inode) {
+		kfree(ctx->name);
+		return -ENOMEM;
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
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
+	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
+
+	mutex_lock(&domain->mutex);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx)
+			continue;
+		if (!strcmp(ctx->name, name)) {
+			*fscache = ctx;
+			igrab(inode);
+			mutex_unlock(&domain->mutex);
+			return 0;
+		}
+	}
+	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
+	mutex_unlock(&domain->mutex);
+	return err;
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2790c93ffb83..efa4f4ad77cc 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -110,6 +110,9 @@ struct erofs_domain {
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
@@ -625,6 +628,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
+int erofs_domain_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
@@ -646,6 +652,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
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

