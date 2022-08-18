Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48B5984C0
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 15:53:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7mYT3fhkz3c6D
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 23:53:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rx0D5/86;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rx0D5/86;
	dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7mYD0Jxyz3bry
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 23:52:46 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id r69so1358058pgr.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JIt9Hr3bnXwA/tRzFdUUjJF8ICdMOLH9UGftglFwKs0=;
        b=rx0D5/86CeH9rfls9cK+ovoX6WXvUqWR5yR9uWVkAKmXOMBXx94XSUUEx7H3dppxqk
         0XJR0QcosZQsZamTxInDJnivdwpSHeRDS7y+llNNp3dHBXKLlc83/VJ+oArwJUMP+Ur9
         hIakH/6FLBjhAayfoOwo57F1c+VwhPJPl75FCbrvtgwAsTgdYkGDCuaGwxaREE04BMCc
         9/3Ec7a5OdzkzyAJmB0OJO55kdOjDp6dWJYnm8UQ57HxpVflXFA9vdb/6+FzlSJG4K3K
         uFF3mhw+/UR6CUVl+qU+0YH4tGfsv+KRtARIieVUP/aShtVfQotfAsAiNQMPAR2Vmocd
         ZaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JIt9Hr3bnXwA/tRzFdUUjJF8ICdMOLH9UGftglFwKs0=;
        b=gK5wpApxkKh2zqEWDGkhNBNf0NkSe73tdF615XNKHWpC/B7cgCHpSM2alyMcHByIbZ
         Zh9HsibjZca4bZX5MNkM7O9xDl6wFSWkTtgBuxMr/Qj0nyEoI1YZAWic5uV+x710Z7Qk
         gpZFje6lP4fHiB96FP+C2QdSGoLBpHs6SmplHSwsnydjx3FwkuOF+F7sJV0wb6DBo3jo
         ZbE+lokpPtYbDn6kkPC9n9xqveEt4vrM1RFIrgNl7udfHfXKLTgN22sk/+90RkJ6prod
         Cfzj4wonTU1e84vVBnPa9eP7Xnwe4bStDmvwMqm+A6XUlxyRrpdB+XQQhTj8Xm0P5ylb
         ntag==
X-Gm-Message-State: ACgBeo3vIH95QuL/LXO7OwSw3HK56he8zQ4SUydqKGCZrlCdtOyNveHd
	YZIayj8yh9hUFF6Oauk2lMjpzw==
X-Google-Smtp-Source: AA6agR7dyQJ+ORPyUmexb/HyRV/vRty6JE9R9UJyqOx4rKaS8Fn0kNA5WBhPQP1h+roc/IdDaQXkGQ==
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id e132-20020a63698a000000b0041c8dfae622mr2473637pgc.465.1660830758358;
        Thu, 18 Aug 2022 06:52:38 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:37 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [RFC PATCH 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Thu, 18 Aug 2022 21:51:59 +0800
Message-Id: <20220818135204.49878-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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
https://github.com/userzj/linux/tree/fscache-failover-v1

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
 fs/cachefiles/internal.h  |  74 ++++++++++++++++++++-
 fs/cachefiles/ondemand.c  | 135 ++++++++++++++++++++++++++++----------
 4 files changed, 193 insertions(+), 36 deletions(-)

-- 
2.20.1

