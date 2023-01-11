Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8526653AE
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 06:26:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsGP22qc0z3cKM
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 16:25:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OmLcznBU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OmLcznBU;
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsGNj58t8z3cH1
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 16:25:41 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id s8so7316024plk.5
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 21:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDYD8kdF4QcIxV+XVTzksOOF3bsvD3XSTsyoZ+oU6es=;
        b=OmLcznBUhwb6V7Iv7/A44e+lcoabUFSifrsud2HZbjVV7xNimVZi/xOnDXpfOVYkOV
         0pgBY+uBOAHtdIjKnohFMo4hqlkBl9ZHyeqyzBaySzyKorNmjJiUSWtNAu1MnThr9bZ0
         03dCX3pZ6EOLf0aI13y7Ym+iM2d6scbetEoZSNrRqLYPoVSFETLAuGx1cNfb9JjnrSTc
         mT157ARyhoes8Nqvpe4yrO/lbpCdnXgoypUyCK5igRGq+PUyXMi/WFxz99+plbto03cw
         sJIne/4ds8ktscqloKaTaaJHVs23pSHwZOS/mCkjRrjfeSok1V4aNUnBCpmKLtHysNCz
         qxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDYD8kdF4QcIxV+XVTzksOOF3bsvD3XSTsyoZ+oU6es=;
        b=2EO4tjroWz5bVeXaZRC2RooOolNdb3Xeng/+HkCd3P8R8hkg2SZALGx1eP+W2wR2p3
         Fb6+GEgw/wuqeaeDW35sJjNCLj/9iWhVh6JOSZbgbn0zEYM843AkUcJM50KVeDPOi+g6
         IOour19lyVAbhCLsAckaFniSDJdtypmH+eF6k+U19QbgWW6Utfs8KRbS7j7SrdiLzUj2
         RfWbkciVvQQYILvdOqWLqEDmEF1avzBd0fvDBDqSwqeLBn5CgdkTnT7c97cdthQJi2mf
         dpAugxZMjqjgOaVefUQ+NmKZVwyZjIaFkQmXF4yznbf2D4FaN703M3ei11NgmqDY24c3
         vRYw==
X-Gm-Message-State: AFqh2kqK4ZWOaEKdWX6pVir3C5KC97dif97cCdEHY8CcUWmtwHHXdmiS
	xB0bF1Sbk67JMoPpNAmON34myA==
X-Google-Smtp-Source: AMrXdXv2i/melO+AoHL3yfAagLR5DbuQwlvc40wWx8sbnZnmAu95AVugnppbuaMQoO1kuzhzYqENDQ==
X-Received: by 2002:a17:902:968d:b0:192:8d74:99e0 with SMTP id n13-20020a170902968d00b001928d7499e0mr46324926plp.4.1673414739479;
        Tue, 10 Jan 2023 21:25:39 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:39 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com
Subject: [PATCH V4 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date: Wed, 11 Jan 2023 13:25:14 +0800
Message-Id: <20230111052515.53941-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230111052515.53941-1-zhujia.zj@bytedance.com>
References: <20230111052515.53941-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 15 +++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..b8d8f280fb7a 100644
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
+			xa_lock(xa);
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			xa_unlock(xa);
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ed836d4169e..3d94990a8b38 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -326,6 +326,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening);
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
@@ -353,6 +360,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 {
 	return 0;
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

