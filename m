Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA969F4D8E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 15:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1734445450;
	bh=X77ljd6MI8M+MpADdUzXBadNMgLcvrZWXODn/J2SgNQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=m7MI7D7trA6g8waRgauxgacdRIoA1RRx1vO2CZRZhQxwyG7YSq1yJWqjpdbfoLIq1
	 Bjp3NdaGAvWJz1qLb0ON8Nfk60NAV++4lJiApR7wq1zBszJ612dWBlE2MXLjWMrEGo
	 Bv9Zv/LkNqu3P+1AHzRGb1kM5+rk/U+JkqUG402HDs+ZYuMDIWt7y4XmA9++NL4HYd
	 QaQoWNLksHCDc9GQSycLjPdvVYUAx3k/we10QM+0CVTGBkLz9gweIU9AS+653E2Ckq
	 7Fz9Z/tHNS2vjHeyDmge8AQF8+ZIPlLynY06CsVO4+nUJb+TMkK+1vnG8Bgt+z2PEF
	 pKz0iKXmqocwQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCJwB5WDCz30hW
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 01:24:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734445449;
	cv=none; b=Bd8T90yt8mU8LhsmVvQfoIY+FMXzKQLrRWIUArT9Y8nafvkPfilmjEoOobFyS9qk3fqCB29szqWsG80dq+PRYRmA3O3I8Z62G8bu0FPXTceEkxehsyOGM6dwRwsDMuHssh3DVJzDPvIkcyzxpIgd/rusHO4NhrOIuLlpR1IApFBkcGS03NH5mFh7cAk+XXHUB0z193sfWlp3ne9GA9j9rabiuTRR63UOEeFwKNN7RSMK4x3maFzwKIXyCKLYazd8L2v/fZOitVnkNo2VjxD8sUXDpGLAFFpKXapb2pS+FBH7MaLHfzRO7TxwXr0Y5KvYfXmhtmTgPKe1XSyLs6GNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734445449; c=relaxed/relaxed;
	bh=X77ljd6MI8M+MpADdUzXBadNMgLcvrZWXODn/J2SgNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=imDvCRl2DqeJgq+1gSkpDsw7Ulsg62BttsnMCeSORQArSn1WOsEe+TZQCAfyWH0vKxHhRRubQQeKQ3XxiLCPkTBpIdhdhGE/5sa075vwxI7lpXWlIdkIBwYO+xHaM54FnvDv5H3zAmbWLFYpyR8wfPTU3Xi1z8StgMXPpEN9Vh5/L5ebZoiqb6y8wx4nS6p3MEE/cMU9KTnlcBh8OzjPyDilM6BfZWBB3xsTrLa2H0SflzmXM7S/DRYQmTyPDfkgAdLx86uH1hKIBOadUfHZWIe1bFFc2u3r/suzA9NVNl5OsH5rflz8Yjdprwz8tTymcDPYq2/29DO/k4v1iPp4Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ag1JbsLD; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ag1JbsLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCJw80zpfz30DV
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 01:24:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AEE05C5882;
	Tue, 17 Dec 2024 14:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BEC4CED3;
	Tue, 17 Dec 2024 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445445;
	bh=j3HRziA2BSqPktqBMFjFA6JGdKsy5NE/8LDdhAzqgWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Ag1JbsLDqEOmqLWOxJ2b2/gtGJiptyFZvUaPQF2iP6duiwvrC8dLKNZSN3LW0lso7
	 lie5xEPnBOckCI+I7pApjdZWHjrirFn3VQ3o0xZif5VBpEo9mdJHdnvqslKzQWMoNB
	 f0KrH2wvr9k/p35e8Lmhav8nAS/t4wtpQ5POocoh6tAjmqmxVAvUkHZggVYZFeiWP4
	 hVtc61PHq3r2oPkR+/Mz+8fwO1psX00X97E5jqJF49TRCfMSmLwPtQRX+NelVeHAJV
	 ixkmgFvdXYlQTkBErqW0igyDXU2HYbUXVqqN8HY+BmqcuVGFZ6RDN0/0RFoyQuGH/L
	 yXAiKM+BJcyZA==
Date: Tue, 17 Dec 2024 22:23:58 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.13-rc4
Message-ID: <Z2GJfmDTrzh0mM8P@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org, Yue Hu <zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these three fixes for 6.13-rc4?

The first one fixes a syzbot UAF report caused by a commit introduced
in this cycle, but it also addresses a longstanding memory leak.  The
second one resolves a PSI memstall mis-accounting issue.

The remaining patches switch file-backed mounts to use buffered I/Os
by default instead of direct I/Os, since the page cache of underlay
files is typically valid and maybe even dirty.  This change also aligns
with the default policy of loopback devices.  A mount option has been
added to try to use direct I/Os explicitly.

All commits have been in -next and no potential merge conflict
is observed.

Thanks,
Gao Xiang

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes

for you to fetch changes up to 6422cde1b0d5a31b206b263417c1c2b3c80fe82c:

  erofs: use buffered I/O for file-backed mounts by default (2024-12-16 21:02:07 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix (pcluster) memory leak and (sbi) UAF after umounting;

 - Fix a case of PSI memstall mis-accounting;

 - Use buffered I/Os by default for file-backed mounts.

----------------------------------------------------------------
Gao Xiang (6):
      erofs: fix rare pcluster memory leak after unmounting
      erofs: fix PSI memstall accounting
      erofs: add erofs_sb_free() helper
      erofs: use `struct erofs_device_info` for the primary device
      erofs: reference `struct erofs_device_info` for erofs_map_dev
      erofs: use buffered I/O for file-backed mounts by default

Yue Hu (1):
      MAINTAINERS: erofs: update Yue Hu's email address

 MAINTAINERS         |  2 +-
 fs/erofs/data.c     | 36 +++++++++----------------
 fs/erofs/fileio.c   |  9 ++++---
 fs/erofs/fscache.c  | 10 +++----
 fs/erofs/internal.h | 15 ++++-------
 fs/erofs/super.c    | 78 +++++++++++++++++++++++++++++------------------------
 fs/erofs/zdata.c    |  4 +--
 fs/erofs/zutil.c    |  7 ++---
 8 files changed, 79 insertions(+), 82 deletions(-)
