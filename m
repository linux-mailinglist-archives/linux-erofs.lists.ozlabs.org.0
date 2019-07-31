Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A87C7D2
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 17:59:03 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zJ4z49kyzDqkf
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 01:58:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zJ4K5qcxzDqjb
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2019 01:58:23 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B31A9CCB8EE6D6FE45A5;
 Wed, 31 Jul 2019 23:58:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:09 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu
 <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 00/22] staging: erofs: updates according to
 erofs-outofstaging v4
Date: Wed, 31 Jul 2019 23:57:30 +0800
Message-ID: <20190731155752.210602-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changes from v1:
 (mainly address comments from Chao:)
  - keep EROFS_IO_MAX_RETRIES_NOFAIL;
  - add a new patch "drop __GFP_NOFAIL for managed inode";
  - kill a redundant NULL check in "__stagingpage_alloc";
  - add some description in document about "use_vmap";
  - rearrange erofs_vmap of "staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM";
 - combine two similar patches about "cleaning up internal.h"
   since they rearrange the same file...

----8<----

This patchset includes all meaningful modifications till now according
to erofs-outofstaging v4:
https://lore.kernel.org/linux-fsdevel/20190725095658.155779-1-gaoxiang25@huawei.com/

Some empty lines which were add or delete are not included in this
patchset, I will send erofs-outofstaging v5 later in order to keep
main code bit-for-bit identical with this staging patchset.

Thanks,
Gao Xiang

Gao Xiang (22):
  staging: erofs: update source file headers
  staging: erofs: rename source files for better understanding
  staging: erofs: fix dummy functions erofs_{get,list}xattr
  staging: erofs: keep up erofs_fs.h with erofs-outofstaging patchset
  staging: erofs: sunset erofs_workstn_{lock,unlock}
  staging: erofs: clean up internal.h
  staging: erofs: remove redundant #include "internal.h"
  staging: erofs: kill CONFIG_EROFS_FS_IO_MAX_RETRIES
  staging: erofs: clean up shrinker stuffs
  staging: erofs: kill sbi->dev_name
  staging: erofs: kill all failure handling in fill_super()
  staging: erofs: drop __GFP_NOFAIL for managed inode
  staging: erofs: refine erofs_allocpage()
  staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM
  staging: erofs: tidy up zpvec.h
  staging: erofs: remove redundant braces in inode.c
  staging: erofs: tidy up decompression frontend
  staging: erofs: remove clusterbits in sbi
  staging: erofs: turn cache strategies into mount options
  staging: erofs: tidy up utils.c
  staging: erofs: update super.c
  staging: erofs: update Kconfig

 .../erofs/Documentation/filesystems/erofs.txt |   14 +
 drivers/staging/erofs/Kconfig                 |  111 +-
 drivers/staging/erofs/Makefile                |    4 +-
 drivers/staging/erofs/compress.h              |    2 +-
 drivers/staging/erofs/data.c                  |    6 +-
 drivers/staging/erofs/decompressor.c          |   45 +-
 drivers/staging/erofs/dir.c                   |    6 +-
 drivers/staging/erofs/erofs_fs.h              |   47 +-
 .../erofs/include/trace/events/erofs.h        |    2 +-
 drivers/staging/erofs/inode.c                 |   24 +-
 drivers/staging/erofs/internal.h              |  246 +--
 drivers/staging/erofs/namei.c                 |    7 +-
 drivers/staging/erofs/super.c                 |  268 ++-
 .../erofs/{include/linux => }/tagptr.h        |   12 +-
 drivers/staging/erofs/unzip_vle.c             | 1591 -----------------
 drivers/staging/erofs/utils.c                 |  112 +-
 drivers/staging/erofs/xattr.c                 |    6 +-
 drivers/staging/erofs/xattr.h                 |   22 +-
 drivers/staging/erofs/zdata.c                 | 1405 +++++++++++++++
 .../staging/erofs/{unzip_vle.h => zdata.h}    |  119 +-
 drivers/staging/erofs/zmap.c                  |    5 +-
 .../erofs/{unzip_pagevec.h => zpvec.h}        |   41 +-
 22 files changed, 1856 insertions(+), 2239 deletions(-)
 rename drivers/staging/erofs/{include/linux => }/tagptr.h (94%)
 delete mode 100644 drivers/staging/erofs/unzip_vle.c
 create mode 100644 drivers/staging/erofs/zdata.c
 rename drivers/staging/erofs/{unzip_vle.h => zdata.h} (56%)
 rename drivers/staging/erofs/{unzip_pagevec.h => zpvec.h} (78%)

-- 
2.17.1

