Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A877D833
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 04:14:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQWsP3B5Pz3cN2
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 12:14:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQWsJ67Btz2yW5
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 12:13:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vptqv67_1692152027;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vptqv67_1692152027)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 10:13:48 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 00/12] erofs-utils: mkfs: introduce rebuild mode
Date: Wed, 16 Aug 2023 10:13:35 +0800
Message-Id: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
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

v2:
- add Reviewed-by tag from Gao Xiang
- patch 7: erofs_inode_tag_opaque() is merged into
  erofs_read_xattrs_from_disk(); simplify the implementation of
  erofs_read_xattrs_from_disk() in which erofs_setxattr() is used to set
  read xattrs directly; move all xattr name related macros to xattr.c;
  the long xattr name prefixes related logic now is all handled by
  erofs_getxattr() and erofs_setxattr() [1]
- patch 11: inode->i_ino[1] now is set to nid (i_ino[0] in v1) of source
  inode, and is used to distinguish the inode in the inode hash table

[1] https://lore.kernel.org/all/20230815091521.74661-1-jefflexu@linux.alibaba.com/

v1: https://lore.kernel.org/all/20230814034239.54660-1-jefflexu@linux.alibaba.com/

-------------------------

Introduce a new rebuild mode merging multiple erofs images generated
from either tarerfs index mode (--tar=i):

	mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=i --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs

or tarerofs non-index mode (--tar=f):

	mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs
layer0.tar
	...
	mkfs.erofs --tar=f -Enoinline_data --aufs layerN.erofs
layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs


Jingbo Xu (12):
  erofs-utils: fix overriding of i_rdev for special device
  erofs-utils: lib: add list_splice_tail() helper
  erofs-utils: lib: read i_ino in erofs_read_inode_from_disk()
  erofs-utils: lib: fix erofs_init_devices() in multidev mode
  erofs-utils: lib: keep self maintained devname
  erofs-utils: lib: make erofs_get_unhashed_chunk() global
  erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
  erofs-utils: lib: add erofs_insert_ihash() helper
  erofs-utils: lib: add erofs_rebuild_dump_tree() helper
  erofs-utils: lib: add erofs_rebuild_get_dentry() helper
  erofs-utils: lib: add erofs_rebuild_load_tree() helper
  erofs-utils: mkfs: introduce rebuild mode

 include/erofs/blobchunk.h |   2 +
 include/erofs/inode.h     |   5 +-
 include/erofs/internal.h  |   8 +-
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 +++
 include/erofs/xattr.h     |  33 +---
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/inode.c               |  33 +++-
 lib/io.c                  |  14 +-
 lib/namei.c               |   2 +
 lib/rebuild.c             | 387 ++++++++++++++++++++++++++++++++++++++
 lib/super.c               |  11 +-
 lib/tar.c                 | 195 +++++--------------
 lib/xattr.c               | 114 +++++++++++
 mkfs/Makefile.am          |   3 +-
 mkfs/main.c               | 199 +++++++++++++++-----
 17 files changed, 813 insertions(+), 239 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.19.1.6.gb485710b

