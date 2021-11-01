Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B21754411B7
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 01:40:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjDjM3KhDz2yPL
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 11:40:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YnZYb/Tc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YnZYb/Tc; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjDjH4lgBz2yKN
 for <linux-erofs@lists.ozlabs.org>; Mon,  1 Nov 2021 11:40:51 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3B760E90;
 Mon,  1 Nov 2021 00:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635727248;
 bh=2uUhdauGw92C8QxzP01fb14EoJ7ezdWDgs1/7QdKx6s=;
 h=Date:From:To:Cc:Subject:From;
 b=YnZYb/Tcg35l7Os151X8BDLQDvWmCdP4YJNNfTWbm99w4W/ck5sK2v3YMw8ZXSKaY
 OMs8LvYESjw5cIyGQvuPKPsDjxpQzBXrNCDdqD9vyezvqp7flnpjMZWlkEvbuL8kPp
 4+/EHPM1empXX1m4BoWEa2gb+2TlPR5n2CTOgAu1qvacMC5K2Iv2+oBTkJdgJ/lTZA
 btzuagRKLVGm9eH63kuZbLFUCxYDyglMmJ7bQnwWGhmx2btLeD5I3GFSi35aco0xHr
 EcuUvD9Ogr6KkyEM/LlFMQ3K0ttV3J9AGGbN5JrS8ed6WALQnaFIJWzlyCdUOHyVN0
 KBh/j4+oTQtGA==
Date: Mon, 1 Nov 2021 08:40:32 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.16-rc1
Message-ID: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Lasse Collin <lasse.collin@tukaani.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
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
Cc: Lasse Collin <lasse.collin@tukaani.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.16-rc1?

There are some new features available for this cycle. Firstly, EROFS
LZMA algorithm support, specifically called MicroLZMA, is available
as an option for embedded devices, LiveCDs and/or as the secondary
auxiliary compression algorithm besides the primary algorithm in one
file.

In order to better support the LZMA fixed-sized output compression,
especially for 4KiB pcluster size (which has lowest memory pressure
thus useful for memory-sensitive scenarios), Lasse introduced a new
LZMA header/container format called MicroLZMA to minimize the original
LZMA1 header (for example, we don't need to waste 4-byte dictionary
size and another 8-byte uncompressed size, which can be calculated by
fs directly, for each pcluster.) and enable EROFS fixed-sized output
compression. Note that MicroLZMA can also be later used by other
things in addition to EROFS too where wasting minimal amount of space
for headers is important and it can be only compiled by enabling
XZ_DEC_MICROLZMA. MicroLZMA has been supported by the latest upstream
XZ embedded [1] & XZ utils [2], apply the latest related XZ embedded
upstream patches by the XZ author Lasse here.

Secondly, multiple device is also supported in this cycle, which is
designed for multi-layer container images. By working together with
inter-layer data deduplication and compression, we can achieve the
next high-performance container image solution. Our team will announce
the new Nydus container image service [3] implementation with new RAFS
v6 (EROFS-compatible) format in Open Source Summit 2021 China [4] soon.

Besides, the secondary compression head support and readmore
decompression strategy are also included in this cycle. There are also
some minor bugfixes and cleanups, as always.

All commits have been tested and have been in linux-next. This merges
cleanly with master.

[1] https://git.tukaani.org/?p=xz-embedded.git
[2] https://git.tukaani.org/?p=xz.git
[3] https://github.com/dragonflyoss/image-service
[4] https://kccncosschn21.sched.com/event/pcdL/erofsdaelsju-nanojdyags-erofs-what-are-we-doing-now-for-containers-xiang-gao-alibaba

Thanks,
Gao Xiang

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1

for you to fetch changes up to a0961f351d82d43ab0b845304caa235dfe249ae9:

  erofs: don't trigger WARN() when decompression fails (2021-10-31 21:00:28 +0800)

----------------------------------------------------------------
Changes since last update:

 - support multiple devices for multi-layer container images;

 - support the secondary compression head;

 - support readmore decompression strategy;

 - support new LZMA algorithm (specifically called MicroLZMA);

 - some bugfixes & cleanups.

----------------------------------------------------------------
Gao Xiang (9):
      erofs: decouple basic mount options from fs_context
      erofs: add multiple device support
      erofs: get compression algorithms directly on mapping
      erofs: introduce the secondary compression head
      erofs: introduce readmore decompression strategy
      erofs: rename some generic methods in decompressor
      erofs: lzma compression support
      erofs: get rid of ->lru usage
      erofs: don't trigger WARN() when decompression fails

Lasse Collin (5):
      lib/xz: Avoid overlapping memcpy() with invalid input with in-place decompression
      lib/xz: Validate the value before assigning it to an enum variable
      lib/xz: Move s->lzma.len = 0 initialization to lzma_reset()
      lib/xz: Add MicroLZMA decoder
      lib/xz, lib/decompress_unxz.c: Fix spelling in comments

Yue Hu (1):
      erofs: remove the fast path of per-CPU buffer decompression

 Documentation/filesystems/erofs.rst |  12 +-
 fs/erofs/Kconfig                    |  40 +++--
 fs/erofs/Makefile                   |   1 +
 fs/erofs/compress.h                 |  28 ++--
 fs/erofs/data.c                     |  73 +++++++--
 fs/erofs/decompressor.c             | 139 ++++++-----------
 fs/erofs/decompressor_lzma.c        | 290 ++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h                 |  73 ++++++---
 fs/erofs/inode.c                    |   2 +-
 fs/erofs/internal.h                 | 105 +++++++++++--
 fs/erofs/pcpubuf.c                  |   6 +-
 fs/erofs/super.c                    | 231 ++++++++++++++++++++++------
 fs/erofs/utils.c                    |  19 ++-
 fs/erofs/xattr.c                    |   4 +-
 fs/erofs/zdata.c                    | 175 +++++++++++++++-------
 fs/erofs/zdata.h                    |   7 -
 fs/erofs/zmap.c                     |  65 +++++---
 include/linux/xz.h                  | 106 +++++++++++++
 include/trace/events/erofs.h        |   2 +-
 lib/decompress_unxz.c               |  10 +-
 lib/xz/Kconfig                      |  13 ++
 lib/xz/xz_dec_lzma2.c               | 182 +++++++++++++++++++++-
 lib/xz/xz_dec_stream.c              |   6 +-
 lib/xz/xz_dec_syms.c                |   9 +-
 lib/xz/xz_private.h                 |   3 +
 25 files changed, 1281 insertions(+), 320 deletions(-)
 create mode 100644 fs/erofs/decompressor_lzma.c
