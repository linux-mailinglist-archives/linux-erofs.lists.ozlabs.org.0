Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE85B86A5
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 12:51:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSHFG5WsXz3bls
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 20:51:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zGdqejR9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zGdqejR9;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSHF80MPBz3bqj
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 20:51:07 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id b21so14732186plz.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8McC9dsHojc4NyE65toTstywUmp/NndsAZvxbDSio0Q=;
        b=zGdqejR9YMZ1NQME8AnBkbg16ephrXZmwwVcx2COtNRdsx2dO4n9pAhyd0Krg3/kOe
         woHdAbQ3c/JG+CBmygqmsGziLRmt/T1Pmm6W+e51MkRybekCSU8Tvl1dv3B/p+XOulzN
         KzkGag/2Ilj6YVGwmbQs+z7DDu151i0YZwB+pmUKLgH0FOPzM/9pL5KUY/cexUd5mJz4
         3GPsqpHhHJi7Ed6VtXbpK6hc2NARGq4rTnnn5r+I289urSlN1B0BARQDiNncKU+4C8vp
         fZMvtLE6C8vPA7u1N0dQ8+24V0Ig8TwwW1ali9fpb6D9YqziCVy2Gj69RZer20b0APjU
         iSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8McC9dsHojc4NyE65toTstywUmp/NndsAZvxbDSio0Q=;
        b=0K3hA8CFpIf5h6uZDpYQ0Luq7e5Kx3su8q83TSxB1YcuZA953qqJ8JJogeWYjcPZJh
         s4VeNVZxNPDSl86i7GyqW2nE4R20O4YoYW3UBgwdqURzpJYBa6IlQeJES5Yg3D3iavEz
         OVKKYQ5RzFv5sUsbmOZ2gBcElmIs7jG8uimKPA0lDsD5eLv9XgG2sBzHOkQoyaXwcmV0
         /yjZ8nQEnk829nTrJGdHysan/6SHROynhcjI5Eg9e5KmUZ5os6gBLBynJeMl6+00Zi3/
         ra4lRvM2l3KYZCMzABwQ0VrZ6x4d4BoCvlap+xvyYljrHMpeSSdFla2ygvlsGb1i+yRX
         tQxg==
X-Gm-Message-State: ACrzQf1nRnYTm8rIMv9/7iX0TDUjetTUEkzvA29vcRkn7m0/aTYYGKXa
	ezLnhbXM9F8j74aGxj6mzosgWYc+hG/LeXHMSaZE8Q==
X-Google-Smtp-Source: AMsMyM7Re2VNLh6tWmIDLba8vHJ7cUt5xyjLC++rV5FO5XvDwdSLPNP+RieQ+jTsgtkU4MLbrc2VCw==
X-Received: by 2002:a17:90a:7642:b0:200:4a5e:1227 with SMTP id s2-20020a17090a764200b002004a5e1227mr4019174pjl.91.1663152665397;
        Wed, 14 Sep 2022 03:51:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:51:05 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V3 4/6] erofs: introduce fscache-based domain
Date: Wed, 14 Sep 2022 18:50:39 +0800
Message-Id: <20220914105041.42970-5-zhujia.zj@bytedance.com>
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

A new fscache-based shared domain mode is going to be introduced for
erofs. In which case, same data blobs in same domain will be shared
and reused to reduce on-disk space usage.

As the first step, we use pseudo mnt to manage and maintain domain's
lifecycle.

The implementation of sharing blobs will be introduced in subsequent
patches.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 134 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |   9 +++
 2 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4159cf781924..b2100dc67cde 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2022, Alibaba Cloud
+ * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
 #include "internal.h"
 
