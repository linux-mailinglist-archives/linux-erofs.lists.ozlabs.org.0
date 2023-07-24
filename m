Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0214675EFC9
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 11:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690192055;
	bh=9U3hHp3Ixfpl9U4smEWKzCVcwCA5eIL8z0A28L1UZbc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TezO2TO5JtRo2Jw0GicTzE0Y+pJINtBTJahknmr16ic7BZQTJOyB1iY9H7oWBo9En
	 xDJkPi61hRABpETEElIQtiEvTw7/lPMrGVl4DDoJUMgReUILXva5BvcCUtkEqxNi4x
	 XS4goc7gEK0qZEupEGz6t1FlqBDYXOdIa3ggq4l7mSB6cscYvvkEx9nCGooVeDeIRt
	 PVsUyH3zgJAoLHOHG7MY2uk3TnAhg4JB8FTNcbxG1vcXtpBTNgBhp6H0irfGE1tYkf
	 yMpWnrVt22CMiNsqR8ZElNhPEaS934rfPjikcEyLdmotr/jo78baiGn3x0Sxu0Dn1u
	 G609M1U/Kknqw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8b1M6Qsfz2ytq
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:47:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QAYeqCfp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8b1K53FFz2yhS
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 19:47:33 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-682b1768a0bso1051614b3a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 02:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192050; x=1690796850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U3hHp3Ixfpl9U4smEWKzCVcwCA5eIL8z0A28L1UZbc=;
        b=RO3TtTIEaTFQjkSmnJaSlmJ99aP+Fu91EY0Iy8HfSKjGjMPwahqvtchaDRMQYjwcag
         r4Y4bJO/EgLDdKxghF73AV8u9N0+uunuJhKvF0GLfzhJ2xnwhyy3ZqX+Adukn65XBsIu
         7MVAHVfcUrxPpLPMdC8QvbBUn8JLXs1Qz/izwq/MxTbx4plYrQwMqqkG8/lBpbCwJ1OW
         QnSjgv/+7D5H/fJoM+8aSfzDlPPAb277UfMgkgHsJnEOJY3GMgk4bmJcPbSo0ObiSNmE
         2mWgDvagFd0UstSB0GXhZrI7b1JpaJjiw9WxdB+/3iiI4yTI49Mc50MB1eYQBJc86bh7
         Ncrw==
X-Gm-Message-State: ABy/qLYx+b7MKJVlbj1ZUKc4mT4raQAKu8zqZKix+o2Dk4CSRDiUDQX8
	57pgxZTrTY72lwjqi6L2BMJ6lw==
