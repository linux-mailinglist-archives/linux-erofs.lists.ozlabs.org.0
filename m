Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4297F0B47
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 05:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1700453741;
	bh=nIDTyvDZmEbG+Yu+hBrCT0MY3hx+Ko8aN1HuoFlM3pE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=e0vnW1KygAaG0uFnGZDQaquC8exHmI1ZICtS9VDcu//FNqb1xt3ad5ISFxr1isrwD
	 a2DSZuFTk2/nbnu+aGpZ3CYe/tqfvB+vGCsAfUFfb4YpSOw0tR9t88QKoaM08jEqLg
	 TWm4IDhC6B2UR8q6cEJ80Br6s+MXhoD/wLK7wnQdOCDcA2hQJk8r7AbRowayLliv0V
	 WlliQUvTgwET+vVRxfIQi+iugRpAmI4YO8TnCkVxXhLCjYNUsofAVU9DDfiuUTInEV
	 flEeORHRuz1ccikzkg2MILNBH+zC9li99Ccaj83p8RY9OZKDu0xWec+GixZv/lSTEJ
	 xd0uX5GOqoexg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYZ1T5qxJz3cS5
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 15:15:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=XiIUI7PG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYZ1D1Wwpz2ytV
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 15:15:26 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so3081352a12.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 19 Nov 2023 20:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453720; x=1701058520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIDTyvDZmEbG+Yu+hBrCT0MY3hx+Ko8aN1HuoFlM3pE=;
        b=kq5kFzbruyUreGJgdhDCSTmaY7UXFMBRcGpChIDj/Pgo/1IxX5rCyXNjk454G3SPXC
         c1/X6uL2oFx1Sxf1TVsqycChe20Y/bVkkKN7DTotRMxq5GBWp83OD7UFTPyqceEq311G
         EcXrF3hbSzWKL02wMePHeJ4LRjKg7I3fMJ/iRed0TZbXW/cs5Y3ljkeijqz1XCXyWt5y
         kE7gZpdUUyZSm1vbdTgcckun0QZKO1lMlGBnw4Xj1HHHnYRSgh5AshzkZ3XgUxBKQapN
         3knABzsmNz/n5GCjhHyyNDhuPnT7MizAhJlZovQ33zYj+45ATeo67UNve4YrcqtkzZRw
         rHZg==
X-Gm-Message-State: AOJu0YzpoNOkHOHf1/DNoh/FRkaZwPH5Ix6tjq/1xjyUTWZInblsGpeU
	anxqgSrZE77X8NnMZ6F36+V12NzrR2x4MSZAFLNtpQ==
X-Google-Smtp-Source: AGHT+IGVZZxbvriUAg4m5DBW0KlhluDN/YDbsZf0qUPd9sQzHBSRdkPXBSjpcmPduH8x79b1PQAWuA==
X-Received: by 2002:a05:6a20:1612:b0:187:f22b:8037 with SMTP id l18-20020a056a20161200b00187f22b8037mr7742380pzj.52.1700453720117;
        Sun, 19 Nov 2023 20:15:20 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:19 -0800 (PST)
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Subject: [PATCH V6 RESEND 0/5] cachefiles: Introduce failover mechanism for on-demand mode
Date: Mon, 20 Nov 2023 12:14:17 +0800
Message-Id: <20231120041422.75170-1-zhujia.zj@bytedance.com>
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
In the on-demand read mode, if user daemon unexpectedly closes an on-demand fd
(for example, due to daemon crashing), subsequent read operations and inflight
requests relying on these fd will result in a return value of -EIO, indicating
an I/O error.
While this situation might be tolerable for individual personal users, it
becomes a significant concern when it occurs in a real public cloud service
production environment (like us).  Such I/O errors will be propagated to cloud
service users, potentially impacting the execution of their jobs and
compromising the overall stability of the cloud service.  Besides, we have no
way to recover this.

[Design]
========
The main concept behind daemon failover is to reopen the inflight request-related
objects so that the newly started daemon can process the requests as usual. 
To achieve this, certain requirements need to be met:
1. Storing inflight requests during a daemon crash:
   It is necessary to have a mechanism in place to store the inflight
   requests while the daemon is offline or during a crash. This ensures
   that the requests are not lost and can be processed once the daemon
   is up and running again.
2. Holding the handle of /dev/cachefiles:
   The handle of /dev/cachefiles should be retained, either by the container
   snapshotter or systemd, to facilitate the failover process. This allows
   the newly started daemon to access the necessary resources and continue
   processing the requests seamlessly.

It's important to note that if the user chooses not to keep the /dev/cachefiles
fd, the failover feature will not be enabled. In this case, inflight requests
will return error, which will be passed on to the container, maintaining the same
behavior as the current setup.

By implementing these mechanisms, the failover system ensures that inflight requests
are not lost during a daemon crash and that the newly started daemon can resume
its operations smoothly, providing a more robust and reliable service for users.

[Flow Path]
===========
This patchset introduce three states for ondemand object:
CLOSE: This state represents an object that has either just been allocated or
	   closed by the user daemon.
OPEN: This state indicates that the object is open and ready for processing.
	  It signifies that the related OPEN request has been successfully handled
	  and the object is available for read operations or other interactions.
REOPENING: This state is assigned to an object that has been previously closed
	  but is now being driven to reopen due to a read request. The REOPENING state
	  indicates that the object is in the process of being reopened, preparing
	  for subsequent read operations.

1. The daemon utilizes Unix Domain Sockets (UDS) to send and receive fd in order to
   maintain and pass the reference to "/dev/cachefiles".

2. In the event of a user daemon crash, the daemon is restarted and the reference
   to the file descriptor for "/dev/cachefiles" is recovered.

3. The user daemon writes "restore" to the device, triggering the following actions:
   3.1. The object's state is reset from CLOSE to REOPENING, indicating that it
        is in the process of reopening.
   3.2. A work unit is initialized, which reinitializes the object and adds it to
        the work queue. This allows the daemon to handle the open request,
        transitioning from kernel space to user space.

4. As a result of these recovery mechanisms, the user of the upper filesystem
   remains unaware of the daemon crash. The inflight I/O operations are restored
   and correctly handled, ensuring that the system operates seamlessly without
   any noticeable disruptions.

By implementing these steps, the system achieves fault tolerance by recovering and
restoring the necessary references and states, ensuring the smooth functioning of
the user daemon and providing a seamless experience to the users of the upper filesystem.

[GitWeb]
========
https://github.com/userzj/linux/tree/fscache-failover-v6

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20230111052515.53941-1-zhujia.zj@bytedance.com/
V5: https://lore.kernel.org/all/20230329140155.53272-1-zhujia.zj@bytedance.com/

[Test]
======
There are testcases for above mentioned scenario.
A user process read the file by fscache on-demand reading.
At the same time, we kill the daemon constantly.
The expected result is that the file read by user is consistent with
original, and the user doesn't notice that daemon has ever been killed.

https://github.com/userzj/demand-read-cachefilesd/commits/failover-test

In addition, this patchset has also been merged in our downstream kernel
for almost one year as out-of-tree patches for real production use.
Therefore, we hope it could be landed upstream too.

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

