Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8170E2B1
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 19:20:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQh0K0CVjz3f6B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 03:20:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvT0WSR3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvT0WSR3;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQh0C2FjLz3c6v
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 03:20:11 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5113F61AB2;
	Tue, 23 May 2023 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F26C433D2;
	Tue, 23 May 2023 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684862407;
	bh=f46ZRC2jjMXG31VuvQ607oPUvDN+Mcrlg8Kzt5AOalU=;
	h=Date:From:To:Cc:Subject:From;
	b=fvT0WSR3TJ+jl8pfMLH5fFkL82VMBh+qig2K3u97ERovmbs+R1TvgTIfn5DCfrNXF
	 cXzpTa8ZiGLhGVAEXxjCYar8isqslMJH+zwo2wGOvnNhH3k2TBokfTEcSr0n2TngTc
	 lH3LulIyV/UUghTUReEgeRO5rLWYciINzXwgrfK3OArSc3p5RSjU8ATdo1eDlNqN3k
	 05ia4jDW0R3fjKt9cTDx5OKymtl/B1sEARmoGKekW1ta8NWGp1a2FYqYYFLXGe6OQv
	 V7XaFttllzWhwQnZTtIlaJCISNeTLHEtwjacseYPkGvOW90GrjXLYmXL4lO9IS2vS1
	 tGHp7N8qgX4tw==
Date: Wed, 24 May 2023 01:20:02 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.4-rc4
Message-ID: <ZGz1wpqyI+lfCaUA@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
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
Cc: Sandeep Dhavale <dhavale@google.com>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these three patches for 6.4-rc4?

One patch addresses a null-ptr-deref issue reported by syzbot weeks
ago, which is caused by the new long xattr name prefix feature and
needs to be fixed.

The remaining two patches are minor cleanups to avoid unnecessary
compilation and adjust per-cpu kworker configuration.

Thanks,
Gao Xiang

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc4-fixes

for you to fetch changes up to cf7f2732b4b83026842832e7e4e04bf862108ac2:

  erofs: use HIPRI by default if per-cpu kthreads are enabled (2023-05-23 16:57:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix null-ptr-deref related to long xattr name prefixes;

 - Avoid pcpubuf compilation if CONFIG_EROFS_FS_ZIP is off;

 - Use high priority kthreads by default if per-cpu kthread workers are
   enabled.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: use HIPRI by default if per-cpu kthreads are enabled

Jingbo Xu (1):
      erofs: fix null-ptr-deref caused by erofs_xattr_prefixes_init

Yue Hu (1):
      erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

 fs/erofs/Kconfig    |  1 +
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 13 +++++++------
 fs/erofs/xattr.c    |  2 +-
 fs/erofs/zdata.c    |  2 --
 5 files changed, 11 insertions(+), 11 deletions(-)
