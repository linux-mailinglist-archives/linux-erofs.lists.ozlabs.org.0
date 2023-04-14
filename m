Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3E6E2930
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 19:23:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PyjwB2B5Jz3fVl
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 03:23:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681493018;
	bh=VT+0HvHjEsU+vTXyoXG01Ki1olkigaqjaaxRq0h7zD0=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QPzYiQWFo4M2ttf0KOn2XQ0gf3Y34ULZ2gw93jPf5we92ZOQRN7LIlcjmtNkWFxU9
	 UuHntC1zDnYkC79Ze0NEql4K2AAqaBUJw2/fISfE6kK2pwYMTT0d1aJAiW6wppDgNX
	 fGqJGilYpz8LmR4d8rXkEC22Nfczcl55bBYu9QiVxYJpRKwL1ZZYccaXrfiAVIICu5
	 G671TNhwo1tC6A/sUG5taBMWNnhMJVFN4F5j4LPGApjabV6rq3+Nc633nVkfeCQeV1
	 k7n3CamJa1i2agF290TlberkwxufelRp4kIcgcfM+DCNwSuWRP2kSCNvKAY7XHJ1kp
	 rGl5RfVmzFb9w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WrL85XgE;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pyjvw60lMz3fVM
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 03:23:22 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso5367310pjr.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 10:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492999; x=1684084999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT+0HvHjEsU+vTXyoXG01Ki1olkigaqjaaxRq0h7zD0=;
        b=h2HWLXiSmdCCR0bchqYPxAPxtLMe78TOhPCEkvnBxJJU2q4Xn9mCaqkfBporthUGMN
         tU7SzmuhT2c9jD2paynlbDMJgML2fl+v2csRoYWQytbNAZPc0l1Ai2rVtxW2M0NMmdJe
         ds87gpSs0FmK/APmkVBu0qELNXkRyamrxxT1pkrfkmRSyU+TTIWub9w250QZx2K2uVp5
         5UhyO8kqcGBRwXv1B5F3ARtHwNDhuPX2fJDwRHDE5GhHNrBFjGmoIoHfHpOobCSYCxjb
         xdBAkNaPozHfmlWNuOCiLt1yX8FFOdo1ltaOnR3hoZ6SuVg5dffRFJSf+ZTtg9q4AmBl
         x2YQ==
X-Gm-Message-State: AAQBX9epdG0xqkT/ZcN+4n/VXoMjy/IgrNi4oujGtWPQcmWDcyr6JQjs
	IXCyeEnDS8YJydx2WYDmiFSICQ==
X-Google-Smtp-Source: AKy350YoK4w2okqy34rm4+OZcZLR+GQ/jupsYmqKLeW08OcJZwUp+2x19/ioiaHyOTYBH/N7bCnvVw==
X-Received: by 2002:a17:902:c951:b0:1a6:8ee3:4e2e with SMTP id i17-20020a170902c95100b001a68ee34e2emr4809363pla.33.1681492998912;
        Fri, 14 Apr 2023 10:23:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:18 -0700 (PDT)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V6 0/5]  Introduce daemon failover mechanism to recover from crashing
Date: Sat, 15 Apr 2023 01:22:34 +0800
Message-Id: <20230414172239.33743-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Changes since v5:
In cachefiles_daemon_poll(), replace xa_for_each_marked with xas_for_each_marked.

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
https://github.com/userzj/linux/tree/fscache-failover-v6

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20230111052515.53941-1-zhujia.zj@bytedance.com/
V5: https://lore.kernel.org/all/20230329140155.53272-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  15 +++-
 fs/cachefiles/interface.c |   7 +-
 fs/cachefiles/internal.h  |  59 +++++++++++++-
 fs/cachefiles/ondemand.c  | 166 ++++++++++++++++++++++++++++----------
 4 files changed, 201 insertions(+), 46 deletions(-)

-- 
2.20.1

