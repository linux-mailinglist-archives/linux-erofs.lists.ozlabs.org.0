Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29B5FE759
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 05:10:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MpWbw6n20z3dt0
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 14:10:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=j7OAaYtj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=j7OAaYtj;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MpWXx5NVcz3cfN
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 14:08:01 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id o21so1145321ple.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+LEXzrwnagFeN1X0qgpjAc8sXMoTZWp+ylsCx2Q8o=;
        b=j7OAaYtj4gywSty7236efJMlTd/eu1sIqqWbPt8D+9YFUIliYfpSpcCP0RVtqISuqu
         EUApBFrH2c13AslkzH2kxWWxVhadCyNF/XhwEb1+wO1wlOTaN9UmHTqGz6A7dGpsv7YF
         it1z3ccyiqrCduYkbdGYj6lFMob/8GWFUxSCLiEfqRHYmzWYMz69f2joQ1gse4CahmQo
         B0QilVGK3KBdC876cBFng16Xiyd/XBhGL3l+BQpBzVtwxcRpIqlzRC0RzVLV7IIzDFrN
         seYRGXSdBD8Bnk7v8XEuCwP6nYfyx4K0Y2PGOehom5FlQdP1PnCIfIsZ1rHUoEYjSv2F
         SSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR+LEXzrwnagFeN1X0qgpjAc8sXMoTZWp+ylsCx2Q8o=;
        b=flN0/2Kj2WlB5JtVSAiO/i7aGkF9wgN8uPC/XzoFii+o1N9fTWokocVWHKyAfw8/2z
         ntg9dgZRgOEAGCrBbk4AufDLJcFENOVuL8ivX7ATcyLvJNrbIgGrLTI4yTvOHjF5LrMU
         seZIiLKCU7w4ggsBdOLe7vuDk58qriqlwA0YZ75jrH7ljUPE/+Amv167KOEg57GXgC/T
         +h2daB3tNOoxH0qyQ3bA7s3BPzCfGc5Pkj0jgBSj9XN9xJ7uG5fdw6YnxRGoWYI4bSxJ
         Vb3jqq+6rZurOedy+k068BvU71gfjhYuRHs03U/qdMTO3iL51SBjIWdqfTBBD+XH0cD8
         xkOA==
X-Gm-Message-State: ACrzQf0sNqzfUtV5a1ttxl7PP9Cdy8fKbqxokqepFCjciGckcBuP76sd
	WPKTWGmwHT67DVrvzTNSJL3eqw==
X-Google-Smtp-Source: AMsMyM6fZ2yYhCzfqcA1T5TPO16rRcN9qdwd1V7oXdpGUkUt1ol+W9QIVGnrnP7azUmdi3NbdWxY1Q==
X-Received: by 2002:a17:903:2307:b0:17f:78a5:5484 with SMTP id d7-20020a170903230700b0017f78a55484mr2957038plh.15.1665716879180;
        Thu, 13 Oct 2022 20:07:59 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:07:58 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH V2 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Fri, 14 Oct 2022 11:07:40 +0800
Message-Id: <20221014030745.25748-1-zhujia.zj@bytedance.com>
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

Changes since V1:
1. Extract cachefiles_ondemand_select_req() from cachefiles_ondemand_daemon_read()
   to make the code more readable.
2. Fix a UAF bug reported by JeffleXu.
3. Modify some code comments.

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
https://github.com/userzj/linux/tree/fscache-failover-v3

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
 fs/cachefiles/internal.h  |  58 +++++++++++++-
 fs/cachefiles/ondemand.c  | 156 ++++++++++++++++++++++++++++----------
 4 files changed, 188 insertions(+), 46 deletions(-)

-- 
2.20.1

