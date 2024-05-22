Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id CB96D8CBA3C
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 06:11:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vkd5k70sKz3gL1
	for <lists+linux-erofs@lfdr.de>; Wed, 22 May 2024 14:06:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vkd5S1G83z3g64
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 14:06:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkd5D3tKPz4f3jqY
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 12:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 560ED1A08D3
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 May 2024 12:05:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4ib01ms1VYNQ--.24441S7;
	Wed, 22 May 2024 12:05:58 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH RESEND 3/5] cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
Date: Wed, 22 May 2024 19:59:09 +0800
Message-Id: <20240522115911.2403021-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522115911.2403021-1-libaokun@huaweicloud.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ4ib01ms1VYNQ--.24441S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1DXw1fuFWfXw13Zr45Awb_yoW7Ary3pF
	ZIvrWxtrW8W3y7Grs8Jw1UJrn3J3s8JanrXw18Xr1rAws5Zr1YqF1jyr1YvFy5CrWkArs2
	y3WUKFy7WryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRgo7tUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

We got the following issue in our fault injection stress test:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_withdraw_cookie+0x4d9/0x600
Read of size 8 at addr ffff888118efc000 by task kworker/u78:0/109

CPU: 13 PID: 109 Comm: kworker/u78:0 Not tainted 6.8.0-dirty #566
Call Trace:
 <TASK>
 kasan_report+0x93/0xc0
 cachefiles_withdraw_cookie+0x4d9/0x600
 fscache_cookie_state_machine+0x5c8/0x1230
 fscache_cookie_worker+0x91/0x1c0
 process_one_work+0x7fa/0x1800
 [...]

Allocated by task 117:
 kmalloc_trace+0x1b3/0x3c0
 cachefiles_acquire_volume+0xf3/0x9c0
 fscache_create_volume_work+0x97/0x150
 process_one_work+0x7fa/0x1800
 [...]

Freed by task 120301:
 kfree+0xf1/0x2c0
 cachefiles_withdraw_cache+0x3fa/0x920
 cachefiles_put_unbind_pincount+0x1f6/0x250
 cachefiles_daemon_release+0x13b/0x290
 __fput+0x204/0xa00
 task_work_run+0x139/0x230
 do_exit+0x87a/0x29b0
 [...]
==================================================================

Following is the process that triggers the issue:

           p1                |             p2
------------------------------------------------------------
                              fscache_begin_lookup
                               fscache_begin_volume_access
                                fscache_cache_is_live(fscache_cache)
cachefiles_daemon_release
 cachefiles_put_unbind_pincount
  cachefiles_daemon_unbind
   cachefiles_withdraw_cache
    fscache_withdraw_cache
     fscache_set_cache_state(cache, FSCACHE_CACHE_IS_WITHDRAWN);
    cachefiles_withdraw_objects(cache)
    fscache_wait_for_objects(fscache)
      atomic_read(&fscache_cache->object_count) == 0
                              fscache_perform_lookup
                               cachefiles_lookup_cookie
                                cachefiles_alloc_object
                                 refcount_set(&object->ref, 1);
                                 object->volume = volume
                                 fscache_count_object(vcookie->cache);
                                  atomic_inc(&fscache_cache->object_count)
    cachefiles_withdraw_volumes
     cachefiles_withdraw_volume
      fscache_withdraw_volume
      __cachefiles_free_volume
       kfree(cachefiles_volume)
                              fscache_cookie_state_machine
                               cachefiles_withdraw_cookie
                                cache = object->volume->cache;
                                // cachefiles_volume UAF !!!

After setting FSCACHE_CACHE_IS_WITHDRAWN, wait for all the cookie lookups
to complete first, and then wait for fscache_cache->object_count == 0 to
avoid the cookie exiting after the volume has been freed and triggering
the above issue. Therefore call fscache_withdraw_volume() before calling
cachefiles_withdraw_objects().

This way, after setting FSCACHE_CACHE_IS_WITHDRAWN, only the following two
cases will occur:
1) fscache_begin_lookup fails in fscache_begin_volume_access().
2) fscache_withdraw_volume() will ensure that fscache_count_object() has
   been executed before calling fscache_wait_for_objects().

Fixes: fe2140e2f57f ("cachefiles: Implement volume support")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/cache.c  | 35 ++++++++++++++++++++++++++++++++++-
 fs/cachefiles/volume.c |  1 -
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 56ef519a36a0..9fb06dc16520 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -313,7 +313,39 @@ static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
 }
 
 /*
- * Withdraw volumes.
+ * Withdraw fscache volumes.
+ */
+static void cachefiles_withdraw_fscache_volumes(struct cachefiles_cache *cache)
+{
+	struct list_head *cur;
+	struct cachefiles_volume *volume;
+	struct fscache_volume *vcookie;
+
+	_enter("");
+retry:
+	spin_lock(&cache->object_list_lock);
+	list_for_each(cur, &cache->volumes) {
+		volume = list_entry(cur, struct cachefiles_volume, cache_link);
+
+		if (atomic_read(&volume->vcookie->n_accesses) == 0)
+			continue;
+
+		vcookie = fscache_try_get_volume(volume->vcookie,
+						 fscache_volume_get_withdraw);
+		if (vcookie) {
+			spin_unlock(&cache->object_list_lock);
+			fscache_withdraw_volume(vcookie);
+			fscache_put_volume(vcookie, fscache_volume_put_withdraw);
+			goto retry;
+		}
+	}
+	spin_unlock(&cache->object_list_lock);
+
+	_leave("");
+}
+
+/*
+ * Withdraw cachefiles volumes.
  */
 static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 {
@@ -381,6 +413,7 @@ void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	pr_info("File cache on %s unregistering\n", fscache->name);
 
 	fscache_withdraw_cache(fscache);
+	cachefiles_withdraw_fscache_volumes(cache);
 
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 89df0ba8ba5e..781aac4ef274 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -133,7 +133,6 @@ void cachefiles_free_volume(struct fscache_volume *vcookie)
 
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
 {
-	fscache_withdraw_volume(volume->vcookie);
 	cachefiles_set_volume_xattr(volume);
 	__cachefiles_free_volume(volume);
 }
-- 
2.39.2

