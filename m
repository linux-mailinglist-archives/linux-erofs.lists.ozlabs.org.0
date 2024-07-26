Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1DA93D3D5
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 15:13:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dsEh3Y7Q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVp8V2s4Sz3dRW
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 23:12:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dsEh3Y7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVp8R1cVpz3cK8
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 23:12:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A55AFCE1748;
	Fri, 26 Jul 2024 13:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CEBC32782;
	Fri, 26 Jul 2024 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999573;
	bh=+n9W4ZMWC0TWR+Gs0AP+tbxvG9OWgAbubrC48+1vsOU=;
	h=Date:From:To:Cc:Subject:From;
	b=dsEh3Y7Q2WFszkhItk13QYdg5EtkAi8s2j4elndyJuZEZucV6Y+ERHP5QUamZ3J38
	 NgQssw0GxnXPbXpSlWvNOUxB40U3Nvy84ZAAA9erz8ecmg39+e2GCgcW5urWvybyQC
	 3d4VD1mFh8M3Uez9SWHjvjoqRFq2rc1Hy1ghmo7kbU7UpJk+zL6TMjAlNBI+u7EHDV
	 7R72EPJSuhxTDp33AVp28fqDFxutJj6qCCVS7zg65cDmkGCj9jnzSfazeWin0wIIpQ
	 1HKrASjAnJrV4RbFBVAcMbbAH1kN0KopXujps4ZcE4FF/zkrQkmgZqTERZiFqATKPN
	 5Be6bC3M/K0Lg==
Date: Fri, 26 Jul 2024 21:12:43 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs more updates for 6.11-rc1
Message-ID: <ZqOgy0Xh2hPy4Ojm@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>,
	Chen Ni <nichen@iscas.ac.cn>, Chao Yu <chao@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Chen Ni <nichen@iscas.ac.cn>, LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these extra patches for 6.11-rc1?

Two patches add STATX_DIOALIGN and FS_IOC_GETFSSYSFSPATH support and
another one gets rid of the remaining page->index in the codebase
according to [1].  I tend to resolve them in this cycle since those
improvements are actually straight-forward.

The remaining fix addresses a LZ4 decompression race introduced in
v6.10 found by regular stress tests.

All commits have been in -next except for Chao's new reviewed-bys,
so I re-pushed them again.  No potential merge conflict is observed.

[1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org

Thanks,
Gao Xiang

The following changes since commit a3c10bed330b7ab401254a0c91098a03b04f1448:

  erofs: silence uninitialized variable warning in z_erofs_scan_folio() (2024-07-13 12:47:34 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2

for you to fetch changes up to 14e9283fb22d0d259820a5f05c6059678bab9ac5:

  erofs: convert comma to semicolon (2024-07-26 18:48:12 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support STATX_DIOALIGN and FS_IOC_GETFSSYSFSPATH;

 - Fix a race of LZ4 decompression due to recent refactoring;

 - Another multi-page folio adaption in erofs_bread().

----------------------------------------------------------------
Chen Ni (1):
      erofs: convert comma to semicolon

Gao Xiang (2):
      erofs: fix race in z_erofs_get_gbuf()
      erofs: support multi-page folios for erofs_bread()

Hongbo Li (1):
      erofs: support STATX_DIOALIGN

Huang Xiaojia (1):
      erofs: add support for FS_IOC_GETFSSYSFSPATH

 fs/erofs/data.c              | 30 ++++++++++++------------------
 fs/erofs/decompressor_lzma.c |  2 +-
 fs/erofs/inode.c             | 19 +++++++++++++++++--
 fs/erofs/super.c             | 16 ++++++++++++++++
 fs/erofs/zutil.c             |  3 +++
 5 files changed, 49 insertions(+), 21 deletions(-)
