Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A45FB320
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Oct 2022 15:16:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MmxBd3cZVz2yhy
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Oct 2022 00:16:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rY+PWlvE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rY+PWlvE;
	dkim-atps=neutral
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MmxBJ03dGz3blj
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Oct 2022 00:16:23 +1100 (AEDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso15798973fac.6
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Oct 2022 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0QJPhughD80u7ewLF/tLA+xOCDrl/cfryqlkNyAxbY=;
        b=rY+PWlvEEZtJ+HmXXbLiYRgNbuvRmBZeRWVqWpI2rKqCJccNk+ZqopV4EPVf1Q0qpz
         B/bSu3cokc+8EocLFcORWfEckjlHkoHjle5UXU3LwaAwXMLI74KLRyCQgWf09lg25Fbi
         4JmNle7Lcw5uqueqRyJ1df3nmHfLiu0IgnMBkvPYpe+KLtFYw0Ww5lwTXssb5cK9LeDB
         F5zYYGYT1ENpmoXg3MC5MD4+rPPPx5EkwjlylMTlRTQxytrEPhJSetBoYUpx2Lj7XSuO
         iGmbMyCobXc/Zm0gUG3FfaX3ouOgzkVB+yV8TKFoC9BVySClixuELZ5bX8Xtpsxojzyh
         +sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0QJPhughD80u7ewLF/tLA+xOCDrl/cfryqlkNyAxbY=;
        b=LdgAWGxpkIFwPics6/UwAsjzPESdgvU/bxbr+D9/IHBQxEOVIUqC7q+E7fPIWvqdvS
         5a2HjlgJqoF2fjCcExNqJGiYwEt7+UUqZm2OunMNzxARfE9FMShxungzjksZaM91hf9M
         8Am6QmAvzysciDAymCzwryS4Y4jiLoC6E2gQrFZ6u0V5XNmkZ0hQoBqsOy2T8wH35G/F
         itc+dyniY9i610YgKEHB6ZaDH0kYLrLX+juJSlmaYr4xSQ7ckw3Zz7BIGplL0NpOxTjK
         S2DLPwVEoqpikAkK2GIABnVJ+R4/8TOVHdK4VK6dMOTXSDcxuKr3yD2v81lP1BbCHlqm
         Fnww==
X-Gm-Message-State: ACrzQf0HalbdMJHRNi5WSeJCByAXr5O8ydlgnlWAxqunr9V4SfXr47H6
	i3iOat9d49QEHVFFhaS60jGTSk+JeyCawL5N
X-Google-Smtp-Source: AMsMyM6VuhiNMjdIO3SyvCAmXoE9oQdlr+6UO2h2kSoiH3hgKQ+xUOuHexT0ia7yWQdNOXMDI90tHA==
X-Received: by 2002:a17:90a:d983:b0:20a:ec04:e028 with SMTP id d3-20020a17090ad98300b0020aec04e028mr35546281pjv.122.1665494165504;
        Tue, 11 Oct 2022 06:16:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:05 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH 0/5] Introduce daemon failover mechanism to recover from crashing
Date: Tue, 11 Oct 2022 21:15:47 +0800
Message-Id: <20221011131552.23833-1-zhujia.zj@bytedance.com>
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

Changes since RFC:
1. Solve the conflict with patch "cachefiles: make on-demand request distribution fairer" 
2. Add some code comments.
3. Optimize some structures to make the code more readable.
4. Extract cachefiles_ondemand_skip_req() from cachefiles_ondemand_daemon_read()
   to make codes more intuitional.

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
https://github.com/userzj/linux/tree/fscache-failover-v2

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
 fs/cachefiles/internal.h  |  71 ++++++++++++++++-
 fs/cachefiles/ondemand.c  | 155 +++++++++++++++++++++++++++++---------
 4 files changed, 205 insertions(+), 41 deletions(-)

-- 
2.20.1

