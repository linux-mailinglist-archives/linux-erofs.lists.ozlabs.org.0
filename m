Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D328E5984BB
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 15:52:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7mYM59jVz3c2W
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 23:52:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2EvxctSr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2EvxctSr;
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7mYD0DsTz306K
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 23:52:45 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1936564pjl.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RqIFS3uQuz8ZCr2lEZPiUaSyj69GXTkqlo83y6u621E=;
        b=2EvxctSr5Q1/SEgne3HxcS5c+B/3gWCA39X7INMzilFPkSA9H+kby2xQzG7rcKBZFd
         f80LGnLpUjBedwg6SVbJeuaqRtPjTS5pUQdzctsm2V2wDR7Ny7N7r2XrKP3+Lj0S3bEW
         CJVROTC5Q24ZFdOkFCI4X/0WOHUhLkuglMyno53yIAjgarw+KlzOJhtLL3hITb8uelAC
         yeruTZjyM+f6056n4AFa/ZfbsSh1HNyL3hehweMvPJeMrMQ7OuWPTtoVqYNLLuyF1ZlA
         JN5kAYtC+JQLwCFeL+bsSh4gkqeOrteyAkrX5wg+MTnIyl3y7b5ZuavzGXb2JViNWRA/
         tDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RqIFS3uQuz8ZCr2lEZPiUaSyj69GXTkqlo83y6u621E=;
        b=63ezqF9U0sM/28jliRO6sMVh+wq0pUrQdI4E8FS5Cv+YEp5xJt1+wcVUeqUo53UjnZ
         Nn63oT5FiQ/i8y/ebaFbDuZY+FaoAn1c/vvawy9t5wJlErpMLNPqv5VoplIUJsimdrAE
         l6y5R9s6M1hTSMJ4w6j8PdhCy75ZG0ah7c980GMIxzkWpM7GnYHvkcocf0ycNUimLTAj
         Cq1lQ3uZ7VBLbdLnglcyCTNTp5WgYiT5U7QrZ92vMnDVcmst/D5UepUiFigA5pHEDsoI
         X9ynd+BzoH+H6rmWybukMJNIlhXQHoRTkfsJUwmk+OKRx0jekRq6wTwtdZyy4H9h2S1J
         zzLQ==
X-Gm-Message-State: ACgBeo3F6FNNVnsAL4A4oR1XdpSiIlQg8tT/EVDgi/8eEk4/tNt6AC+A
	+yT+JY3bRFwoIpKNS/hGjfLHow==
X-Google-Smtp-Source: AA6agR4SjEpLT0u/4ZBNuQ8cCRUtgkNLidJHqdyeYP8+AO/WKZHP6NeAErRqiv9WYEWSQg06XXdwFg==
X-Received: by 2002:a17:90b:3ec2:b0:1f7:3f49:17c3 with SMTP id rm2-20020a17090b3ec200b001f73f4917c3mr8674863pjb.203.1660830763941;
        Thu, 18 Aug 2022 06:52:43 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:43 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [RFC PATCH 1/5] cachefiles: introduce object ondemand state
Date: Thu, 18 Aug 2022 21:52:00 +0800
Message-Id: <20220818135204.49878-2-zhujia.zj@bytedance.com>
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

Previously, @ondemand_id field was used not only to identify ondemand
state of the object, but also to represent the index of the xarray.
This commit introduces @state field to decouple the role of @ondemand_id
and adds helpers to access it.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/internal.h | 33 +++++++++++++++++++++++++++++++++
 fs/cachefiles/ondemand.c | 15 +++++++++------
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..6661b3e361da 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -17,6 +17,7 @@
 #include <linux/security.h>
 #include <linux/xarray.h>
 #include <linux/cachefiles.h>
+#include <linux/atomic.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -44,6 +45,11 @@ struct cachefiles_volume {
 	struct dentry			*fanout[256];	/* Fanout subdirs */
 };
 
+enum cachefiles_object_state {
+	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
+	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
+};
+
 /*
  * Backing file state.
  */
@@ -62,6 +68,7 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	int				ondemand_id;
+	enum cachefiles_object_state	state;
 #endif
 };
 
@@ -295,6 +302,32 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	/*
+	 * Pairs with smp_store_release() in set_object_##_state()
+	 * I.e. another task can publish state concurrently, by executing
+	 * a RELEASE barrier. We need to use smp_load_acquire() here
+	 * to safely ACQUIRE the memory the other task published.
+	 */											\
+	return smp_load_acquire(&object->state) == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	/*
+	 * Pairs with smp_load_acquire() in object_is_##_state()
+	 * I.e. here we publish a state with a RELEASE barrier
+	 * so that concurrent tasks can ACQUIRE it.
+	 */											\
+	smp_store_release(&object->state, CACHEFILES_ONDEMAND_OBJSTATE_##_state); \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open);
+CACHEFILES_OBJECT_STATE_FUNCS(close);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..e3155a5f32e4 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -15,6 +15,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 
 	xa_lock(&cache->reqs);
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	cachefiles_ondemand_set_object_close(object);
 
 	/*
 	 * Flush all pending READ requests since their completion depends on
@@ -172,6 +173,8 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
+	cachefiles_ondemand_set_object_open(req->object);
+
 out:
 	complete(&req->done);
 	return ret;
@@ -353,7 +356,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+		if (opcode != CACHEFILES_OP_OPEN &&
+			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
@@ -420,7 +424,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
 	/*
 	 * It's possible that object id is still 0 if the cookie looking up
@@ -428,10 +431,10 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
 	 * anon_fd has already been closed.
 	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
+	req->msg.object_id = object->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -450,7 +453,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	int object_id = object->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
+	if (!cachefiles_ondemand_object_is_open(object)) {
 		WARN_ON_ONCE(object_id == 0);
 		pr_info_once("READ: anonymous fd closed prematurely.\n");
 		return -EIO;
@@ -475,7 +478,7 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
-- 
2.20.1

