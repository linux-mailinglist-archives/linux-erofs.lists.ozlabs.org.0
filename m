Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FA5FEA10
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 10:06:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mpf9f69mdz3cBV
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 19:06:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OtPMThNb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OtPMThNb;
	dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mpf9W2c1fz2xHM
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 19:06:38 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id s196so2387863pgs.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90kmgNBxYuQDRjoJ++HQAlxGZIWs9oLzsbBHk0vLgUo=;
        b=OtPMThNbb2WOOHLxa+QlctGa0JbZInKy8kSXh9SoHLMCt8nULHPQnF09yBTHpP/Udk
         gu5KnxTVZoOUFHA/9H1eutkfBF3jVWc0fItRmP6uvZ9Ey+NoJPO6lZm3NPbZAGqnjQaY
         IVIk40rjWuKwERXAWAEXExLmLK0tFhM77u9fEdlCWFf5RyJR4Oe0ONg8KO+OviHZXmZd
         R0lcP+zIKbbZPU75ixyN3lOFmcrj2KPjcqTjH6da57Os3AOujFcXPbvSz/r8H5Spn7Dr
         /nTyFdJMPJsoT3nxEvsgEd1z9N3zTHshx7VbJsOiY9MBe30I4xdRBGX4PV05vF6iLmye
         qR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90kmgNBxYuQDRjoJ++HQAlxGZIWs9oLzsbBHk0vLgUo=;
        b=AafsTSVmMoeZmYvXLjzkolqwa75Ro5PIJbEwfCU/K5MGmk3SCl/5of5L2BK/iIoh9f
         xMc2yE+2brdKft5f3pJHcuIa07Sni0h3xzg+/GPpvd/31uA9HI0cvHbKlFCzwvqmSNYK
         0T0F9MQpBHcjuanjQINuve66YpAtC1xyz7GFRxpOZ7PLEPpatMIEa/3L/y0H719mOglA
         B7sWhNYyWhZn0u7iKHTJpLqjtm7gURTRbm7CvD035aj/WV5lqKy7ujW5pUV5jBaCjvhr
         NcWFd/tmdhmNilIHQpYr64L7rz8jG8oOtl1G7C4OMMYrOg5un6VSgFrJP4R8/Ouv1B5Y
         aD/w==
X-Gm-Message-State: ACrzQf3Ys2nGBNXeYI9bPKFdxc8vL8pOnVWvk4CI+mXPe1XsuD4grivC
	Q+UZhiA690qsYd7B5QbXzGk3Vw==
X-Google-Smtp-Source: AMsMyM5Zx7Qn9iRmKEY5gHbnSMEHHrDjyxn7uuX9kvfDoFaNsj+MDU3tUeehdFxmy9MnBKR6CLGVUA==
X-Received: by 2002:a65:63ce:0:b0:43a:2103:b7b8 with SMTP id n14-20020a6563ce000000b0043a2103b7b8mr3666169pgv.59.1665734793849;
        Fri, 14 Oct 2022 01:06:33 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:33 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V3 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Fri, 14 Oct 2022 16:05:54 +0800
Message-Id: <20221014080559.42108-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Changes since v2:
1. Remove useless header file.
2. Remove useless assignment statement about object_id.
3. Modify some code comments.
4. Add Reviewed-by lines from Jingbo Xu.

[Background]
============
In ondemand read mode, if user daemon closes anonymous fd(e.g. daemon
crashes), subsequent read and inflight requests based on these fd will
return -EIO.
Even if above mentioned case is tolerable for some individual users, but
when it happenens in real cloud service production environment, such IO
errors will be passed to cloud service users and impact its working jobs.
It's terrible for cloud service stability.

[Design]
========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

[Flow Path]
===========
[Daemon Crash] 
0. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
1. User daemon crashes -> restart and recover dev fd's reference.
2. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to OPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
3. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

[Daemon Close fd]
1. User daemon closes an anonymous fd.
2. User daemon reads a READ request which the associated anonymous fd was
   closed and init a work which re-open the object.
3. User daemon handles above open request normally.
4. The user of upper filesystem won't notice that the daemon ever closed
   any fd since the closed object is re-opened and related request was
   handled correctly.

[Test]
======
There is a testcase for above mentioned scenario.
A user process read the file by fscache ondemand reading.
At the same time, we kill the daemon constantly.
The expected result is that the file read by user is consistent with
original, and the user doesn't notice that daemon has ever been killed.

https://github.com/userzj/demand-read-cachefilesd/commits/failover-test

[GitWeb]
========
https://github.com/userzj/linux/tree/fscache-failover-v4

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  14 +++-
 fs/cachefiles/interface.c |   6 ++
 fs/cachefiles/internal.h  |  57 +++++++++++++-
 fs/cachefiles/ondemand.c  | 158 ++++++++++++++++++++++++++++----------
 4 files changed, 188 insertions(+), 47 deletions(-)

-- 
2.20.1

