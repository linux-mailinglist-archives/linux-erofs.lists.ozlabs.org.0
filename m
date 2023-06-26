Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73973D6E7
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jun 2023 06:39:32 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XYevjjKM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QqFVk3qX6z30f4
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jun 2023 14:39:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XYevjjKM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QqFVY6Vl6z2ys3
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jun 2023 14:39:17 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CB7B960C68;
	Mon, 26 Jun 2023 04:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082ACC433C8;
	Mon, 26 Jun 2023 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687754354;
	bh=Of4ysmu672KpbjZBfuoU0uRNcf9i4Uh3dPRn8YJ9Owc=;
	h=Date:From:To:Cc:Subject:From;
	b=XYevjjKMvRGIB4unL1n2cFePA+8Zjt2hmeFm42ccVi7bjbITuTRWsElC+DaqXhIxT
	 FqVlh63eJzP9SGqNMMVJLhRPC3K9Nv+Y8l7pWxIEr4V6edsnvVuMz6ngBFWrE2ZIqe
	 j3sprhNbitNQ5QvE63FHBaDeGdaRqWAOjUjcyDcQfLkDYk6+u9LvSj+M6XLXeMgBqN
	 Wv9XdmUmGvcTfsSisXWiGgowukEtb/ptHrQG15kkL863gRsHgJHzoqHfjtqqsn1Ew9
	 f2I46GDp+iBdtXti8akswksS46vpVBObgBg2eGyaR4tJT4flagETR3Z6S/I2cyk8TG
	 gW8Sri3ODz0pA==
Date: Mon, 26 Jun 2023 12:39:07 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.5-rc1
Message-ID: <ZJkWa+t/WBCXs9XT@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Yue Hu <huyue2@coolpad.com>,
	Yangtao Li <frank.li@vivo.com>, Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
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
Cc: Yangtao Li <frank.li@vivo.com>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.5-rc1?

No outstanding new feature available for this cycle.  Most of these
commits are decompression cleanups which are part of the ongoing
development for subpage/folio compression support as well as xattr
cleanups for the upcoming xattr bloom filter optimization [1].

In addition, there are bugfixes to address some corner cases of
compressed images due to global data de-duplication and arm64 16k
pages.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20230621083209.116024-1-jefflexu@linux.alibaba.com

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1

for you to fetch changes up to 8241fdd3cdfe88e31a3de09a72b5bff661e4534a:

  erofs: clean up zmap.c (2023-06-22 21:16:34 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix rare I/O hang on deduplicated compressed images due to loop
   hooked chains;

 - Fix compact compression layout of 16k blocks on arm64 devices;

 - Fix atomic context detection of async decompression;

 - Decompression/Xattr code cleanups.

----------------------------------------------------------------
Gao Xiang (8):
      erofs: allocate extra bvec pages directly instead of retrying
      erofs: avoid on-stack pagepool directly passed by arguments
      erofs: kill hooked chains to avoid loops on deduplicated compressed images
      erofs: adapt managed inode operations into folios
      erofs: use struct lockref to replace handcrafted approach
      erofs: use poison pointer to replace the hard-coded address
      erofs: fix compact 4B support for 16k block size
      erofs: clean up zmap.c

Jingbo Xu (6):
      erofs: convert erofs_read_metabuf() to erofs_bread() for xattr
      erofs: use absolute position in xattr iterator
      erofs: unify xattr_iter structures
      erofs: make the size of read data stored in buffer_ofs
      erofs: unify inline/shared xattr iterators for listxattr/getxattr
      erofs: use separate xattr parsers for listxattr/getxattr

Sandeep Dhavale (1):
      erofs: Fix detection of atomic context

Yangtao Li (1):
      erofs: remove unnecessary goto

Yue Hu (3):
      erofs: fold in z_erofs_decompress()
      erofs: remove the member readahead from struct z_erofs_decompress_frontend
      erofs: clean up z_erofs_pcluster_readmore()

 fs/erofs/compress.h     |   3 +-
 fs/erofs/decompressor.c |   8 +-
 fs/erofs/internal.h     |  41 +--
 fs/erofs/super.c        |  69 +----
 fs/erofs/utils.c        |  86 +++----
 fs/erofs/xattr.c        | 670 +++++++++++++++++-------------------------------
 fs/erofs/zdata.c        | 269 +++++++++----------
 fs/erofs/zmap.c         |  75 +++---
 8 files changed, 438 insertions(+), 783 deletions(-)
