Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE37999F8
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RjdnT3kvWz3by9
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjdnN0xbTz3bVS
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:32:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrfyqNa_1694277160;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqNa_1694277160)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:32:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 00/13] erofs-utils: mkfs: introduce rebuild mode
Date: Sun, 10 Sep 2023 00:32:27 +0800
Message-Id: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v6: https://lore.kernel.org/r/20230905100227.1072-1-jefflexu@linux.alibaba.com

changes since v6:
 - several random fixes when testing with `--enable-debug`
 - better code arrangement.

I plan to use this version for testing.

Thanks,
Gao Xiang

Gao Xiang (2):
  erofs-utils: lib: avoid exporting non-EROFS xattrs
  erofs-utils: lib: always fix up xattr_isize even w/o xattrs

Jingbo Xu (11):
  erofs-utils: lib: remove unneeded NULL checks
  erofs-utils: lib: add erofs_inode_is_whiteout() helper
  erofs-utils: lib: set OVL_XATTR_ORIGIN for directories with whiteouts
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
 include/erofs/internal.h  |  18 +-
 include/erofs/list.h      |  20 ++
 include/erofs/rebuild.h   |  21 ++
 include/erofs/xattr.h     |  34 +---
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   2 +-
 lib/inode.c               |  29 ++-
 lib/rebuild.c             | 404 ++++++++++++++++++++++++++++++++++++++
 lib/tar.c                 | 125 ++----------
 lib/xattr.c               | 138 ++++++++++++-
 mkfs/main.c               | 225 ++++++++++++++++-----
 14 files changed, 815 insertions(+), 212 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

-- 
2.24.4

