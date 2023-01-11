Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCC6653A7
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 06:25:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsGNd2lQtz3cJB
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 16:25:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=z5siAmwL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=z5siAmwL;
	dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsGNW5Hqhz3bT5
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 16:25:30 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id bj3so11514768pjb.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 21:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zKLZ4cMF4VZH8zOzNr6plvSw69rGNAVsqBjH7W6v6Q=;
        b=z5siAmwL0KyX3ZAkTakARazMKr4W80Evyjiap3KoB249oAn29O0Wc3a89zZfNTxmCU
         nakN0bq7rIJkBBmlXBQwwNCv+/WeFVOPAOTRi23O0o9Iz9Ne9emioRPjfG0HP41SdG9E
         ry5CoGjhHruyyIPsQv3JoOHUc2TvuZ5jB76HRNGT4ORAt97bReLLosizCUFaqtvurzGJ
         Tu/Wcd3fqr3drSAhKbIfCm1yWcYBhTdlL1/IgjPn1rUzPs0SiHUYVMa03x7ImQ4CmSLY
         hSyurk8FXo6tB/5sq0k/kUEm6CEsxs3aw82aE1ugLgymue/qO0lEOfdPi5Q+iGSkDMao
         zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zKLZ4cMF4VZH8zOzNr6plvSw69rGNAVsqBjH7W6v6Q=;
        b=W8C0VByL1VMdMelBdaoXt7mUPUKK56RC/t3HT3yJfA/ywElvkr6IyqXcMw8qGaFf3C
         vrLGqyUjVQX/ootIsSdrnkuw3CSWs6kEp/dVDJ9AwpgZ+G1m+fWKfnEGWps7aplGR8N+
         PLVNenPcUlPRoyc/xlE5B9Xx0rSx4dA6EuOxK7mpMp7y7UE4MdYV2V0v1CW3Aj4TtNOI
         K9F67IWxUIrHoziYtWeaAabbX0aBbglHQ/K/PUL011Csk5I75p5L5zrVNuO3rkQIIrpE
         2RsKJPf1wbWrgvYrnBTY4to0f0Wy3oXmauNHS/gRJlOHPsXzPTDc+ALT1gbBtq87hmPW
         Rl1g==
X-Gm-Message-State: AFqh2kocr5pwu6nBCNjZdWBfdLpm1zG4keAZtC80ECNX20U2kxRThbtx
	56q2R/wniMcWEj9DkHSIJPmKng==
X-Google-Smtp-Source: AMrXdXskv4V+w6rv13eZ0t91lgtE+UkuxrtFOIPL7NLfX0z7KikkZVtz4uyclgawuLN/+DOvISOr+g==
X-Received: by 2002:a17:902:9b8f:b0:192:6d68:158 with SMTP id y15-20020a1709029b8f00b001926d680158mr66117737plp.15.1673414725912;
        Tue, 10 Jan 2023 21:25:25 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:25 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com
Subject: [PATCH V4 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Wed, 11 Jan 2023 13:25:10 +0800
Message-Id: <20230111052515.53941-1-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Changes since v3:
1. Add xa_lock for traverse xarray in cachefiles_daemon_poll(). 
2. Use macro to simplify the code  in cachefiles_ondemand_select_req().

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
 fs/cachefiles/interface.c |   6 ++
 fs/cachefiles/internal.h  |  57 +++++++++++++-
 fs/cachefiles/ondemand.c  | 160 ++++++++++++++++++++++++++++----------
 4 files changed, 192 insertions(+), 47 deletions(-)

-- 
2.20.1

