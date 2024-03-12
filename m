Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB5878E2C
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 06:30:23 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g50xcMcl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tv2KT2Qp2z3d32
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 16:30:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g50xcMcl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tv2KM3D48z3cGL
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Mar 2024 16:30:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EA70361088;
	Tue, 12 Mar 2024 05:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CCC433C7;
	Tue, 12 Mar 2024 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710221412;
	bh=+5tJ6mr9tb2opb0sZ3KJ72ZbRYxwxwwtGK/uof+Odac=;
	h=Date:From:To:Cc:Subject:From;
	b=g50xcMclHzBKkWk78XJ7i0kFHtqEM5x9dPd21nc+3/TGTWvaKkzJm/ocmaJmZ7hJU
	 Ghm2uvn4jVlBkC6ldqSJKOA3KD7BJBwNLi/gSiyYfa2f+Q6l4GpJmNPnsrt4igyCxt
	 mAd/DSMjub+0gran8cVEX3CQPh0yE+cUBcpGPOrIKQqfpuWUAVKbM0TqtrVbua6B9I
	 KR+FNxD5qXxDf6JUX/rJdBfmnOvQ/yQofQ7IrOlcCjzjSokbVLrwKhoDD6LaQEt/DH
	 oAwkdD3D/Zm7fxZWGZjelACW9xtvNj24K4gJjnYKvjFNd365YMqC2b1PKsS4h2szU/
	 OXMkXAJDZg0hQ==
Date: Tue, 12 Mar 2024 13:30:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs updates for 6.9-rc1
Message-ID: <Ze/oXlaiQfdspyNX@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>, Chao Yu <chao@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.9-rc1?

In this cycle, we'd like to introduce compressed inode support over
fscache since a lot of native EROFS images are explicitly compressed
so that EROFS over fscache can be more widely used even without
Dragonfly Nydus [1].

Apart from that, there are some folio conversions for compressed
inodes available as well as a lockdep false positive fix.

All commits have been in -next and no potential merge conflict is
observed.

[1] https://nydus.dev

Thanks,
Gao Xiang

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1

for you to fetch changes up to a1bafc3109d713ed83f73d61ba5cb1e6fd80fdbc:

  erofs: support compressed inodes over fscache (2024-03-10 18:41:32 +0800)

----------------------------------------------------------------
Changes since last update:

 - Some folio conversions for compressed inodes;

 - Add compressed inode support over fscache;

 - Fix lockdep false positives of erofs_pseudo_mnt.

----------------------------------------------------------------
Baokun Li (1):
      erofs: fix lockdep false positives on initializing erofs_pseudo_mnt

Gao Xiang (6):
      erofs: convert z_erofs_onlinepage_.* to folios
      erofs: convert z_erofs_do_read_page() to folios
      erofs: get rid of `justfound` debugging tag
      erofs: convert z_erofs_fill_bio_vec() to folios
      erofs: convert z_erofs_submissionqueue_endio() to folios
      erofs: refine managed cache operations to folios

Jingbo Xu (2):
      erofs: make iov_iter describe target buffers over fscache
      erofs: support compressed inodes over fscache

 fs/erofs/compress.h             |   7 -
 fs/erofs/decompressor_deflate.c |   3 -
 fs/erofs/decompressor_lzma.c    |   3 -
 fs/erofs/fscache.c              | 297 +++++++++++++++++++++++++---------------
 fs/erofs/inode.c                |  14 +-
 fs/erofs/internal.h             |   9 +-
 fs/erofs/super.c                |  30 +---
 fs/erofs/utils.c                |   2 +-
 fs/erofs/zdata.c                | 287 ++++++++++++++++++--------------------
 9 files changed, 335 insertions(+), 317 deletions(-)
