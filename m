Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B27416CDB6A
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 16:02:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmpCp4VgCz3c6y
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 01:02:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680098566;
	bh=201B13UZk/ur2kBlvNBkJlC5f80F32l3qYGjPhn9UGk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Dfm6ygLC72TSwkujw+iyYerhZgk+aPVqKnnvccXvoiHbAz/52W1YQy+xEqnzl/jfL
	 tpawrAe0Ot+sBoIEShMm+qSRQDg/B4Flx9+SeI0eEZfMJ2e1Sm8fscWimZ6PnX8kkU
	 rKTbN8+jcFOp9i6c/D7tKPW93IkL05cz/oAr9E7a5y57/PdiS0/EdmBlFDSPaRz4wM
	 J7A5tMPTynQbaOPUQBJA3IhgFZ5FyqiIoOCcUXNx/xq7ni5KPbxB8ADr/JDHDsWaMb
	 lqyCi3PZbiUGFJB9RoOplgdcQWpvInwvLaXg/xnmR73YIsqbVP8voU/63PXksuwNU8
	 cQUklE4D5zvcQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=l589k9Vc;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmpCS27Lsz3f53
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 01:02:28 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id x37so9333696pga.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 07:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=201B13UZk/ur2kBlvNBkJlC5f80F32l3qYGjPhn9UGk=;
        b=GLEQB7t1CSFv/4L0rY4nVI1IdM5++M4qI69z/hBx1DOAff8EzbXV3wrpJMZDgKvgdx
         g2A4Vv0+vesd0qHOCBZXy0MnlPXVNutY6d0BiB9+BIPneJaFaVWW5F9q0tyn8DFr9KnS
         +ZEDqn/wvJ+Xco12xdkK5YaCyroltLciPdFPJ2W9/qjtkK3DKg9DAJlOgFfOO9irf+2c
         x9mLs7lgAEYb6BNTfTFplnslH6msGc0UZfIBeiHlCkmWLiAl51GVWnlwKdBNTsrhBqij
         GUlyok0MxYcXiYYPRdPSlWi0azNyrdk8PQvovi/CIptOgA9+/pmTtU1iEnfnj+yHqH2m
         nDKA==
X-Gm-Message-State: AAQBX9d0YISDXAJCXZRRkB7+VP8KjW8xPl9T8BG0UBM3Y/4Evaxde9Bl
	+g1NSUztsC19zjUh4Enf9/518g==
X-Google-Smtp-Source: AKy350aS4UxXoOIsHELZC+pNvz0Orc/jDx6TWEB+8m6gvhUkHKqYrpdjkPrCG/VD3G35YcxyACiV1Q==
X-Received: by 2002:a05:6a00:1d0f:b0:629:3f28:ead1 with SMTP id a15-20020a056a001d0f00b006293f28ead1mr2194928pfx.12.1680098545899;
        Wed, 29 Mar 2023 07:02:25 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:25 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V5 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date: Wed, 29 Mar 2023 22:01:54 +0800
Message-Id: <20230329140155.53272-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230329140155.53272-1-zhujia.zj@bytedance.com>
References: <20230329140155.53272-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 15 +++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e37..86892f471e761 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,25 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(xa)) {
+			rcu_read_lock();
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
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

