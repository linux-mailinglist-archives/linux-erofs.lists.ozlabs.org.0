Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232E772126
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 13:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691407180;
	bh=VvZzKGLWBPnU/YifQKDl8Wb9pt+zZKHS88YiwcrJMO0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EuCzcXjoz+NeTIrUpGLZhQSw3j2BCfjVN1R3/uLsUViFR7/H5uwOrY4wiYtyLLL9z
	 TxdZxG8nmJKJwg0/6J1tHj2NEh0xks0kwwyRv/Lw4sANKVmPzvVrPIpV8FXQpCPajd
	 4sY/ZycfYdrEEr3cWCnfUm95/7+whoQrTfZ2pYMo4mHxRZCOx1Eomol6UFkPKIt6Rn
	 MyHCXwCSHOJcHdnn3saxvU+MiXGmvb9CSJh41WLC3rtX9SFpEMQom8u6z/paT8xON5
	 Ph2wjcoFOgNAtRqvvBQOHd4XeKXMfHr+HzpuXpiEHUOOkwZH/YR7O/pnP079aTr4Q+
	 I4HPPtkuJAAzg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKDP86npcz2yh2
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 21:19:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SsVeEy7g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::d29; helo=mail-io1-xd29.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKDP60lxJz2yGB
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 21:19:37 +1000 (AEST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-780c89d1998so32669339f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 04:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407175; x=1692011975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvZzKGLWBPnU/YifQKDl8Wb9pt+zZKHS88YiwcrJMO0=;
        b=G8JaiCbtzi+aB9SDTLvaL8xCqAyFDh754Hdra+548PdG1THTlRBP68SdlqW0UH70cq
         OmjoZox68cXS+Li52AzGCjt6rd2MwQUn3MvPKVb/elFpsw/x5efwFa6itd5RCO/iPTyG
         VZ8Ptf9EaOSVVqjsfbsbXXU+5iZwVfub6foD/yGHZsGEsbvACIV3jOwsxjXIPnvNYEL6
         htwBmIGWVyfhj9BV4ofuQK6fl0KgJf3toRod6ARRY5QY6ATlN/gjMYAvveV+JanIzwRr
         hTjDwK0B9iJNv90A4ZO5b3kVPXVaX2Ttu20pxyiz/PnngzoK1/WR8wk4NLICOG3QKLOl
         ckjw==
X-Gm-Message-State: ABy/qLZsdWDTvDGWd8cVBICzCA9KlzI2KP7mBm5t1e4NwjssBQIsXjEw
	Bw/qPAGX46Ile9j61nrREOVsnA==
X-Google-Smtp-Source: APBJJlG/XxZB6sKzQ/QKN1+d/Y+m2Z7kNpKSUjYzz7Oa2LvDnuz3c5eyzNfvhPPV8k8oKjwIpKOiLg==
X-Received: by 2002:a6b:c30f:0:b0:783:6e76:6bc7 with SMTP id t15-20020a6bc30f000000b007836e766bc7mr26415608iof.2.1691407174771;
        Mon, 07 Aug 2023 04:19:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:19:34 -0700 (PDT)
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
Subject: [PATCH v4 45/48] mm: shrinker: make global slab shrink lockless
Date: Mon,  7 Aug 2023 19:09:33 +0800
Message-Id: <20230807110936.21819-46-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The shrinker_rwsem is a global read-write lock in shrinkers subsystem,
which protects most operations such as slab shrink, registration and
unregistration of shrinkers, etc. This can easily cause problems in the
following cases.

1) When the memory pressure is high and there are many filesystems
   mounted or unmounted at the same time, slab shrink will be affected
   (down_read_trylock() failed).

   Such as the real workload mentioned by Kirill Tkhai:

   ```
   One of the real workloads from my experience is start
   of an overcommitted node containing many starting
   containers after node crash (or many resuming containers
   after reboot for kernel update). In these cases memory
   pressure is huge, and the node goes round in long reclaim.
   ```

2) If a shrinker is blocked (such as the case mentioned
   in [1]) and a writer comes in (such as mount a fs),
   then this writer will be blocked and cause all
   subsequent shrinker-related operations to be blocked.

Even if there is no competitor when shrinking slab, there may still be a
problem. The down_read_trylock() may become a perf hotspot with frequent
calls to shrink_slab(). Because of the poor multicore scalability of
atomic operations, this can lead to a significant drop in IPC
(instructions per cycle).

We used to implement the lockless slab shrink with SRCU [2], but then
kernel test robot reported -88.8% regression in
stress-ng.ramfs.ops_per_sec test case [3], so we reverted it [4].

This commit uses the refcount+RCU method [5] proposed by Dave Chinner
to re-implement the lockless global slab shrink. The memcg slab shrink is
handled in the subsequent patch.

For now, all shrinker instances are converted to dynamically allocated and
will be freed by call_rcu(). So we can use rcu_read_{lock,unlock}() to
ensure that the shrinker instance is valid.

And the shrinker instance will not be run again after unregistration. So
the structure that records the pointer of shrinker instance can be safely
freed without waiting for the RCU read-side critical section.

In this way, while we implement the lockless slab shrink, we don't need to
be blocked in unregister_shrinker().

The following are the test results:

stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &

1) Before applying this patchset:

