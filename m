Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3359B42B
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 15:58:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M9cX90l3gz3bqT
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Aug 2022 23:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BPHnRI2O;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BPHnRI2O;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M9cX21hqHz3bXD
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 23:58:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso8923744pjo.5
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Aug 2022 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=UQQzefDptbAYQPi2SEjO3xYIUAfNeEAIZzi8TR7KziE=;
        b=BPHnRI2OkGhbpeJI0zO/c073+q/1o56VE4v/nTtHra5FQxLxIyzVkpKT2MvZMhqWI5
         dK1VyXYtNoSTk6K3ZzEJXotDV6WXAHRneDtNtikYmkbwx2jfR/2IDlQ4IdB9FqUX3UTP
         1vb1NAH9WRBPnWDVi4dXqiFuJ/MoWn9QiKJMoT6b3+DuKv42qeTZ66faHve+bbnlmZay
         TGHJexxI+Xga60Mfk0McBjWTa+pNZtDZzgI7iDvB/vP0k59JDon1IlF63xbseSIGQTsi
         DQbThwpPilCFun9ZZ84uoX2rOb+p6tKYezOQCRhcoikgSMSF+XBCgh8th6Z6KchRFk9+
         5RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UQQzefDptbAYQPi2SEjO3xYIUAfNeEAIZzi8TR7KziE=;
        b=IaWCKRjh6vEZXPWkuZr3hcZUoe8Gmar+9oTa1WUL01ye8Jdsg0ElYsTR10XgK9fDKK
         aWr3JR0/FDCFQS8OngHdZeMKNQORmzk77EBXqk0OHODhaUuIhxNajRiI4BBYR3y3MBCO
         yh8AhxKki0g35ZdytZA3zg+ROs0wL90ACk0oqpnSBzkhTy5WkZZvHJ9qgBEvirptSHwK
         gEIn/kL06Pk1+uqdZS50Bjh7NON1bfgN08KuBfTCuOEvv7jtVWBfshjiQ5yyn9JwyvvL
         w8cREvd8wb0JuhmgKI8KpPtQULC34X3gGbN8Xyc3+Kdon7PxP5hDE16Q1NBGvv7eu9vM
         2RAw==
X-Gm-Message-State: ACgBeo0UsSG/3JhjUcTUdccxj5Qecsz9fxvXoXcYRk1cS0VeiiSg6Ysw
	lOGBw7K2NzEAWPajXrrzjPktDNfbOOo=
X-Google-Smtp-Source: AA6agR4LhFl2KEaV0wDMH641+fI9V1a1SklEDa/iYor+oX01mMd8xiVkLfddRHu7zeSvnSDjr5Bfgw==
X-Received: by 2002:a17:90a:bc8f:b0:1fa:bdb4:96c8 with SMTP id x15-20020a17090abc8f00b001fabdb496c8mr18512792pjr.236.1661090283199;
        Sun, 21 Aug 2022 06:58:03 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g29-20020aa796bd000000b00535e46171c1sm6088318pfk.117.2022.08.21.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:02 -0700 (PDT)
From: zbestahu@gmail.com
X-Google-Original-From: huyue2@coolpad.com
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v4 0/3] erofs-utils: compressed fragments feature
Date: Sun, 21 Aug 2022 21:57:22 +0800
Message-Id: <cover.1661087840.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

In order to achieve greater compression ratio, let's introduce
compressed fragments feature which can merge tail of per-file or the
whole files into one special inode to reach the target.

And we can also set pcluster size to fragments inode for different
compression requirments.

In this patchset, we also improve the uncompressed data layout of
compressed files. Just write it from 'clusterofs' instead of 0 since it
can benefit from in-place I/O. For now, it only goes with fragments.

The main idea above is from Xiang.

Here is some test data of Linux 5.10.87 source code under Ubuntu 18.04:

linux-5.10.87 (erofs, uncompressed)                1.1G

linux-5.10.87 (erofs, lz4hc,12 4k fragments,4k)    301M
linux-5.10.87 (erofs, lz4hc,12 8k fragments,8k)    268M
linux-5.10.87 (erofs, lz4hc,12 16k fragments,16k)  242M
linux-5.10.87 (erofs, lz4hc,12 32k fragments,32k)  225M
linux-5.10.87 (erofs, lz4hc,12 64k fragments,64k)  217M

linux-5.10.87 (erofs, lz4hc,12 4k vanilla)         396M
linux-5.10.87 (erofs, lz4hc,12 8k vanilla)         376M
linux-5.10.87 (erofs, lz4hc,12 16k vanilla)        364M
linux-5.10.87 (erofs, lz4hc,12 32k vanilla)        359M
linux-5.10.87 (erofs, lz4hc,12 64k vanilla)        358M

Usage:
mkfs.erofs -zlz4hc,12 -C65536 -Efragments,65536 foo.erofs.img foo/

Changes since v3:
 - fuse minor change and modify fragments naming related suggested by Xiang;
 - refator fragments build code;
 - rebase to latest commit 547bea3cb71a.

Changes since v2:
 - mainly reimplment the decompression logic for fragment inode due to
   kernel side;
 - fix compatibility issue to old image with ztailpacking feature;
 - move code of super.c in patch 3/3 to patch 1/3;
 - minor naming change.

Changes since v1:
 - mainly optimize index space for fragment inode;
 - add merging tail with len <= pclustersize into fragments directly;
 - use a inode instead of nid to avoid multiple load fragments;
 - fix memory leak of building fragments;
 - minor change to diff special fragments with normal inode.
 - rebase to commit cb058526 with patch [1];
 - code cleanup.

Note that inode will be extended version (64 bytes) due to mtime, may
use 'force-inode-compact' option to reduce the size if mtime careless.

[1] https://lore.kernel.org/linux-erofs/20220722053610.23912-1-huyue2@coolpad.com/

Yue Hu (3):
  erofs-utils: lib: add support for fragments data decompression
  erofs-utils: lib: support on-disk offset for shifted decompression
  erofs-utils: introduce compressed fragments support

 include/erofs/compress.h   |   3 +-
 include/erofs/config.h     |   3 +-
 include/erofs/decompress.h |   3 ++
 include/erofs/fragments.h  |  25 +++++++++
 include/erofs/inode.h      |   1 +
 include/erofs/internal.h   |   7 +++
 include/erofs_fs.h         |  27 +++++++---
 lib/Makefile.am            |   4 +-
 lib/compress.c             | 108 +++++++++++++++++++++++++++----------
 lib/data.c                 |  28 +++++++++-
 lib/decompress.c           |  10 +++-
 lib/fragments.c            |  58 ++++++++++++++++++++
 lib/inode.c                |  59 +++++++++++++++-----
 lib/super.c                |  24 ++++++++-
 lib/zmap.c                 |  26 +++++++++
 mkfs/main.c                |  64 +++++++++++++++++++---
 16 files changed, 390 insertions(+), 60 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

