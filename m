Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684F5BBBA7
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 06:35:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MVZjh2KTTz3bdg
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 14:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=LXQbGXSn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=LXQbGXSn;
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MVZjV3llGz2xKh
	for <linux-erofs@lists.ozlabs.org>; Sun, 18 Sep 2022 14:35:08 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so3156400pja.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 17 Sep 2022 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=i1zDof6OtvGZP5SPndoQ1fuuVqZzAR4cxcPoesi3UZQ=;
        b=LXQbGXSnCu1RB9u7uebnc9Z0LaBzCWIEB/4qpF887O03nW02QEWF/azLZaiU9xfarr
         9deDlOP6adhCM/Y58+MSjvXnuN4LLdvpncUTRoyxPgwWyzey9uarYsrh+RjQtNo5Di3y
         nyhWnSubU15bSHOrKdQRtjLObKZioWl7yL/PiueXpSk9E4p2bwNp8H+EQV3OvM+WwmVW
         MTx3KaNpaWGtmCasoChP+CJi57On5fQlVyXp5KEgKIaQDRunYMe5iBqypbiqqosI7A6D
         L7qqd+2LcmLRs+vz8DSlZ64bpppcmXyFbhQGreAZO75DNBqtlm9NqOa85jeTc3g4Xlq6
         XFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=i1zDof6OtvGZP5SPndoQ1fuuVqZzAR4cxcPoesi3UZQ=;
        b=kWBPk8EL6QlffQNPvOcxAi7pD3lMzldA+ylhE/wStbUCUWeJPe+0BBInzTJmuobS9f
         RkOMGLqn28JlJEX51KXKA6hzi983/NVm6P8Q0lCHmWmAZaV+0THU9eRbw/7Fkup7atkE
         zghKGH25Lk680tj/Ou3susWpfmT0ogJXWW1kG8qPXXAJvQDVrYJ78Z2azY+ZgyYxb/yg
         dhkdYjinYFM3aPRzUuUoqzKrnD0C/AUL2IYcDAOemRU7EZ0O3r2WDJrH+g34Z2bVJDIm
         938N5rTugM7blhdhN+ip+Ayb50tQHVnXNY1E7xSA3BoWbNvz1qqgmkjSh9jNNE7jNopq
         SKgw==
X-Gm-Message-State: ACrzQf1Ldg/sFi98EVYduf+7QtiUrkCEBDNJha8z1QV8VVOmDTc9AQGe
	kkZCTReN5HAebqqMlwyuhmi/XVXMdTG0pV63
X-Google-Smtp-Source: AMsMyM57wriUwliO2AXNIEA0PUT6e6XYJXVTf8ub390eTWLi8xe1z7AMtFfvlz6UW/1FyXxKosxPRA==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr23615945pjy.228.1663475703591;
        Sat, 17 Sep 2022 21:35:03 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:03 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V6 0/6] Introduce erofs shared domain
Date: Sun, 18 Sep 2022 12:34:50 +0800
Message-Id: <20220918043456.147-1-zhujia.zj@bytedance.com>
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

[Kernel Patchset]
===============
Git tree:
	https://github.com/userzj/linux.git zhujia/shared-domain-v6
Git web:
	https://github.com/userzj/linux/tree/zhujia/shared-domain-v6

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
V5: https://lore.kernel.org/all/20220916085940.89392-1-zhujia.zj@bytedance.com/

Jia Zhu (6):
  erofs: use kill_anon_super() to kill super in fscache mode
  erofs: code clean up for fscache
  erofs: introduce fscache-based domain
  erofs: introduce a pseudo mnt to manage shared cookies
  erofs: Support sharing cookies in the same domain
  erofs: introduce 'domain_id' mount option

 fs/erofs/fscache.c  | 263 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |  32 ++++--
 fs/erofs/super.c    |  73 +++++++++---
 fs/erofs/sysfs.c    |  19 +++-
 4 files changed, 324 insertions(+), 63 deletions(-)

-- 
2.20.1

