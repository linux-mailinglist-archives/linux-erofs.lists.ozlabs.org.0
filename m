Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB573FCFB9
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 01:00:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzjMT5Dslz2yHR
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 09:00:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sqk+nbqH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sqk+nbqH; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzjMQ1tWKz2xY7
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 09:00:18 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5FDD61008;
 Tue, 31 Aug 2021 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630450814;
 bh=Cx3MuIuVBVJhXs6mGbeECmG65uZjw5Ixf+O9JVrX9dI=;
 h=Date:From:To:Cc:Subject:From;
 b=sqk+nbqHS3gxA0/TSb7B1Jfp17xpdHcS1wO03uuNh3EQaFitNV6Aj1umrpYFE6aqm
 TCeGqT2PVacZTZkZ/Y0f3GpG02+jH1ZwjlapCY7dpBHvXMC9L6vUAuXNyL3+u4U6p4
 Tf7wU1m7KTTZikMxDYXWGLogEh46f+zpnhGRADgJnj2OR1P72tEPfSe6yB0L6ODjwz
 8FuvbU3+0M9iz3+zwBA3iTQbtISiJp+1lLQ+AHa5AtKy7PnWVU4utloL31f+Wok7gm
 X6XawyxMGvYtMzGGlZLfObE2wgOjK3kWgoBiCcs6TQfXpxNBFQ2CPdrikoi3PiQW8e
 zUKm1NLKAVKFA==
Date: Wed, 1 Sep 2021 06:59:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.15-rc1
Message-ID: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Huang Jianan <huangjianan@oppo.com>, Yue Hu <huyue2@yulong.com>,
 Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Peng Tao <tao.peng@linux.alibaba.com>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus.

Could you consider this pull request for 5.15-rc1?

In this cycle, direct I/O and fsdax support for uncompressed files
are now added in order to avoid double-caching for loop device and
VM container use cases. All uncompressed cases are now turned into
iomap infrastructure, which looks much simpler and cleaner.

Besides, fiemap support is added for both (un)compressed files by
using iomap infrastructure as well so end users can easily get file
distribution. We've also added chunk-based uncompressed files support
for data deduplication as the next step of VM container use cases.

All commits have been tested and have been in linux-next. Note that
in order to support iomap tail-packing inline, I had to merge iomap
core branch (I've created a merge commit with the reason) in advance
to resolve such functional dependency, which is now merged into
upstream. Hopefully I did the right thing...

Also, there is a merge conflict detected by Stephen with new fsdax
cleanups in the nvdimm tree, which can be resolved as below if needed:
https://lore.kernel.org/r/20210830170938.6fd8813d@canb.auug.org.au

Thanks,
Gao Xiang

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc1

for you to fetch changes up to 1266b4a7ecb679587dc4d098abe56ea53313d569:

  erofs: fix double free of 'copied' (2021-08-25 22:05:58 +0800)

----------------------------------------------------------------
Changes since last update:

 - support direct I/O for all uncompressed files;

 - support fsdax for non-tailpacking regular files;

 - use iomap infrastructure for all uncompressed cases;

 - support fiemap for both (un)compressed files;

 - introduce chunk-based files for chunk deduplication.

 - some cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Fix some typos and bad grammar

Christoph Hellwig (2):
      iomap: simplify iomap_readpage_actor
      iomap: simplify iomap_add_to_ioend

Gao Xiang (9):
      iomap: support reading inline data from non-zero pos
      erofs: dax support for non-tailpacking regular file
      Merge tag 'iomap-5.15-merge-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
      erofs: convert all uncompressed cases to iomap
      erofs: add support for the full decompressed length
      erofs: add fiemap support with iomap
      erofs: introduce chunk-based file on-disk format
      erofs: support reading chunk-based uncompressed files
      erofs: fix double free of 'copied'

Huang Jianan (1):
      erofs: iomap support for non-tailpacking DIO

Matthew Wilcox (Oracle) (3):
      iomap: Support inline data with block size < page size
      iomap: Use kmap_local_page instead of kmap_atomic
      iomap: Add another assertion to inline data handling

Yue Hu (2):
      erofs: directly use wrapper erofs_page_is_managed() when shrinking
      erofs: remove the mapping parameter from erofs_try_to_free_cached_page()

 Documentation/filesystems/erofs.rst |  19 +-
 fs/erofs/Kconfig                    |   1 +
 fs/erofs/data.c                     | 415 +++++++++++++++++++-----------------
 fs/erofs/erofs_fs.h                 |  47 +++-
 fs/erofs/inode.c                    |  29 ++-
 fs/erofs/internal.h                 |  22 +-
 fs/erofs/namei.c                    |   1 +
 fs/erofs/super.c                    |  61 +++++-
 fs/erofs/zdata.c                    |   6 +-
 fs/erofs/zmap.c                     | 133 +++++++++++-
 fs/iomap/buffered-io.c              | 169 +++++++--------
 fs/iomap/direct-io.c                |  10 +-
 include/linux/iomap.h               |  18 ++
 13 files changed, 627 insertions(+), 304 deletions(-)
