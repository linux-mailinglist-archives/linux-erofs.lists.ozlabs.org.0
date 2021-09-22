Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD0415040
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 20:56:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF6wP09XMz2yw5
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 04:56:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF6wC2P79z2yZh
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 04:56:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpFo0Io_1632336968; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpFo0Io_1632336968) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 02:56:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/5] erofs-utils: add support for chunk-based files
Date: Thu, 23 Sep 2021 02:56:02 +0800
Message-Id: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v1 & 2: https://lore.kernel.org/r/20210818070316.1970-2-hsiangkao@linux.alibaba.com

changes since v2:
 - add erofsfuse support for chunk-based files;
 - add support for 4-byte blockmap array in addition to chunk indexes;
 - update manpages;
 - minor cleanups.

Gao Xiang (5):
  erofs-utils: fuse: support reading chunk-based uncompressed files
  erofs-utils: introduce hashmap from git source
  erofs-utils: introduce sha256
  erofs-utils: introduce copy_file_range
  erofs-utils: mkfs: support chunk-based uncompressed files

 configure.ac               |   1 +
 include/erofs/blobchunk.h  |  18 +++
 include/erofs/config.h     |   1 +
 include/erofs/defs.h       |  77 ++++++++++
 include/erofs/flex-array.h | 147 +++++++++++++++++++
 include/erofs/hashmap.h    | 103 ++++++++++++++
 include/erofs/hashtable.h  |  77 ----------
 include/erofs/internal.h   |   6 +
 include/erofs/io.h         |   7 +
 include/erofs_fs.h         |  48 ++++++-
 lib/Makefile.am            |   3 +-
 lib/blobchunk.c            | 217 ++++++++++++++++++++++++++++
 lib/data.c                 |  86 +++++++++--
 lib/hashmap.c              | 284 +++++++++++++++++++++++++++++++++++++
 lib/inode.c                |  36 ++++-
 lib/io.c                   |  97 ++++++++++++-
 lib/namei.c                |  15 +-
 lib/sha256.c               | 248 ++++++++++++++++++++++++++++++++
 man/mkfs.erofs.1           |   3 +
 mkfs/main.c                |  38 +++++
 20 files changed, 1413 insertions(+), 99 deletions(-)
 create mode 100644 include/erofs/blobchunk.h
 create mode 100644 include/erofs/flex-array.h
 create mode 100644 include/erofs/hashmap.h
 create mode 100644 lib/blobchunk.c
 create mode 100644 lib/hashmap.c
 create mode 100644 lib/sha256.c

-- 
2.24.4

