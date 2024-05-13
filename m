Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0B8C3B25
	for <lists+linux-erofs@lfdr.de>; Mon, 13 May 2024 08:08:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iNrlbj/5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vd8FL31L3z3blb
	for <lists+linux-erofs@lfdr.de>; Mon, 13 May 2024 16:08:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iNrlbj/5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vd8FD60CCz30Wc
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 May 2024 16:08:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CB2E760C23;
	Mon, 13 May 2024 06:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2A9C113CC;
	Mon, 13 May 2024 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715580525;
	bh=CEN/6ECcGbhwsoH3ZfDaw9JNq/DjakjQX74isPF0xJg=;
	h=Date:From:To:Cc:Subject:From;
	b=iNrlbj/5wnalJExrDBpuEoPN/Tx3Otd2wPPyk/4NyA7nw/OMt4iQMf/ZRpOly+tJV
	 gEoX1aA6VYDKrOzYPn78jk1M5B09FxS9n3F80tdqSvP3o75QuraWF2bdBtSVKUJHyQ
	 /+eIQQi9sa5iTHFK4YiVRNXaZX63lfjP7Pn3JHFaBOhUpa+9LCnSbeXrE6423XZXly
	 YzfShQQRw4ZagQseT9DUaz0duWDI6NcA0X0cO8o0RDarBPthC1+fwTkxWRzd1vFrV+
	 J1HnnjKaMwVfzZ2BBAi89tYmw0HZBzBAypcwqzrqsW9d5eVOZqOjqANIeBhVyVgDlm
	 CfPDtV9tn4tOw==
Date: Mon, 13 May 2024 14:08:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.10-rc1
Message-ID: <ZkGuZ319TzAiLS+Z@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: LKML <linux-kernel@vger.kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.10-rc1?

In this cycle, LZ4 global buffer count is now configurable instead
of the previous per-CPU buffers, which is useful for bare metals with
hundreds of CPUs.  A reserved buffer pool for LZ4 decompression can
also be enabled to minimize the tail allocation latencies under the
low memory scenarios with heavy memory pressure.

In addition, Zstandard algorithm is now supported as an alternative
since it has been requested by users for a while.

There are some random cleanups as usual.  All commits have been in
-next and no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1

for you to fetch changes up to 7c35de4df1056a5a1fb4de042197b8f5b1033b61:

  erofs: Zstandard compression support (2024-05-09 07:46:56 +0800)

----------------------------------------------------------------
Changes since last update:

 - Make LZ4 global buffers configurable instead of per-CPU buffers;

 - Add a reserved buffer pool for LZ4 decompression for lower latencies;

 - Support Zstandard compression algorithm as an alternative;

 - Derive fsid from on-disk UUID for .statfs() if possible;

 - Minor cleanups.

----------------------------------------------------------------
Chunhai Guo (4):
      erofs: rename utils.c to zutil.c
      erofs: rename per-CPU buffers to global buffer pool and make it configurable
      erofs: do not use pagepool in z_erofs_gbuf_growsize()
      erofs: add a reserved buffer pool for lz4 decompression

Gao Xiang (2):
      erofs: clean up z_erofs_load_full_lcluster()
      erofs: Zstandard compression support

Hongzhen Luo (1):
      erofs: derive fsid from on-disk UUID for .statfs() if possible

 fs/erofs/Kconfig              |  15 +++
 fs/erofs/Makefile             |   5 +-
 fs/erofs/compress.h           |   4 +
 fs/erofs/decompressor.c       |  15 ++-
 fs/erofs/decompressor_zstd.c  | 279 ++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h           |  15 ++-
 fs/erofs/internal.h           |  28 +++--
 fs/erofs/pcpubuf.c            | 148 ----------------------
 fs/erofs/super.c              |  28 +++--
 fs/erofs/zmap.c               |  24 ++--
 fs/erofs/{utils.c => zutil.c} | 206 ++++++++++++++++++++++++++++---
 11 files changed, 555 insertions(+), 212 deletions(-)
 create mode 100644 fs/erofs/decompressor_zstd.c
 delete mode 100644 fs/erofs/pcpubuf.c
 rename fs/erofs/{utils.c => zutil.c} (58%)
