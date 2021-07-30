Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D643DBF2E
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jul 2021 21:46:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gbyb52vFZz3bnC
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Jul 2021 05:46:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GbyZz6Q8Rz30KN
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Jul 2021 05:46:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0UhT8q23_1627674386; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UhT8q23_1627674386) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 31 Jul 2021 03:46:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/3] erofs: iomap support for uncompressed cases
Date: Sat, 31 Jul 2021 03:46:22 +0800
Message-Id: <20210730194625.93856-1-hsiangkao@linux.alibaba.com>
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
Cc: nvdimm@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Tao Ma <boyu.mt@taobao.com>,
 linux-fsdevel@vger.kernel.org, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This patchset mainly adds EROFS iomap support for uncompressed cases
I've planed for the next merge window.

The first 2 patches mainly deal with 2 new cases:
1) Direct I/O is useful in certain scenarios for uncompressed files.
For example, double pagecache can be avoid by direct I/O when loop
device is used for uncompressed files containing upper layer
compressed filesystem.

2) DAX is quite useful for some container use cases in order to save
guest memory extremely by using the minimal lightweight EROFS image.
BTW, a bit more off this iomap topic, chunk-deduplicated regfile
support is almost available (blob data support) for multi-layer
container image use cases (aka. called RAFS v6, nydus [1] will support
RAFS v6 (EROFS-compatible format) in the future and form a unified
high-performance container image solution, which will be announced
formally independently), which is also a small independent update.

The last patch relies on the previous iomap core update in order to
convert tail-packing inline files into iomap, thus all uncompressed
cases are handled with iomap properly.

Comments are welcome. Thanks for your time on reading this!

Thanks,
Gao Xiang

[1] https://github.com/dragonflyoss/image-service

changes since v1:
 - mainly resend with commit message & comments update.

Gao Xiang (2):
  erofs: dax support for non-tailpacking regular file
  erofs: convert all uncompressed cases to iomap

Huang Jianan (1):
  erofs: iomap support for non-tailpacking DIO

 fs/erofs/Kconfig    |   1 +
 fs/erofs/data.c     | 342 +++++++++++++++++++-------------------------
 fs/erofs/inode.c    |   9 +-
 fs/erofs/internal.h |   4 +
 fs/erofs/super.c    |  60 +++++++-
 5 files changed, 217 insertions(+), 199 deletions(-)

-- 
2.24.4