setting to a 60 second run per stressor
dispatching hogs: 9 ramfs
stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                          (secs)    (secs)    (secs)   (real time) (usr+sys time)
ramfs            735238     60.00     12.37    363.70     12253.05        1955.08
for a 60.01s run time:
   1440.27s available CPU time
     12.36s user time   (  0.86%)
    363.70s system time ( 25.25%)
    376.06s total time  ( 26.11%)
load average: 10.79 4.47 1.69
passed: 9: ramfs (9)
failed: 0
skipped: 0
successful run completed in 60.01s (1 min, 0.01 secs)

2) After applying this patchset:

setting to a 60 second run per stressor
dispatching hogs: 9 ramfs
stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                          (secs)    (secs)    (secs)   (real time) (usr+sys time)
ramfs            746698     60.00     12.45    376.16     12444.02        1921.47
for a 60.01s run time:
   1440.28s available CPU time
     12.44s user time   (  0.86%)
    376.16s system time ( 26.12%)
    388.60s total time  ( 26.98%)
load average: 9.01 3.85 1.49
passed: 9: ramfs (9)
failed: 0
skipped: 0
successful run completed in 60.01s (1 min, 0.01 secs)

We can see that the ops/s has hardly changed.

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
[2]. https://lore.kernel.org/lkml/20230313112819.38938-1-zhengqi.arch@bytedance.com/
[3]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[4]. https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
[5]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 17 ++++++++++
 mm/shrinker.c            | 70 +++++++++++++++++++++++++++++-----------
 2 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index eb342994675a..f06225f18531 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -4,6 +4,8 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
 
 #define SHRINKER_UNIT_BITS	BITS_PER_LONG
 
@@ -87,6 +89,10 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	refcount_t refcount;
+	struct completion done;
+	struct rcu_head rcu;
+
 	void *private_data;
 
 	/* These are for internal use */
@@ -120,6 +126,17 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
 
+static inline bool shrinker_try_get(struct shrinker *shrinker)
+{
+	return refcount_inc_not_zero(&shrinker->refcount);
+}
+
+static inline void shrinker_put(struct shrinker *shrinker)
+{
+	if (refcount_dec_and_test(&shrinker->refcount))
+		complete(&shrinker->done);
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 1911c06b8af5..d318f5621862 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -2,6 +2,7 @@
 #include <linux/memcontrol.h>
 #include <linux/rwsem.h>
 #include <linux/shrinker.h>
+#include <linux/rculist.h>
 #include <trace/events/vmscan.h>
 
 #include "internal.h"
@@ -577,33 +578,42 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
 			.memcg = memcg,
 		};
 
+		if (!shrinker_try_get(shrinker))
+			continue;
+
+		/*
+		 * We can safely unlock the RCU lock here since we already
+		 * hold the refcount of the shrinker.
+		 */
+		rcu_read_unlock();
+
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
+
 		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the registration from being stalled for long periods
-		 * by parallel ongoing shrinking.
+		 * This shrinker may be deleted from shrinker_list and freed
+		 * after the shrinker_put() below, but this shrinker is still
+		 * used for the next traversal. So it is necessary to hold the
+		 * RCU lock first to prevent this shrinker from being freed,
+		 * which also ensures that the next shrinker that is traversed
+		 * will not be freed (even if it is deleted from shrinker_list
+		 * at the same time).
 		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
+		rcu_read_lock();
+		shrinker_put(shrinker);
 	}
 
-	up_read(&shrinker_rwsem);
-out:
+	rcu_read_unlock();
 	cond_resched();
 	return freed;
 }
@@ -671,13 +681,29 @@ void shrinker_register(struct shrinker *shrinker)
 	}
 
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
+
+	init_completion(&shrinker->done);
+	/*
+	 * Now the shrinker is fully set up, take the first reference to it to
+	 * indicate that lookup operations are now allowed to use it via
+	 * shrinker_try_get().
+	 */
+	refcount_set(&shrinker->refcount, 1);
 }
 EXPORT_SYMBOL_GPL(shrinker_register);
 
+static void shrinker_free_rcu_cb(struct rcu_head *head)
+{
+	struct shrinker *shrinker = container_of(head, struct shrinker, rcu);
+
+	kfree(shrinker->nr_deferred);
+	kfree(shrinker);
+}
+
 void shrinker_free(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry = NULL;
@@ -686,9 +712,18 @@ void shrinker_free(struct shrinker *shrinker)
 	if (!shrinker)
 		return;
 
+	if (shrinker->flags & SHRINKER_REGISTERED) {
+		shrinker_put(shrinker);
+		wait_for_completion(&shrinker->done);
+	}
+
 	down_write(&shrinker_rwsem);
 	if (shrinker->flags & SHRINKER_REGISTERED) {
-		list_del(&shrinker->list);
+		/*
+		 * Lookups on the shrinker are over and will fail in the future,
+		 * so we can now remove it from the lists and free it.
+		 */
+		list_del_rcu(&shrinker->list);
 		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 		shrinker->flags &= ~SHRINKER_REGISTERED;
 	} else {
@@ -702,9 +737,6 @@ void shrinker_free(struct shrinker *shrinker)
 	if (debugfs_entry)
 		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
 
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-
-	kfree(shrinker);
+	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
 }
 EXPORT_SYMBOL_GPL(shrinker_free);
-- 
2.30.2

