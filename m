Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C15FEA1F
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 10:07:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MpfB70vv9z3c6r
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 19:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qVTtmipa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qVTtmipa;
	dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mpf9p0CcZz3cd2
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 19:06:53 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so4197760pfp.13
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJhr9GEso5XW6jomGaYhGKFuz4nHt5uQZJthz4evrwY=;
        b=qVTtmipam3rM6KfQlKjS9oB81qvNT4EbK05pZ/u8KhqTeMxi1fgQuugD0vIdferh4A
         YbPU1ZdtYPR/ZPK5WVwhOLx0PTxgdovGreGSp3BwRvbk/eVN1SZMEkZTSXOGevy3iugB
         AogReglRz/ngZipTLIK2lRwUlzQ7E6noznmewO+dUqWDsZMVyqKhugFDig/QBvybFt8t
         Vsx7w7v2uUUB5MSDzYmRU6/oD4TB2PLfO4YaDpnr5j9n7LFnLE8L91zITpD9smh490eb
         0/OSLFJHUGkje4f/2tYzx91hXBA5zHhogkFUEypk+BKxWcCeQ66erKddmZAiYYVM9FTE
         hyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJhr9GEso5XW6jomGaYhGKFuz4nHt5uQZJthz4evrwY=;
        b=DHVyurSffmvjd6VaVJdWmoVviVzJBqFf9Tsu2t4KHH31EP/Wy9XbuiAM/5xbl/Od7E
         CV1GjjZH7SRDSNrxR8RV2t78QOG1MsAJNtUJOKwR6LXoqEtrg8egNWN69mqcHorzDrpL
         RVf7XtGfbgHnwDaRtPXOyu9w+CRxo1MsMxoK1ZvQPXHmmPCAL52RmQ5gpJ0Jt8Elbcve
         c6Lj0l88bMjjrf0xBscVI8DtrRGscW2gRnH6u0IXEWfQXaqlvqWlZiTMU/A69z7su7Un
         9ZMKs615qXKUesFwVlCvhL3AcmHbNMDsNd0szhcnZBlzvwL65oqjhqzzmjcnlMGJyfPf
         2C7Q==
X-Gm-Message-State: ACrzQf0Y9XwJn0IuyrTMgQAW0RQzyu6BNFVuOYuRq/rm8ONdffvguIEL
	1YDaLJHkqon4vtr4dkLYNIAWcQ==
X-Google-Smtp-Source: AMsMyM5JxpG9s5zxrgZFOJc1qRRC6V0WPzYraBHHSO028+hk4ZTnTxwCa5/lFVyTrnav5G/YHeoJVg==
X-Received: by 2002:a05:6a00:1a0e:b0:547:1cf9:40e8 with SMTP id g14-20020a056a001a0e00b005471cf940e8mr3894976pfv.82.1665734811751;
        Fri, 14 Oct 2022 01:06:51 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:51 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V3 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date: Fri, 14 Oct 2022 16:05:59 +0800
Message-Id: <20221014080559.42108-6-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, in ondemand read scenario, if the anonymous fd was closed by
user daemon, inflight and subsequent read requests would return EIO.
As long as the device connection is not released, user daemon can hold
and restore inflight requests by setting the request flag to
CACHEFILES_REQ_NEW.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   |  1 +
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index c74bd1f4ecf5..014369266cb2 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
 #endif
 	{ "",		NULL				}
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3d94990a8b38..e1f8bd47a315 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -301,6 +301,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d8dce55d907c..c773ea940cc1 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -182,6 +182,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
+	 * requests have been processed halfway before the crash of the
+	 * user daemon could be reprocessed after the recovery.
+	 */
+	xas_lock(&xas);
+	xas_for_each(&xas, req, ULONG_MAX)
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	xas_unlock(&xas);
+
+	wake_up_all(&cache->daemon_pollwq);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
-- 
2.20.1

