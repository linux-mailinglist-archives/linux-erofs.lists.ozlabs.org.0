Return-Path: <linux-erofs+bounces-119-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E15A6D024
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Mar 2025 17:57:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLMmQ0CJdz2ygh;
	Mon, 24 Mar 2025 03:57:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742749029;
	cv=none; b=GU+t/KBQrlvSsfVTHPL7b5lN1s0Jtw+Xp8AEf8bBAkv9Eg8MeasDg4QpqscvdlrOVAw2YXGkjoLwAkes2mKpA7V6Cq025N//iRINjd9GxcAv51RehWvDR+Exc+o+5A9VlLRn23JwCeuQp/1JSVCpNqZyN5svzjMDOOq+AgFRVEcN5YCrxbVOvePyvjCgPVFIwBUjmkvRDBvo+dyY5hMvGJShaIsOH6R8L4hjNrOeY2CGDOsIUm9QJcTfQoNf/iN6Pf0XBXA+qyaZbcjREPj04qlNqOUPhsp5DpaC/BXbRU9d/4u3v39S36iprQx3ezYEEaIbNM4RKcPrArk1XiG2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742749029; c=relaxed/relaxed;
	bh=mbKDVCl/lczXaRRlEmeMWa6/k3/BcVJe6ooHOPtY+n0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fg/NemuZrGuqhdA26vK/4aG3R3IR3s2xQI4U1Fp/nIyV39ZHM6M+EguaRk0l76OjYANekvLjxhQuh2whxxFcfjC5QLP3LB5KmIyjf9Rv3wGpUt/Cpd4pT8JzPG7iu00uXVTIdb2EaixNmxRhmcnoF1EJAhkYm0HitL8rCFF4trdwotiMYTPj1mU0//9biWJKu0VUqvc8pnpju2K3EA/URBTiWA+561BYj+i3dTzv/X+aHDHdz5QIwyaDdzp8JzXrzjAlRUPnpTgALgVCTZ/IEGDaGDKPnVgxosOPxd6LQoLgBATHJUeRKiQd0Kk3E59dsw8mFBePe6A5pJUGrYy3HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yvuaozcb; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yvuaozcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZLMmN2Yg7z2yfR
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Mar 2025 03:57:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0AF825C3FAC;
	Sun, 23 Mar 2025 16:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D03C4CEE2;
	Sun, 23 Mar 2025 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742749025;
	bh=FxOUYhiHm+2OmW3aiiCHsAGgHhgywv+CYn5hIK/Lw08=;
	h=Date:From:To:Cc:Subject:From;
	b=YvuaozcbbaZWjR5TUcLna2xhhJ+gMGzapwv8Nea3w8FH+SdIXAm0HB0sh63PZT8R5
	 fLwJn+ykfQtZlqeoyqVdrcoBoTEQbqt/t0AB+HTx6+kd/VDnx3dfYNC5+E3o3JRusl
	 cme4mEwvdpXG0kSuJzoD+DkICpYgvukU2sfGCViGF/aU6gSuO/y3K0Jb9O+KzNWmPP
	 lPPt0lNOra+bs2dtpyz8cjno8PQPneoqoONvYBK3xOYOaIgmqtUQD4WsLR2l0yBz03
	 oe2aTAaJiuXKHuTdNAB+airws5qyZy3Y5F0VIFrcS7ccfbrL5xnC25QFqbT8YnYQeI
	 T9BpDPuUhyJwA==
Date: Mon, 24 Mar 2025 00:57:00 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.15-rc1
Message-ID: <Z+A9XO3+rPjpLUa2@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider this pull request for 6.15-rc1?

In this cycle, EROFS 48-bit block addressing is available to support
massive datasets for model training and other large data archive use
cases.

In addition, byte-oriented encoded extents have been supported to
reduce metadata sizes when using large configurations as well as to
improve Zstd compression speed.

There are some bugfixes and cleanups as usual.  All commits have been
in -next for a while and no potential merge conflicts is observed.

Thanks,
Gao Xiang

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc1

for you to fetch changes up to 0f24e3c05afeac905a9df557264cc48f3363ab47:

  erofs: enable 48-bit layout support (2025-03-17 14:02:16 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support 48-bit block addressing for large images;

 - Introduce encoded extents to reduce metadata on larger pclusters;

 - Enable unaligned compressed data to improve Zstd compression speed;

 - Allow 16-byte volume names again;

 - Minor cleanups.

----------------------------------------------------------------
Bo Liu (1):
      erofs: get rid of erofs_kmap_type

Gao Xiang (14):
      erofs: allow 16-byte volume name again
      erofs: simplify tail inline pcluster handling
      erofs: clean up header parsing for ztailpacking and fragments
      erofs: move {in,out}pages into struct z_erofs_decompress_req
      erofs: get rid of erofs_map_blocks_flatmode()
      erofs: simplify erofs_{read,fill}_inode()
      erofs: add 48-bit block addressing on-disk support
      erofs: implement 48-bit block addressing for unencoded inodes
      erofs: support dot-omitted directories
      erofs: initialize decompression early
      erofs: add encoded extent on-disk definition
      erofs: implement encoded extent metadata
      erofs: support unaligned encoded data
      erofs: enable 48-bit layout support

Hongzhen Luo (1):
      erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches

 fs/erofs/Kconfig                |  14 +-
 fs/erofs/compress.h             |   2 +-
 fs/erofs/data.c                 | 148 +++++++++------------
 fs/erofs/decompressor.c         |  95 +++++--------
 fs/erofs/decompressor_deflate.c |   8 +-
 fs/erofs/decompressor_lzma.c    |   8 +-
 fs/erofs/decompressor_zstd.c    |   8 +-
 fs/erofs/dir.c                  |   9 +-
 fs/erofs/erofs_fs.h             | 191 +++++++++++++--------------
 fs/erofs/fileio.c               |   2 +-
 fs/erofs/fscache.c              |   2 +-
 fs/erofs/inode.c                | 125 +++++++++---------
 fs/erofs/internal.h             |  47 +++----
 fs/erofs/namei.c                |   2 +-
 fs/erofs/super.c                |  85 ++++++------
 fs/erofs/sysfs.c                |   2 +
 fs/erofs/xattr.c                |  12 +-
 fs/erofs/zdata.c                | 102 +++++++-------
 fs/erofs/zmap.c                 | 286 ++++++++++++++++++++++++++--------------
 include/trace/events/erofs.h    |   2 +-
 20 files changed, 579 insertions(+), 571 deletions(-)

