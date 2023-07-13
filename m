Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7D7526ED
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 17:28:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OXtC9Zny;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1z5C4HP2z3c4t
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 01:27:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OXtC9Zny;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1z593QZyz3c4G
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 01:27:57 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7800061087;
	Thu, 13 Jul 2023 15:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C87CC433C7;
	Thu, 13 Jul 2023 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689262074;
	bh=Yb0FwToWR1mPgzJmQRpGI5uiW5wHMqCirUi7MRvIv3A=;
	h=Date:From:To:Cc:Subject:From;
	b=OXtC9ZnyPa+EXeMNNjdqCu+mrCGWsYsc+qdrKid8H31wbOOA/FE9gbctWtSg3/5pJ
	 ssiz/sqS6p3iVFF948KQseuq7J0TE6XaGq+wkFvt+5HkQGHid1It7lE4nz4H8b5a4o
	 KGMrusNec3GwkBOEx+gKZrr9rpgSsS9TEyeX0nxWLtF1ep93fdRZoxriE7GPRPHqdq
	 ieQ+i56bDarBQ/O4G7nYIZJqo4GiWchTnTGhKQ0SzGd78kniB+gv5prsJ/uEDr08jw
	 8jPhKMze3TSccSZRiYfZtBcfI2GzbjpflAhiNDCyKt1LxJY+UB6j7q/wLL816azo98
	 nA3lR1F0hvyRQ==
Date: Thu, 13 Jul 2023 23:27:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.5-rc2
Message-ID: <ZLAX9WApf3wGm5Q+@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Xin Yin <yinxin.x@bytedance.com>,
	Chunhai Guo <guochunhai@vivo.com>, Yue Hu <huyue2@coolpad.com>
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

Could you consider these patches for 6.5-rc2?

Three patches address regressions related to post-EOF unexpected
behaviors and fsdax unavailability of chunk-based regular files.

The other two patches mainly get rid of kmap_atomic() and simplify
z_erofs_transform_plain() which I think they are simple enough to
be addressed in this cycle.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes

for you to fetch changes up to 18bddc5b67038722cb88fcf51fbf41a0277092cb:

  erofs: fix fsdax unavailability for chunk-based regular files (2023-07-12 00:50:56 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix two unexpected loop cases when reading beyond EOF;

 - Fix fsdax unavailability for chunk-based regular files;

 - Get rid of the remaining kmap_atomic();

 - Minor cleanups.

----------------------------------------------------------------
Chunhai Guo (2):
      erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Gao Xiang (2):
      erofs: get rid of the remaining kmap_atomic()
      erofs: simplify z_erofs_transform_plain()

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

 fs/erofs/decompressor.c | 37 +++++++++++++++++--------------------
 fs/erofs/inode.c        |  3 ++-
 fs/erofs/zdata.c        |  4 ++--
 3 files changed, 21 insertions(+), 23 deletions(-)
