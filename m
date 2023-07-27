Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 680CF764A1D
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690445224;
	bh=BqN9tp9prAKwSL/xaaZwvgP8yGlZqKh7lkz65rMIkwI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y9OdSJM8xlZVWc7KJjjixEMGWeXWazNUN1sRjjr+pwmV4L+IgQ2RxJnCpuDnJU+kI
	 dRnvBONoBS57MlLpdiWsj0hAgTfKqRXOYG/hF4D4Y/vmSMTzf6sJDV3Cx0l6xouQsY
	 i6D6hfvMxl17aCk5trlU+KQXlZaNLAVy3VqlgBoJJNMPxzwdgOyGoBh27ZSqWfcDho
	 B0Ezm/OcksSzrlqSlWhQH3/rQgQUcPkI1feuYGsvp3sBm20J6MnQ3NKDIHQvqdwwQ3
	 IlcyavZvcGjuqeNGlBsueLznLmxhHM+ZSn0x+c97Q7u2eAIAsW5yFRdDK8bjvRd6gM
	 brmEvC1z+tEBw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNf02JdNz3dC5
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:07:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GBN6icr0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNdn2VZTz3dG1
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:06:53 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6862d4a1376so188327b3a.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 01:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445210; x=1691050010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqN9tp9prAKwSL/xaaZwvgP8yGlZqKh7lkz65rMIkwI=;
        b=BHuYb7lKjzKa8bcPp7t/4icwYXIMQ6IoT1XSWVvtn11M3XAuTdp2RhmpEjOYfqBX3P
         VDYmr5didlwBOf65rI4/NTGHrf6EfxUACw8NmCLiVH6bx7FrUXlmTgTi6p8dZwQBTuqt
         kmNX+9obHJVXRayMf5Uf5GdDsFcNA1LgyZ+8JyOZ2Rc+HaiBXINNpmcWNcPsjCqz1hBw
         gx0Hyp9tn77CnK3LxSBfkA0qS1004XbPqicil2qWyOslk75YEyIsqxn7kHInlTJNMUc6
         02d1+ss/NjVkj/Sv/gfU2YfRHkvnchVj7/GepxP9O2a42A3VUE3YkF7kqNRDx99MojH2
         5usw==
X-Gm-Message-State: ABy/qLYmcWIQCSsYbnvQO7DNvz2cZ9TQcaRWByv2SXuwtM9rLJajp9ZO
	+o1b/ECcxmQGAaa5HmbhAp6H7Q==
X-Google-Smtp-Source: APBJJlGqyHUGzcwYP72gZn72jBkXTN2mSwLe5z3KDdW3R9YyUcC+gdVHx8KhimUXzhfrGyXx8SlIVg==
X-Received: by 2002:a05:6a20:918e:b0:11a:dbb3:703b with SMTP id v14-20020a056a20918e00b0011adbb3703bmr5539836pzd.6.1690445210111;
        Thu, 27 Jul 2023 01:06:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:06:48 -0700 (PDT)
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
Subject: [PATCH v3 05/49] mm: shrinker: add infrastructure for dynamically allocating shrinker
Date: Thu, 27 Jul 2023 16:04:18 +0800
Message-Id: <20230727080502.77895-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

Currently, the shrinker instances can be divided into the following three
types:

a) global shrinker instance statically defined in the kernel, such as
   workingset_shadow_shrinker.

b) global shrinker instance statically defined in the kernel modules, such
   as mmu_shrinker in x86.

c) shrinker instance embedded in other structures.

For case a, the memory of shrinker instance is never freed. For case b,
the memory of shrinker instance will be freed after synchronize_rcu() when
the module is unloaded. For case c, the memory of shrinker instance will
be freed along with the structure it is embedded in.

In preparation for implementing lockless slab shrink, we need to
dynamically allocate those shrinker instances in case c, then the memory
can be dynamically freed alone by calling kfree_rcu().

So this commit adds the following new APIs for dynamically allocating
shrinker, and add a private_data field to struct shrinker to record and
get the original embedded structure.

1. shrinker_alloc()

Used to allocate shrinker instance itself and related memory, it will
return a pointer to the shrinker instance on success and NULL on failure.

2. shrinker_register()

Used to register the shrinker instance, which is same as the current
register_shrinker_prepared().

3. shrinker_free()

Used to unregister (if needed) and free the shrinker instance.

In order to simplify shrinker-related APIs and make shrinker more
independent of other kernel mechanisms, subsequent submissions will use
the above API to convert all shrinkers (including case a and b) to
dynamically allocated, and then remove all existing APIs.

This will also have another advantage mentioned by Dave Chinner:

```
The other advantage of this is that it will break all the existing
out of tree code and third party modules using the old API and will
no longer work with a kernel using lockless slab shrinkers. They
need to break (both at the source and binary levels) to stop bad
things from happening due to using uncoverted shrinkers in the new
setup.
```

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h |   7 +++
 mm/internal.h            |  11 +++++
 mm/shrinker.c            | 101 +++++++++++++++++++++++++++++++++++++++
 mm/shrinker_debug.c      |  17 ++++++-
 4 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 8dc15aa37410..cc23ff0aee20 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -70,6 +70,8 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	void *private_data;
