Return-Path: <linux-erofs+bounces-299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E245AAE77C
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 19:12:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zt1yx0VMcz30QJ;
	Thu,  8 May 2025 03:12:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746637928;
	cv=none; b=bK7hwElfT+XODlNfgpviKAjlyVSthzsuMex88TnNIXJKJUAKy08DIro/9Xi2Q1h3s7iISG+KIVkXoX0xrU8ZKjCrXiqaVauKH31HBbgngzZxDgA1pEDo1cs18rHMlN4GrHApyTpc3dd1UmUEAXDT/OTxVyoHm1wAfnGlM13fxyD+AEYNwgUwmGKMmUNiyC+KNaLSPZBgQE9UITpQWdy4jxnkIIpjQfJnI1MXRghH0mqwqSygib1X8tGpYB/5POcou7sBHhj7UgqWSDRc7px9jji2ZfoLk1/D7eN8ffp/0USOV9qEOpx6EKlJTRwCgMPCXtpiFZNOXKsu5NsTJAbd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746637928; c=relaxed/relaxed;
	bh=dP+UdiKbeHuqhOAH9VdJ4LQZiTEGzmo9jB2aZbdEsa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eb4vn6AD8IQgujoHjBfOjEKdmObwPGB24O6Bc2s3WDuF+iG+GdiDueTOes5EeIEOXZiJhO9JJHEUeX/kgH1Nt8QmsmwiW863yQTCJK4xusWsoOZvF4GL3t7jlc+jxqxy+l34HtcoGibG31OLsuDBeX50u+hRi56ZssEpN4L0gMODrG7PvlDo1wG6kf1LA65xWa7/vkw2jxG3+KpkPtYhxzenAVXpQWYN3L9UQMWa4BCn/SjU1hTyFi94/L4R6CJ4Q/AI9FQSjHqcJNXzDEWiQCo7EtWaO69cHTLrQEWJ4MO6tbEULj7CJvcimpn7mhMJ6u5AiEUsZNYbbp1KfWu7ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LqZ2bAC7; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LqZ2bAC7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zt1yw1yJlz30Nl
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 03:12:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 598045C1071;
	Wed,  7 May 2025 17:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D55C4CEE2;
	Wed,  7 May 2025 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746637925;
	bh=zHOBVAhoN4DHw68EYZzaE/9ebznx1HIdqWv3gESepsI=;
	h=Date:From:To:Cc:Subject:From;
	b=LqZ2bAC7Tix2feSkGmn+UwTxdQpq8FtDslWmqrSGd5kkAumQZChwHAhnLI7lGtook
	 Q1wfUw7qdc5noCm6wGUCmQIORsaWQsS9zn/nAqDAxyjf0Xrggf4rvr0vT1fiTzqlA+
	 HCyIPNiM2fVluO86vIT14SgagXE904ozsHkzACq34Xq/ynie6B5ufpqKvOxrLfLcky
	 5ni8JxB+ak8pN0KxxpsnvZDbkQllNrJ5zQAn+KkB9yKcvXeOWWV8iqrULCeA0UhIN4
	 teBriS759vZLIaPNGMkSgxoEkZo0x28Mup9kSEnYckwYK/qClqZ4oNWJEYoazpTR0s
	 JPrCbrCL9CgVg==
Date: Thu, 8 May 2025 01:11:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.15-rc6
Message-ID: <aBuUXWt2bnmMBR1B@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Max Kellermann <max.kellermann@ionos.com>,
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider those fixes for 6.15-rc6?

There are mainly two fixes that would be better to address immediately,
as shown below.  All commits have been in -next (except for Hongbo's
new received rvb), and no potential merge conflicts are observed.

Thanks,
Gao Xiang

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc6-fixes

for you to fetch changes up to 35076d2223c731f7be75af61e67f90807384d030:

  erofs: ensure the extra temporary copy is valid for shortened bvecs (2025-05-07 09:50:51 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add a new reviewer, Hongbo Li, for better community development;

 - Fix an I/O hang out of file-backed mounts;

 - Address a rare data corruption caused by concurrent I/Os on the
   same deduplicated compressed data;

 - Minor cleanup.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: ensure the extra temporary copy is valid for shortened bvecs

Hongbo Li (2):
      MAINTAINERS: erofs: add myself as reviewer
      erofs: remove unused enum type

Max Kellermann (1):
      fs/erofs/fileio: call erofs_onlinefolio_split() after bio_add_folio()

 MAINTAINERS       |  1 +
 fs/erofs/fileio.c |  4 ++--
 fs/erofs/super.c  |  1 -
 fs/erofs/zdata.c  | 31 ++++++++++++++-----------------
 4 files changed, 17 insertions(+), 20 deletions(-)

