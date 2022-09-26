Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F585EAADA
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Sep 2022 17:25:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MbmmH3nXzz3bkx
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 01:25:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mbmm81drdz300V
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 01:25:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQoJOH7_1664205913;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQoJOH7_1664205913)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 23:25:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/8] erofs-utils: collection for fragments and dedupe
Date: Mon, 26 Sep 2022 23:25:03 +0800
Message-Id: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a collection patchset to resolve conflicts for the following
features:
https://lore.kernel.org/r/cover.1663065968.git.huyue2@coolpad.com (fragments)
and
https://lore.kernel.org/r/20220909045821.104499-1-ZiyangZhang@linux.alibaba.com (dedupe)

Except that the fragment feature still has some TODOs. For example,
duplicated fragment data can still exist in the packed file and
needs to be optimized to avoid fragment data duplication. However
such improvement is purely a userspace strategy improvement and I
think Yue Hu will continue working on this.

I've tested fragments + dedupe with the following testcase:

dataset: Linux 5.10 + Linux 5.10.87 source code
pcluster size: 4k

compressed vanilla		658845696
fragment			634245120
dedupe				488689664
dedupe + fragment               425848832

Gao Xiang (2):
  erofs-utils: introduce z_erofs_inmem_extent
  erofs-utils: fuse: introduce partial-referenced pclusters

Yue Hu (4):
  erofs-utils: fuse: support interlaced uncompressed pcluster
  erofs-utils: lib: support fragments data decompression
  erofs-utils: mkfs: support interlaced uncompressed data layout
  erofs-utils: mkfs: support fragments

Ziyang Zhang (2):
  erofs-utils: lib: add rb-tree implementation
  erofs-utils: mkfs: introduce global compressed data deduplication

 include/erofs/compress.h   |  11 +-
 include/erofs/config.h     |   4 +-
 include/erofs/decompress.h |   3 +
 include/erofs/dedupe.h     |  39 +++
 include/erofs/fragments.h  |  28 ++
 include/erofs/inode.h      |   1 +
 include/erofs/internal.h   |  14 +
 include/erofs_fs.h         |  33 ++-
 lib/Makefile.am            |   5 +-
 lib/compress.c             | 296 +++++++++++++++------
 lib/data.c                 |  29 ++-
 lib/decompress.c           |  19 +-
 lib/dedupe.c               | 176 +++++++++++++
 lib/fragments.c            |  65 +++++
 lib/inode.c                |  58 ++++-
 lib/rb_tree.c              | 512 +++++++++++++++++++++++++++++++++++++
 lib/rb_tree.h              | 104 ++++++++
 lib/rolling_hash.h         |  60 +++++
 lib/super.c                |   1 +
 lib/zmap.c                 |  59 ++++-
 mkfs/main.c                |  77 +++++-
 21 files changed, 1492 insertions(+), 102 deletions(-)
 create mode 100644 include/erofs/dedupe.h
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/dedupe.c
 create mode 100644 lib/fragments.c
 create mode 100644 lib/rb_tree.c
 create mode 100644 lib/rb_tree.h
 create mode 100644 lib/rolling_hash.h

-- 
2.24.4

