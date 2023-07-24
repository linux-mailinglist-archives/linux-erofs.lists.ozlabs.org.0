Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9D75F0C1
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 11:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690192416;
	bh=tgz3Agis5n4s/WxjwmGNRU8p70ZOSlVCE9Y6IFYv5Fc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=L03FjUSol4K9gjLEeAXChIccB+i1vXMDidF+0rOHbHB4keNFjfzR+8WlnYjlUW/CF
	 EqCUISbm2gZ9yh+YfWp7iMZ05U/7BclHS5nGq9yCtqRQB6MUvpooytwkfERJhB2MIo
	 MBKyv1uZGG0fmaqZGNflJJmKpUQG9ZoKZjfgrY+AJRaWZpro6dWsG6OEJhqbhYR5t1
	 VU00Xnv+OsBSOVWCI1SMWlzWMRDX7+WAGB+ZNRsQS6SexeZrYh3Zycu2a5tuIG1frm
	 J7lbxhUejaHvdaAUH+Jm0Ot9jEffDYM8Acc3mo68uYZGMvFXgVZHT/+iQourKjv77s
	 kRmqktUj//Hog==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8b8J3QBWz2ytd
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 19:53:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eiUPUGpd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8b8D40YZz2xVV
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 19:53:32 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6864c144897so1023553b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 02:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192409; x=1690797209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgz3Agis5n4s/WxjwmGNRU8p70ZOSlVCE9Y6IFYv5Fc=;
        b=J2pTFGpPjr8OoG6Sd3GYGIRTmnGbv8ELiyijFUjB87pSxK1a0FN5LqZr505AY+Pl5u
         52x9IsO5C1LwoE220nh7J7uXXPvWJjI6xxBrXseMxBq3RGTv4OQQqLScqXhNa15xjZvJ
         cH7KUpbmIe1D0L64QVjmgVVqjvNN+DrtJ2Xxp4JC+3MqTiI9bv5qtctireb+p83+5H1v
         xH3pHtDKxgVyCn/4ZP473gMVoigfI0k9CFt/tbDH6BMi6OkRNe2yNTl1d9+9JbTfW2/k
         f9/M9PbPnPEacUJNn27ggjDtI7XHKPWIV2N8979jJ+WM2DnwZjxmYatim5svk4KX1sVJ
         NwHQ==
X-Gm-Message-State: ABy/qLY+HI876+AW/GI04Qgc0perOMqy9U/eJDz1BaW8T0Rv8I3ZMLUT
	63qRX7dEVEfb6lNqZGqAtIct7A==
X-Google-Smtp-Source: APBJJlGQECD+YmQyidx3CbYp8mtos2ukz3b+adApuBRwpx+yQP4R50i+1wYRdDRgYwf/0cvAmnpMMg==
X-Received: by 2002:a17:902:f681:b0:1b8:a469:53d8 with SMTP id l1-20020a170902f68100b001b8a46953d8mr12732513plg.0.1690192409468;
        Mon, 24 Jul 2023 02:53:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:53:29 -0700 (PDT)
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
Subject: [PATCH v2 42/47] drm/ttm: introduce pool_shrink_rwsem
Date: Mon, 24 Jul 2023 17:43:49 +0800
Message-Id: <20230724094354.90817-43-zhengqi.arch@bytedance.com>
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

Currently, the synchronize_shrinkers() is only used by TTM pool. It only
requires that no shrinkers run in parallel.

After we use RCU+refcount method to implement the lockless slab shrink,
we can not use shrinker_rwsem or synchronize_rcu() to guarantee that all
shrinker invocations have seen an update before freeing memory.

So we introduce a new pool_shrink_rwsem to implement a private
synchronize_shrinkers(), so as to achieve the same purpose.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++++++
 include/linux/shrinker.h       |  2 --
 mm/shrinker.c                  | 15 ---------------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index e1eb73d0b72a..8a35fd48ec46 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -74,6 +74,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
 static struct shrinker *mm_shrinker;
+static DECLARE_RWSEM(pool_shrink_rwsem);
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
@@ -317,6 +318,7 @@ static unsigned int ttm_pool_shrink(void)
 	unsigned int num_pages;
 	struct page *p;
 
+	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
 	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
 	list_move_tail(&pt->shrinker_list, &shrinker_list);
@@ -329,6 +331,7 @@ static unsigned int ttm_pool_shrink(void)
 	} else {
 		num_pages = 0;
 	}
+	up_read(&pool_shrink_rwsem);
 
 	return num_pages;
 }
@@ -572,6 +575,18 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 }
 EXPORT_SYMBOL(ttm_pool_init);
 
+/**
+ * synchronize_shrinkers - Wait for all running shrinkers to complete.
+ *
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory, similar to rcu.
+ */
+static void synchronize_shrinkers(void)
+{
+	down_write(&pool_shrink_rwsem);
+	up_write(&pool_shrink_rwsem);
+}
+
 /**
  * ttm_pool_fini - Cleanup a pool
  *
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index e464b4e9be0e..23ea9360c5d8 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -105,8 +105,6 @@ void shrinker_free_non_registered(struct shrinker *shrinker);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_unregister(struct shrinker *shrinker);
 
-extern void synchronize_shrinkers(void);
-
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
 extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 2f3635ad1b45..3c4d3fe2fa17 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -660,18 +660,3 @@ void shrinker_unregister(struct shrinker *shrinker)
 	kfree(shrinker);
 }
 EXPORT_SYMBOL(shrinker_unregister);
-
-/**
- * synchronize_shrinkers - Wait for all running shrinkers to complete.
- *
- * This is equivalent to calling unregister_shrink() and register_shrinker(),
- * but atomically and with less overhead. This is useful to guarantee that all
- * shrinker invocations have seen an update, before freeing memory, similar to
- * rcu.
- */
-void synchronize_shrinkers(void)
-{
-	down_write(&shrinker_rwsem);
-	up_write(&shrinker_rwsem);
-}
-EXPORT_SYMBOL(synchronize_shrinkers);
-- 
2.30.2

