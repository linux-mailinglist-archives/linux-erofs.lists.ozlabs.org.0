Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7297F0B4B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 05:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1700453747;
	bh=bz3jIhYwuRIQTrKQv0iVXi5ds41jIbadiSwFXBU2nXU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PIFQ+1i+3s+2rfWF0R1hlv8nYuN+V4rWNgNETPs4122eU3Yz+3FnODhCchDN6FGOZ
	 dr47najhoClK4OLP4WNjIAw5qWG7h/5dw/rxnQemUw4mB1PSLwqPZmi0gzQZDRd3+X
	 I+mklX/eUYI/0K9X4Tr9XMoJg/QwoLrI9vSGz23LIRMokMY4om2r0Li5jnooxtvGM4
	 2O+P0m929NhstESYCPbRNHU0iYeuyCPMhy6O3Dopb2kY33KE82jye7yUHVRb0Bhjgv
	 LlFzFqluiSjhiLxmvkU2GMP5lVoNds1J43vN4aAYttiRCNlifcGShfNjJlLIojDlaz
	 LJi3hyB3shvaQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYZ1b50WTz3cN3
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 15:15:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dQe/I9Oo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYZ1G2LrWz2yq4
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 15:15:30 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc5b705769so35371605ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 19 Nov 2023 20:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453727; x=1701058527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz3jIhYwuRIQTrKQv0iVXi5ds41jIbadiSwFXBU2nXU=;
        b=DkMFHCTLk5Hyts0WlCuRy5VTqLAHQpWOsWC6UT1v2/F7x+yCVW2855Cpgn7GvdQu5V
         BtvzfK9dCsgx8FLMxaS6PrfLOBiL6xGu3U0bNXXcIt6t58Z1n0QApV1iBA8nVd3+56XE
         vL4AJBV6xC291fZxQG7BHUZwexHnGNAJk+B0WjTE1PnA3oUIjKhjTzt5vUNNnbmWgcPz
         TX/Zi8rGaaQbTrg8nA5EMxQTxGp2FfVSXMAybCJmhbrq+uBOJEX8nuKUT5GLYOyqcPJG
         nkyKELNLj/CnuwJVz/2WX0jLOJhTW9n8QJYwX7yzHsRvJWXLy292GuaxnZWfis+UARSp
         QbGA==
X-Gm-Message-State: AOJu0YwxVbd/T5XxugAcBTM0he5Hn28aaQFQLRbGNGn+QeqS0LNEmwWy
	SOxq9t4yTCU7CrKezfTq/HecOQ==
X-Google-Smtp-Source: AGHT+IGz6PiCdVG7TeVF99IUhEgj/RacwYre7R6jqcbwDOVc6nbMTswKqx6m5gY/+n6FnYNy7oIWGg==
X-Received: by 2002:a17:902:eecd:b0:1ca:1be4:bda4 with SMTP id h13-20020a170902eecd00b001ca1be4bda4mr6685850plb.4.1700453727298;
        Sun, 19 Nov 2023 20:15:27 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:27 -0800 (PST)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V6 RESEND 2/5] cachefiles: extract ondemand info field from cachefiles_object
Date: Mon, 20 Nov 2023 12:14:19 +0800
Message-Id: <20231120041422.75170-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c |  7 ++++++-
 fs/cachefiles/internal.h  | 26 ++++++++++++++++++++++----
 fs/cachefiles/ondemand.c  | 34 ++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 40052bdb3365..35ba2117a6f6 100644
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
index 00beedeaec18..b0fe76964bc0 100644
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
index 90456b8a4b3e..deb7e3007aa1 100644
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

