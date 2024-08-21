Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11FE959BDD
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 14:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724243506;
	bh=TU81IwlsV+e6p/Y9fsI7jxcx4E2q8E+SbO6xuLhTtKY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QpIme2OByMMlfcJn6KYAgVUWsJaGboXPiEVUHpjd++t46srHTfoOTFUJrctlrcxnL
	 s6GoLK5bq3BGXMSqTQjf98snw07nBuYN+Cy5/xi+dww4xF4CMQ2+KBxO3FUbCnhg1O
	 dJqcId/L81ikW2SVFfbZvL4N5F+lzWGlRGYClHaSwEbyTY6YvqxC7Xry5oUK2mM8I9
	 MqCXPzK6XRs9+9R/Ux0hO34JPyZtw4cv+mrjO1aqNCdgmADtG202DbmBSuBpkfd4Wg
	 cAMSG+xljg5+RWWZdG5jSpUPHIDnpZScZqamvqYJln5smxXWRL4nZzexN+D5YiXb3x
	 LLPqvLbdZrQcw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wpm0y2gZHz2ykx
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 22:31:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k0O38Ljc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 418 seconds by postgrey-1.37 at boromir; Wed, 21 Aug 2024 22:31:41 AEST
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wpm0s566Vz2yMb
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 22:31:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5AE36A41194;
	Wed, 21 Aug 2024 12:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72A0C32782;
	Wed, 21 Aug 2024 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243076;
	bh=7Jml25bVydYsXgiMrn6j29Y0MUA8dnPhETeqDcz5x7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=k0O38LjcQ+Go64NbMEQM6LFkrnF+xdQCZmO8tAD4Dt69qv79Kxc0zIakLiRZn0weP
	 K9nVB8NFucBxaVDkJ0zHKYQT1pEU43t9a5ZIDcRbLAic7GDJj86X/CMdRGvaW0FZWJ
	 /vTGZZ9aW2gU5jtovTyM+mu0dNPVE4GyBriN1V/2MkxiVpx40AjxDFCYXFiCv8ADw2
	 1T1qhA9KXCkpFvfV+yGDK4A7CXrUJ3wC5wxVmH8kvkEr/+qd/yJeAMOo4P6J3d79ZZ
	 zKGSsIGuZUl6LCXTRGnaG1E0AI/gC1lGQWCnU0ShLdlnis8EkXUvUhluyzisdSehgd
	 kF4JiL2Q+iuJA==
Date: Wed, 21 Aug 2024 20:24:28 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.11-rc5
Message-ID: <ZsXcfPaKq3X+Wa5h@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Chunhai Guo <guochunhai@vivo.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these patches for 6.11-rc5?

As I mentioned in [1], there is a regression which could cause system
hang due to page migration.  The corresponding fix [2] was landed
upstream through MM tree last week, therefore large folios can be safely
allowed for compressed inodes and stress tests have been running on my
fleet for over 20 days without any regression.  Users have explicitly
requested this for months, so let's allow large folios for EROFS full
cases now for wider testing.

Additionally, there is a fix which addresses invalid memory accesses on
a failure path triggered by fault injection and two minor cleanups to
simplify the codebase.

All commits have been in -next except for Sandeep's new reviewed-by.
No potential merge conflict is observed.

[1] https://lore.kernel.org/r/ZpTAI1mLZ1pfTnz8@debian
[2] 2e6506e1c4ee ("mm/migrate: fix deadlock in migrate_pages_batch() on large folios")

Thanks,
Gao Xiang

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes

for you to fetch changes up to 0005e01e1e875c5e27130c5e2ed0189749d1e08a:

  erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails (2024-08-21 08:12:05 +0800)

----------------------------------------------------------------
Changes since last update:

 - Allow large folios on compressed inodes;

 - Fix invalid memory accesses if z_erofs_gbuf_growsize()
   partially fails;

 - Two minor cleanups.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: allow large folios for compressed files
      erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails

Hongzhen Luo (2):
      erofs: simplify readdir operation
      erofs: get rid of check_layout_compatibility()

 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/dir.c                      | 35 ++++++++++++-----------------------
 fs/erofs/inode.c                    | 18 ++++++++----------
 fs/erofs/internal.h                 |  2 +-
 fs/erofs/super.c                    | 26 ++++++--------------------
 fs/erofs/zutil.c                    |  3 ++-
 6 files changed, 30 insertions(+), 56 deletions(-)
