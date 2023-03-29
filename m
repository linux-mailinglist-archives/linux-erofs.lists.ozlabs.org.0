Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0926CDB62
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Mar 2023 16:02:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PmpCQ43Czz3cjT
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 01:02:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680098546;
	bh=4uvssyWsx3k7MHrKeBtfOfjBMlx3rM4q3Jp1ubBODfw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=XQdchVtDpdKbJcIxaXBH8xb38l4dmWz8ALYeFDNJWw/PwtMzYCSyrIsokzCYTJv+8
	 EbTQPQU3LidhXK63M+GKiSE24VKojDSaLBU47joOnGHCvkuS6TWrKte6tkj/N21+wG
	 Drfqt9p8CTAKOcJpXNQ9QQBiGo7tQzDONAfAaovxbXYAXvcx6J5MVFlUYdDyourCJs
	 L1MI91Y6XxMqkR31KaTz93ACEgGYnk178i6WoQiXQDtrwfoqmbGOHGlRGF0a/sIcpp
	 d36IUV2yYKnMcHj+7+L4UCgOVjgXWPzPuaDVbgvYkmfay2Dn6jOif+s/+n4OpYGsbv
	 e3eTiaqRdhDoA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UGojkOsi;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PmpCH1z5Cz3c6y
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 01:02:16 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id y19so9334802pgk.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Mar 2023 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uvssyWsx3k7MHrKeBtfOfjBMlx3rM4q3Jp1ubBODfw=;
        b=ziOhRU81nuD/J+D+Exw4Ef+CtgVPr7z3Qm0I3eO5v54Xp6CTZXY+kHC9z3CoVrHX33
         RLEMKiRcm/CpHlo+jFrnCafCGVHnbADJOIucoWUpVUtmdfZyCVpcTJXwh+3B9tlwJDxv
         rspknniiVoUU4NYCb8DNSDhyNEzCmto+JwquXn455zsnHzNiRDxma8X6g9JIdgxNWYrw
         3Ji0+pS0ykpowae7W0vPTrwZQBDpsrtebXjzY1o4TCU81KE3dGT7VOzoL1mhNeR8h3nu
         MofKfBrXTUE9QZZwG08wTTAI8fQuGLmE1JJFV5ynL6Lkf6CveCFDffdBR4WX+bYtWwG3
         G7dg==
X-Gm-Message-State: AAQBX9dec1gNY+GcJBHspfzZ4Nuyrb3gtLGx9B6YevVqceDDPwSlkkda
	rbx+PSEeMRDfTqDbGkh5FNk5JA==
X-Google-Smtp-Source: AKy350Zu7f5eX6mOVbKMD+sOv6QkyLwxP6u50C0/15Nu8mhq7u6EIcFAOwM6F9nrt/UGfUx/Cec5dQ==
X-Received: by 2002:a62:190d:0:b0:628:aa3:82bc with SMTP id 13-20020a62190d000000b006280aa382bcmr15683522pfz.18.1680098533403;
        Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V5 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Wed, 29 Mar 2023 22:01:50 +0800
Message-Id: <20230329140155.53272-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

Changes since v3:
1. Make enum cachefiles_object_state to all-uppercase and optimize the implement
   of CACHEFILES_OBJECT_STATE_FUNCS.
2. For struct cachefiles_object:
	1. Make ondemand field inside of "#ifdef CONFIG_CACHEFILES_ONDEMAND".
	2. Rename struct cachefiles_ondemand_info *private to *ondemand.
3. In ondemand_object_worker():
	1. Replace type casting with container_of().
	2. Remove useless "else".
4. In cachefiles_daemon_poll(), replace xa_(un)lock with rcu_read_(un)lock.

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
The main idea of daemon failover is reopen the inflight req related object,
thus the newly started daemon could process the req as usual. 
To implement that, we need to support:
	1. Store inflight requests during daemon crash.
	2. Hold the handle of /dev/cachefiles(by container snapshotter/systemd).
BTW, if user chooses not to keep /dev/cachefiles fd, failover is not enabled.
Inflight requests return error and passed it to container.(same behavior as now).

[Flow Path]
===========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

1. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
2. User daemon crashes -> restart and recover dev fd's reference.
3. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to REOPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
4. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

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
https://github.com/userzj/linux/tree/fscache-failover-v5

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20230111052515.53941-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  16 +++-
 fs/cachefiles/interface.c |   7 +-
 fs/cachefiles/internal.h  |  59 +++++++++++++-
 fs/cachefiles/ondemand.c  | 166 ++++++++++++++++++++++++++++----------
 4 files changed, 202 insertions(+), 46 deletions(-)

-- 
2.20.1

