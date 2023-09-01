Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8CF78FB5F
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 11:47:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RcY9J1pF8z3c4M
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 19:47:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RcY8z6Xz0z3bvB
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Sep 2023 19:47:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vr4rL5W_1693561627;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vr4rL5W_1693561627)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 17:47:07 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 0/8] erofs-utils: mkfs: introduce rebuild mode
Date: Fri,  1 Sep 2023 17:46:58 +0800
Message-Id: <20230901094706.27539-1-jefflexu@linux.alibaba.com>
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

v5:
- patch 6: reuse the new allocated inode; call
  erofs_rebuild_get_dentry() first, and then erofs_read_inode_from_disk()
  is called only when erofs_rebuild_get_dentry() indicates a valid
  location of this inode (Gao Xiang)
- patch 7: add new helper erofs_alloc_root_inode()


[1] https://lore.kernel.org/all/20230822092457.114686-2-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20230822092457.114686-3-jefflexu@linux.alibaba.com/

v1: https://lore.kernel.org/all/20230814034239.54660-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230816021347.126886-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230822092457.114686-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230823071517.12303-1-jefflexu@linux.alibaba.com/

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




Jingbo Xu (8):
  erofs-utils: lib: add list_splice_tail() helper
  erofs-utils: lib: make erofs_get_unhashed_chunk() global
  erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
  erofs-utils: lib: add erofs_insert_ihash() helper
  erofs-utils: lib: add erofs_rebuild_get_dentry() helper
  erofs-utils: lib: add erofs_rebuild_load_tree() helper
  erofs-utils: mkfs: introduce rebuild mode
  erofs-utils: mkfs: add --keep-whiteout option for tarfs and rebuild
    mode

 include/erofs/blobchunk.h |   2 +
 include/erofs/config.h    |   1 +
 include/erofs/inode.h     |   5 +-
 include/erofs/internal.h  |   6 +
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 ++
 include/erofs/xattr.h     |  33 +---
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/config.c              |   1 +
 lib/inode.c               |  31 ++-
 lib/rebuild.c             | 400 ++++++++++++++++++++++++++++++++++++++
 lib/tar.c                 | 118 +----------
 lib/xattr.c               | 112 +++++++++++
 mkfs/main.c               | 229 +++++++++++++++++-----
 15 files changed, 781 insertions(+), 203 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.19.1.6.gb485710b

