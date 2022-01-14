Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 146CA48E978
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jan 2022 12:51:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jb04z6y9qz30LP
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jan 2022 22:51:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jb04w1gcWz2xsY
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jan 2022 22:51:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V1otL6J_1642161054; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V1otL6J_1642161054) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 14 Jan 2022 19:50:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v9 0/2] erofs-utils: support tail-packing inline compressed
 data
Date: Fri, 14 Jan 2022 19:50:51 +0800
Message-Id: <20220114115053.28824-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v8: https://lore.kernel.org/r/20211224012316.42929-1-hsiangkao@linux.alibaba.com

This is a follow-up of previous v6 Yue Hu's patchset. It implements
tail-packing inline for compressed files. In particular, called
tail pcluster inline.

Here is some evaluation of Linux 5.10.87 source code (75368 inodes):
linux-5.10.87 (erofs, uncompressed)		972570624

linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384
linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936
linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152

linux-5.10.87 (erofs, lz4hc,9 4k vanilla)	416079872
linux-5.10.87 (erofs, lz4hc,9 8k vanilla)	395493376
linux-5.10.87 (erofs, lz4hc,9 16k vanilla)	383213568

Usage:
mkfs.erofs -zlz4hc -Eztailpacking foo.erofs.img foo/

Thanks,
Gao Xiang

changes since v8:
 - [1/2] sync up with the latest in-kernel version;
 - [2/2] fix an assertion failure in debugging mode.

Yue Hu (2):
  erofs-utils: fuse: support tail-packing inline compressed data
  erofs-utils: mkfs: support tail-packing inline compressed data

 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   6 ++
 include/erofs_fs.h       |  10 +++-
 lib/compress.c           | 122 ++++++++++++++++++++++++++++++---------
 lib/compressor.c         |  16 +++--
 lib/compressor.h         |   2 +-
 lib/decompress.c         |   5 +-
 lib/inode.c              |  57 +++++++++++++-----
 lib/namei.c              |   2 +-
 lib/zmap.c               |  99 +++++++++++++++++++++++--------
 mkfs/main.c              |   8 +++
 11 files changed, 251 insertions(+), 77 deletions(-)

-- 
2.24.4

