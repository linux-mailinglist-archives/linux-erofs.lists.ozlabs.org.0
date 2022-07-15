Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BF576492
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkwbT3bZbz3c7K
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbQ3qVPz3c5G
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC-h_1657899724;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC-h_1657899724)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 00/16] erofs: prepare for folios, deduplication and kill PG_error 
Date: Fri, 15 Jul 2022 23:41:47 +0800
Message-Id: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

I've been doing this for almost 2 months, the main point of this is
to support large folios and rolling hash deduplication for compressed
data.

This patchset is as a start of this work targeting for the next 5.20,
it introduces a flexable range representation for (de)compressed buffers
instead of too relying on page(s) directly themselves, so large folios
can laterly base on this work.  Also, this patchset gets rid of all
PG_error flags in the decompression code. It's a cleanup as a result
as well.

In addition, this patchset kicks off rolling hash deduplication for
compressed data by introducing fully-referenced multi-reference
pclusters first instead of reporting fs corruption if one pcluster
is introduced by several differnt extents.  The full implementation
is expected to be finished in the merge window after the next.  One
of my colleagues is actively working on the userspace part of this
feature.

However, it's still easy to verify fully-referenced multi-reference
pcluster by constructing some image by hand (see attachment):

Dataset: 300M
seq-read (data-deduplicated, read_ahead_kb 8192): 1095MiB/s
seq-read (data-deduplicated, read_ahead_kb 4096): 771MiB/s
seq-read (data-deduplicated, read_ahead_kb 512):  577MiB/s
seq-read (vanilla, read_ahead_kb 8192):           364MiB/s

Finally, this patchset survives ro-fsstress on my side.

Thanks,
Gao Xiang

Changes since v1:
 - rename left pagevec words to bvpage (Yue Hu);

Gao Xiang (16):
  erofs: get rid of unneeded `inode', `map' and `sb'
  erofs: clean up z_erofs_collector_begin()
  erofs: introduce `z_erofs_parse_out_bvecs()'
  erofs: introduce bufvec to store decompressed buffers
  erofs: drop the old pagevec approach
  erofs: introduce `z_erofs_parse_in_bvecs'
  erofs: switch compressed_pages[] to bufvec
  erofs: rework online page handling
  erofs: get rid of `enum z_erofs_page_type'
  erofs: clean up `enum z_erofs_collectmode'
  erofs: get rid of `z_pagemap_global'
  erofs: introduce struct z_erofs_decompress_backend
  erofs: try to leave (de)compressed_pages on stack if possible
  erofs: introduce z_erofs_do_decompressed_bvec()
  erofs: record the longest decompressed size in this round
  erofs: introduce multi-reference pclusters (fully-referenced)

 fs/erofs/compress.h     |   2 +-
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/zdata.c        | 785 +++++++++++++++++++++++-----------------
 fs/erofs/zdata.h        | 119 +++---
 fs/erofs/zpvec.h        | 159 --------
 5 files changed, 496 insertions(+), 571 deletions(-)
 delete mode 100644 fs/erofs/zpvec.h

-- 
2.24.4

