Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48254A98C
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jun 2022 08:35:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LMdwJ1h0xz3cgf
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jun 2022 16:35:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=n69xLhdn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=n69xLhdn;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LMdvs2cfRz3bqN
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jun 2022 16:34:49 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id f8so6967608plo.9
        for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jun 2022 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:references:to
         :cc:in-reply-to:content-transfer-encoding;
        bh=skhpWdz/fVr5Z4eL8Xj0/NttsCVeBDmRP9w0g3/Whag=;
        b=n69xLhdnFBVD/mcAfXKXlmHjIZVMxn/jpE+0WcQVD5bHzB6SRmnaMOnnpQ5fOTQ9Qf
         ltWsIcvXS97GNnnrcJLc+WjZFJvqbUaOKU1VQ7VYRpcwJvlF6J1boCWLAp3eTkMNXEp0
         lStAB8cE4yXkRsgUX9BLzqALcs5FtLTtG9VAtIsiNSgxVYzj33Gt2fd9pxfCwLEas0pW
         gbffQYN91qk11OAYPvc8/HK5U4g4YQumghRpARQiR9OrLoucl2AAYMHe6RyHJWHzcGYd
         GQgGdm4EGRWSbmjR5VCzzHwtrNof69Lu2YDzST2YX4VIW7EmTa9JKVL3K4Fi12XHe2iY
         nkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:references:to:cc:in-reply-to:content-transfer-encoding;
        bh=skhpWdz/fVr5Z4eL8Xj0/NttsCVeBDmRP9w0g3/Whag=;
        b=Yc8PqSW9WwKGOiRpxG9g15c0esGr7P4DB3JqxD6tWworKGTTx1g5kh1htua38g3CBM
         YMeS4JpQa3RPYwpynT6yCLJNHXp9B76t5WWOzclZG90scn0PAeEYFKC+rI3kWL0Kic0s
         nn+eDth3ZWQAyapS4+PJyiNCb0f82HzeRGR7N0YxEgxv+J2AdWTIJJjUsO7JR1yd5Jn0
         79zjbzmD2kvPwFxEBXE04RVFkdI38LZQYYFAFzeCAlacN4DJAA4EnUgNjiY476BR2BJk
         AUDCncy1WZwcSYDL4C51AeRjmoj/LTK2m8djUB7tNOn3T0s0Ij2E5JTKJEckYR/bu4im
         OlWg==
X-Gm-Message-State: AJIora9vASBv3rX0LfemkkDrirCMYrSVlvflXHxE5Ohcmd8H57pgGnUG
	/Sou0+TZauAGc5f1Olas0fPSdw==
X-Google-Smtp-Source: AGRyM1uEWpuqApQ0YFIqPF26m4yeyOyFetT/gzggOr8wuWGCa0nbZWfha1AghEBVfB+9NYDL7BJdRQ==
X-Received: by 2002:a17:902:b784:b0:168:b8ee:a27f with SMTP id e4-20020a170902b78400b00168b8eea27fmr2722444pls.107.1655188487024;
        Mon, 13 Jun 2022 23:34:47 -0700 (PDT)
Received: from [10.4.226.233] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b00163fa4b7c12sm6317799plb.34.2022.06.13.23.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:34:46 -0700 (PDT)
Message-ID: <275d80bb-2f14-58c3-e829-119c88bf18f9@bytedance.com>
Date: Tue, 14 Jun 2022 14:34:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From: Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 1/1] cachefiles: Add a command to restore on-demand requests
References: <0a015f53-00f1-57d0-bca3-74cd7db8ed2e@bytedance.com>
To: dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
 xiang@kernel.org
In-Reply-To: <0a015f53-00f1-57d0-bca3-74cd7db8ed2e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


In on-demand read scenario, as long as the device connection
is not released, user daemon can restore the inflight request
by setting the request flag to CACHEFILES_REQ_NEW.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
  fs/cachefiles/daemon.c   |  1 +
  fs/cachefiles/internal.h |  3 +++
  fs/cachefiles/ondemand.c | 25 +++++++++++++++++++++++++
  3 files changed, 29 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 5956bf10cb4b..280104171996 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd 
cachefiles_daemon_cmds[] = {
  	{ "tag",	cachefiles_daemon_tag		},
  #ifdef CONFIG_CACHEFILES_ONDEMAND
  	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
  #endif
  	{ "",		NULL				}
  };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..402f552a9756 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -289,6 +289,9 @@ extern ssize_t 
cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
  extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
  				     char *args);

+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+				     char *args);
+
  extern int cachefiles_ondemand_init_object(struct cachefiles_object 
*object);
  extern void cachefiles_ondemand_clean_object(struct cachefiles_object 
*object);

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 2506e6d56965..0d0ed82f4814 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -174,6 +174,31 @@ int cachefiles_ondemand_copen(struct 
cachefiles_cache *cache, char *args)
  	return ret;
  }

+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	xas_lock(&xas);
+	/*
+	 * Search the requests that being proceessed before
+	 * the user daemon crashed.
+	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
+	 */
+	xas_for_each(&xas, req, ULONG_MAX) {
+		if (!xas_get_mark(&xas, CACHEFILES_REQ_NEW))
+			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	}
+	xas_unlock(&xas);
+	return 0;
+}
+
  static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
  {
  	struct cachefiles_object *object;
-- 
2.20.1

