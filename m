Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E27DDBE5
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Nov 2023 05:36:15 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OkjP2u2Y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SKvMs6SkDz3bwJ
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Nov 2023 15:36:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OkjP2u2Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SKvMl4XZWz2yVd
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Nov 2023 15:36:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id A0010B81690;
	Wed,  1 Nov 2023 04:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E38EC433C7;
	Wed,  1 Nov 2023 04:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698813356;
	bh=vx0Vtdnjqks3VndXdG5T8xg4RLh5/XDEGWMNvAZ2jjk=;
	h=Date:From:To:Cc:Subject:From;
	b=OkjP2u2YTNSe0CcGUdxP+oWXWvQ5qDIpNM2mmtPSuJLjJDEm8Z3PyI2d6o5/iXB0D
	 WTOmAkgZETD0V8tV6yzDEbm4s9Dk6QF+LtemeaM1VjpW0e7mrWau/WT0Cp5jCia32l
	 FuqukziPY6Ve2BAHuD6GY3kpL8Tekg8KFjLhLDSzzrVt9/Yjcme13LEHtW+lzWDvzX
	 w2jFnEYChCBXVfsI50tlIlD0jzYJ1n94ljj0wFag9WiyIBxDOpKSDl7l/icy6qP/LY
	 11ewTZIiMiAuH2is3MyT+9it7uGsDZsE4bbL4eJcutwIArPDkwimxsFPRgtz4Wxck8
	 l5AdejQvkKZfg==
Date: Wed, 1 Nov 2023 12:35:44 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.7-rc1
Message-ID: <ZUHVoP/682uPjvfj@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Tiwei Bie <tiwei.btw@antgroup.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.7-rc1?

Nothing exciting lands for this cycle, since we're still busying in
developing support for sub-page blocks and large-folios of
compressed data for new scenarios on Android.

In this cycle, MicroLZMA format is marked as stable, and there are
minor cleanups around documentation and codebase.  In addition, it
also fixes incorrect lockref usage in erofs_insert_workgroup().

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1

for you to fetch changes up to 1a0ac8bd7a4fa5b2f4ef14c3b1e9d6e5a5faae06:

  erofs: fix erofs_insert_workgroup() lockref usage (2023-10-31 18:59:49 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix inode metadata space layout documentation;

 - Avoid warning MicroLZMA format anymore;

 - Fix erofs_insert_workgroup() lockref usage;

 - Some cleanups.

----------------------------------------------------------------
Ferry Meng (2):
      erofs: get rid of ROOT_NID()
      erofs: tidy up redundant includes

Gao Xiang (3):
      erofs: don't warn MicroLZMA format anymore
      erofs: simplify compression configuration parser
      erofs: fix erofs_insert_workgroup() lockref usage

Tiwei Bie (1):
      erofs: fix inode metadata space layout description in documentation

 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/Kconfig                    |  7 +---
 fs/erofs/compress.h                 |  6 +++
 fs/erofs/data.c                     |  2 -
 fs/erofs/decompressor.c             | 63 +++++++++++++++++++++++++++--
 fs/erofs/decompressor_deflate.c     |  6 +--
 fs/erofs/decompressor_lzma.c        |  7 +---
 fs/erofs/internal.h                 | 42 ++-----------------
 fs/erofs/super.c                    | 81 +++++--------------------------------
 fs/erofs/utils.c                    |  8 +---
 fs/erofs/zdata.c                    |  1 +
 11 files changed, 89 insertions(+), 136 deletions(-)
