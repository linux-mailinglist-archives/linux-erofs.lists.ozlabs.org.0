Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9750E4283CB
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:32:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFWB13Xxz2yJT
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXfO/2qa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HXfO/2qa; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFW63TWmz2xtQ
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:32:02 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02C2360F22;
 Sun, 10 Oct 2021 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901519;
 bh=KtET40tdS/7iKcoQytl+RxYKLfngJFpO1eVfPnmXYe0=;
 h=From:To:Cc:Subject:Date:From;
 b=HXfO/2qa9j5yYBgMWS0jtVaonMKRBaVTN8EkNMHQtKkMSwLNB7A0Xl8YeniMIpLbV
 bxGzGSAF6F2BTjswraFY/uvSydX9qCx1LwAjBJcgvpCEk1ne1NVUht4YZJr+kwY9E6
 S2AP1iZVI0jd/+FCJ1mlGLt8lsOt1NcpIY4Y+4zN52JU3Wnr94quO4sjN8Rnrg66XB
 Rzil3YWIbr9gblk5Cp3A/GJ2xTIU0Lmrc9xHsjx0Pcq1OrRd0BJyOBgm1QSJkaBNID
 St11QbIT787sZ3anZQUaorFMw3+kBeTdiUgW5GH2KQAAk7iQpyHQKU+YUVH6DIeM+I
 BboF+PJ+BI4cQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] erofs: add LZMA compression support
Date: Mon, 11 Oct 2021 05:31:38 +0800
Message-Id: <20211010213145.17462-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

Here is the EROFS LZMA support which I've been working on and off for
more than half a year together with the XZ author Lasse Collin (many
thanks again!).

In order to better support the LZMA fixed-sized output compression,
especially for 4KiB pcluster size (which has lowest memory pressure
thus useful for memory-sensitive scenarios). Lasse introduced a new
LZMA header/container format called MicroLZMA [1] to minimize the
original LZMA1 header (for example, we don't need to waste 4-byte
dictionary size and another 8-byte uncompressed size, which can be
calculated by fs directly, for each pcluster.) and enable EROFS
fixed-sized output compression. Also note that MicroLZMA can be used
by other things in addition to EROFS too where wasting minimal amount
of space for headers is important, which can be compiled by enabling
XZ_DEC_MICROLZMA.

Similar to LZ4, EROFS LZMA decompression runtime also utilizes inplace
I/O and overlapped decompression to reuse the file page for compressed
data temporarily with proper strategies, which is useful to ensure
guaranteed performance under extremely memory pressure without extra
cost.

Due to the EROFS on-disk design, LZMA algorithm can be used in the
per-file basis independently and as a secondary compression algorithm
besides the primary algorithm given in one file as a complement for
specific access/data patterns.

The latest version can also be fetched from:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/lzma

The latest mkfs can be fetched from:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-lzma

[ The latest liblzma should be used in order to support MicroLZMA:
  https://git.tukaani.org/?p=xz.git ]

Finally, there are few in-kernel fses with LZMA support but as always
I might need to show some real numbers here anyway.. There are still
some ongoing EROFS runtime strategies to optimize such CPU bound
decompression algorithms even further. But let's do step by step:

Kernel: Linux 5.15.0-rc2
Testdata: enwik8 (100000000 bytes)
Compression level: LZMA_PRESET_DEFAULT (6)

Processor: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
SSD: INTEL SSDPEKKF360G7H (360 GB)
DDR: Samsung M471A1K43CB1-CRC (8 GB)
OS Distribution: Debian 10
Test environment:
Turbo Boost disabled
scaling_governor = userspace, scaling_{min,max}_freq = 1801000
 __________________________________________________
|  file system  |   size    | seq read | rand read |
|_______________|___________|_ MiB/s __|__ MiB/s __|
|___erofs_4k____|__41664512_|_ 59.92 __|__ 16.88 __|
|___erofs_8k____|__38555648_|_ 63.86 __|__ 22.18 __|
|___erofs_16k___|__36179968_|_ 63.14 __|__ 28.98 __|
|___erofs_32k___|__34299904_|_ 59.14 __|__ 35.38 __|
|___erofs_64k___|__32792576_|_ 57.56 __|__ 41.24 __|
|__squashfs_8k__|__43274240_|_ 21.48 __|__ 15.42 __|
|__squashfs_16k_|__39866368_|_ 25.10 __|__ 20.80 __|
|__squashfs_64k_|__35241984_|_ 31.02 __|__ 31.36 __|
|_squashfs_128k_|__33632256_|_ 36.62 __|__ 36.92 __|

Some numbers of silesia.tar:
 ___________________________
|  file system  |   size    |
|_______________|___________|
|__silesia.tar__|_211957760_|
|__squashfs_8k__|__75964416_|
|___erofs_4k____|__70987776_|
|__squashfs_16k_|__69337088_|
|___erofs_8k____|__65617920_|
|___erofs_16k___|__61333504_|
|__squashfs_64k_|__60669952_|
|___erofs_32k___|__58331136_|
|_squashfs_128k_|__58036224_|
|___erofs_64k___|__56123392_|

Revised EROFS roadmap:
https://lore.kernel.org/r/20211009061150.GA7479@hsiangkao-HP-ZHAN-66-Pro-G1


[1] where the first byte of a raw LZMA stream has been replaced with a
    bitwise-negation of the lc/lp/pb properties byte and it has no EOPM marker
    since the exact compressed size is known and provided explicitly.


Hi Andrew,

Some XZ embedded (lib/xz) patches by Lasse are sent out together in this series
although they're irrelevant to MicroLZMA but quite coupled. Can I send a pull
request together with EROFS LZMA support for 5.16 then? Many thanks in advance!

Thanks,
Gao Xiang


Gao Xiang (2):
  erofs: rename some generic methods in decompressor
  erofs: lzma compression support

Lasse Collin (5):
  lib/xz: Avoid overlapping memcpy() with invalid input with in-place
    decompression
  lib/xz: Validate the value before assigning it to an enum variable
  lib/xz: Move s->lzma.len = 0 initialization to lzma_reset()
  lib/xz: Add MicroLZMA decoder
  lib/xz, lib/decompress_unxz.c: Fix spelling in comments

 fs/erofs/Kconfig             |  16 ++
 fs/erofs/Makefile            |   1 +
 fs/erofs/compress.h          |  16 ++
 fs/erofs/decompressor.c      |  73 +++++----
 fs/erofs/decompressor_lzma.c | 290 +++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h          |  14 +-
 fs/erofs/internal.h          |  22 +++
 fs/erofs/super.c             |  17 +-
 fs/erofs/zdata.c             |   4 +-
 fs/erofs/zdata.h             |   7 -
 fs/erofs/zmap.c              |   5 +-
 include/linux/xz.h           | 106 +++++++++++++
 lib/decompress_unxz.c        |  10 +-
 lib/xz/Kconfig               |  13 ++
 lib/xz/xz_dec_lzma2.c        | 182 +++++++++++++++++++++-
 lib/xz/xz_dec_stream.c       |   6 +-
 lib/xz/xz_dec_syms.c         |   9 +-
 lib/xz/xz_private.h          |   3 +
 18 files changed, 725 insertions(+), 69 deletions(-)
 create mode 100644 fs/erofs/decompressor_lzma.c

-- 
2.20.1