+
 	/* These are for internal use */
 	struct list_head list;
 #ifdef CONFIG_MEMCG
@@ -95,6 +97,11 @@ struct shrinker {
  * non-MEMCG_AWARE shrinker should not have this flag set.
  */
 #define SHRINKER_NONSLAB	(1 << 3)
+#define SHRINKER_ALLOCATED	(1 << 4)
+
+struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
+void shrinker_register(struct shrinker *shrinker);
+void shrinker_free(struct shrinker *shrinker);
 
 extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
diff --git a/mm/internal.h b/mm/internal.h
index 8b82038dcc6a..38434175df86 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1144,6 +1144,9 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
+extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
+				       const char *fmt, va_list ap);
+extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
 extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 					      int *debugfs_id);
 extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
@@ -1153,6 +1156,14 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	return 0;
 }
+static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
+					      const char *fmt, va_list ap)
+{
+	return 0;
+}
+static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
+{
+}
 static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 						     int *debugfs_id)
 {
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 043c87ccfab4..43a375f954f3 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -550,6 +550,107 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 	return freed;
 }
 
+struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
+{
+	struct shrinker *shrinker;
+	unsigned int size;
+	va_list ap;
+	int err;
+
+	shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
+	if (!shrinker)
+		return NULL;
+
+	va_start(ap, fmt);
+	err = shrinker_debugfs_name_alloc(shrinker, fmt, ap);
+	va_end(ap);
+	if (err)
+		goto err_name;
+
+	shrinker->flags = flags | SHRINKER_ALLOCATED;
+
+	if (flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err == -ENOSYS)
+			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+		else if (err == 0)
+			goto done;
+		else
+			goto err_flags;
+	}
+
+	/*
+	 * The nr_deferred is available on per memcg level for memcg aware
+	 * shrinkers, so only allocate nr_deferred in the following cases:
+	 *  - non memcg aware shrinkers
+	 *  - !CONFIG_MEMCG
+	 *  - memcg is disabled by kernel command line
+	 */
+	size = sizeof(*shrinker->nr_deferred);
+	if (flags & SHRINKER_NUMA_AWARE)
+		size *= nr_node_ids;
+
+	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
+	if (!shrinker->nr_deferred)
+		goto err_flags;
+
+done:
+	return shrinker;
+
+err_flags:
+	shrinker_debugfs_name_free(shrinker);
+err_name:
+	kfree(shrinker);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(shrinker_alloc);
+
+void shrinker_register(struct shrinker *shrinker)
+{
+	if (unlikely(!(shrinker->flags & SHRINKER_ALLOCATED))) {
+		pr_warn("Must use shrinker_alloc() to dynamically allocate the shrinker");
+		return;
+	}
+
+	down_write(&shrinker_rwsem);
+	list_add_tail(&shrinker->list, &shrinker_list);
+	shrinker->flags |= SHRINKER_REGISTERED;
+	shrinker_debugfs_add(shrinker);
+	up_write(&shrinker_rwsem);
+}
+EXPORT_SYMBOL_GPL(shrinker_register);
+
+void shrinker_free(struct shrinker *shrinker)
+{
+	struct dentry *debugfs_entry = NULL;
+	int debugfs_id;
+
+	if (!shrinker)
+		return;
+
+	down_write(&shrinker_rwsem);
+	if (shrinker->flags & SHRINKER_REGISTERED) {
+		list_del(&shrinker->list);
+		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
+		shrinker->flags &= ~SHRINKER_REGISTERED;
+	} else {
+		shrinker_debugfs_name_free(shrinker);
+	}
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
+	up_write(&shrinker_rwsem);
+
+	if (debugfs_entry)
+		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+
+	kfree(shrinker);
+}
+EXPORT_SYMBOL_GPL(shrinker_free);
+
 /*
  * Add a shrinker callback to be called from the vm.
  */
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index f1becfd45853..506257585408 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -191,6 +191,20 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	return 0;
 }
 
+int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
+				va_list ap)
+{
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+
+	return shrinker->name ? 0 : -ENOMEM;
+}
+
+void shrinker_debugfs_name_free(struct shrinker *shrinker)
+{
+	kfree_const(shrinker->name);
+	shrinker->name = NULL;
+}
+
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
 	struct dentry *entry;
@@ -239,8 +253,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 
 	lockdep_assert_held(&shrinker_rwsem);
 
-	kfree_const(shrinker->name);
-	shrinker->name = NULL;
+	shrinker_debugfs_name_free(shrinker);
 
 	*debugfs_id = entry ? shrinker->debugfs_id : -1;
 	shrinker->debugfs_entry = NULL;
-- 
2.30.2

