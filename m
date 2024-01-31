Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6188434A1
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jan 2024 04:45:24 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z+uWTVxU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TPnxC088Xz3bqB
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jan 2024 14:45:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z+uWTVxU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TPnx71wx0z309c
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jan 2024 14:45:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 909CECE1C27;
	Wed, 31 Jan 2024 03:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80196C433C7;
	Wed, 31 Jan 2024 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706672709;
	bh=ykzqhetelTYX6R6hoF5APKU0QC0aniQQjrvlRNHploA=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+uWTVxUFBV4vZNSVMsU/PcJ8BF57hPdbXtst1bZqQCPpb1GshZWb+wqtZJo/uYLu
	 pVg1FCJksnEoTljbkremtKukmDvO4X3uksQmupkkCh+Qokx9RMC5nHRCh1SGtHAHBG
	 rwpp5ZHkjwG0Gkx/7UBFcr4vNnTZveeVVpBNAAInQs+KAJZXghZZoKNK4pm+4zT6cx
	 WELIoR0NZaXTvC7ZMwaXMjr30EOPjTKi31khudsBNAnelipnDdChsZwlwljWKNw1vj
	 fzvuZk5R2JyTv4cp9fPrRi71x1QhWUzdPw6zFOQHIUmJxa9TrcoQLsJNmjZK7Gjgfm
	 LQUxmu0IevR/A==
Date: Wed, 31 Jan 2024 11:45:03 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs fixes for 6.8-rc3
Message-ID: <ZbnCP71bgYBzzHA3@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>,
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these fixes for 6.8-rc3?

One commit fixes an infinite loop issue of sub-page compressed data
support found with lengthy stress tests on a 64k-page arm64 VM.

Another one optimizes temporary buffer allocation for low-memory
scenarios, which can reduce 20.21% on average under a heavy multi-app
launch benchmark workload.

The remaining one gets rid of unnecessary GFP_NOFS.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes

for you to fetch changes up to d9281660ff3ffb4a05302b485cc59a87e709aefc:

  erofs: relaxed temporary buffers allocation on readahead (2024-01-27 12:28:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix infinite loops due to filling compressed_bvecs non-atomically;

 - Remove unnecessary GFP_NOFS;

 - Relax temporary buffer allocation for low-memory scenarios.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: relaxed temporary buffers allocation on readahead

Gao Xiang (1):
      erofs: fix infinite loop due to a race of filling compressed_bvecs

Jingbo Xu (1):
      erofs: get rid of unneeded GFP_NOFS

 fs/erofs/compress.h             |  5 +--
 fs/erofs/decompressor.c         |  5 ++-
 fs/erofs/decompressor_deflate.c | 19 +++++---
 fs/erofs/decompressor_lzma.c    | 17 ++++---
 fs/erofs/fscache.c              |  2 +-
 fs/erofs/inode.c                |  2 +-
 fs/erofs/utils.c                |  2 +-
 fs/erofs/zdata.c                | 98 +++++++++++++++++++++++------------------
 8 files changed, 87 insertions(+), 63 deletions(-)
