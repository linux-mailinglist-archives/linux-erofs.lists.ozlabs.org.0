Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358E6E2931
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 19:23:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyjwG31pXz3fVx
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 03:23:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681493022;
	bh=ipz6nTPRZ3Cs9OsNmMIh4U9rG9HmGZtivZr/8M/3lr4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZXoaY+TVH/gMZjl/Yij38uZJNPUwUOcx/GZ0GfbYpuVf+e5mbe7JR9uxo5wneilme
	 hT2PVLxgOU8BNKV0vMmfVXgG5rb6oI/yI2znifCuMEoOG5eva0Tflbyg/okPXzTPx0
	 krKptblMNZdB92B28JikJ1ZTan6W49HsrzGjTKgREYbOBWqz4AkhJTxFfesp82fX2G
	 WgPNCdOO61caeNnJYYVgKl9WlxCfzUqEbRcjjCjNBep7CxDM+Z+tjqxrQ8N7nbvj4B
	 Ueru00k7Ic3eKLAEc1NSxKgZlaaWuBFV8n2Ggewe7GDXH+48gI854bS9DWlJQC+qsX
	 0KnfsPSBqtkIw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UJtia1KQ;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pyjvz6sGsz3fVJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 03:23:27 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso5678726pjb.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 10:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493005; x=1684085005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipz6nTPRZ3Cs9OsNmMIh4U9rG9HmGZtivZr/8M/3lr4=;
        b=eqCbBctJWv6kK5hhzyRRgk5IlK8C0nqTsEd8Pv/sRB/Tq+p2Sj47EdcFzxZ/yBWIXL
         QPdSqlFVBbSru186+tr6YmBT+HYzCXrGJ3/J7E+BqeA1yR2Jvm+IbQWXl8eJnwkfg5G+
         w01hoObg14z7SNGiU5Ak16wkeAiCPFam1PbwXllWqM0pShrr8jujLmzFfjx4/T5ZZa5C
         exLkYqT9uIQ283s2WH764acnxs1Wghw2H+wQqKfddPD1ThdLU8JgfXpgWIBLdlBzUzoU
         G+MivlCIPdOpnoITVF5c1985s9Zd0lu4LWPwizOobeb/pbxMlj8mRvvs91gLHXgp6sHk
         /ttg==
X-Gm-Message-State: AAQBX9ej/GJ0bPY2aPv3yM1vGT/7QQ89dbjCysDJu1X7970aO3pQtoR/
	MAxK1HEfDsjBrZzUS9u6L9vJ7Q==
X-Google-Smtp-Source: AKy350bQmej5oN9HI0IU11IlEP/9x2ufpFK+o2Abgu/ZkZdz4tbF9Wu6v4eJ8btTafN+eQoyRPPeIg==
X-Received: by 2002:a05:6a20:4694:b0:dc:925f:62f1 with SMTP id el20-20020a056a20469400b000dc925f62f1mr5685706pzb.6.1681493005739;
        Fri, 14 Apr 2023 10:23:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:25 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V6 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date: Sat, 15 Apr 2023 01:22:36 +0800
Message-Id: <20230414172239.33743-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230414172239.33743-1-zhujia.zj@bytedance.com>
References: <20230414172239.33743-1-zhujia.zj@bytedance.com>
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We'll introduce a @work_struct field for @object in subsequent patches,
it will enlarge the size of @object.
As the result of that, this commit extracts ondemand info field from
@object.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/interface.c |  7 ++++++-
 fs/cachefiles/internal.h  | 26 ++++++++++++++++++++++----
 fs/cachefiles/ondemand.c  | 34 ++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 40052bdb33655..35ba2117a6f65 100644
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
@@ -88,7 +93,7 @@ void cachefiles_put_object(struct cachefiles_object *object,
 		ASSERTCMP(object->file, ==, NULL);
 
 		kfree(object->d_name);
-
+		cachefiles_ondemand_deinit_obj_info(object);
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
 		object->cookie = NULL;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 00beedeaec183..b0fe76964bc0d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -49,6 +49,12 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
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
@@ -66,8 +72,7 @@ struct cachefiles_object {
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
-	int				ondemand_id;
-	enum cachefiles_object_state	state;
+	struct cachefiles_ondemand_info	*ondemand;
 #endif
 };
 
@@ -302,17 +307,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+extern int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+					struct cachefiles_volume *volume);
+extern void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj);
+
 #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
 static inline bool								\
 cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
 {												\
-	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+	return object->ondemand->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
 }												\
 												\
 static inline void								\
 cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 {												\
-	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+	object->ondemand->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
 }
 
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
@@ -338,6 +347,15 @@ static inline int cachefiles_ondemand_read(struct cachefiles_object *object,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *obj,
+						struct cachefiles_volume *volume)
+{
+	return 0;
+}
+static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
+{
+}
 #endif
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 90456b8a4b3e0..deb7e3007aa1d 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -9,12 +9,13 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 {
 	struct cachefiles_object *object = file->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	int object_id = object->ondemand_id;
+	struct cachefiles_ondemand_info *info = object->ondemand;
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
+	object->ondemand->ondemand_id = object_id;
 
 	cachefiles_get_unbind_pincount(cache);
 	trace_cachefiles_ondemand_open(object, &req->msg, load);
@@ -368,7 +369,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 
 		if (opcode != CACHEFILES_OP_OPEN &&
 			!cachefiles_ondemand_object_is_open(object)) {
-			WARN_ON_ONCE(object->ondemand_id == 0);
+			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -438,7 +439,7 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object->ondemand_id;
+	req->msg.object_id = object->ondemand->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -454,7 +455,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	struct cachefiles_object *object = req->object;
 	struct cachefiles_read *load = (void *)req->msg.data;
 	struct cachefiles_read_ctx *read_ctx = private;
-	int object_id = object->ondemand_id;
+	int object_id = object->ondemand->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
 	if (!cachefiles_ondemand_object_is_open(object)) {
@@ -500,6 +501,27 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 			cachefiles_ondemand_init_close_req, NULL);
 }
 
+int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
+				struct cachefiles_volume *volume)
+{
+	if (!cachefiles_in_ondemand_mode(volume->cache))
+		return 0;
+
+	object->ondemand = kzalloc(sizeof(struct cachefiles_ondemand_info),
+					GFP_KERNEL);
+	if (!object->ondemand)
+		return -ENOMEM;
+
+	object->ondemand->object = object;
+	return 0;
+}
+
+void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *object)
+{
+	kfree(object->ondemand);
+	object->ondemand = NULL;
+}
+
 int cachefiles_ondemand_read(struct cachefiles_object *object,
 			     loff_t pos, size_t len)
 {
-- 
2.20.1

