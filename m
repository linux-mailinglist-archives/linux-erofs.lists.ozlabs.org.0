Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2547BD17
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 10:44:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJBNy0gpWz3bTS
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 20:44:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJBNq5qh5z2xB8
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 20:43:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V.K7m0l_1640079804; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.K7m0l_1640079804) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 21 Dec 2021 17:43:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 0/2] erofs-utils: support tail-packing inline compressed
 data
Date: Tue, 21 Dec 2021 17:43:19 +0800
Message-Id: <20211221094321.108367-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

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
linux-5.10.87 (erofs, lz4hc,9 16k vanilla)	345649152

Thanks,
Gao Xiang

Yue Hu (2):
  erofs-utils: fuse: support tail-packing inline compressed data
  erofs-utils: mkfs: support tail-packing inline compressed data

 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   6 ++
 include/erofs_fs.h       |  10 +++-
 lib/compress.c           | 122 ++++++++++++++++++++++++++++++---------
 lib/compressor.c         |  14 +++--
 lib/compressor.h         |   2 +-
 lib/decompress.c         |   5 +-
 lib/inode.c              |  55 +++++++++++++-----
 lib/namei.c              |   2 +-
 lib/zmap.c               | 101 ++++++++++++++++++++++++--------
 mkfs/main.c              |   8 +++
 11 files changed, 249 insertions(+), 77 deletions(-)

-- 
2.24.4

