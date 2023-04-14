Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776706E2935
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 19:23:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyjwS2kv3z3c6f
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 03:23:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681493032;
	bh=jLxzEPuRQOpnZLaEq6SfAsMRmsFnFoLhYkxVpQU9ODc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f87e7JXjP6klkoCGh+aF6nJFR6MRPedA1QE7W0LdeadcZEyum3oPcJwXxvyaANmml
	 RVdC59+Ay0yK1GceAZ8UBUVjb58QhVnHJYnXkL8QCvFnjZpCnSrN4OU/PNI4/28yGE
	 0OZtJdkoSUZOtl0k54xTtBnWInHX1R7ehk0NnjCYdbBwRIxnWqGRJ7rNMZ7K8lhlLZ
	 gyr7bKslKAthHaSi610OwN/jxzb5RaP0+rXwBpG76P5guqZ6ZxrfAJynEuZmu8wiWs
	 VjWrccFoJbnUliZc6ywcPE5qTSALUBHmlc8wg919TIaGJCkOi3ZoSVTh9BNM+Y32x0
	 wp7ZOsmaWAd4Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BRc8Yf2c;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pyjw54ZPmz3fWc
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 03:23:33 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso5679084pjb.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 10:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493013; x=1684085013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLxzEPuRQOpnZLaEq6SfAsMRmsFnFoLhYkxVpQU9ODc=;
        b=YGN1cRBinRjty9prN8bja8H7iDY5J2xg6pqjWdebKfmXFpekNflWCP2DJCGKJViVbc
         Fh0Ka8wKZkpbhbeSDUnjcwukD6ji4UoiXLpSYHyBZRd7vHAMYZ6ZhmDvlex7sdbGbZ6O
         dVcU4KS1h7EaqBI+ynqFrQQ3CsprMoeD5uwFNaWzvYypfxn0ztgUZ3hHQhxVgV3Hsp71
         UNQ5hdXx2zdKJxlERdzxpwTQ9bb5UPw+8yNI9awT+a0CRUS/OymwqzldqKXj4kUIG1q2
         s4eHWTh/6fZQUlzEG+MCkNnYmtRtlKzhq5Zoq/UdB6aRNlqYhlrsGrT4CbgH/scx3z8C
         Umog==
X-Gm-Message-State: AAQBX9czOAoDmW4n3ivuoj8trJuADNtbDsNI1gKPYOBFZ2scNw+Kf8f6
	aTLTNbUh5arWtAM3wPzjTBFPfA==
X-Google-Smtp-Source: AKy350ZlZsrNyqeh3U1slp9rUpz0KUQlUzMaBR9xIRDcSaraCogNI9a9HQahcjC0ZgcUIst42pl5Dw==
X-Received: by 2002:a05:6a20:7347:b0:ee:818a:3497 with SMTP id v7-20020a056a20734700b000ee818a3497mr1941553pzc.35.1681493013176;
        Fri, 14 Apr 2023 10:23:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:32 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V6 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date: Sat, 15 Apr 2023 01:22:38 +0800
Message-Id: <20230414172239.33743-5-zhujia.zj@bytedance.com>
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

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 14 ++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e37..70caa1946207d 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,24 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	XA_STATE(xas, &cache->reqs, 0);
+	struct cachefiles_req *req;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(&cache->reqs)) {
+			rcu_read_lock();
+			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b9a90f1a0c015..26e5f8f123ef1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -329,6 +329,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return cachefiles_ondemand_object_is_reopening(req->object) &&
+			req->msg.opcode == CACHEFILES_OP_READ;
+}
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -359,6 +366,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
 {
 }
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.20.1

