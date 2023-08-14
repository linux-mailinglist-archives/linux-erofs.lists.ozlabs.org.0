Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39D77B03A
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKx05WMJz3bnN
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKwp0LNTz2yD6
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpemLy9_1691984559;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpemLy9_1691984559)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:40 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 00/13] erofs-utils: mkfs: introduce rebuild mode
Date: Mon, 14 Aug 2023 11:42:26 +0800
Message-Id: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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

The rebuild mode doesn't support flat inline datalayout yet.

Jingbo Xu (13):
  erofs-utils: fix overriding of i_rdev for special device
  erofs-utils: lib: add list_splice_tail() helper
  erofs-utils: lib: read i_ino in erofs_read_inode_from_disk()
  erofs-utils: lib: fix erofs_init_devices() in multidev mode
  erofs-utils: lib: keep self maintained devname
  erofs-utils: lib: make erofs_get_unhashed_chunk() global
  erofs-utils: lib: add erofs_read_xattrs_from_disk() helper
  erofs-utils: lib: add erofs_inode_tag_opaque() helper
  erofs-utils: lib: add erofs_insert_ihash() helper
  erofs-utils: lib: add erofs_rebuild_dump_tree() helper
  erofs-utils: lib: add erofs_rebuild_get_dentry() helper
  erofs-utils: lib: add erofs_rebuild_load_tree() helper
  erofs-utils: mkfs: introduce rebuild mode

 include/erofs/blobchunk.h |   2 +
 include/erofs/inode.h     |   5 +-
 include/erofs/internal.h  |   9 +-
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 +++
 include/erofs/xattr.h     |  23 +++
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/inode.c               |  33 +++-
 lib/io.c                  |  14 +-
 lib/namei.c               |   2 +
 lib/rebuild.c             | 387 ++++++++++++++++++++++++++++++++++++++
 lib/super.c               |  11 +-
 lib/tar.c                 | 193 +++++--------------
 lib/xattr.c               | 120 ++++++++++++
 mkfs/Makefile.am          |   3 +-
 mkfs/main.c               | 198 ++++++++++++++-----
 17 files changed, 839 insertions(+), 207 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.19.1.6.gb485710b

