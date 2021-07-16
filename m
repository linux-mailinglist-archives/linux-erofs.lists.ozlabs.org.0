Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D647E3CB1CC
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 07:08:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GQzlP5X5Zz3064
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 15:08:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GQzlH29fmz2yMm
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 15:07:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R521e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UfwgDyq_1626412048; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UfwgDyq_1626412048) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 16 Jul 2021 13:07:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] erofs: iomap support for tailpacking cases
Date: Fri, 16 Jul 2021 13:07:22 +0800
Message-Id: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

non-tailpacking I/O: https://lore.kernel.org/r/20210712120241.199903-1-hsiangkao@linux.alibaba.com

This patchset is a follow-up patchset of the previous patchset and
interacts with iomap itself, whcih mainly adds preliminary EROFS iomap
support for all tackpacking inline cases and has been preliminary
tested myself.

It only covers iomap read path. The write path remains untouched and
bail out with -EIO if inline data with pos != 0 since EROFS cannot be
used for actual testing. It'd be better to be implemented if upcoming
fs users care rather than leave untested dead code around in kernel.
 
Hopefully [PATCH 1/2] could be landed in iomap for-next independently
since it has few changes / iomap-specific and the rest patches can be
rebased upon iomap for-next then.

Comments are welcome. Thanks for your time on reading this!

Thanks,
Gao Xiang

Gao Xiang (2):
  iomap: support tail packing inline read
  erofs: convert all uncompressed cases to iomap

 fs/erofs/data.c        | 288 +++++++----------------------------------
 fs/iomap/buffered-io.c |  41 +++++-
 fs/iomap/direct-io.c   |   8 +-
 3 files changed, 90 insertions(+), 247 deletions(-)

-- 
2.24.4

