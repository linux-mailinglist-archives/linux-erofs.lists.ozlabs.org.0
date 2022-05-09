Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AD51F565
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:40:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY4j1ptcz3by3
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:40:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4b0BC5z3bl5
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:40:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCfaIjH_1652082033; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCfaIjH_1652082033) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:34 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 03/22] cachefiles: unbind cachefiles gracefully in
 on-demand mode
Date: Mon,  9 May 2022 15:40:09 +0800
Message-Id: <20220509074028.74954-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a refcount to avoid the deadlock in on-demand read mode. The
on-demand read mode will pin the corresponding cachefiles object for
each anonymous fd. The cachefiles object is unpinned when the anonymous
fd gets closed. When the user daemon exits and the fd of
"/dev/cachefiles" device node gets closed, it will wait for all
cahcefiles objects getting withdrawn. Then if there's any anonymous fd
getting closed after the fd of the device node, the user daemon will
hang forever, waiting for all objects getting withdrawn.

To fix this, add a refcount indicating if there's any object pinned by
anonymous fds. The cachefiles cache gets unbound and withdrawn when the
refcount is decreased to 0. It won't change the behaviour of the
original mode, in which case the cachefiles cache gets unbound and
withdrawn as long as the fd of the device node gets closed.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 19 ++++++++++++++++---
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index d5417da7f792..5b1d0642c749 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -111,6 +111,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&cache->volumes);
 	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
+	refcount_set(&cache->unbind_pincount, 1);
 	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
 	xa_init_flags(&cache->ondemand_ids, XA_FLAGS_ALLOC1);
 
@@ -164,6 +165,20 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
 	xa_destroy(&cache->ondemand_ids);
 }
 
+void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache)
+{
+	if (refcount_dec_and_test(&cache->unbind_pincount)) {
+		cachefiles_daemon_unbind(cache);
+		cachefiles_open = 0;
+		kfree(cache);
+	}
+}
+
+void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache)
+{
+	refcount_inc(&cache->unbind_pincount);
+}
+
 /*
  * Release a cache.
  */
@@ -179,14 +194,12 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	if (cachefiles_in_ondemand_mode(cache))
 		cachefiles_flush_reqs(cache);
-	cachefiles_daemon_unbind(cache);
 
 	/* clean up the control file interface */
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
-	cachefiles_open = 0;
 
-	kfree(cache);
+	cachefiles_put_unbind_pincount(cache);
 
 	_leave("");
 	return 0;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4f5150a96849..e5c612888f84 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -109,6 +109,7 @@ struct cachefiles_cache {
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
+	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
@@ -171,6 +172,8 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern void cachefiles_get_unbind_pincount(struct cachefiles_cache *cache);
+extern void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache);
 
 /*
  * error_inject.c
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 64fc312b16d3..7946ee6c40be 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -14,6 +14,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	xa_erase(&cache->ondemand_ids, object_id);
 	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
+	cachefiles_put_unbind_pincount(cache);
 	return 0;
 }
 
@@ -169,6 +170,8 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	load->fd = fd;
 	req->msg.object_id = object_id;
 	object->ondemand_id = object_id;
+
+	cachefiles_get_unbind_pincount(cache);
 	return 0;
 
 err_put_fd:
-- 
2.27.0

