Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128A5FB31C
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Oct 2022 15:16:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MmxBK74tGz3c2L
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Oct 2022 00:16:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3od1X0UQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3od1X0UQ;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MmxB70frkz2yMk
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Oct 2022 00:16:14 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id pq16so12471988pjb.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Oct 2022 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ8Q74Vr6wbl3jU/oxuFPb7m9GC9CrvTBnfVmj49Cog=;
        b=3od1X0UQsUAd8L7lZ3C7ormfAdhYKVsiMnd6hl2nQgDZVSpyNmYOpQUqpB9ZtewWat
         keqX7WeaztF0v+3pH1hzcgKoXuwqG+kCgLYE+Kpthgm5ni+pQaSllFAEsFhQSsZUAH3v
         qLtOeyOhSbr5jsIVbMc3odwsIWl6iH2TQG4iLo63WRF6drL8Kyp7Ap41HhmJhqPODUjh
         JUhMNHGPQa1awyRXmDW0eC2CnqVch+Rn1d9mU7Cz/ye8+ZSBuH0U1bNSL3QxXJLUOqb7
         h3fZLSX5IS59kbnVbkukSOz3lGfCOuFMu2Ngv5RXhZy8UQ2LeyNF5J6YttVVmvx8bvQH
         0SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ8Q74Vr6wbl3jU/oxuFPb7m9GC9CrvTBnfVmj49Cog=;
        b=vfKj2PK7UepcddTLBIVABVXVM4aCaqzd9XaWdjDcus9rOEzfRNF0whNK+1k4cEKL9N
         155jAsA1STTjmn5+BC5tkQCsgGxgl7vG3MwSGMlcsvqsifgnOV7pKOzge53/C+9Kbd0j
         I1J4LdcOE5DDg54BxNJhFHV9Zsym3VqaDed366rKgl1I5xo2GoROIsGlAO+wiV5l6tSY
         /i9hRThtqkx22JDTxN5abornaqFm/yg/sL9IQlgq9fffg2bwi6kpnDs+k2q3mFid3yaD
         IW9Hxu5pqCYaSOYxQLNL4ABk2E7I3D7QJxFNoPDE+c3wQisMmu8zh9qC/7J4vIzy2a1r
         VvXA==
X-Gm-Message-State: ACrzQf1ZQM6XAWcF4KC7Y7mRw8ZOyOsIdyrHLAElZqS+p4Wr2aBtv3qD
	lPPtavf9pOwoGcusVF2hB2pGXTOhSeCCAdYa
X-Google-Smtp-Source: AMsMyM4lcCaEI5NbydxMQzTA2QuXu2vJ0ctbpOr1mLlUocuUtNTklpMMkphgWsY0LYgAHkRFpQ0arg==
X-Received: by 2002:a17:90b:164a:b0:202:5f0f:290e with SMTP id il10-20020a17090b164a00b002025f0f290emr38263496pjb.27.1665494172533;
        Tue, 11 Oct 2022 06:16:12 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:12 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date: Tue, 11 Oct 2022 21:15:49 +0800
Message-Id: <20221011131552.23833-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221011131552.23833-1-zhujia.zj@bytedance.com>
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
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
 fs/cachefiles/internal.h  | 26 ++++++++++++++++++++------
 fs/cachefiles/ondemand.c  | 28 ++++++++++++++++++++++------
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a69073a1d3f0..690e3e1ee661 100644
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
+		kfree(object->private);
 
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2dcc8b6ad536..f6cc9a89b6d4 100644
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
@@ -66,10 +72,7 @@ struct cachefiles_object {
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
-#ifdef CONFIG_CACHEFILES_ONDEMAND
-	int				ondemand_id;
-	enum cachefiles_object_state	state;
-#endif
+	struct cachefiles_ondemand_info	*private;
 };
 
 #define CACHEFILES_ONDEMAND_ID_CLOSED	-1
@@ -303,6 +306,9 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+					struct cachefiles_volume *volume);
+
 #define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
 static inline bool								\
 cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
@@ -313,7 +319,8 @@ cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
 	 * a RELEASE barrier. We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */											\
-	return smp_load_acquire(&object->state) == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+	return smp_load_acquire(&(object->private->state)) == \
+			CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
 }												\
 												\
 static inline void								\
@@ -324,7 +331,8 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 	 * I.e. here we publish a state with a RELEASE barrier
 	 * so that concurrent tasks can ACQUIRE it.
 	 */											\
-	smp_store_release(&object->state, CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
+	smp_store_release(&(object->private->state),	\
+		CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
 }
 
 CACHEFILES_OBJECT_STATE_FUNCS(open);
@@ -350,6 +358,12 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
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
index e81d72c7bb4c..54581d59847a 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -9,12 +9,13 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 {
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	int object_id = object->ondemand_id;
+	struct cachefiles_ondemand_info *info = object->private;
+	int object_id = info->ondemand_id;
 	struct cachefiles_req *req;
 	XA_STATE(xas, &cache->reqs, 0);
 
 	xa_lock(&cache->reqs);
-	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
 	cachefiles_ondemand_set_object_close(object);
 
 	/*
@@ -222,7 +223,7 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 	load = (void *)req->msg.data;
 	load->fd = fd;
 	req->msg.object_id = object_id;
-	object->ondemand_id = object_id;
+	object->private->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
@@ -368,7 +369,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 
 		if (opcode != CACHEFILES_OP_OPEN &&
 			!cachefiles_ondemand_object_is_open(object)) {
-			WARN_ON_ONCE(object->ondemand_id == 0);
+			WARN_ON_ONCE(object->private->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -444,7 +445,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->ondemand_id;
+	req->msg.object_id = object->private->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -460,7 +461,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
+	int object_id = object->private->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
 	if (!cachefiles_ondemand_object_is_open(object)) {
@@ -506,6 +507,21 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
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
+	object->private->object = object;
+	return 0;
+}
+
 int cachefiles_ondemand_read(struct cachefiles_object *object,
 			     loff_t pos, size_t len)
 {
-- 
2.20.1

