Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E65B9B27
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 14:42:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSxgL3t8Qz3bdk
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 22:42:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZcehTf+g;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZcehTf+g;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSxgD5Cp6z2xJD
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 22:42:32 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id a80so9355710pfa.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7R+j7wZtr6PMHfqjiv3nkV/a0UcoizsRKOwYLocOZGY=;
        b=ZcehTf+g6XANFF260jYKGNH1MHnPD/8e3qg1uMSIVbEZsbO2mQ1a91g5+kBrfmMc8D
         df95AQ58en4aIwU8Cqhuws2yBIc7M/pgkzQsOMajpAkm1AcrX8fZYCzBPukSqShDiQEc
         1HTxogrPOBliLkhrNXxnbyz2NGS3F1sXZBaPguGlVZoNAzv62yCkgrgCMWb653glMssm
         LI4nQUt6aoXUVur2AGuLWJ3JiaIgS3/mejYmAWKit/XKdLLxB9kagZBBdo0JgrPZzLvf
         PGmZj+14574uE00vgdJIuCMlXssnh0COFDE8xHpiSGmt3AE+Q77VdYews3P6Zr4tIp5n
         r9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7R+j7wZtr6PMHfqjiv3nkV/a0UcoizsRKOwYLocOZGY=;
        b=X4DXCHJWdxvHuxeORJ1V7EWuCQyXYqNY3ZSa34+kMygNo6upD6Ibqnry45sMo0Z1ad
         cLSU2nSWkjzTY/2z4SBj3YgJ7GX1ossw1vo/PJlePxe8W3FsByJLiKki0AjM3cxUFCpO
         8PifFvbrBTZtcHtjX3gmw+ZQAX1WGl0Lk0p5i+u+/g8I1LGSyn64iS2ApCp6n3Vbh8Sh
         ev+FvOqjMHisRG9x4uJT8DDP0/i7i+GY8jYnfiIYnR+BeR+Her4dj6lUR4Bk7D20PwxE
         c9nYDqdJs8fvBCZI0gAxBb+Q8XuC6TQJZqGyp1yBFN/LrQ5AxNvtTcNn/PydC0L0YMxx
         I+SA==
X-Gm-Message-State: ACgBeo31INI6j23V8Is1wUvVGWcxpPOYcWsrjzbOpcm4bSysN0g1QPlw
	6yYRsfI31+GOozTri5Sp6N7f9caUznLnhA==
X-Google-Smtp-Source: AA6agR48s/xjOTWg6C4e0X1Y+joB/hhyF2EiMG4yEQMB7vlw4rdRJ/Bd2KRlsLAK79QiVzKyVXdXEQ==
X-Received: by 2002:a05:6a00:1149:b0:53e:62c8:10bc with SMTP id b9-20020a056a00114900b0053e62c810bcmr41667054pfm.49.1663245748645;
        Thu, 15 Sep 2022 05:42:28 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:27 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V4 0/6] Introduce erofs shared domain
Date: Thu, 15 Sep 2022 20:42:07 +0800
Message-Id: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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

Changes since V3:
1. Avoid race condition.
   1.1. Relinquish the volume before removing the domain from list. 
   1.2. Hold erofs_domain_list_lock before dec the refcnt of domain.
2. Relinquish previously registered erofs_fscache in
	erofs_fscache_domain_init_cookie()'s error handling path.
3. Some code cleanups without logic change.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v4
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v4

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

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain
  erofs: introduce 'domain_id' mount option

 fs/erofs/fscache.c  | 253 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |  30 ++++--
 fs/erofs/super.c    |  72 ++++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 317 insertions(+), 57 deletions(-)

-- 
2.20.1

