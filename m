Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567A5984BF
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 15:53:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7mYW3FDjz3cCW
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 23:53:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QyHAjRjj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QyHAjRjj;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7mYH0Qh9z306K
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 23:52:50 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso2113648pjh.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AO4PYjCx0vXpaCKfQl5aDcYdKlf6Zm6zj4mxVrexpEo=;
        b=QyHAjRjjrjiZ9oGIrd+FGPpO7TvOj5bbsDQ3W2m70ZnRfRYHjt8r1XThHlgmtt32Uo
         rF7GZe9cx1pKlGKPRMLGCqoHQZzS31r0AWKclhM9hIxqCfj+ZB/yM16iq4U7CuSafLwr
         evPcyB4EqlXbRkQfgeGNfPMlIcxtv0IXxuhCCKjGKsSue42E9LqZDlJcudVDxql8tZYi
         b0IBNIqrHcZ8olq2KgIKnIr2wy1qAcjunRsZP83Nqh6cAM/D09xR8zvohBpypiR9bk2w
         SkpTvbWIjgLlD4wG4OTJrWH4kZUG/ddnmpdQgd6TJ+yYoclTy4/NGj8awscyH2NCOKWp
         /lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AO4PYjCx0vXpaCKfQl5aDcYdKlf6Zm6zj4mxVrexpEo=;
        b=dPskBxYOterEsbYTDG28r/fMq/lVIlVIIAsSjTOP8mCijwCsL6eUX9XFbgW2Nnb2RP
         ZtGEyD6TZNU1h0rHPJWKdYkDqvzNl8E4Uc6CMjzJR3g8nlOq5Z6lFN6o2VsviAmQoRep
         0ItGGzYmp+inUexLbl232QJ/L1xn+Ta9UfFzrfIUT2f9TjSqGVJuPcNCudcfsT037CQo
         9e7ffrb8B7TOeFgV+yizNkOnaFS5CieDspxmGUYjmNujIWYp5UXO0lPsnZQtWjW6IA7F
         2fYogGC5ll+cjemnMa9VP8vpAP8joJBLhx/qU8sYJLi1kCcqD1EVhDEa4Rsixlrz7Rh6
         0cpQ==
X-Gm-Message-State: ACgBeo0bm9M95zfATjz+azgjN9DHi4PzRLGAvGZPy+zdX5PjMPCUKZ/E
	mEvOOY+6BrJSef0kyVNRwwaTVA==
X-Google-Smtp-Source: AA6agR6Prqv2loglSrJuFS5LnkbzxN6+zNWILCKh5CNTaNFa7imFiGHdHiZIU75qH8+TDRaSFves3g==
X-Received: by 2002:a17:90b:314e:b0:1f3:189c:518f with SMTP id ip14-20020a17090b314e00b001f3189c518fmr3195014pjb.193.1660830767981;
        Thu, 18 Aug 2022 06:52:47 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:47 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [RFC PATCH 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date: Thu, 18 Aug 2022 21:52:01 +0800
Message-Id: <20220818135204.49878-3-zhujia.zj@bytedance.com>
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

We'll introduce a @work_struct field for @object in subsequent patches,
it will enlarge the size of @object.
As the result of that, this commit extracts ondemand info field from
@object.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/interface.c |  6 ++++++
 fs/cachefiles/internal.h  | 29 +++++++++++++++++++++++++----
 fs/cachefiles/ondemand.c  | 28 ++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a69073a1d3f0..f21f5660ea7f 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -31,6 +31,11 @@ struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
 	if (!object)
 		return NULL;
 
+	if (cachefiles_ondemand_init_obj_info(object, volume)) {
+		kmem_cache_free(cachefiles_object_jar, object);
+		return NULL;
+	}
+
 	refcount_set(&object->ref, 1);
 
 	spin_lock_init(&object->lock);
@@ -88,6 +93,7 @@ void cachefiles_put_object(struct cachefiles_object *object,
 		ASSERTCMP(object->file, ==, NULL);
 
 		kfree(object->d_name);
+		kfree(CACHEFILES_ONDEMAND_OBJINFO(object));
 
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6661b3e361da..cdf4ec781933 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -50,6 +50,12 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
 };
 
+struct cachefiles_ondemand_info {
+	int				ondemand_id;
+	enum cachefiles_object_state	state;
+	struct cachefiles_object	*object;
+};
+
 /*
  * Backing file state.
  */
@@ -67,8 +73,7 @@ struct cachefiles_object {
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
-	int				ondemand_id;
-	enum cachefiles_object_state	state;
+	void				*private;
 #endif
 };
 
@@ -302,6 +307,12 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+					struct cachefiles_volume *volume);
+
+#define CACHEFILES_ONDEMAND_OBJINFO(object)	\
+		((struct cachefiles_ondemand_info *)(object)->private)
+
 #define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
 static inline bool								\
 cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
@@ -312,7 +323,8 @@ cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
 	 * a RELEASE barrier. We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */											\
-	return smp_load_acquire(&object->state) == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+	return smp_load_acquire(&(CACHEFILES_ONDEMAND_OBJINFO(object)->state)) == \
+			CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
 }												\
 												\
 static inline void								\
@@ -323,12 +335,15 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 	 * I.e. here we publish a state with a RELEASE barrier
 	 * so that concurrent tasks can ACQUIRE it.
 	 */											\
-	smp_store_release(&object->state, CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
+	smp_store_release(&(CACHEFILES_ONDEMAND_OBJINFO(object)->state),	\
+		CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
 }
 
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
 #else
+#define CACHEFILES_ONDEMAND_OBJINFO(object)	NULL
+
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
 {
@@ -349,6 +364,12 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+						struct cachefiles_volume *volume)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index e3155a5f32e4..f51266554e4d 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -9,12 +9,13 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 {
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	int object_id = object->ondemand_id;
+	struct cachefiles_ondemand_info *info = CACHEFILES_ONDEMAND_OBJINFO(object);
+	int object_id = info->ondemand_id;
 	struct cachefiles_req *req;
 	XA_STATE(xas, &cache->reqs, 0);
 
 	xa_lock(&cache->reqs);
-	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
 
 	/*
@@ -218,7 +219,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	req->msg.object_id = object_id;
-	object->ondemand_id = object_id;
+	CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
@@ -358,7 +359,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 
 		if (opcode != CACHEFILES_OP_OPEN &&
 			!cachefiles_ondemand_object_is_open(object)) {
-			WARN_ON_ONCE(object->ondemand_id == 0);
+			WARN_ON_ONCE(CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -434,7 +435,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->ondemand_id;
+	req->msg.object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -450,7 +451,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
+	int object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
 	if (!cachefiles_ondemand_object_is_open(object)) {
@@ -496,6 +497,21 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 			cachefiles_ondemand_init_close_req, NULL);
 }
 
+int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+				struct cachefiles_volume *volume)
+{
+	if (!cachefiles_in_ondemand_mode(volume->cache))
+		return 0;
+
+	object->private = kzalloc(sizeof(struct cachefiles_ondemand_info),
+					GFP_KERNEL);
+	if (!object->private)
+		return -ENOMEM;
+
+	CACHEFILES_ONDEMAND_OBJINFO(object)->object = object;
+	return 0;
+}
+
 int cachefiles_ondemand_read(struct cachefiles_object *object,
 			     loff_t pos, size_t len)
 {
-- 
2.20.1

