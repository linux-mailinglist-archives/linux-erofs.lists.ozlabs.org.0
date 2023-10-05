Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58C7BA97B
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Oct 2023 20:52:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Odg2p3sb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S1gf119kpz3cQ4
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Oct 2023 05:52:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Odg2p3sb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S1gdx6nTnz307V
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Oct 2023 05:52:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B652ECE2469;
	Thu,  5 Oct 2023 18:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7D6C433C7;
	Thu,  5 Oct 2023 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696531924;
	bh=OvwK77ltnAZjXJBl59/zk04Rk8MD0OfKyT7xQ223tf0=;
	h=Date:From:To:Cc:Subject:From;
	b=Odg2p3sbjePg9oNS0q6gAl1Xlb/qaf56msGMOsgao/o0Z1eDVBSSP0Gp58DmSgnl+
	 zAEp3I5YvLp3t7RdsdtaSMjXz38YiQVSFwAtPYyb+2u0FjvICgOa+7moizl/rRU/8e
	 7a0D3T1BCiKI5Sr77Rtf4r3c293M9scyw9sVdYbVy7i/XfV9T6Z+39upO4em6SoUhv
	 W1QDx0RJQ7Ijy+ol9CDa9ovaHs1Y0bq5cdLhWXYqhqARjzzE++bW1L6WfUh24ocCp7
	 3gB8IyN/Rc3zn1QmrTFymEu71md5p1vEaaDOIXXa3TwPPuY39dhVMdU2a1rsHde/rq
	 gfZDI5KmTvEHg==
Date: Fri, 6 Oct 2023 02:51:54 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.6-rc5
Message-ID: <ZR8Fyu+gi7yw6HMh@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jia Zhu <zhujia.zj@bytedance.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these patches for 6.6-rc5?

There are two actual fixes: the one addresses a memory leak issue, and
the other one fixes mount failure of flatdev mode if device tags in an
image are empty.  The remaining one updates documentation.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes

for you to fetch changes up to 3048102d9d68008e948decbd730f0748dd7bdc31:

  erofs: update documentation (2023-09-28 22:40:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a memory leak issue when using LZMA global compressed
   deduplication;

 - Fix empty device tags in flatdev mode;

 - Update documentation for recent new features.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix memory leak of LZMA global compressed deduplication

Jingbo Xu (2):
      erofs: allow empty device tags in flatdev mode
      erofs: update documentation

 Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++++++++++---
 fs/erofs/decompressor_lzma.c        |  5 ++++-
 fs/erofs/super.c                    |  2 +-
 3 files changed, 42 insertions(+), 5 deletions(-)
