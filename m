Return-Path: <linux-erofs+bounces-482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CA4AE298A
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Jun 2025 16:43:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPcXk0XNLz2xs7;
	Sun, 22 Jun 2025 00:43:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750517014;
	cv=none; b=S4epOAxTfXGfRxtOtLLLY+tKsgF2mg+Q6H9WNKxD0wWn6ZwA/hXMEVxioqjCnwNMU9LYYXIewAHmsu3V1N1hKe32Qr9bonmPs+Qn2J3o3CoLxb0sJowN6/7/ZV8WOgZsNtqs0bm8pA370yI6GumUOeC+2s6OQbRkz89U426Y7jA2XoNfDoyvzsCdzyYSvqfXMyoJwR3gfSnVzKaOl5bLiF18wSQR4suaqJRmnLNkiQIE+S+G2/YfkYBFvPTU3QOwd8PdSdsfpwrK0F11TIScx1NgTgreFJGJieHeIT1WoF8ySMGl69L2QwjajBhlTUYuxonMJyjjPgL+IJB0pyAcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750517014; c=relaxed/relaxed;
	bh=T1ZYEVlQRBPKj+xXulXS83mOuLxzDpUsxw54Zol5S1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iSW/KJ0QdqZmpM3DXnj65lI6pZqarfkmuVlpCnFfyRep9q/YAvG1Q0l59pZqgOkQf3TxZOMHyGdGWSMUjHYPsP45pij/ktLl6g9ROnyj9zwMYs69AwFWrS9WjiMG0mo8z9KFkKJrNJbQcfrep3el4VcWXZ0K8tnt9KkbBtJy7caF4gX3UIwvvEWKCNoRVxzvXSXfffuHK7zGPrrd5nl2c+NQ+je4pj8axZpll6B2S2evEPwz6vpoSetmrhmcodHTbL168wAFNF69LRiAB9GvD6ZgzvPxnFAEKGrWshnkgUew3oHC1LPPf5J3QvEx7K1TQzoUfQsjlwnuHUSUOrF5aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b+zbLIzO; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b+zbLIzO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPcXh63KZz2xlL
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Jun 2025 00:43:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CE870A4C967;
	Sat, 21 Jun 2025 14:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B6BC4CEEF;
	Sat, 21 Jun 2025 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517008;
	bh=QA1Q+5+OWk/IBpt41mmGU0DCfYU/ArkXG9Bg8q8JztA=;
	h=Date:From:To:Cc:Subject:From;
	b=b+zbLIzO0J43borKo00gg/t7mXtKgxU+nMX3NcYdJjwofllG/aH0hfnNLZSfe4eDd
	 4hgyW6f5NPADqWQ3g+72XTI2wfFeR8c3/OXS86H9cbGMdj+xZm3fQCvN0Ov+OXd2xQ
	 FfhGj/k2ry7Hq4N+roflpX09RICkA2+g+AtSKK5QpHS63DkznSNG0ZtBC/vAx5PRH3
	 790rsxUf5i+6y3eFLOLUiKgwvIy73he1HYs1nWptwJiDsL/x9XwgU/SFQuI+w+N0Dk
	 ZSnGWWax9t6Ba354tWmpiWrTIrEhJQu+M7LYpgGxTpOvl2g1ADEjFvTdDvPPKilHrR
	 9nLfN0P2nQv6Q==
Date: Sat, 21 Jun 2025 22:43:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.16-rc3
Message-ID: <aFbFC3q0SNO7ZkQi@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider those fixes for 6.16-rc3?

A few miscellaneous fixes are as shown below..

Thanks,
Gao Xiang

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc3-fixes

for you to fetch changes up to 417b8af2e30d7f131682a893ad79c506fd39c624:

  erofs: remove a superfluous check for encoded extents (2025-06-20 23:41:12 +0800)

----------------------------------------------------------------
Changes since the last update:

 - Use the mounter’s credentials for file-backed mounts to resolve
   Android SELinux permission issues;

 - Remove the unused trace event `erofs_destroy_inode`;

 - Error out on crafted out-of-file-range encoded extents;

 - Remove an incorrect check for encoded extents.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: remove unused trace event erofs_destroy_inode
      erofs: refuse crafted out-of-file-range encoded extents
      erofs: remove a superfluous check for encoded extents

Tatsuyuki Ishi (1):
      erofs: impersonate the opener's credentials when accessing backing file

 fs/erofs/fileio.c            |  3 +++
 fs/erofs/zmap.c              | 10 ++++------
 include/trace/events/erofs.h | 18 ------------------
 3 files changed, 7 insertions(+), 24 deletions(-)


