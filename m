Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E050DFE3
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 14:22:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kn3zl6SLWz3bpb
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 22:22:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kn3zV6crNz3bZZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Apr 2022 22:21:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VBDlJDt_1650889310; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VBDlJDt_1650889310) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Apr 2022 20:21:51 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v10 04/21] cachefiles: notify the user daemon when withdrawing
 cookie
Date: Mon, 25 Apr 2022 20:21:26 +0800
Message-Id: <20220425122143.56815-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Notify the user daemon that cookie is going to be withdrawn, providing a
hint that the associated anonymous fd can be closed.

Be noted that this is only a hint. The user daemon may close the
associated anonymous fd when receiving the CLOSE request, then it will
receive another anonymous fd when the cookie gets looked up. Or it may
ignore the CLOSE request, and keep writing data through the anonymous
fd. However the next time the cookie gets looked up, the user daemon
will still receive another new anonymous fd.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/interface.c       |  2 ++
 fs/cachefiles/internal.h        |  5 +++++
 fs/cachefiles/ondemand.c        | 38 +++++++++++++++++++++++++++++++++
 include/uapi/linux/cachefiles.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index ae93cee9d25d..a69073a1d3f0 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -362,6 +362,8 @@ static void cachefiles_withdraw_cookie(struct fscache_cookie *cookie)
 		spin_unlock(&cache->object_list_lock);
 	}
 
+	cachefiles_ondemand_clean_object(object);
+
 	if (object->file) {
 		cachefiles_begin_secure(cache, &saved_cred);
 		cachefiles_clean_up_object(object, cache);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e5c612888f84..da388ba127eb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -290,6 +290,7 @@ extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
@@ -302,6 +303,10 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
 {
 	return 0;
 }
+
+static inline void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
+{
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 7946ee6c40be..11b1c15ac697 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -229,6 +229,12 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 		goto err_put_fd;
 	}
 
+	/* CLOSE request has no reply */
+	if (msg->opcode == CACHEFILES_OP_CLOSE) {
+		xa_erase(&cache->reqs, id);
+		complete(&req->done);
+	}
+
 	return n;
 
 err_put_fd:
@@ -300,6 +306,13 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
+		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+			WARN_ON_ONCE(object->ondemand_id == 0);
+			xas_unlock(&xas);
+			ret = -EIO;
+			goto out;
+		}
+
 		xas.xa_index = 0;
 		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
 		if (xas.xa_node == XAS_RESTART)
@@ -356,6 +369,25 @@ static int cachefiles_ondemand_init_open_req(struct cachefiles_req *req,
 	return 0;
 }
 
+static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
+					      void *private)
+{
+	struct cachefiles_object *object = req->object;
+	int object_id = object->ondemand_id;
+
+	/*
+	 * It's possible that object id is still 0 if the cookie looking up
+	 * phase failed before OPEN request has ever been sent. Also avoid
+	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
+	 * anon_fd has already been closed.
+	 */
+	if (object_id <= 0)
+		return -ENOENT;
+
+	req->msg.object_id = object_id;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -379,3 +411,9 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	return cachefiles_ondemand_send_req(object, CACHEFILES_OP_OPEN,
 			data_len, cachefiles_ondemand_init_open_req, NULL);
 }
+
+void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
+{
+	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
+			cachefiles_ondemand_init_close_req, NULL);
+}
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 521f2fe4fe9c..37a0071037c8 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -12,6 +12,7 @@
 
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
+	CACHEFILES_OP_CLOSE,
 };
 
 /*
-- 
2.27.0

