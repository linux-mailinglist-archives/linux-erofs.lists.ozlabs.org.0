Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7B480693
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 06:46:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNNnm3SYBz302G
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 16:46:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNNng0Xwfz2yZd
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 16:46:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0240kf_1640670365; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0240kf_1640670365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 13:46:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 0/5] erofs: support tail-packing inline compressed data
Date: Tue, 28 Dec 2021 13:45:59 +0800
Message-Id: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

v2: https://lore.kernel.org/r/20211225070626.74080-1-hsiangkao@linux.alibaba.com
mkfs v8: https://lore.kernel.org/r/20211224012316.42929-1-hsiangkao@linux.alibaba.com

This is the 4th version of tail-packing inline compressed data feature.
It tries to inline the tail pcluster right after the inode metadata to
save data I/O and storage space.

Take Linux 5.10.87 source code as an example:
linux-5.10.87 (erofs, uncompressed)		972570624

linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384
linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936
linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152

linux-5.10.87 (erofs, lz4hc,9 4k vanilla)	416079872
linux-5.10.87 (erofs, lz4hc,9 8k vanilla)	395493376
linux-5.10.87 (erofs, lz4hc,9 16k vanilla)	383213568

Thanks,
Gao Xiang

changes since v3:
 - add comments about z_erofs_lz4_decompress_ctx (Chao);
 - move cache_strategy together with preload_compressed_pages (Yue);
 - remove duplicated code about z_idata_size (Yue);
 - rename z_idata_headlcn to z_tailextent_headlcn since
   EROFS_GET_BLOCKS_FINDTAIL is a generic flag which is not
   only used for tail pcluster (Yue).

Gao Xiang (3):
  erofs: tidy up z_erofs_lz4_decompress
  erofs: introduce z_erofs_fixup_insize
  erofs: support unaligned data decompression

Yue Hu (2):
  erofs: support inline data decompression
  erofs: add on-disk compressed tail-packing inline support

 fs/erofs/compress.h          |   4 +-
 fs/erofs/decompressor.c      | 132 +++++++++++++++++++--------------
 fs/erofs/decompressor_lzma.c |  19 ++---
 fs/erofs/erofs_fs.h          |  10 ++-
 fs/erofs/internal.h          |   6 ++
 fs/erofs/super.c             |   3 +
 fs/erofs/sysfs.c             |   2 +
 fs/erofs/zdata.c             | 139 +++++++++++++++++++++++------------
 fs/erofs/zdata.h             |  24 +++++-
 fs/erofs/zmap.c              | 113 ++++++++++++++++++++--------
 10 files changed, 306 insertions(+), 146 deletions(-)

-- 
2.24.4

