Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234E1462AD4
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 04:02:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J36Sz2jj1z3bjP
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 14:02:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638241331;
	bh=GgnbvK6LXPOpA5Ctr4aP9yiHBLCVJjpDoP9GcXi1ufk=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZODmPmIAZOp5HR49cb9CmJ5Ci+y8/SJXMFZjMsocP9k6aNUZS4CNgx3kqHLFHwlmH
	 0ofMWvKFshxukjOurBCLpqlYxMCS5v6iXMIICEopBzcfiZSlwsFUJ36wa0uRJ42lMg
	 xf7/QETd2Gf7XZ41I+KAbVOjFjFGp1rNsGuqY9Z067jbV+YoqhG+3rPRfR89mpX9km
	 6adYUkvE7AlfcyMiN8FoxiGZ1vVTSXEYM+vDaGiBpXBj69T03NgWQFqzOcIe/NPKfx
	 nPi20rH1+v+02OVu5y1kcek3V6ZqaryZ4GCVoTL7NeffgHwaGlncpHjN6QMVbthU/L
	 hxDdbalLHpFbg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3j5slyqskc_g4mfslpjq0nslttlqj.htrqnsz2-jwtkxqnxyx.t4qfgx.twl@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=PoPRZE03; dkim-atps=neutral
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J36St0GYWz3bP6
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 14:02:03 +1100 (AEDT)
Received: by mail-vk1-xa49.google.com with SMTP id
 77-20020a1f1950000000b002fec8b725c5so10427908vkz.14
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 19:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=GgnbvK6LXPOpA5Ctr4aP9yiHBLCVJjpDoP9GcXi1ufk=;
 b=qzLzjP5bTlWi5sTwA9Fa5aRLy1wLZLp4s+D4w6tUkvqLh94cWTe2DUgn8YdXv/RIBi
 lOmW0ZkPS95MeDwzaGP1PZq5Jc0i0B+ckimQxk3A0dKkt5M8W9mCWKWdvlypsw64T4SD
 DGpf/lVR+ZkHctnGJDt5YTMXpZoNJcKOEVDfyH9MtyfTRtV2lDiCMryjyQVn65w87NtZ
 IDtrWE2udXErhvxqO40F64KaAR83SBCEabMTNQczU8WpvN70Js/TZOQcpNXSqDv4IK9h
 8+wuPctuaqeIuVO6KRY2AkNjeeEWVHR7Ad3K0SmRd7VM4+J+sAABMP0QdM+PojtFI9ii
 IZWA==
X-Gm-Message-State: AOAM533mVVsmKvJOAOzXQrY88kjpChl1TevYYryM6FJXDh+aUnQVCW3p
 Kl25A8Yea5s7QFmuAIKLdRshiUziTiXyND4Yj462Mo2UZLtAYk65d5VsmbMiEDzPGQKgTXzCACF
 tk5cIH7Q8tq5thO/A6+s55GL2FQLKcQicyWsAK6Vqrdn6z9XS6ziE9hOy95TApDdCvAmRQKmdA7
 HvTVkkMr4=
X-Google-Smtp-Source: ABdhPJwwRXq+Tq/J1T//6lSVOR/sNX0dXX045SJl0xBphh4BNzQWVSfJwAFuTEwZUQlhqwEV9kK6+PWo+e06QUHxEg==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a1f:e605:: with SMTP id
 d5mr37232390vkh.39.1638241319322; Mon, 29 Nov 2021 19:01:59 -0800 (PST)
Date: Mon, 29 Nov 2021 19:01:53 -0800
Message-Id: <20211130030155.2804358-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 0/2] Cosmetic changes to erofs-utils
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The following patches make erofs-utils more C++ friendly. It does not
perform any refactoring, instead it simply added extern "C" keywords so
that C++ code can call into EROFS.

Kelvin Zhang (2):
  Add android build target to build erofs as library
  Make erofs-utils more C++ friendly

 Android.bp                     | 38 +++++++++++++++++++++++++++++++---
 include/erofs/blobchunk.h      | 10 +++++++++
 include/erofs/block_list.h     | 10 +++++++++
 include/erofs/cache.h          |  9 ++++++++
 include/erofs/compress.h       |  9 ++++++++
 include/erofs/compress_hints.h | 10 +++++++++
 include/erofs/config.h         | 20 ++++++++----------
 include/erofs/decompress.h     |  9 ++++++++
 include/erofs/defs.h           | 20 ++++++++++++++++++
 include/erofs/err.h            |  9 ++++++++
 include/erofs/exclude.h        | 10 +++++++++
 include/erofs/flex-array.h     |  9 ++++++++
 include/erofs/hashmap.h        |  9 ++++++++
 include/erofs/hashtable.h      |  9 ++++++++
 include/erofs/inode.h          |  9 ++++++++
 include/erofs/internal.h       |  9 ++++++++
 include/erofs/io.h             | 11 ++++++++++
 include/erofs/list.h           | 10 +++++++++
 include/erofs/print.h          |  9 ++++++++
 include/erofs/trace.h          |  9 ++++++++
 include/erofs/xattr.h          |  9 ++++++++
 include/erofs_fs.h             |  9 ++++++++
 lib/config.c                   | 12 +++++++++++
 lib/inode.c                    |  7 +++++++
 lib/xattr.c                    | 12 +++++++++++
 mkfs/main.c                    |  7 +++++++
 26 files changed, 280 insertions(+), 14 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

