Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D729D28B7
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 15:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1732028255;
	bh=tRMGQLaEWvTFgXR1cUMyR648pzI5OUdKYHVMPvHqI0E=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gP7jKcWBeGnoZHxcqedcqyx5rd+3yVMtab2IdinGqe2e0HVlXg+yNAKUyjeC6GO7p
	 geFs5PN+xJIj/IBMW+3O0BVsX/p5hBbP+vFZ8jPF9rXQ9XaBtGsqZTLqpG3mxjzaSR
	 rIIZV8yzU4N1VTR88M6yN9yAFzsAgNIzAagt84Jl+1IFjDje3rujPPiKlb0JhhAyt7
	 ViVfTlX1nWWidW1M4AmBEnO+73eLvSpgWQEcMlmNRnMDaJOdYye4KBzQ7UL1lCeoKI
	 J2rZ72MuKuGSed2jK8Xxn+6ptYlJQc0XQuQ5ptVxz1VTe19naKTtAiTgUkgYHZQ9lw
	 TgIWjeveVQ1Yw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xt6zg5JMcz2yvq
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Nov 2024 01:57:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732028254;
	cv=none; b=BUxRlzZW77LFFy0Tf5TsXOLz/msp9RDht4fSU0foXZYV6tR0/21dQRR4WGVepm5TvFGke1o7dnvc6/olWMhp6VAh+NA/W5Rahci5PbuzrucAc56ox9tMU1c6qklTdcEH1rPV3yO/XlmHZxMup1TaAbSLnqIk2kh0A2O0Yi0XJYsJNUJH3WEA9ojjx+7aETREqlLF++sYnTd9gfl0wQmnE/o+Vl+1TrVWMz5pFwftuXxo5sG25hlPBZBbn5Jd6dWiHLTeIwk7mtZIchraF2GNSJR/pafEptlKRl0J0UqUSjWB6nIzmwOflJ8VA2PIE3e7IqorqiY+IG4tyrTkivjf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732028254; c=relaxed/relaxed;
	bh=tRMGQLaEWvTFgXR1cUMyR648pzI5OUdKYHVMPvHqI0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QZHPcc2zZ16Hd8CxuqBuowZFYp8B1A3u/BNnkR+MPCT0HcCAGpoum1Q4G1/cFNnF/kJkdSfWMMu7dByvl13Ri6sDkIczBtghGHBplPqvnyWwE6JGh0sMcmb/dyRFd7CYEosrE83oMC8A/3dNZStTK97YnHV8J4lv3Zinm39Tjsv8GIrG5exOUUhkn0wLClMCJf3KNi/n7KiZ1RDN+IkfFqXTlOrjnvELvcvHR6GJ4uXn1nGvRSrAeVbwicHbZ63cO7gMZsp3ZPP/I/IsdHW6ccvVrQ0DABgQvW5D1n2tOHq0LLkpU+rYvui8+AvGqKyJr+5yJyTvmXRzU5KlECDd9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MiprhkCf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MiprhkCf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xt6zd0tQpz2xst
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Nov 2024 01:57:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 35C28A42A27;
	Tue, 19 Nov 2024 14:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C043FC4CECF;
	Tue, 19 Nov 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028249;
	bh=zD455pxGO/pPbjwDJ/NX1AkL1K0SjQr2sIIoO+GcYvQ=;
	h=Date:From:To:Cc:Subject:From;
	b=MiprhkCfxr3gqRTMX7JdJRhUa9+JtizEA/qweJidUMXNvwHl7j/WZQsD/YoYMSli+
	 8Ouise/xxzeHp9MW0IrHTC/7c4qCtylF+IMtVSWO2ArLTHYq0VFiw/1a2Z8MiqFEcK
	 67TCR5gV7G3VEoV2DfJq3nx2q8MOwhOTEVCnAykPuCBiNIw6Rb7Q0riQRhDwpb86/V
	 T0fVC19iv7XCIPwjFsLevC3x+kzyQ5+BrF3UCLTbue0QqxIB3Nn8cSwypbwI/dl/eJ
	 8XGWs4GbijQzF93B2ojYZjTNN1yCrfWcWPPfZYuFZA1q38iE6jJlX+DhzQFt6UnIcQ
	 SA/vTXEXkA1qw==
Date: Tue, 19 Nov 2024 22:57:23 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.13-rc1
Message-ID: <ZzynU2PQOgkWy6BM@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>, Gou Hao <gouhao@uniontech.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.13-rc1?

There is no outstanding feature for this cycle.  The most useful changes
are SEEK_{DATA,HOLE} support and some decompression micro-optimization.
Other than those, there are some bugfixes and cleanups as usual.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1

for you to fetch changes up to 0bc8061ffc733a0a246b8689b2d32a3e9204f43c:

  erofs: handle NONHEAD !delta[1] lclusters gracefully (2024-11-18 18:50:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add SEEK_{DATA,HOLE} support;

 - Free redundant pclusters if no cached compressed data is valid;

 - Add sysfs entry to drop internal caches;

 - Several bugfixes & cleanups.

----------------------------------------------------------------
Chunhai Guo (2):
      erofs: free pclusters if no cached folio is attached
      erofs: add sysfs node to drop internal caches

Gao Xiang (8):
      erofs: add SEEK_{DATA,HOLE} support
      erofs: get rid of erofs_{find,insert}_workgroup
      erofs: move erofs_workgroup operations into zdata.c
      erofs: sunset `struct erofs_workgroup`
      erofs: fix file-backed mounts over FUSE
      erofs: get rid of `buf->kmap_type`
      erofs: clarify direct I/O support
      erofs: handle NONHEAD !delta[1] lclusters gracefully

Gou Hao (1):
      erofs: simplify definition of the log functions

Hongzhen Luo (1):
      erofs: fix blksize < PAGE_SIZE for file-backed mounts

 Documentation/ABI/testing/sysfs-fs-erofs |  11 ++
 fs/erofs/data.c                          |  69 +++++-----
 fs/erofs/inode.c                         |  12 +-
 fs/erofs/internal.h                      |  35 ++---
 fs/erofs/super.c                         |  35 ++---
 fs/erofs/sysfs.c                         |  17 +++
 fs/erofs/zdata.c                         | 221 +++++++++++++++++++++++--------
 fs/erofs/zmap.c                          |  17 +--
 fs/erofs/zutil.c                         | 155 +---------------------
 9 files changed, 276 insertions(+), 296 deletions(-)

