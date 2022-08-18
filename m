Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDE5984C1
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 15:53:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7mYd0zZVz3c72
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 23:53:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=WCbM+4/N;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=WCbM+4/N;
	dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7mYL3GRWz306K
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 23:52:54 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id y141so1593111pfb.7
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gOTOSimzRInzIF9tRyR7wLEvlpNDEpWviLzVhGKpvgs=;
        b=WCbM+4/NKJJDt0kRk6rJwkWEkflQ6N1dGlE9bMBj4GfRk/vaWuvMGhpZ7qok9H59pt
         FzzGmSb879NTnucQQeVU2UviTYhO+ZKbhhupO0Y89TpwWa/xKqK/siYSPnCnXJ/EdyXS
         FRZ5ybT3D3C+M+v98Ea92xLRhT4/F1gDLrMEHGfonb7b0fdSnAvKvV1u2iknqlkvja3S
         dQJeFQMeCcruokhXJ93Sp0E6DKFLZjx7B+Uge8Gbu8E2IU09CxIhP7T9uIHXpmdoRiew
         NObXzsPdjMN2a9qzmbHj4kyETeF/0e0wQHG6N5jmu5HtGjTpmJS3egxkpn39mclrjO5s
         0GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gOTOSimzRInzIF9tRyR7wLEvlpNDEpWviLzVhGKpvgs=;
        b=gYmNo4MNhFBML2rp+igP2mKBAO13BWnBzMk86z0/iDrL5G31/4FNQQ3cPyFm8AHylW
         vnr66sgZv5Kq7BixoMcNsdgVo/V47HxmwIY3tpIvxV55KDlWCEumG+2zB0iPdcRgxnB1
         ZDC3MzpyrzPSmXcZsEAmmMYg7AruhPDHdghSljbMi/8xkN7U9VDrod2d6t8CSJoDz7+j
         xhA9z422W6CUTkb8iRIftius2Bw5ekFAxgGGKRgyrgQGHkUIc4znY9R4FMYwPYSOzEup
         9707BhAbNEaIUdLTPxV9gW2gkjZ5ZZH4+z668R1cZuDjA0xFCTVPOsy99ikUmT6OEqMP
         bDtA==
X-Gm-Message-State: ACgBeo1aJCTp8uLGrk70jLPlIxc6N/C5fMycmCLP8+Ci3mSIoxNAk70w
	qna0GR1/p7YrE6tKKGClMA+05g==
X-Google-Smtp-Source: AA6agR6P7ElV4nXCTIaBHrH8KRLneoCsGKc20E9YjNNkU13UpJdntmJ71RwZSeWCFQtAb7zJsZNqMA==
X-Received: by 2002:a63:1624:0:b0:41a:9dea:1c80 with SMTP id w36-20020a631624000000b0041a9dea1c80mr2531645pgl.400.1660830772110;
        Thu, 18 Aug 2022 06:52:52 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:51 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [RFC PATCH 3/5] cachefiles: resend an open request if the read request's object is closed
Date: Thu, 18 Aug 2022 21:52:02 +0800
Message-Id: <20220818135204.49878-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220818135204.49878-1-zhujia.zj@bytedance.com>
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When an anonymous fd is closed by user daemon, if there is a new read
request for this file comes up, the anonymous fd should be re-opened
to handle that read request rather than fail it directly.

1. Introduce reopening state for objects that are closed but have
   inflight/subsequent read requests.
2. No longer flush READ requests but only CLOSE requests when anonymous
   fd is closed.