X-Google-Smtp-Source: APBJJlHqJFoGUA+vGZIvjP2L+AzvJt8mYCuJXkz93MaA+snz7x91W/Nq1tjb4AkURZSKSg9l3nnnXQ==
X-Received: by 2002:a05:6a20:7d86:b0:137:3eba:b808 with SMTP id v6-20020a056a207d8600b001373ebab808mr14262798pzj.5.1690192050616;
        Mon, 24 Jul 2023 02:47:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:47:30 -0700 (PDT)
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev
Subject: [PATCH v2 12/47] NFSv4.2: dynamically allocate the nfs-xattr shrinkers
Date: Mon, 24 Jul 2023 17:43:19 +0800
Message-Id: <20230724094354.90817-13-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use new APIs to dynamically allocate the nfs-xattr shrinkers.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/nfs/nfs42xattr.c | 87 +++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 911f634ba3da..3604342e0f77 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -796,28 +796,9 @@ static unsigned long nfs4_xattr_cache_scan(struct shrinker *shrink,
 static unsigned long nfs4_xattr_entry_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 
-static struct shrinker nfs4_xattr_cache_shrinker = {
-	.count_objects	= nfs4_xattr_cache_count,
-	.scan_objects	= nfs4_xattr_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
-
-static struct shrinker nfs4_xattr_entry_shrinker = {
-	.count_objects	= nfs4_xattr_entry_count,
-	.scan_objects	= nfs4_xattr_entry_scan,
-	.seeks		= DEFAULT_SEEKS,
-	.batch		= 512,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
-
-static struct shrinker nfs4_xattr_large_entry_shrinker = {
-	.count_objects	= nfs4_xattr_entry_count,
-	.scan_objects	= nfs4_xattr_entry_scan,
-	.seeks		= 1,
-	.batch		= 512,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
+static struct shrinker *nfs4_xattr_cache_shrinker;
+static struct shrinker *nfs4_xattr_entry_shrinker;
+static struct shrinker *nfs4_xattr_large_entry_shrinker;
 
 static enum lru_status
 cache_lru_isolate(struct list_head *item,
@@ -943,7 +924,7 @@ nfs4_xattr_entry_scan(struct shrinker *shrink, struct shrink_control *sc)
 	struct nfs4_xattr_entry *entry;
 	struct list_lru *lru;
 
-	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	lru = (shrink == nfs4_xattr_large_entry_shrinker) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
 	freed = list_lru_shrink_walk(lru, sc, entry_lru_isolate, &dispose);
@@ -971,7 +952,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count;
 	struct list_lru *lru;
 
-	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	lru = (shrink == nfs4_xattr_large_entry_shrinker) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
 	count = list_lru_shrink_count(lru, sc);
@@ -991,18 +972,34 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
-static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
-				    struct list_lru *lru, const char *name)
+typedef unsigned long (*count_objects_cb)(struct shrinker *s,
+					  struct shrink_control *sc);
+typedef unsigned long (*scan_objects_cb)(struct shrinker *s,
+					 struct shrink_control *sc);
+
+static int nfs4_xattr_shrinker_init(struct shrinker **shrinker,
+				    struct list_lru *lru, const char *name,
+				    count_objects_cb count,
+				    scan_objects_cb scan, long batch, int seeks)
 {
-	int ret = 0;
+	int ret;
 
-	ret = register_shrinker(shrinker, name);
-	if (ret)
+	*shrinker = shrinker_alloc(SHRINKER_MEMCG_AWARE, name);
+	if (!*shrinker)
+		return -ENOMEM;
+
+	ret = list_lru_init_memcg(lru, *shrinker);
+	if (ret) {
+		shrinker_free_non_registered(*shrinker);
 		return ret;
+	}
 
-	ret = list_lru_init_memcg(lru, shrinker);
-	if (ret)
-		unregister_shrinker(shrinker);
+	(*shrinker)->count_objects = count;
+	(*shrinker)->scan_objects = scan;
+	(*shrinker)->batch = batch;
+	(*shrinker)->seeks = seeks;
+
+	shrinker_register(*shrinker);
 
 	return ret;
 }
@@ -1010,7 +1007,7 @@ static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
 static void nfs4_xattr_shrinker_destroy(struct shrinker *shrinker,
 					struct list_lru *lru)
 {
-	unregister_shrinker(shrinker);
+	shrinker_unregister(shrinker);
 	list_lru_destroy(lru);
 }
 
@@ -1026,27 +1023,31 @@ int __init nfs4_xattr_cache_init(void)
 		return -ENOMEM;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_cache_shrinker,
-				       &nfs4_xattr_cache_lru,
-				       "nfs-xattr_cache");
+				       &nfs4_xattr_cache_lru, "nfs-xattr_cache",
+				       nfs4_xattr_cache_count,
+				       nfs4_xattr_cache_scan, 0, DEFAULT_SEEKS);
 	if (ret)
 		goto out1;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_entry_shrinker,
-				       &nfs4_xattr_entry_lru,
-				       "nfs-xattr_entry");
+				       &nfs4_xattr_entry_lru, "nfs-xattr_entry",
+				       nfs4_xattr_entry_count,
+				       nfs4_xattr_entry_scan, 512, DEFAULT_SEEKS);
 	if (ret)
 		goto out2;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_large_entry_shrinker,
 				       &nfs4_xattr_large_entry_lru,
-				       "nfs-xattr_large_entry");
+				       "nfs-xattr_large_entry",
+				       nfs4_xattr_entry_count,
+				       nfs4_xattr_entry_scan, 512, 1);
 	if (!ret)
 		return 0;
 
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_entry_shrinker,
 				    &nfs4_xattr_entry_lru);
 out2:
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_cache_shrinker,
 				    &nfs4_xattr_cache_lru);
 out1:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
@@ -1056,11 +1057,11 @@ int __init nfs4_xattr_cache_init(void)
 
 void nfs4_xattr_cache_exit(void)
 {
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_large_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_large_entry_shrinker,
 				    &nfs4_xattr_large_entry_lru);
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_entry_shrinker,
 				    &nfs4_xattr_entry_lru);
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_cache_shrinker,
 				    &nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 }
-- 
2.30.2

