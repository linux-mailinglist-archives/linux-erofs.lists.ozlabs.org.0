Return-Path: <linux-erofs+bounces-1028-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB3B56400
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Sep 2025 02:04:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cPT1h06pHz30BW;
	Sun, 14 Sep 2025 10:04:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757808295;
	cv=none; b=BwNijgZox4pIUAkaOCitecmaWNQFpYAz1G1wVFy1mmHiqdWjoqzHP88puQN+fHOtPfNCldRd6cKCZZNGnHua2Ck67pBrvPCuLF4AvMqFRiWtdPL8ugsN1rIEQWFvb/9llB0b6q2NX/dInPw0Vbk+BBZhTI8ctMwQKfD4k5MeRaAn0XOOBpcYgYdrHOOdsbRPen7gvy1E74rwXyB+IU1oYAeEPz7xbfzMHiCly98iGLpMMh7evlKV0S++vD2b76aofDW0mHLNs+FwXHmt2pnmHrZqwlDhlt+ODyGZJRUCV5xXsZOtlr4c0AACtCS5tWeVzHULwQW5ISGZDLdKY8wOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757808295; c=relaxed/relaxed;
	bh=CBKdU/D6FCgf78FWCspAfZkrvHLAybEesqY2aHFhS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=STaqVblILFaZ3uetc7eNODIJ4NCu7saB/v6JTMPAGACFQnJa+jd12rSpTkhudDu80F6OHz9PgQ7Qyo0eoHHtPGUN44czOic7nmytmJ4NDwvPqRazbML5qQ3EVW4cz26YgRstZwD+QqwVGRw9J24u7dbsepxqgU7vcIo8zzajZ3azkMEEX4zX5kVncSUYnZVOLhn12nYW8RsyLR5tCw4388IApaT7zyoUtz75r0LiPxXy5HFnEgstqNPlPKSx1oiFKAg27jVXkYI24PFuPucRFy0nZHUZCQrK74eVapc20Aq6s4IAEf1JmrjJeRCg+Qy+YglPoxuAZQBUqcigYVmnGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YonLBBL9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YonLBBL9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cPT1g2Cr8z304x
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Sep 2025 10:04:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 150DC444E4;
	Sun, 14 Sep 2025 00:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9EC4CEEB;
	Sun, 14 Sep 2025 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757808292;
	bh=jhxlJQ1D3aXAHnveeb4Bqd8Arf+9bkmDUaPFFpf52EY=;
	h=Date:From:To:Cc:Subject:From;
	b=YonLBBL9XtJ+Z0e/O+tCbfXvL6N+OUUSx0O+4ZY8zkbqFYwwcuGwb2DQzzvMViBOW
	 eJr3CoHMaKPAqlWFmGWX6Mas2AmXCk77nBobHu1BO1j4fBwqSJ8EydCWmneA2gEBlP
	 ig/rjUXLR8YnHz2BWaaeKaSjyXMtHbZRraBeGF7HY04+K6ckCdplV9V7jqKDvdMsVp
	 vcixJuiiHTFjqePvV5DqEudbzflM+waY/0r8P4ZUG3wCCRj8aMHiapYZpuFs6cl8ea
	 7ZKn+DHyu69hW42bOSXoxvS/PSsu1bDnzbOBXrZMm+2iDENxhktNDGDDx0U9wifgBa
	 dw553Bv7E3xKg==
Date: Sun, 14 Sep 2025 08:04:47 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.17-rc6
Message-ID: <aMYGn1hQjWaQCaiM@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
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

Could you consider those fixes for 6.17-rc6?

A few new random fixes as shown below..

Thanks,
Gao Xiang

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes

for you to fetch changes up to 1fcf686def19064a7b5cfaeb28c1f1a119900a2b:

  erofs: fix long xattr name prefix placement (2025-09-12 03:37:07 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix invalid algorithm dereference in encoded extents;

 - Add missing dax_break_layout_final(), since recent FSDAX fixes
   didn't cover EROFS;

 - Arrange long xattr name prefixes more properly.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix invalid algorithm for encoded extents
      erofs: fix long xattr name prefix placement

Yuezhang Mo (1):
      erofs: fix runtime warning on truncate_folio_batch_exceptionals()

 fs/erofs/erofs_fs.h |  8 ++++---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 12 ++++++++++
 fs/erofs/xattr.c    | 13 ++++++++---
 fs/erofs/zmap.c     | 67 +++++++++++++++++++++++++++++------------------------
 5 files changed, 65 insertions(+), 36 deletions(-)

