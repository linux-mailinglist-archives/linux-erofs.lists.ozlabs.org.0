Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0497921BE
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:02:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1Jv60M6z3bv2
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:02:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jq6TCSz301V
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:34 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPSrQl_1693908147;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPSrQl_1693908147)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:28 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 00/11] erofs-utils: mkfs: introduce rebuild mode
Date: Tue,  5 Sep 2023 18:02:16 +0800
Message-Id: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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

v6:
- newly add cleanup patches (patch 1 and 9)
- patch 8: improve the code of parsing multiple sources with "do {}
  while" loop
- patch 10: newly added to work around the potential issue of exposing
  whiteouts in the overlayfs mount by setting origin xattr on parent
  directory of whiteouts
- patch 11: the former "--keep-whiteout" option is renamed to
  "--overlay-strip" option; apart from whiteouts, origin xattrs will
  also be stripped when the option is enabled

[1] https://lore.kernel.org/all/20230822092457.114686-2-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20230822092457.114686-3-jefflexu@linux.alibaba.com/

v1: https://lore.kernel.org/all/20230814034239.54660-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230816021347.126886-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230822092457.114686-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230823071517.12303-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20230901094706.27539-1-jefflexu@linux.alibaba.com/

-------------------------

Introduce a new rebuild mode merging multiple erofs images generated
from either tarerfs index mode (--tar=i):

	mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=i --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs

or tarerofs non-index mode (--tar=f):

	mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=f -Enoinline_data --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs


Jingbo Xu (11):
  erofs-utils: lib: remove unneeded NULL checking for returned item
  erofs-utils: lib: add list_splice_tail() helper
  erofs-utils: lib: make erofs_get_unhashed_chunk() global
  erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
  erofs-utils: lib: add erofs_insert_ihash() helper
  erofs-utils: lib: add erofs_rebuild_get_dentry() helper
  erofs-utils: lib: add erofs_rebuild_load_tree() helper
  erofs-utils: mkfs: introduce rebuild mode
  erofs-utils: lib: add erofs_inode_is_whiteout() helper
  erofs-utils: lib: set origin xattr on parent directory of whiteout
  erofs-utils: mkfs: add --overlay-strip option for tarfs and rebuild
    mode

 include/erofs/blobchunk.h |   2 +
 include/erofs/config.h    |   1 +
 include/erofs/inode.h     |   5 +-
 include/erofs/internal.h  |  11 +
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 ++
 include/erofs/xattr.h     |  36 +---
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/inode.c               |  26 ++-
 lib/rebuild.c             | 409 ++++++++++++++++++++++++++++++++++++++
 lib/tar.c                 | 129 ++----------
 lib/xattr.c               | 144 +++++++++++++-
 mkfs/main.c               | 228 ++++++++++++++++-----
 14 files changed, 827 insertions(+), 210 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.19.1.6.gb485710b