+static DEFINE_MUTEX(erofs_domain_list_lock);
+static LIST_HEAD(erofs_domain_list);
+
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -417,6 +421,106 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
+static
+struct erofs_domain *erofs_fscache_domain_get(struct erofs_domain *domain)
+{
+	refcount_inc(&domain->ref);
+	return domain;
+}
+
+static void erofs_fscache_domain_put(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	if (refcount_dec_and_test(&domain->ref)) {
+		fscache_relinquish_volume(domain->volume, NULL, false);
+		mutex_lock(&erofs_domain_list_lock);
+		list_del(&domain->list);
+		mutex_unlock(&erofs_domain_list_lock);
+		kfree(domain->domain_id);
+		kfree(domain);
+	}
+}
+
+static int erofs_fscache_register_volume(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *domain_id = sbi->opt.domain_id;
+	struct fscache_volume *volume;
+	char *name;
+	int ret = 0;
+
+	if (domain_id)
+		name = kasprintf(GFP_KERNEL, "erofs,%s", domain_id);
+	else
+		name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
+	if (!name)
+		return -ENOMEM;
+
+	volume = fscache_acquire_volume(name, NULL, NULL, 0);
+	if (IS_ERR_OR_NULL(volume)) {
+		erofs_err(sb, "failed to register volume for %s", name);
+		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
+		volume = NULL;
+	}
+
+	sbi->volume = volume;
+	kfree(name);
+	return ret;
+}
+
+static int erofs_fscache_init_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
+	if (!domain->domain_id) {
+		kfree(domain);
+		return -ENOMEM;
+	}
+	sbi->domain = domain;
+	err = erofs_fscache_register_volume(sb);
+	if (err)
+		goto out;
+
+	domain->volume = sbi->volume;
+	refcount_set(&domain->ref, 1);
+	mutex_init(&domain->mutex);
+	list_add(&domain->list, &erofs_domain_list);
+	return 0;
+out:
+	kfree(domain->domain_id);
+	kfree(domain);
+	sbi->domain = NULL;
+	return err;
+}
+
+static int erofs_fscache_register_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	mutex_lock(&erofs_domain_list_lock);
+	list_for_each_entry(domain, &erofs_domain_list, list) {
+		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
+			sbi->domain = erofs_fscache_domain_get(domain);
+			sbi->volume = domain->volume;
+			mutex_unlock(&erofs_domain_list_lock);
+			return 0;
+		}
+	}
+	err = erofs_fscache_init_domain(sb);
+	mutex_unlock(&erofs_domain_list_lock);
+	return err;
+}
+
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 						     char *name, bool need_inode)
 {
@@ -486,24 +590,16 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct fscache_volume *volume;
 	struct erofs_fscache *fscache;
-	char *name;
-	int ret = 0;
+	int ret;
 
-	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
-	if (!name)
-		return -ENOMEM;
+	if (sbi->opt.domain_id)
+		ret = erofs_fscache_register_domain(sb);
+	else
+		ret = erofs_fscache_register_volume(sb);
 
-	volume = fscache_acquire_volume(name, NULL, NULL, 0);
-	if (IS_ERR_OR_NULL(volume)) {
-		erofs_err(sb, "failed to register volume for %s", name);
-		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
-		volume = NULL;
-	}
-
-	sbi->volume = volume;
-	kfree(name);
+	if (ret)
+		return ret;
 
 	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
 	if (IS_ERR(fscache))
@@ -518,7 +614,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	erofs_fscache_unregister_cookie(sbi->s_fscache);
-	fscache_relinquish_volume(sbi->volume, NULL, false);
 	sbi->s_fscache = NULL;
+
+	if (sbi->domain)
+		erofs_fscache_domain_put(sbi->domain);
+	else
+		fscache_relinquish_volume(sbi->volume, NULL, false);
+
 	sbi->volume = NULL;
+	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2d129c6b3027..5ce6889d6f1d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,14 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_domain {
+	refcount_t ref;
+	struct mutex mutex;
+	struct list_head list;
+	struct fscache_volume *volume;
+	char *domain_id;
+};
+
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
@@ -158,6 +166,7 @@ struct erofs_sb_info {
 	/* fscache support */
 	struct fscache_volume *volume;
 	struct erofs_fscache *s_fscache;
+	struct erofs_domain *domain;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
-- 
2.20.1

