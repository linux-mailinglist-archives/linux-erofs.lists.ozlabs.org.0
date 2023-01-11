Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB26653B0
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 06:26:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsGP74TZlz3cYd
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 16:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lSpQZ5Nl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lSpQZ5Nl;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsGNs0FnZz3c95
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 16:25:48 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id dw9so13303060pjb.5
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 21:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIpHcwHuLOh4SwnFnBbeF8LhMIZd7B1uohTZsNHDUqE=;
        b=lSpQZ5Nl1oGZSNpIMCryP8PrFoR67A6GlkkwW9vZo8CD5btOX8PPc93muHthaWNoKy
         D7CXmW0L+PtqlbTMaYsKksxeEXV2J8Jtlorc6bsUuGpLizxf7K7risMkBcP7+WH8b4d9
         cmYK91t3GBHw7IxZT/XQM/4Bv0vbcGPGoMvsNB167guolV2JvVEHqur5YyX67Zk2uC+5
         9iNih8DPSpq0lJeRqR3bo99I4HxVwMdBli9ioY5G6clMrBrOWbm53/xq9j/SZtwlfpgh
         SLY8jNvHJbxEAnHLYa/sF6JQItsls4Pvnu846zRgjyotBkLOpjMHwXFe+ZI6VsWsBBNZ
         bOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIpHcwHuLOh4SwnFnBbeF8LhMIZd7B1uohTZsNHDUqE=;
        b=r0JR27t8thJoWv85hSeVLjnWtOENANPGgE7WOw9DhPYWGiFAx9KM73eCEgBzTRhHdA
         PHoosNu1DaaCx+/M9etxchVBzMBc12BlTPaviBEBM6aJkHyX7y276uVNsdfVpjgp6f1b
         OgsoIy9UH4mG2f3JqtsB5uqPxVLISB+C6Z2u5pkL1rs0wqvilHKj+JsfZf2jEwQyhm9D
         lH+g26J/VQd0utI2l57xtIkXDV2E4BZ6PwkjQ5l2WJyI4sC4aSgnXosypKiVscMnPVmv
         1Wv+L0w105zvMb/eyur1EAfHI+VtA7EZk9qHdl0vEyaen4y3Vl+zGvbvZlwCxUQD4Ebo
         Tixw==
X-Gm-Message-State: AFqh2koEwjZtzaE5vFI5Vu6WJF5XqddEThlPDZeXc45G3jpMVWLPbBPU
	qylV2ObjlWPOSuJOw5Kq8AoDmA==
X-Google-Smtp-Source: AMrXdXvB7/2u85kjEwGxlcNYhbcb8dmOh3QsdpsZJEqb49naEuncdonDNg0WEQwkdPL58RcJMt18ZA==
X-Received: by 2002:a17:902:9a0b:b0:189:d3dc:a9c4 with SMTP id v11-20020a1709029a0b00b00189d3dca9c4mr65777152plp.36.1673414746818;
        Tue, 10 Jan 2023 21:25:46 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:46 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com
Subject: [PATCH V4 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date: Wed, 11 Jan 2023 13:25:15 +0800
Message-Id: <20230111052515.53941-6-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
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
index b8d8f280fb7a..5d9ec62cdd5e 100644
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
index 8e7f8c152a5b..711b47448c85 100644
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

