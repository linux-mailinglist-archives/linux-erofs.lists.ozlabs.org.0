Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A59095AA688
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkQn4TLVz2yx8
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3fno8THL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3fno8THL;
	dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkQf2BMsz2xHw
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:08 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id bh13so886599pgb.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hcraQuo3t4d4QrFau8j8qQ9DHHwXRsW4oFyIv4CPr0M=;
        b=3fno8THLVlG0GX9ntut3pD0E8LZambLAMn6wFPkGNJWKh5C0doM2JyQB8jhj22obB3
         xvS+IYfwcx/a0omB3oH/Sqi0V3qhUhRfFHJ93TVOMnfxC+1pYMNb21yEIuyioBEgcspB
         zbniO60dzuP96M2jg9rB1/r7z6D0qM220UAoxMPmvi1/sqYNg+AGlDmtK6wwtzOnsgwY
         U9uZkCojQnDuM9K5LerbslI9erbS4twa8qknhmdGic7uLFGRyDTBIgmuk7giBrJ/w3HI
         Oq8vS6LV4UnXToUjBCM9MQbsXXDpPEgJoFgni4imes372r323INEcvorUDRlhjOjxfQb
         jmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hcraQuo3t4d4QrFau8j8qQ9DHHwXRsW4oFyIv4CPr0M=;
        b=FDSTRbSrKsgeoy/QcitPdSC7OGyo0Pu8VcBBaEfDdQk+izsTH9mxhJBS/ENOkZ4Bbq
         wLJTRlMvokGC0+VJUlWIQ9UKuqE8Yuk0K/dzj/DgqTyAo1S2BdMS6qFKNskdHen+nB+Z
         DxurCWhB4dupUA5k49NlDi6KKuez/49OEsssWYiYhtlIwKo/JkC80j2xMzqs20/kUkop
         3l6LXJjl20ozSd/L6qOgku8FXJD8JEwSbWNufkGwTQH5B6UNSd6rMC82arOk6IXZAyBl
         +gBG4Z6yJDdSmbhw1GR+v5YakfpD4Y7VGhHd522AeQERkJkZNG1sIB2wwCl52DZ0clNo
         8efw==
X-Gm-Message-State: ACgBeo3oiHAqd7gf7EwGLOkLKrx6+4nirWtdAXcLLjVgNfdcY5pE/gLf
	JWJxfsUxSyvZI8wGYo/Hjg8w5wm19bc20w==
X-Google-Smtp-Source: AA6agR7dRYABhSvA/oWYU4UmpifJnz+WUVXp4AetGrnCOvoV4+bRVCAIaRJfQYdTVb77CGwYqnng9A==
X-Received: by 2002:a63:41c5:0:b0:42c:6b7f:6d95 with SMTP id o188-20020a6341c5000000b0042c6b7f6d95mr15717008pga.175.1662090485261;
        Thu, 01 Sep 2022 20:48:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:04 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 0/5] Introduce erofs shared domain
Date: Fri,  2 Sep 2022 11:47:43 +0800
Message-Id: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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

Changes since RFC:
1. Fix the macro CONFIG_EROFS_FS_ONDEMAND misuse in
   erofs_fc_parse_param().
2. Move the code in domain.c to fscache.c
3. Remove the definition of anon_inode_fs_type and just use erofs
   filesystem type to init pseudo mnt.
4. Use mutex lock for erofs_domain_list.
5. Unregister the cookies before kill_sb() to avoid inode busy when
   umount erofs.
6. Remove useless declaration of domain_get/put in internal.h

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
Git web:
	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
More test cases will be added to:
	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache 

RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/

Jia Zhu (5):
  erofs: add 'domain_id' mount option for on-demand read sementics
  erofs: introduce fscache-based domain
  erofs: add 'domain_id' prefix when register sysfs
  erofs: remove duplicated unregister_cookie
  erofs: support fscache based shared domain

 fs/erofs/fscache.c  | 169 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  33 ++++++++-
 fs/erofs/super.c    |  94 ++++++++++++++++++------
 fs/erofs/sysfs.c    |  11 ++-
 4 files changed, 281 insertions(+), 26 deletions(-)

-- 
2.20.1

