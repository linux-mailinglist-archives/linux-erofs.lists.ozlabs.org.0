Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBE6CDB6C
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 16:02:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmpCt420qz3f54
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 01:02:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680098570;
	bh=sqFkGHmM/dJ9kF1cZmCY3mrpL1ZG3gGE12XFAvwXSFw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MxkhBWdCkYMEQcC+DF1iSc6aYUtwqg0+eXsrLVqqr1blHO94/nYVYlTnou/W7z6BH
	 Vcokh8N5lydkjeN2uqdYR6pD1UvIs+1CdEJzqhMQ/nlSb3PND/LrG80TFNXraHwOgQ
	 k4Q1/13NJHglwE6QI6kSqyoqTLT0lI8bJ4HpOTZe2hpt0lorB8VQAU7eaCkynGBdvS
	 l6NP/oLNE0foThiRjHkivrJfNpZWVogVamQx8J3VoX2E6OoakIAyIQVqKKKGZwLLtu
	 f3BfiDRpmMPBuRPTBWWNiOMVLcg8QrboILWqcpna+kBAeQZKCgXTCEyZ0QeKP1Deaa
	 rcTDFZHS1M0IQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HisIVLRz;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmpCW6JGnz3cjT
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 01:02:31 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id k15so9320121pgt.10
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 07:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqFkGHmM/dJ9kF1cZmCY3mrpL1ZG3gGE12XFAvwXSFw=;
        b=8HJiqQ2ah1YVm34VJoeRLeavAWM/fFLQu17Amr35xebtXdp+iVXCJGzBhwG+mv03yC
         RDlfv6Vc5gFOVm6dlBAHedjv/yrinUA9H7fQgZzkJtKuIm2No5pN+e5/FPuZ3FSO4msZ
         C+03RH3lF+2JxSB6XRW8thRfjbohj/S08gAB/l+5c26AnjnzuN2p5yGnS1PQWWHdq/zW
         Im878ObqxfiF5ayWXlM58MIQKH8SXgy1PmYa9mu8KFQz9WdD/wcjwBE+232KzDkeSq0r
         ae1M1trD3hCPZaZrNVfPJ4b/2fIGbtvWgjEJ/kR8/0K3Dp1/v6kR7HurjsS+rQdMSagW
         PF/Q==
X-Gm-Message-State: AAQBX9doMCm0hnCg/DsFHL8O+RYWsQEt9+r9TagzNOvlNaDovJ6CPFJG
	LLKAzHfKyTZt1lQkJQG3X4obNfQ/dPLCNsoqvbk=
X-Google-Smtp-Source: AKy350aIQGtdpdkmlvis3jdpff7WI8LKw5KfGcE0+/FdziyL8/vsa6HJF3dMnqGEngmO2GEwEv/E+A==
X-Received: by 2002:a62:cfc1:0:b0:625:ebc3:b26c with SMTP id b184-20020a62cfc1000000b00625ebc3b26cmr15854390pfg.22.1680098549382;
        Wed, 29 Mar 2023 07:02:29 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:28 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V5 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date: Wed, 29 Mar 2023 22:01:55 +0800
Message-Id: <20230329140155.53272-6-zhujia.zj@bytedance.com>
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
index 86892f471e761..b0f4dd6384128 100644
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
index 26e5f8f123ef1..4a87c9d714a94 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 8e130de952f7d..b8fbbb1961bbc 100644
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

