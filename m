Return-Path: <linux-erofs+bounces-1469-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D711CC9718D
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 12:46:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKhvR53mYz2yv6;
	Mon, 01 Dec 2025 22:46:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764589603;
	cv=none; b=Ej9G+dnTtZoUsm8NF2JxFs0fJL3FpVxdP9OVBBoijUHDWZCgDCHW6VO0sxAmVt2mt4cyNtr/rNiSHm1Mku6cZebbuDd5GOq4CI9bHsbmYZDRCn9FShNJMEMenfU+rTbjFKRCS1Tsvof1pdUt2gATKVhBZoH7ywpMV6xdawlftg8XMj8hd9L9lsk/T8iks95PYmPXL26WZVybOHtcMUMJD8GpSVXklJsozmxAPq0pB/7fqi7WRVwlssH95tHCyTWazPlFcWcgTv20BGi9qUOjO7E5ZppggrKx0UXIKY6jin5Mp6125R+XuKY4lVRT37+KaIzNeYzwcdna+QlLavUFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764589603; c=relaxed/relaxed;
	bh=0rzOR5Zwq1r//bF++zOYN4PN/JyLeIAZJ0wJDoLCpdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2oh9QP0waoxqtzurFuZzNLoGEqV0qaru1e05EHzE7MyHrcc7fcg/5cwVSk3ACgwGG9vwBUCRKx+LRYCMKHahXjNgbHG0h5W79kttEah6QSS/Oew+CZVLr+GO7ghMD5mKfLsFFXDVDMdXZbGCJIaaaj8gbQ1mauSFNrh7YQ47cLGjXmfpEOTBGhhkWDJ6ZrzUV8Lr7gw3i9oGX8U9m5svNHSaFCXMRfw4N9benhVDHU0EhNno9oE+rYvC3UtASMaqIOhoT4800XTZYfFq51NF8ehpehIsELiun5MEUoYhGfKhJdtorzf/s9B78fsQgn7u7td5515xdX7SR4RpYZS/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPuzx0yc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NPuzx0yc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKhvR0Kllz2ypW
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 22:46:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 21BF06016D;
	Mon,  1 Dec 2025 11:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305AC4CEF1;
	Mon,  1 Dec 2025 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764589599;
	bh=7EB4Rd3pkGw8QEChascC+nBCjID/lLRY4OUdtCovZhE=;
	h=Date:From:To:Cc:Subject:From;
	b=NPuzx0ycrKcc7Nbjm09kLqBQJT2QewxzKwvfYr5w0m1NuADAqQmHIF5TtB4TgdINz
	 gQms2wOGVYO/kkirgvQ3yeNSZlqofFU1BoG8CI4x7q4kCF0aDaexOefVHexB6YtP5L
	 IPgzH0ZAX9+tifL0xxts/PwFfzysbEhoJs1YM1MEMru6ZcL79Bou/AiAm2p5Gdlqjx
	 caQxkU70bpEZyv7R1mbqT9gT7KB+Sq1OfuLcfcnZ5JYY2Qywx9BrkGBCuoVDQuVDHM
	 3OgCMP8xrNEoDD70JXI+EI33cDEHd44/jxlJtmEzDQbl7BxHoDg6lyvEmQV+Aldqtn
	 OunQhmZBd0uHA==
Date: Mon, 1 Dec 2025 19:46:30 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] erofs updates for 6.19-rc1
Message-ID: <aS2AFm3vf2aJWJCB@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider this pull request for 6.19-rc1?

There is still no outstanding feature for this cycle
since page cache sharing feature is still under review.

All commits have been in -next except for the obvious
license change one and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 6a23ae0a96a600d1d12557add110e0bb6e32730c:

  Linux 6.18-rc6 (2025-11-16 14:25:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc1

for you to fetch changes up to 0bdbf89a8bbeb155644b69dc2d071a1ce23414f8:

  erofs: switch on-disk header `erofs_fs.h` to MIT license (2025-12-01 15:25:43 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a WARNING caused by a recent FSDAX misdetection regression

 - Fix the filesystem stacking limit for file-backed mounts

 - Print more informative diagnostics on decompression errors

 - Switch the on-disk definition `erofs_fs.h` to the MIT license

 - Minor cleanups

----------------------------------------------------------------
Gao Xiang (9):
      erofs: correct FSDAX detection
      erofs: limit the level of fs stacking for file-backed mounts
      erofs: tidy up z_erofs_lz4_handle_overlap()
      erofs: improve decompression error reporting
      erofs: improve Zstd, LZMA and DEFLATE error strings
      erofs: enable error reporting for z_erofs_stream_switch_bufs()
      erofs: enable error reporting for z_erofs_fixup_insize()
      erofs: get rid of raw bi_end_io() usage
      erofs: switch on-disk header `erofs_fs.h` to MIT license

 fs/erofs/compress.h             |  12 ++--
 fs/erofs/decompressor.c         | 149 ++++++++++++++++++++--------------------
 fs/erofs/decompressor_crypto.c  |   7 +-
 fs/erofs/decompressor_deflate.c |  37 +++++-----
 fs/erofs/decompressor_lzma.c    |  26 +++----
 fs/erofs/decompressor_zstd.c    |  28 ++++----
 fs/erofs/erofs_fs.h             |   2 +-
 fs/erofs/fileio.c               |   2 +-
 fs/erofs/fscache.c              |   4 +-
 fs/erofs/super.c                |  38 +++++++---
 fs/erofs/zdata.c                |  21 ++++--
 11 files changed, 178 insertions(+), 148 deletions(-)

