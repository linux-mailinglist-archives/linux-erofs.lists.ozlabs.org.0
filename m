Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829E79E782
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 14:03:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rlzcd1vMlz3cDS
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 22:03:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlzcL5yrKz2yVc
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 22:03:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs-kLcv_1694606585;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs-kLcv_1694606585)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 20:03:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 0/8] erofs-utils: mkfs: introduce rebuild mode
Date: Wed, 13 Sep 2023 20:02:55 +0800
Message-Id: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v8:
- patch 7: fix the missing call for erofs_mkfs_dump_blobs() in rebuild
  mode by also calling erofs_mkfs_dump_blobs() when sbi->extra_devices
  is not zero; otherwise the content of the on-disk device slot is all 0
- patch 8: strip overlay.opaque xattr when --ovlfs-strip=1; update the
  commit message accordingly

v1: https://lore.kernel.org/all/20230814034239.54660-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230816021347.126886-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230822092457.114686-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230823071517.12303-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20230901094706.27539-1-jefflexu@linux.alibaba.com/
v6: https://lore.kernel.org/all/20230905100227.1072-1-jefflexu@linux.alibaba.com/
v7: https://lore.kernel.org/all/20230909163240.42057-2-hsiangkao@linux.alibaba.com/

-------------------------

Introduce a new rebuild mode merging multiple erofs images generated
from either tarerfs index mode (--tar=i):

	mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=i --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layer0.erofs ... layerN.erofs

or tarerofs non-index mode (--tar=f):

	mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=f -Enoinline_data --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layer0.erofs ... layerN.erofs


Jingbo Xu (8):
  erofs-utils: lib: add list_splice_tail() helper
  erofs-utils: lib: make erofs_get_unhashed_chunk() global
  erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
  erofs-utils: lib: add erofs_insert_ihash() helper
  erofs-utils: lib: add erofs_rebuild_get_dentry() helper
  erofs-utils: lib: add erofs_rebuild_load_tree() helper
  erofs-utils: mkfs: introduce rebuild mode
  erofs-utils: mkfs: add `--ovlfs-strip` option

 include/erofs/blobchunk.h |   2 +
 include/erofs/config.h    |   1 +
 include/erofs/inode.h     |   5 +-
 include/erofs/internal.h  |   7 +-
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 ++
 include/erofs/xattr.h     |   2 +
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/inode.c               |  31 ++-
 lib/rebuild.c             | 404 ++++++++++++++++++++++++++++++++++++++
 lib/tar.c                 | 109 +---------
 lib/xattr.c               |  87 ++++++++
 mkfs/main.c               | 227 ++++++++++++++++-----
 14 files changed, 751 insertions(+), 170 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.19.1.6.gb485710b

