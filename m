Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66B772110
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 13:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691407140;
	bh=G6s8y0Dka4KE4srOwy3I0FSAaIGrcYmvE6JrVZfCpDs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RCkQv/xeFltJZV2s0PIEpD//jKf8H6VWKn5nYYQFWX3ZfMpQ3qr6Oi1K+X/VwD8eI
	 5hoUS+Uu1OWvlAHj62U47InbpeYL+yuUhQ9PqHmcd5cOewHlqHgOuSgX/FLGb1GeEd
	 gsTRs513XTYNd2Mtb7KrDJb20Oeo0yzgOVXIF7lxdlKHmiKN8RGAocX/JkZCjbmQBy
	 52WpPjh8oJWQkLo8UUPV4EDjZKWEYCjgZxNzKdYPfMXFDtYtsg4rkdNNdGzFC4KQG/
	 06DagftmY/KdwTKCrwbTs3LtHK9ucqaZdE8pmAMhbeRMkv1GewVIo12qfNpIhL738u
	 3ruA1ACtoESZQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKDNN1Txgz2yh2
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 21:19:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=F7XshDjI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKDNK2pw4z2yGB
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 21:18:57 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2680edb9767so931402a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 04:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407135; x=1692011935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6s8y0Dka4KE4srOwy3I0FSAaIGrcYmvE6JrVZfCpDs=;
        b=dvuvslveQHInZKH9ZOkESu+GbZXUj+Tnkl82Z0xmVVllc377IGLeuRDpleDAsNFGVQ
         RFAZSuvV5he3uATDics0bq1Joo3rUtveooe7DfrG7Z5MxMMSKARkpUXcQSyXpAYpyHB5
         Ugd+u88UwQTcVKji71GCmgOiydwWp5u6qSWbOW3yD/d5/lPcRQRyoI1/vuVRXaOj3SY9
         ZYA9dm6Vn7DPA1hoXAnpWjR5Oogf4IdsXkdAFR9pgDpXdchH0cZjKHmUPpvs0mXJeLuk
         YMJzYA2Wdq2GTrRbHjXMHuCNYNlD7gyJiTHg/o8LDRZJXdoJz+S86t7dWoJ+qCqB1EBv
         KOPQ==
X-Gm-Message-State: ABy/qLaNTgiGPUBJrvORA+JPXrKlLsxQ3qMEMWczI2biv8Ohi24xbGAi
	J/LhsWSR2uEbt4bQH4oMagwTEQ==
X-Google-Smtp-Source: APBJJlENzs/96m+S7UnwJhfsSEKfLFwoWHJhRek0zeax/GsXgLjOrIeuu6U5nntKJfSobDso4iAXPQ==
X-Received: by 2002:a17:90a:1f83:b0:268:3dc6:f0c5 with SMTP id x3-20020a17090a1f8300b002683dc6f0c5mr25042984pja.0.1691407135598;
        Mon, 07 Aug 2023 04:18:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:18:55 -0700 (PDT)
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
Subject: [PATCH v4 42/48] mm: shrinker: remove old APIs
Date: Mon,  7 Aug 2023 19:09:30 +0800
Message-Id: <20230807110936.21819-43-zhengqi.arch@bytedance.com>
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

Now no users are using the old APIs, just remove them.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/shrinker.h |   7 --
 mm/shrinker.c            | 143 ---------------------------------------
 2 files changed, 150 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index cc23ff0aee20..c55c07c3f0cb 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -103,13 +103,6 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
 
-extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
-					    const char *fmt, ...);
-extern void register_shrinker_prepared(struct shrinker *shrinker);
-extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
-					    const char *fmt, ...);
-extern void unregister_shrinker(struct shrinker *shrinker);
-extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 43a375f954f3..3ab301ff122d 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -651,149 +651,6 @@ void shrinker_free(struct shrinker *shrinker)
 }
 EXPORT_SYMBOL_GPL(shrinker_free);
 
-/*
- * Add a shrinker callback to be called from the vm.
- */
-static int __prealloc_shrinker(struct shrinker *shrinker)
-{
-	unsigned int size;
-	int err;
-
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
-		if (err != -ENOSYS)
-			return err;
-
-		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
-	}
-
-	size = sizeof(*shrinker->nr_deferred);
-	if (shrinker->flags & SHRINKER_NUMA_AWARE)
-		size *= nr_node_ids;
-
-	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
-	if (!shrinker->nr_deferred)
-		return -ENOMEM;
-
-	return 0;
-}
-
-#ifdef CONFIG_SHRINKER_DEBUG
-int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	va_list ap;
-	int err;
-
-	va_start(ap, fmt);
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-	va_end(ap);
-	if (!shrinker->name)
-		return -ENOMEM;
-
-	err = __prealloc_shrinker(shrinker);
-	if (err) {
-		kfree_const(shrinker->name);
-		shrinker->name = NULL;
-	}
-
-	return err;
-}
-#else
-int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	return __prealloc_shrinker(shrinker);
-}
-#endif
-
-void free_prealloced_shrinker(struct shrinker *shrinker)
-{
-#ifdef CONFIG_SHRINKER_DEBUG
-	kfree_const(shrinker->name);
-	shrinker->name = NULL;
-#endif
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		down_write(&shrinker_rwsem);
-		unregister_memcg_shrinker(shrinker);
-		up_write(&shrinker_rwsem);
-		return;
-	}
-
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-}
-
-void register_shrinker_prepared(struct shrinker *shrinker)
-{
-	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
-	shrinker->flags |= SHRINKER_REGISTERED;
-	shrinker_debugfs_add(shrinker);
-	up_write(&shrinker_rwsem);
-}
-
-static int __register_shrinker(struct shrinker *shrinker)
-{
-	int err = __prealloc_shrinker(shrinker);
-
-	if (err)
-		return err;
-	register_shrinker_prepared(shrinker);
-	return 0;
-}
-
-#ifdef CONFIG_SHRINKER_DEBUG
-int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	va_list ap;
-	int err;
-
-	va_start(ap, fmt);
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-	va_end(ap);
-	if (!shrinker->name)
-		return -ENOMEM;
-
-	err = __register_shrinker(shrinker);
-	if (err) {
-		kfree_const(shrinker->name);
-		shrinker->name = NULL;
-	}
-	return err;
-}
-#else
-int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
-{
-	return __register_shrinker(shrinker);
-}
-#endif
-EXPORT_SYMBOL(register_shrinker);
-
-/*
- * Remove one
- */
-void unregister_shrinker(struct shrinker *shrinker)
-{
-	struct dentry *debugfs_entry;
-	int debugfs_id;
-
-	if (!(shrinker->flags & SHRINKER_REGISTERED))
-		return;
-
-	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
-	shrinker->flags &= ~SHRINKER_REGISTERED;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
-	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
-	up_write(&shrinker_rwsem);
-
-	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
-
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-}
-EXPORT_SYMBOL(unregister_shrinker);
-
 /**
  * synchronize_shrinkers - Wait for all running shrinkers to complete.
  *
-- 
2.30.2

