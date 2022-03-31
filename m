Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5084ED8CA
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 13:58:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KThdf4H7sz2ybB
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Mar 2022 22:58:14 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KThdW3sDSz2xBf
 for <linux-erofs@lists.ozlabs.org>; Thu, 31 Mar 2022 22:58:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8iijnE_1648727878; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8iijnE_1648727878) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 31 Mar 2022 19:57:59 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 03/19] cachefiles: notify user daemon when withdrawing
 cookie
Date: Thu, 31 Mar 2022 19:57:37 +0800
Message-Id: <20220331115753.89431-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
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
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Notify user daemon that cookie is going to be withdrawn, providing a
hint that the associated anon_fd can be closed. The anon_fd attached in
the CLOSE request shall be same with that in the previous OPEN request.

Be noted that this is only a hint. User daemon can close the anon_fd
when receiving the CLOSE request, then it will receive another anon_fd
if the cookie gets looked up. Or it can also ignore the CLOSE request,
and keep writing data into the anon_fd. However the next time cookie
gets looked up, the user daemon will still receive another anon_fd.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c       |  2 ++
 fs/cachefiles/internal.h        |  5 +++++
 fs/cachefiles/ondemand.c        | 34 +++++++++++++++++++++++++++++++++
 include/uapi/linux/cachefiles.h |  5 +++++
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
index 7d5c7d391fdb..8a397d4da560 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -279,6 +279,7 @@ extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
+extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
@@ -291,6 +292,10 @@ static inline int cachefiles_ondemand_init_object(struct cachefiles_object *obje
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
index f0e6e422263b..8cbfba057616 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -209,6 +209,12 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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
@@ -332,6 +338,26 @@ static int init_open_req(struct cachefiles_req *req, void *private)
 	return 0;
 }
 
+static int init_close_req(struct cachefiles_req *req, void *private)
+{
+	struct cachefiles_object *object = req->object;
+	struct cachefiles_close *load = (void *)req->msg.data;
+	int fd = object->fd;
+
+	if (WARN_ON_ONCE(fd == -1))
+		return -EIO;
+
+	/*
+	 * It's possible if the cookie looking up phase failed before READ
+	 * request has ever been sent.
+	 */
+	if (fd == 0)
+		return -ENOENT;
+
+	load->fd = fd;
+	return 0;
+}
+
 int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
@@ -356,3 +382,11 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 					    CACHEFILES_OP_OPEN, data_len,
 					    init_open_req, NULL);
 }
+
+void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
+{
+	cachefiles_ondemand_send_req(object,
+				     CACHEFILES_OP_CLOSE,
+				     sizeof(struct cachefiles_close),
+				     init_close_req, NULL);
+}
diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefiles.h
index 49cb7adb439a..dba97d284899 100644
--- a/include/uapi/linux/cachefiles.h
+++ b/include/uapi/linux/cachefiles.h
@@ -12,6 +12,7 @@
 
 enum cachefiles_opcode {
 	CACHEFILES_OP_OPEN,
+	CACHEFILES_OP_CLOSE,
 };
 
 /*
@@ -36,4 +37,8 @@ struct cachefiles_open {
 	__u8  data[];
 };
 
+struct cachefiles_close {
+	__u32 fd;
+};
+
 #endif
-- 
2.27.0

