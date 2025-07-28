Return-Path: <linux-erofs+bounces-708-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAEB1332B
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 04:51:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br2zz4hDFz307K;
	Mon, 28 Jul 2025 12:51:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753671087;
	cv=none; b=bpTmed8Ut6OSeBjmX3FUMS3hd5hS43WMGW+APAk2bRWVlr4gZqi0mwI4XApdD+ffmRB1E24qEFTQ0zEHDoXrui9nW/yVYMUWoy3j4A0rq55K5MlI3bnQHXPjgfZN04XGE/plghNXW2G6d3h0gdN2NbNRr2WrWDgH1+7eVuNeEz/AN+xBhwsttFrIgW8arujN/rqiEzMSy/i9KEwvHr5cpNtj3F4AIfhALEbkyUgh6EHn2Bashg+KmmcsjUCM8eLNu/3CLnWH+0CDUYKp7evVeEqf441GeYNugffx3Jm7ezWH9c5cFDdXxbRmDCpIljCTVOdXEs107BfyqlOMzcn45w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753671087; c=relaxed/relaxed;
	bh=Zq1RnGGxvQEyOwnIYsYhj8A70n0T5U5dDOZErhUI5to=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B6UOxib6tOK9b/1aRqP/lttKsCN2iinEC4oxwaixiVzX/3plMd+0HIz1Fie4/wbomrl2ojl0TftJ2Ez7QuNM/QLeMJjXqQ2oljnvlea2RSAn95EItJIg9bCpPlH00xA07sP3fwkXx2BbP+0xDnOLLkdJ2kkU/lEpt1r0IEEWuZL7QfJiehqbIv7U8/Ay8k0+Ed0PJ3Kp4MAkTRJG3gkeFNMHDol+vX98xlpdQoXF49nDWbfLBFuU6X93bhkT/VLjm7gAuAFVKWRze7X2EjKoOQdGPAFIcZqMNqP/Zhb8OM7OGiN93QY3KrgKqcF4MNT3Epd4rzOol72Mkdn0zRUXLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PsPxrXbB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PsPxrXbB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br2zy3KzSz2xRq
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 12:51:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1ACAB601D4;
	Mon, 28 Jul 2025 02:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447BFC4CEEB;
	Mon, 28 Jul 2025 02:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753671082;
	bh=Ka6HpcbV3v4iMb9TmNQTjH+8ndDpD9uqux9pQEtKHHs=;
	h=Date:From:To:Cc:Subject:From;
	b=PsPxrXbBdGMIHEzpyoCyyxn+Zjb7ljzpblXmSkEP0ehpURkfbCBQ4gNodymblMm0A
	 4d5gR94vKhoaPeBro7pu2oDwgpmVLcRDyk5lwI+TUFd/3ww/PJ3SWsnlkMt46pxry+
	 81L4J5Nt2PLk9ZdClQuEvrVIOvcZ2k9nzabcyY31mc2ukOq73RksJE1V/a2y/fochA
	 e8SI9qD4KMV5bfNjdXfCkYH27c23HjxBBdE/NfV6yQBaAl59QrbWtOUG7D2fIXHgv4
	 9CWc9SL9laRqrHmy1xbdkD/Yjc68ry3+tkkfus/bnGs1+ygM4lwK7VwM3BAmEvLiv6
	 3qKVQ0tyGycuw==
Date: Mon, 28 Jul 2025 10:51:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs updates for 6.17-rc1
Message-ID: <aIblpKzSWEEYwQ06@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>,
	Hongbo Li <lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider this pull request for 6.17-rc1?

In this cycle, metadata compression is now supported due to user
requests [1].  It can be useful for embedded use cases or archiving
a large number of small files.

Additionally, readdir performance has been improved by enabling
readahead (note that it was already common practice for ext3/4 non-dx
and f2fs directories).  We may consider further improvements later to
align with ext4's s_inode_readahead_blks behavior for slow devices too.

The remaining commits are minor.  All commits have been in -next and no
potential merge conflict is observed.

[1] https://issues.redhat.com/browse/RHEL-75783

Thanks,
Gao Xiang 

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1

for you to fetch changes up to df0ce6cefa453d2236381645e529a27ef2f0a573:

  erofs: support to readahead dirent blocks in erofs_readdir() (2025-07-24 19:44:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add support for metadata compression;

 - Enable readahead for directories to improve readdir performance;

 - Minor fixes and cleanups.

----------------------------------------------------------------
Bo Liu (OpenAnolis) (2):
      erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
      erofs: implement metadata compression

Chao Yu (2):
      erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
      erofs: support to readahead dirent blocks in erofs_readdir()

Gao Xiang (6):
      erofs: get rid of {get,put}_page() for ztailpacking data
      erofs: remove need_kmap in erofs_read_metabuf()
      erofs: unify meta buffers in z_erofs_fill_inode()
      erofs: refine erofs_iomap_begin()
      erofs: remove ENOATTR definition
      erofs: add on-disk definition for metadata compression

 Documentation/ABI/testing/sysfs-fs-erofs |  10 ++-
 fs/erofs/Kconfig                         |   2 +
 fs/erofs/data.c                          |  64 ++++++++------
 fs/erofs/decompressor.c                  |   2 +-
 fs/erofs/dir.c                           |  17 +++-
 fs/erofs/erofs_fs.h                      |  15 +++-
 fs/erofs/fileio.c                        |   2 +-
 fs/erofs/fscache.c                       |   3 +-
 fs/erofs/inode.c                         |  21 ++---
 fs/erofs/internal.h                      |  40 ++++++++-
 fs/erofs/super.c                         |  23 ++++-
 fs/erofs/sysfs.c                         |   4 +
 fs/erofs/xattr.c                         |  56 +++++++------
 fs/erofs/xattr.h                         |   3 -
 fs/erofs/zdata.c                         |  20 +++--
 fs/erofs/zmap.c                          | 140 +++++++++++++------------------
 16 files changed, 255 insertions(+), 167 deletions(-)

