Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FE7720A4
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 13:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691407011;
	bh=xVRvDV5EwClRaurogoo7jeCmWiPiam6NNimoVigpYsU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WaofdjTXe4zbWJkoZueV4arRbvtwd5i4rHiRk0FHb61zhJW0PaXdBWilWvevIVr2d
	 U3ID8KHu3bD+LVMBwniHprjg1f62vCRgQAshjDaFMsTK/MgfdDnsx2ZsdaMvhybshu
	 m+SqRlDFoRfbm3AmA0x+azneT88g8b7EwAhH4I06jUqDSCy0DeJp94O8fVvUAgY1Vo
	 DUhBhXkHEzF3S74SPJoBQmIGvIP2z1WLAXCmTZA1KdGsIXG+VNjwz5vP2VZzzXuNyo
	 f+xC6Nwu1cMJiRrW/G7cJH/Jc03xmkV6rkCRAw7V5ac2zKCnILKf7hhwLjVeoMsN0C
	 /CVs4oGC4TShw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKDKv4sSWz2yh6
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 21:16:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZpUxkeID;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKDKr6fR3z2yGB
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 21:16:48 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2690803a368so591100a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 04:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407007; x=1692011807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVRvDV5EwClRaurogoo7jeCmWiPiam6NNimoVigpYsU=;
        b=VXg7DK5JFr3H9a/jHw5VpO9D129Sw4nB6RcsMyNjaXEqqpf2wScVRfXUKS+mfOEiOc
         I08ZM0rKvDRwQrp8PHxJOr629H0hkx6kcEDQNMTcKPGtneqMocEwxdBxUL7eFil3hEY1
         CeaPZ7qxfxJXVDkhOEF3iQYk6oXHtFTTf18rHJYEBHknPPcMUJYJTb5qMMKaprDGTNSL
         XYP9RFRUipEmyURvMKxkTCPYLMr9D/pd4yqFXTGNXf9Sc6D2FmZcu2EPNCE1bNzXiLQk
         hw7fOTXhkYFQAsZUNNbYc0U+bEnJg8Egqt9kQFpNyMMY985uJYW8YTMfjQDaK1nIE2kO
         rG6w==
X-Gm-Message-State: ABy/qLa3tPXg9ZFmCSaXAVFHTn9IkjKRRaqFTKYoD7CZel3X561ZmSbg
	/7wtZgDu9el6Fi73UxRdai6iGA==
X-Google-Smtp-Source: APBJJlGBV531Fc0h3gGTcYh+GrDchiBvn4r3DyO1GlE79UVq2Tiyx2gaPN4S9h+mnuBR5bsUMtGvYQ==
X-Received: by 2002:a17:90a:ac2:b0:268:f977:848c with SMTP id r2-20020a17090a0ac200b00268f977848cmr15219032pje.2.1691407007341;
        Mon, 07 Aug 2023 04:16:47 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:16:47 -0700 (PDT)
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
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
Subject: [PATCH v4 32/48] mbcache: dynamically allocate the mbcache shrinker
Date: Mon,  7 Aug 2023 19:09:20 +0800
Message-Id: <20230807110936.21819-33-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the mbcache shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct mb_cache.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/mbcache.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 2a4b8b549e93..0d1e24e9a5e3 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -37,7 +37,7 @@ struct mb_cache {
 	struct list_head	c_list;
 	/* Number of entries in cache */
 	unsigned long		c_entry_count;
-	struct shrinker		c_shrink;
+	struct shrinker		*c_shrink;
 	/* Work for shrinking when the cache has too many entries */
 	struct work_struct	c_shrink_work;
 };
@@ -293,8 +293,7 @@ EXPORT_SYMBOL(mb_cache_entry_touch);
 static unsigned long mb_cache_count(struct shrinker *shrink,
 				    struct shrink_control *sc)
 {
-	struct mb_cache *cache = container_of(shrink, struct mb_cache,
-					      c_shrink);
+	struct mb_cache *cache = shrink->private_data;
 
 	return cache->c_entry_count;
 }
@@ -333,8 +332,7 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 static unsigned long mb_cache_scan(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct mb_cache *cache = container_of(shrink, struct mb_cache,
-					      c_shrink);
+	struct mb_cache *cache = shrink->private_data;
 	return mb_cache_shrink(cache, sc->nr_to_scan);
 }
 
@@ -377,15 +375,20 @@ struct mb_cache *mb_cache_create(int bucket_bits)
 	for (i = 0; i < bucket_count; i++)
 		INIT_HLIST_BL_HEAD(&cache->c_hash[i]);
 
-	cache->c_shrink.count_objects = mb_cache_count;
-	cache->c_shrink.scan_objects = mb_cache_scan;
-	cache->c_shrink.seeks = DEFAULT_SEEKS;
-	if (register_shrinker(&cache->c_shrink, "mbcache-shrinker")) {
+	cache->c_shrink = shrinker_alloc(0, "mbcache-shrinker");
+	if (!cache->c_shrink) {
 		kfree(cache->c_hash);
 		kfree(cache);
 		goto err_out;
 	}
 
+	cache->c_shrink->count_objects = mb_cache_count;
+	cache->c_shrink->scan_objects = mb_cache_scan;
+	cache->c_shrink->seeks = DEFAULT_SEEKS;
+	cache->c_shrink->private_data = cache;
+
+	shrinker_register(cache->c_shrink);
+
 	INIT_WORK(&cache->c_shrink_work, mb_cache_shrink_worker);
 
 	return cache;
@@ -406,7 +409,7 @@ void mb_cache_destroy(struct mb_cache *cache)
 {
 	struct mb_cache_entry *entry, *next;
 
-	unregister_shrinker(&cache->c_shrink);
+	shrinker_free(cache->c_shrink);
 
 	/*
 	 * We don't bother with any locking. Cache must not be used at this
-- 
2.30.2

