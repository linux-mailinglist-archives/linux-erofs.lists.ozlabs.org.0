Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4795FE763
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 05:11:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MpWcP3CwVz3dqt
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 14:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=22pn9Os6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=22pn9Os6;
	dkim-atps=neutral
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MpWYh444Dz3c7K
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 14:08:40 +1100 (AEDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d187so3670053vsd.6
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1R7QPYLS3htwC9+m+eMmhkdxMHPXqw45xmXhqmncaA=;
        b=22pn9Os6EXT6UWfc9ZeKQ71GM5Bhmq9AlSEpgZrKl0IUo/yufgpYJMahaOmGApuHFQ
         0HjgOrbOd3sJY2g4HJFuY1sgb4TaAlQP3aRsz10/ANjJZl4lMgHQsK7sWfd8Y0DMkh+C
         Dnl17PUMBTdKkOZPaPAnFJ/golfWNeftyDK3tNB7RN8JVIyFOYWbhGQkwRm4hg/oIKKh
         XWwkEhfZvnj2wPG3jNFSKte8oOALG7BsAxuzpit/Iy/IXoZtVY0BmdVKoGN2ayiG8T6J
         v607OE1Wb3Zg/vDA9PphT7Zvanzlont5JanwatBkMlDh5o+XUUb8SSx2FdIDrQQBfhxj
         TvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1R7QPYLS3htwC9+m+eMmhkdxMHPXqw45xmXhqmncaA=;
        b=VXJcKMzkUv/mS3C1WWViqgMZ/j4blHRNWZIRttae2twxLGrX5bkja7tXU5lp9pu1Ef
         3r5USUKbCMIN9ZnRVPpaqXq5Q8mLMWIMQwzdmzxBUON21TgGhQl5orYhRpzLhTe9m7MN
         YqfwTiODhnEGEFYVG7Uv3gVxI5QMWza/eQiVxRcoA6fiDeiCNk5ay4OALiBRJNJf67mU
         HT3DQiqjt39kwz1TAty3XmBK6P+pKTN93Aktlx9nwqa4J1cVAV52ysePdy1+TjHbPyiu
         qFNIDsjtXoiy2Wr2Xa23r58Oub1BpRuuoTRn99UNPdDwMjlvvtgulO9wximz8fpAdTDC
         7yCg==
X-Gm-Message-State: ACrzQf33KCfiu3rrj+FaosR+DnPtXdyHpCdEWo6cTaYlJf8TjhYjI68E
	tBvhwBK3K9uFrdCsZAsHwpcPJyTbRADbBhyW
X-Google-Smtp-Source: AMsMyM5Ejyc0D+AQNsiKQu3QB+Vg9yCW8ZNFcTSVKsMfVupUu0uJQ3sNLvSheHGNJWaShgZirb4OmA==
X-Received: by 2002:a17:903:1003:b0:181:6c26:1114 with SMTP id a3-20020a170903100300b001816c261114mr2921922plb.75.1665716906763;
        Thu, 13 Oct 2022 20:08:26 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:08:26 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V2 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date: Fri, 14 Oct 2022 11:07:44 +0800
Message-Id: <20221014030745.25748-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014030745.25748-1-zhujia.zj@bytedance.com>
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
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

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 13 +++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..c74bd1f4ecf5 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,23 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
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
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 21ef5007f488..98d6cf58db11 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -327,6 +327,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
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
@@ -354,6 +361,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
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

