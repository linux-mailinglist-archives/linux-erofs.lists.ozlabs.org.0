Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1754467D
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 10:54:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJdFF49Tdz3bmC
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 18:54:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=4Ip7b/oq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=4Ip7b/oq;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJdF86tWjz3bkh
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jun 2022 18:54:20 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id c18so12930654pgh.11
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jun 2022 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:references:cc
         :to:in-reply-to:content-transfer-encoding;
        bh=yMejwtDzyNHfBpGN72so4O9xVLTuy+RaVh5U8x4L1Hw=;
        b=4Ip7b/oqiSGXDor2bv88MS2iljh5KDuFGbRBiYB85ZegNxu3ZUfiPQm2RNJYWEQRmT
         oHML1F9NNRAEcmJvoSP+2BrXErY29dnJW64Y55PgcNackjXEIpbnD+1bl6tilgHXPVNI
         mIrtEh/WPSsvZN3fxl6Wku70icEdUeub6vJUGn2L74Inalnyg8o+kXrUay+Q52hJRe5e
         B32gAu2wFtYZTTWRWV4SMVfsXjwQ1qTNjTJNgHXf/7I+dle5f40XsJNHBp/6qlUt6ubH
         CW4nCSsj8Hc7mfUMUCUx9Ddr7l7Pt2vUloYtpmUvdXDHPp9gxfoPioNhYlNcP8ECBwmW
         hJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:references:cc:to:in-reply-to:content-transfer-encoding;
        bh=yMejwtDzyNHfBpGN72so4O9xVLTuy+RaVh5U8x4L1Hw=;
        b=L61BqTOC+27k55XPqK6Bdeb2Hcgc7EyNY4E1dZ1ce1F+ZhzMecryLivsAenvJpRoNm
         +zNJgrE0UU/5xrZ+ak+HsdXNDMxTcWLIYpOo0gP9KRp+z5wwETU6fiERQaNCT56ngDcv
         FwL8a04SkqFgO/prMEiFRrQ72d/5BjY1U+/pDxGTSkIRw0itd8IWFD+41SesASC02rNL
         wb06KCy3aD3l5Vqd1HO5hQrCifuR4r86OZRLXTYfsxybz8BrYXNJRzelLylUUWd9QhRX
         0VbZ5tMgMro6ckzoue3jM0G6t+SzSIejHGJK61Y/ZE7HUYFLyUrKPEk7rFghB+DlsSq8
         mLaA==
X-Gm-Message-State: AOAM530sVD2RNiMEFG5ivsNUOmkiv+uMBtDE5oeq0ag1J9uNJMENjWYL
	23fM+59lU2gTfLDlwdsgXIpZeA==
X-Google-Smtp-Source: ABdhPJzxfd/E24V2utRYzgKSQLHaTAVb/3N1dFnRzIUtmrYnB73swM5xvClMwqfebmQRh66X5KdXcQ==
X-Received: by 2002:a05:6a00:22cf:b0:51c:11c2:4bb with SMTP id f15-20020a056a0022cf00b0051c11c204bbmr21752464pfj.54.1654764856475;
        Thu, 09 Jun 2022 01:54:16 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902680c00b00163247b64bfsm15698498plk.115.2022.06.09.01.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:54:16 -0700 (PDT)
Message-ID: <b62a09fc-a42c-72b5-eb42-37b52b3d529f@bytedance.com>
Date: Thu, 9 Jun 2022 16:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From: Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH] cachefiles: narrow the scope of flushed requests when
 releasing fd
References: <1a03d5de-e0cf-b23d-b12a-f46795125968@bytedance.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com
In-Reply-To: <1a03d5de-e0cf-b23d-b12a-f46795125968@bytedance.com>
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
Cc: linux-cachefs@redhat.com, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


When an anonymous fd is released, only flush the requests
associated with it, rather than all of requests in xarray.

Fixes: 9032b6e8589f ("cachefiles: implement on-demand read")
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
  fs/cachefiles/ondemand.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index a41ae6efc545..1fee702d5529 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -21,7 +21,8 @@ static int cachefiles_ondemand_fd_release(struct inode 
*inode,
  	 * anon_fd.
  	 */
  	xas_for_each(&xas, req, ULONG_MAX) {
-		if (req->msg.opcode == CACHEFILES_OP_READ) {
+		if (req->msg.object_id == object_id &&
+		    req->msg.opcode == CACHEFILES_OP_READ) {
  			req->error = -EIO;
  			complete(&req->done);
  			xas_store(&xas, NULL);
-- 
2.20.1


