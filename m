Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 3723A8CE6A4
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 16:06:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OEKf2oNO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vm68301zsz87nb
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 23:58:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OEKf2oNO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vm67w0kydz87my
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 23:58:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AAE1BCE1912;
	Fri, 24 May 2024 13:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC16C32782;
	Fri, 24 May 2024 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716559095;
	bh=uFDcDFnvfL5qT+v6BH7T1D5GHPvkVzjP6kkXiYmqx0s=;
	h=Date:From:To:Cc:Subject:From;
	b=OEKf2oNOw4ClzvvnGF1nGv5jdj9y66xt5tu/XIadvaU0Sz4VUwSqJLd137R0qiAqF
	 36kxyU2n/ACR1am+UfAzK2Gz+nDaXWDO4o9L/5hVf+NP2m5m0Q1YASL3SU6zy8i/wI
	 LNDSbTsQBUYWVeDxpVG6FtjfTxnQ/umAC98hfaAr9Acp8CoTFPmPTGRWAV99zyvJZb
	 ZaT4XiMEg9fbpZoQJyCvSA/4rryP7N1c8/K0vH9QyOvM8j81ZtaLEP+RZRfipdwPjq
	 4OwDirAwfafcQ3ub1Vd9QLG3lAdD4eTZoW06sf6hzwtUvejz5jjuHBZ1bTQZJ4aAJR
	 L0kC6itmoFePQ==
Date: Fri, 24 May 2024 21:57:46 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs more updates for 6.10-rc1
Message-ID: <ZlCc2s0h0H1v16er@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these extra patches for 6.10-rc1?

The main ones are metadata API conversion to byte offsets by
Al Viro.  Since some of patches are also part of VFS
"->bd_inode elimination" (and they were merged upstream days ago),
I did a merge commit to resolve the dependency with the detailed
description.

Another patch gets rid of unnecessary memory allocation out of
DEFLATE decompressor.  The remaining one is a trivial cleanup.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 7c35de4df1056a5a1fb4de042197b8f5b1033b61:

  erofs: Zstandard compression support (2024-05-09 07:46:56 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2

for you to fetch changes up to 80eb4f62056d6ae709bdd0636ab96ce660f494b2:

  erofs: avoid allocating DEFLATE streams before mounting (2024-05-21 03:07:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert metadata APIs to byte offsets;

 - Avoid allocating DEFLATE streams unnecessarily;

 - Some erofs_show_options() cleanup.

----------------------------------------------------------------
Al Viro (6):
      erofs: switch erofs_bread() to passing offset instead of block number
      erofs_buf: store address_space instead of inode
      erofs: mechanically convert erofs_read_metabuf() to offsets
      erofs: don't align offset for erofs_read_metabuf() (simple cases)
      erofs: don't round offset down for erofs_read_metabuf()
      z_erofs_pcluster_begin(): don't bother with rounding position down

Gao Xiang (2):
      Merge branch 'misc.erofs' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
      erofs: avoid allocating DEFLATE streams before mounting

Hongzhen Luo (1):
      erofs: clean up erofs_show_options()

 fs/erofs/data.c                 | 25 +++++++++----------
 fs/erofs/decompressor_deflate.c | 55 ++++++++++++++++++++++-------------------
 fs/erofs/dir.c                  |  4 +--
 fs/erofs/fscache.c              | 12 +++------
 fs/erofs/inode.c                |  4 +--
 fs/erofs/internal.h             |  9 +++----
 fs/erofs/namei.c                |  6 ++---
 fs/erofs/super.c                | 44 +++++++++++----------------------
 fs/erofs/xattr.c                | 37 +++++++++++----------------
 fs/erofs/zdata.c                |  8 +++---
 fs/erofs/zmap.c                 | 24 +++++++++---------
 11 files changed, 97 insertions(+), 131 deletions(-)
