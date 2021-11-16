Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D473D452E5E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 10:50:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HthBD6BNZz2yJM
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 20:50:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HthB71X0bz2xDS
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 20:50:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UwqPg0-_1637056181; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwqPg0-_1637056181) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 17:49:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 0/6] erofs-utils: add multiple device support
Date: Tue, 16 Nov 2021 17:49:33 +0800
Message-Id: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

RFC: https://lore.kernel.org/r/20210928081608.9255-1-hsiangkao@linux.alibaba.com
RFC v2: https://lore.kernel.org/r/20210929022521.148059-1-hsiangkao@linux.alibaba.com
v3: https://lore.kernel.org/r/20211112123128.126741-1-hsiangkao@linux.alibaba.com

Hi forks,

This patchset mainly add multiple device support for erofs-utils,
including full multiple device support for erofsfuse, dump.erofs
and fsck.erofs.

Multiple device support is going to be used for the upcoming RAFS
v6 (EROFS-compatible on-disk format) [1] together with Nydus [2]
container image service. Thus, since RAFS v6 is an EROFS-compatible
on-disk format, erofsfuse, dump.erofs and fsck.erofs needs to handle
such images as well.

In addition, "--blobdev" option is added to mkfs.erofs which can
be used to redirect all chunked data to another blob file. It's
another direct use of the multiple device feature too.

[1] https://sched.co/pcdL
[2] https://github.com/dragonflyoss/image-service

Thanks,
Gao Xiang

Gao Xiang (6):
  erofs-utils: add extra device I/O interface
  erofs-utils: fuse: add multiple device support
  erofs-utils: mkfs: add extra blob device support
  erofs-utils: dump: support multiple devices
  erofs-utils: fsck: support multiple devices
  erofs-utils: get compression algorithms directly on mapping

 dump/main.c                | 57 +++++++++++++++++++++-------
 fsck/main.c                | 57 ++++++++++++++++++----------
 fuse/main.c                | 11 ++++++
 include/erofs/blobchunk.h  |  3 +-
 include/erofs/cache.h      |  5 +++
 include/erofs/config.h     |  1 +
 include/erofs/decompress.h |  5 ---
 include/erofs/defs.h       | 32 ++++++++++++++++
 include/erofs/internal.h   | 35 +++++++++++++++--
 include/erofs/io.h         | 10 +++--
 include/erofs_fs.h         | 22 +++++++++--
 lib/blobchunk.c            | 70 ++++++++++++++++++++++++++++------
 lib/data.c                 | 78 ++++++++++++++++++++++++++++----------
 lib/io.c                   | 48 ++++++++++++++++++-----
 lib/namei.c                |  4 +-
 lib/super.c                | 45 ++++++++++++++++++++--
 lib/zmap.c                 | 23 +++++------
 man/dump.erofs.1           | 25 +++---------
 man/erofsfuse.1            |  4 ++
 man/mkfs.erofs.1           |  3 ++
 mkfs/main.c                | 21 +++++++++-
 21 files changed, 432 insertions(+), 127 deletions(-)

-- 
2.24.4

