Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1F76B4D51
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 17:40:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PYBcf4tdRz3cfg
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Mar 2023 03:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V+8fpkbi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V+8fpkbi;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PYBcV64qSz3cDM
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Mar 2023 03:40:26 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 99E51B82345;
	Fri, 10 Mar 2023 16:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F5C433A4;
	Fri, 10 Mar 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678466421;
	bh=lF4WQCD0iAfVt+U1sHPjQ+RcRXvl9M8ViINfhAY6SF8=;
	h=Date:From:To:Cc:Subject:From;
	b=V+8fpkbisZNTc39jlqnOxlbNiBvxEmUYsdJ6F+oOUw5nJLfqqE5Wii6BgLDDlRhSi
	 1PclQm+31z6r8bt8mmvNFxEvnpnXOmXSJ7BnP+RE47Duofyqx2ZJFc0CsZ5dmgb4aY
	 joyrhG63M+GrXerqaZ0BH1+A8aHZn6/HJhPBkGpsAjq4qrrLOnvJZmuVFQ1GHmUk0H
	 In9SlABlwBMhAHMuIcVdU8S/fZQUqNwSjToOLJXwD5/gFxtUzBBeMpDTwQfXtIqL1t
	 1aTaG60cy0CcRSXVGGVEb6XXbAZpqAInHN7GswlWb4PJVhKNloaAgumwiBQeftif48
	 44ASInrgcn9gg==
Date: Sat, 11 Mar 2023 00:40:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.3-rc2
Message-ID: <ZAtdbhFmLD4MCRk+@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yangtao Li <frank.li@vivo.com>, Yue Hu <huyue2@coolpad.com>,
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
Cc: Yangtao Li <frank.li@vivo.com>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these fixes for 6.3-rc2?

The most important one reverts an improper fix which can cause an
unexpected warning more often on specific images, and another one
fixes LZMA decompression on 32-bit platforms.  The others are minor
fixes and cleanups.

All commits have been in -next and tested without strange happening.

Thanks,
Gao Xiang

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes

for you to fetch changes up to 3993f4f456309580445bb515fbc609d995b6a3ae:

  erofs: use wrapper i_blocksize() in erofs_file_read_iter() (2023-03-09 23:36:04 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix LZMA decompression failure on HIGHMEM platforms;

 - Revert an inproper fix since it is actually an implementation
   issue of vmalloc();

 - Avoid a wrong DBG_BUGON since it could be triggered with -EINTR;

 - Minor cleanups.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix wrong kunmap when using LZMA on HIGHMEM platforms
      erofs: Revert "erofs: fix kvcalloc() misuse with __GFP_NOFAIL"
      erofs: get rid of a useless DBG_BUGON

Yangtao Li (1):
      erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init

Yue Hu (1):
      erofs: use wrapper i_blocksize() in erofs_file_read_iter()

 fs/erofs/data.c              |  2 +-
 fs/erofs/decompressor_lzma.c |  4 ++--
 fs/erofs/internal.h          |  4 ++--
 fs/erofs/pcpubuf.c           |  2 +-
 fs/erofs/zdata.c             | 12 ++++++------
 fs/erofs/zmap.c              |  3 ---
 6 files changed, 12 insertions(+), 15 deletions(-)
