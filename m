Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A3758F14
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 09:33:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5SH63dtHz3c7S
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 17:33:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5SGt5Jqpz30MQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 17:33:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnkthRO_1689751999;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnkthRO_1689751999)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 15:33:20 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/2] erofs-utils: remove global sbi in library
Date: Wed, 19 Jul 2023 15:33:17 +0800
Message-Id: <20230719073319.27996-1-jefflexu@linux.alibaba.com>
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


changes since v1:
- patch 1: rename iloc() to erofs_iloc() (Gao Xiang)

v1: https://lore.kernel.org/all/20230718052101.124039-1-jefflexu@linux.alibaba.com/


Later mkfs is going to be capable of converting multiple erofs images
into one merged erofs image, in which case there are multiple device
context and sbi instances.

In preparation for that, remove global device context and sbi in all
libraries except buffer block library, as there's still only one output
erofs image.

The device context is inlined into sbi.  Each erofs_inode keeps a
reference to corresponding sbi through vi->sbi.  Global sbi is remained
but only used by utils directly, e.g. mkfs/dump/fsck.


Jingbo Xu (2):
  erofs-utils: simplify iloc()
  erofs-utils: remove global sbi in library

 dump/main.c                    |  30 +++---
 fsck/main.c                    |  41 ++++----
 fuse/main.c                    |  24 ++---
 include/erofs/blobchunk.h      |   4 +-
 include/erofs/cache.h          |   6 +-
 include/erofs/compress.h       |   8 +-
 include/erofs/compress_hints.h |   2 +-
 include/erofs/decompress.h     |   1 +
 include/erofs/dir.h            |   3 +-
 include/erofs/internal.h       |  59 ++++++------
 include/erofs/io.h             |  38 ++++----
 include/erofs/tar.h            |   4 +-
 include/erofs/xattr.h          |  16 ++--
 lib/blobchunk.c                |  45 ++++-----
 lib/cache.c                    |  42 ++++-----
 lib/compress.c                 | 165 ++++++++++++++++++---------------
 lib/compress_hints.c           |  10 +-
 lib/compressor.c               |  15 +--
 lib/compressor.h               |   4 +-
 lib/compressor_lz4.c           |   2 +-
 lib/compressor_lz4hc.c         |   2 +-
 lib/data.c                     |  69 +++++++-------
 lib/decompress.c               |  29 +++---
 lib/dir.c                      |  21 +++--
 lib/fragments.c                |   2 +-
 lib/inode.c                    | 118 ++++++++++++-----------
 lib/io.c                       | 119 +++++++++++-------------
 lib/namei.c                    |  36 ++++---
 lib/super.c                    |  51 +++++-----
 lib/tar.c                      |  36 +++----
 lib/xattr.c                    |  75 ++++++++-------
 lib/zmap.c                     |  43 +++++----
 mkfs/main.c                    |  62 ++++++-------
 33 files changed, 627 insertions(+), 555 deletions(-)

-- 
2.19.1.6.gb485710b

