Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E45A7D59
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 14:32:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MHk881WKxz3bk8
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 22:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zSQ0FSkW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zSQ0FSkW;
	dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MHk8223vMz2xJ9
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 22:32:00 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id p185so14239448pfb.13
        for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ombG7QermoyUpZgeZmIaVZjDmMrCYL6rBQrF3G0foVY=;
        b=zSQ0FSkWy57Sy7IjyvRbxCrlzP0H9P73QhEFc9sf4E8opP3ffkYx+tkgzgRuqhbGYw
         iAKwLn5unY7thm2wGQZe81wR5yQwvdI3bxtCrUEOst5mRMfy529/0qfiMPxkcf1Mpi2z
         fSEjtO2WWUX8L8PWXSd6fNtU1OSLo0UF9CQ473f9yB++Wc/sv1Wh5pQPGnWvLTuVuBR3
         QczQMJaCsYxFxfLzD4GjEn8+1UdQXjXhw+33ZkTowMwHLMFJsR+eNVe4vuVbV63mJRpy
         6OSFMLdRw2pkFkQGk4+vH7MBGrGgEhKQ2NCjO6OVfsoDZAsKi3tUuxlOCn5j9FCPX0r3
         YTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ombG7QermoyUpZgeZmIaVZjDmMrCYL6rBQrF3G0foVY=;
        b=5R4eJD4H7teMofN5nVQtpIVg0SU9c69vRP/B9gSm05c68I3azWgXOs0LNhsBc1xhH6
         +4Pdya4g1T/CIW6j8DWKGlZQdUG8k1Q+3/3g/ASnegGop2QIbAIW4ZIZ+K6+aEwlCxf9
         Zjrb2ldxW54Jf9YBYV4zkIGuss9bhSeJAE7GWtfCWYN0BTzlZRlny/mYK+auj4t0xMih
         U4sKofrKfZZRupU8KebBOu1bpP7q+MRH6CcI3AE7fodmxgMkH7AqZwwb5uZ7fLYhQuKx
         VZN0pxpM75dTqAxU63RKRezc7cPvzL7d/XsvHzMrIWgvd0GKCSMjb7DLbq3+9DHWMHij
         jzjQ==
X-Gm-Message-State: ACgBeo1giD1y6mbTqBve5QbAICtHfnteLFTy8VRkqYyb27nsnTiUE46J
	vtTlw6h9gHqfu+DEI9DB3ro/YmjqWpg7xw==
X-Google-Smtp-Source: AA6agR4spfWbHnX22P3rGo45qaymewHk53IiWwFvdv38QVAYNh20XM9p0B1NcDUd0UHatSUqXoE+mg==
X-Received: by 2002:a63:525a:0:b0:42b:28a9:8a34 with SMTP id s26-20020a63525a000000b0042b28a98a34mr21320226pgl.269.1661949117772;
        Wed, 31 Aug 2022 05:31:57 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:31:57 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH 0/5] Introduce erofs shared domain
Date: Wed, 31 Aug 2022 20:31:20 +0800
Message-Id: <20220831123125.68693-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v1
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v1

[Background]
============
In ondemand read mode, we use individual volume to present an erofs
mountpoint, cookies to present bootstrap and data blobs.

In which case, since cookies can't be shared between fscache volumes,
even if the data blobs between different mountpoints are exactly same,
they can't be shared.

[Introduction]
==============
Here we introduce erofs shared domain to resolve above mentioned case.
Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

[Usage]
Users could specify 'domain_id' mount option to create or join into a
domain which reuses the same cookies(blobs).

[Design]
========
1. Use pseudo mnt to manage domain's lifecycle.
2. Use a linked list to maintain & traverse domains.
3. Use pseudo sb to create anonymous inode for recording cookie's info
   and manage cookies lifecycle.

[Flow Path]
===========
1. User specify a new 'domain_id' in mount option.
   1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
   1.2 Create a new domain(volume), add it to domain list.
   1.3 Traverse pseudo sb's inode list, compare cookie name with
       existing cookies.[Miss]
   1.4 Alloc new anonymous inodes and cookies.

2. User specify an existing 'domain_id' in mount option and the data
   blob is existed in domain.
   2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
   2.2 Reuse the domain and increase its refcnt.
   2.3 Traverse pseudo sb's inode list, compare cookie name with
   	   existing cookies.[Hit]
   2.4 Reuse the cookie and increase its refcnt.

[Test]
======
Git web: (More test cases will be added.)
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain

Jia Zhu (5):
  erofs: add 'domain_id' mount option for on-demand read sementics
  erofs: introduce fscache-based domain
  erofs: add 'domain_id' prefix when register sysfs
  erofs: remove duplicated unregister_cookie
  erofs: support fscache based shared domain

 fs/erofs/Makefile   |   2 +-
 fs/erofs/domain.c   | 175 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/fscache.c  |  17 ++++-
 fs/erofs/internal.h |  34 ++++++++-
 fs/erofs/super.c    |  45 +++++++++---
 fs/erofs/sysfs.c    |  11 ++-
 6 files changed, 270 insertions(+), 14 deletions(-)
 create mode 100644 fs/erofs/domain.c

-- 
2.20.1

