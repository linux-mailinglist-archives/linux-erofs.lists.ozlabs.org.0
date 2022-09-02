Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB65AACDC
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 12:54:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJvtN2SkXz2yyT
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 20:54:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5RX14LCU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5RX14LCU;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJvtD6Njhz2yYj
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 20:54:10 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id o4so1661314pjp.4
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Sep 2022 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vT4GD3+/0MzbbBEdOSGt98w+JvqU9hw4JCyFBULPEdA=;
        b=5RX14LCU/zE20jlyYS+jNVKQQY9uCRNuM5U94KDBQRnMPdv/BHlAUQKGHnpHxtYgPt
         YUC3gSidU4Ur8dKx1aE1Q39Pl1kU0Sc9F350a4+d8tRlMnGjCwrjlp1fF9xb38kQpzK4
         8rVNcFKvZdeU+5qqa1gtZoz4qq91WYBrw0clTb3l1kCU1RENsFuy+cZRf6m82kjXwxH+
         fUXq4nkVHXTHH8R/i1iasX0iwxtcQi1zp+kB8DAVoxpEI3K2+pNNvY8eGKO/Twl+mR0j
         VUk9OQDPCA2VSsoVmrc3o1F7PJLe/9cWfIiIml7/qFkWRTI3tDGFFDFhGZiPcXR8J/1F
         N9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vT4GD3+/0MzbbBEdOSGt98w+JvqU9hw4JCyFBULPEdA=;
        b=LKC5ypgY3d5M71+KZC54cKp5o82p1dssy1mUQCLL2OmaN6LsDRsQFIeGVFMQKzzXv+
         an3uJW5NlRK3wuNyUvb570JfQNBVyPfgSk1fF2ZW3YtpwpXCuJzbhFxMeJdZhcLnjnlu
         7Ts+/YrfoIpvUINInDAo3L3x9Q6TwF51hVNpsjxhkGWjN75FGENyErq/Z+0x7UCbepL2
         klq7tTAwDFh9G8oFmroqemkW8DaCEDUuAjAt1NffWwJOZiS1AY3FMo7wbsU+0hthOp5L
         8kkPmjSgBJdUz086h0v9pxHrSXFDR6Hx8/QUQR/L3FwKt3SC3J6HFeB70TsZUm8bI+w/
         VPTA==
X-Gm-Message-State: ACgBeo11lTr2MMjC0OiOLhA8oCaUxmaiGRCDg04psFCGNikXXhS0Cik4
	dAuEnTubqaZZ/q0Xp85SqeoOwsIJBgQjpw==
X-Google-Smtp-Source: AA6agR6kEeWww8j05ZFcDdob4i78cy50JnfDQIPezSnmR418EyvU4bI8yHEHQdn5r9dIeRz74989RQ==
X-Received: by 2002:a17:90b:4d12:b0:1f5:59e1:994f with SMTP id mw18-20020a17090b4d1200b001f559e1994fmr4142105pjb.217.1662116047024;
        Fri, 02 Sep 2022 03:54:07 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:06 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V2 0/5] Introduce erofs shared domain
Date: Fri,  2 Sep 2022 18:53:00 +0800
Message-Id: <20220902105305.79687-1-zhujia.zj@bytedance.com>
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

Changes since V1:
0. Only initialize one pseudo fs to manage anonymous inodes(cookies).
1. Remove ctx's 'ref' field and replace it with inode's i_count.
2. Add lock in erofs_fscache_unregister_cookie() to avoid race condition
   between cookie's get/put/search.
3. Remove useless blank lines.

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v2
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v2

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
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/


Jia Zhu (5):
  erofs: add 'domain_id' mount option for on-demand read sementics
  erofs: introduce fscache-based domain
  erofs: add 'domain_id' prefix when register sysfs
  erofs: remove duplicated unregister_cookie
  erofs: support fscache based shared domain

 fs/erofs/fscache.c  | 168 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  31 +++++++-
 fs/erofs/super.c    |  94 +++++++++++++++++++------
 fs/erofs/sysfs.c    |  11 ++-
 4 files changed, 278 insertions(+), 26 deletions(-)

-- 
2.20.1

