Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E715BA8C8
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 11:00:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTSh12Vqgz3bls
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 19:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PFppksqT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PFppksqT;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTSgv22yGz2xH9
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 18:59:53 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id go6so16228902pjb.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bpay7ieFN7L2BD1r82YunERmYrsWOu8zYKex4r+0oWE=;
        b=PFppksqTikwmeE7hjwS3gKaMSubi4w8nin/s0f8Y78blL3QN/srJIxl00OgBygNxxA
         uLI5mknRGe/QUsBXg9PkfQmXDGapb6+kTcRr+Lb70NU6v8BtWyZLb8TTMHvAowT+nd7O
         4s1QoXILXUqDbnyvPzYatuaq56I/HklY5hg+QOQzm9ekqYJuWl/W71mIL2i+26LwII1C
         Rmmar2t20U21mDlS/JXBLr8i/QN6tKr6tuPVPq8iXGj6k+eeVoayxnV+udj7Gfxz4an/
         1sNkvPSKFMgw4Z6VnDjtxmEJuLafHwNNkn23SdnjgMqomPPmkCyIsE35YTK9jOPJvEMb
         l2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bpay7ieFN7L2BD1r82YunERmYrsWOu8zYKex4r+0oWE=;
        b=j5chkR+hQjyMRJ/0AhfoURjIpp0YHWPPs9V4c5jT6Y3Iphh3s9P4A+ltOevr6y47cp
         d7cRceG0SSBb4qFbhAldJ2+IxB29jtM2G5p9T3i7qOmWYXD/HjOIaH3EbY1Nw8aLhIPW
         WAYaHjXnNbrW0Jro61YS4mXi9+Cg2WtdDZIioQPDD6ZCMRUjNArWmZDwZNnNu/l1pHu0
         fO6Qq0MYPMAvguWAfNVLwD+V+RI8vk4d37EN2Jq4D1/kULNqXF7yOhZ4PHWPGoXRwce9
         7rJs1rIIJiJHB38LUaHgh2r+v5lRBU8jGcfZglMiX7IuiL4r0HklhYZ9dv/i9k10onAv
         yOrA==
X-Gm-Message-State: ACrzQf0OknMD814r/ve5iOJo/M6WXMICXDg0hnU+XbNhXXxhssKtBGfL
	cOQTdhfXAJ+z1IM6Ux4TjQv3AmnrKQEcOw==
X-Google-Smtp-Source: AMsMyM4Z/PgW19wtEWnOkFA0a40RWMyMBzggOVW5eKXzaASNM8IvaNms0QWc9EI4dLnEcyvXoOv14A==
X-Received: by 2002:a17:902:e212:b0:178:5c:8248 with SMTP id u18-20020a170902e21200b00178005c8248mr3884974plb.102.1663318790508;
        Fri, 16 Sep 2022 01:59:50 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.01.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:59:49 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V5 0/6] Introduce erofs shared domain
Date: Fri, 16 Sep 2022 16:59:34 +0800
Message-Id: <20220916085940.89392-1-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Changes since V4:
0. Relinquish the volume after mutex unlock in erofs_fscache_domain_put().
1. Use kill_anon_super() instead of kill_litter_super() to umount pseudo mnt.
2. Extract erofs_fscache_relinquish_cookie() to reduce lines.
3. Add code comments.
4. Remove useless local variable initialization.
5. Add "Fixes" line to patch 1.
6. Add Reviewed-by lines from Jingbo Xu.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v5
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v5

[User Daemon for Quick Test]
============================
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

[E2E Container Demo for Quick Test]
===================================
[Issue]
	https://github.com/containerd/nydus-snapshotter/issues/161
[PR]
	https://github.com/containerd/nydus-snapshotter/pull/162

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

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20220902105305.79687-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20220914105041.42970-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20220915124213.25767-1-zhujia.zj@bytedance.com/

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain
  erofs: introduce 'domain_id' mount option

 fs/erofs/fscache.c  | 264 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |  32 ++++--
 fs/erofs/super.c    |  73 +++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 325 insertions(+), 63 deletions(-)

-- 
2.20.1

