Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920025FEA14
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 10:06:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mpf9r2r7Vz3bwQ
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 19:06:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=K1qiidBa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=K1qiidBa;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mpf9b20x1z307g
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 19:06:43 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so4039670plb.10
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUNmB6S9jkYzZMjtNGXZtdFizVu+vOEWVlJtmuAd/sM=;
        b=K1qiidBafyGVJuBIrZZf5epw6s41L5yPdv6+KQS8m67IMUDq2vow0B9ByUHGf7ZNXw
         zgj7P2o8VH2/T33qOjIBGnZp7LYi7JgzDJjnMQ6/voXJNuUJ1LeuFN6A4EXksf4h6EqL
         9FzSX/ZkwMVBjlB76mTVqhrz4LH9BxBTjymprtDVGBOilBakxcZjwxsY0ivJ+9CuWb5T
         vIjEAPwWdTyUYU++vqhfYueCkxLhXrjo4ID6wb32bB87pGGiPnR2ZpTKAUAI4wv8Lxcy
         GO9+DvilKlGqMklov1dvWdVlAAIVlvhj6Di5vHgickhzro+mz1+4f/9Eeoya5XFDvqSn
         nDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUNmB6S9jkYzZMjtNGXZtdFizVu+vOEWVlJtmuAd/sM=;
        b=EfK9j4rP9dtlXjLAu6fmzR/cv1Z1OR6bfGVdPYMdQjJbNI3n7RjsrlgTCT1L2QDA8D
         CK78P+gorSYjqdmcAaWohh9Mo8FYRjIhE149i63eOC/i96ajLzReEwgq986rUk0dvY3j
         3SaVFwkH4YL4REXtF6sqmhYhGJ9oaVosfYjyQXUpRGtvY07/uo3abB91kuytZnq3Fyvb
         i4hQ3DE+MPgeCvAMPn9cPW/+MyloUVqpK+sWfLZw9tqWBFh1AErPBcSWDfO3NiBFOZIQ
         NSQ2I7kxa4ydJdN86pX48yUNW7l6zPUDkGmYLMXiw6hH/Pb6aX3KTrvwcE6zfHlRJYzA
         yXbA==
X-Gm-Message-State: ACrzQf3aRfksXHuckrQQDqCgXABHIme8uDs9kHsbRoX5ZWn7yoG0ptOF
	14TYVpjvJU7gOVspcEhhoRe2ag==
X-Google-Smtp-Source: AMsMyM4+QTDVe0PSOfko1jnOnb99TRszP8FZFZUtSLXmLusfUA1j9vn62i4e9tauPA02Mw0XOV3/EA==
X-Received: by 2002:a17:903:11cc:b0:178:aec1:18c3 with SMTP id q12-20020a17090311cc00b00178aec118c3mr4226294plh.91.1665734800983;
        Fri, 14 Oct 2022 01:06:40 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:40 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V3 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date: Fri, 14 Oct 2022 16:05:56 +0800
Message-Id: <20221014080559.42108-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014080559.42108-1-zhujia.zj@bytedance.com>
References: <20221014080559.42108-1-zhujia.zj@bytedance.com>
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c |  6 ++++++
 fs/cachefiles/internal.h  | 24 ++++++++++++++++++------
 fs/cachefiles/ondemand.c  | 28 ++++++++++++++++++++++------
 3 files changed, 46 insertions(+), 12 deletions(-)

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
index b9c76a935ecd..beaf3a8785ce 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -49,6 +49,12 @@ enum cachefiles_object_state {
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
@@ -65,10 +71,7 @@ struct cachefiles_object {
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
@@ -302,17 +305,20 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+					struct cachefiles_volume *volume);
+
 #define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
 static inline bool								\
 cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
 {												\
-	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+	return object->private->state == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
 }												\
 												\
 static inline void								\
 cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 {												\
-	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+	object->private->state = CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
 }
 
 CACHEFILES_OBJECT_STATE_FUNCS(open);
@@ -338,6 +344,12 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
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
index 90456b8a4b3e..6e47667c6690 100644
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
@@ -438,7 +439,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->ondemand_id;
+	req->msg.object_id = object->private->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -454,7 +455,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
+	int object_id = object->private->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
 	if (!cachefiles_ondemand_object_is_open(object)) {
@@ -500,6 +501,21 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
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