3. Enqueue the reopen work to workqueue, thus user daemon could get rid
   of daemon_read context and handle that request smoothly. Otherwise,
   the user daemon will send a reopen request and wait for itself to
   process the request.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/internal.h |  3 ++
 fs/cachefiles/ondemand.c | 79 +++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index cdf4ec781933..66bbd4f1d22a 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -48,9 +48,11 @@ struct cachefiles_volume {
 enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
 	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
+	CACHEFILES_ONDEMAND_OBJSTATE_reopening, /* Object that was closed and is being reopened. */
 };
 
 struct cachefiles_ondemand_info {
+	struct work_struct		work;
 	int				ondemand_id;
 	enum cachefiles_object_state	state;
 	struct cachefiles_object	*object;
@@ -341,6 +343,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
+CACHEFILES_OBJECT_STATE_FUNCS(reopening);
 #else
 #define CACHEFILES_ONDEMAND_OBJINFO(object)	NULL
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index f51266554e4d..79ffb19380cd 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -18,14 +18,10 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
 
-	/*
-	 * Flush all pending READ requests since their completion depends on
-	 * anon_fd.
-	 */
-	xas_for_each(&xas, req, ULONG_MAX) {
+	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
+	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 		if (req->msg.object_id == object_id &&
-		    req->msg.opcode == CACHEFILES_OP_READ) {
-			req->error = -EIO;
+		    req->msg.opcode == CACHEFILES_OP_CLOSE) {
 			complete(&req->done);
 			xas_store(&xas, NULL);
 		}
@@ -175,6 +171,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
 	cachefiles_ondemand_set_object_open(req->object);
+	wake_up_all(&cache->daemon_pollwq);
 
 out:
 	complete(&req->done);
@@ -234,6 +231,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	return ret;
 }
 
+static void ondemand_object_worker(struct work_struct *work)
+{
+	struct cachefiles_object *object =
+		((struct cachefiles_ondemand_info *)work)->object;
+
+	cachefiles_ondemand_init_object(object);
+}
+
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -249,7 +254,27 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	 * requests from being processed repeatedly.
 	 */
 	xa_lock(&cache->reqs);
-	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	xas_for_each_marked(&xas, req, UINT_MAX, CACHEFILES_REQ_NEW) {
+		/*
+		 * Reopen the closed object with associated read request.
+		 * Skip read requests whose related object are reopening.
+		 */
+		if (req->msg.opcode == CACHEFILES_OP_READ) {
+			ret = cmpxchg(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->state,
+						  CACHEFILES_ONDEMAND_OBJSTATE_close,
+						  CACHEFILES_ONDEMAND_OBJSTATE_reopening);
+			if (ret == CACHEFILES_ONDEMAND_OBJSTATE_close) {
+				INIT_WORK(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work,
+						ondemand_object_worker);
+				queue_work(fscache_wq,
+					&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work);
+				continue;
+			} else if (ret == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
+				continue;
+			}
+		}
+		break;
+	}
 	if (!req) {
 		xa_unlock(&cache->reqs);
 		return 0;
@@ -267,14 +292,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
-	msg->msg_id = id;
 
 	if (msg->opcode == CACHEFILES_OP_OPEN) {
 		ret = cachefiles_ondemand_get_fd(req);
-		if (ret)
+		if (ret) {
+			cachefiles_ondemand_set_object_close(req->object);
 			goto error;
+		}
 	}
 
+	msg->msg_id = id;
+	msg->object_id = CACHEFILES_ONDEMAND_OBJINFO(req->object)->ondemand_id;
+
 	if (copy_to_user(_buffer, msg, n) != 0) {
 		ret = -EFAULT;
 		goto err_put_fd;
@@ -307,19 +336,23 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 					void *private)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct cachefiles_req *req;
+	struct cachefiles_req *req = NULL;
 	XA_STATE(xas, &cache->reqs, 0);
 	int ret;
 
 	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
 		return 0;
 
-	if (test_bit(CACHEFILES_DEAD, &cache->flags))
-		return -EIO;
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	req->object = object;
 	init_completion(&req->done);
@@ -357,7 +390,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN &&
+		if (opcode == CACHEFILES_OP_CLOSE &&
 			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id == 0);
 			xas_unlock(&xas);
@@ -382,8 +415,12 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	wake_up_all(&cache->daemon_pollwq);
 	wait_for_completion(&req->done);
 	ret = req->error;
+	kfree(req);
+	return ret;
 out:
 	kfree(req);
+	if (opcode == CACHEFILES_OP_OPEN)
+		cachefiles_ondemand_set_object_close(req->object);
 	return ret;
 }
 
@@ -435,7 +472,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -451,16 +487,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
 
-	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (!cachefiles_ondemand_object_is_open(object)) {
-		WARN_ON_ONCE(object_id == 0);
-		pr_info_once("READ: anonymous fd closed prematurely.\n");
-		return -EIO;
-	}
-
-	req->msg.object_id = object_id;
 	load->off = read_ctx->off;
 	load->len = read_ctx->len;
 	trace_cachefiles_ondemand_read(object, &req->msg, load);
-- 
2.20.1

