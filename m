Return-Path: <linux-erofs+bounces-1569-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B1CD9B81
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 15:49:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbHwX0h4Mz2xlP;
	Wed, 24 Dec 2025 01:49:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766501388;
	cv=none; b=irRmRZT5tfMj6rAH+jTIzJ5ZFZFmcn8LHyZqKPr+5G/cqXuseVl5yvgqmFBKC9WlIC/9Z/3KqkIKg0R3MMbpNgKrFzcs1aYZCcIE0F6a+Ehq1GJP2R/mbelaBLiaMBB5jXsBGol1NU0M0zoOfs0GTmWIzI9y/XtXeaFpT4MrnDhQi40w64LX/ebz4vRUuvq/jRGJXi/7CRkE0UyBFBbEo1yK2SmnuHlhCUKRs7DCl26NDyUjKroHQT1olieRmsByRs053RHRCZNV2t4D8C58EG2ovC1Dhglx371cT//x8PmZU04PcX5BG+AXUcDwod7iibH+HVSBNwPgYr59BRN1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766501388; c=relaxed/relaxed;
	bh=sGBxZRoj/z5YK5kVQwVByCOiouYitfFOUuzE6yAIxSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FrtMGX4sjbJm5qvRLZgABKcxD2VUiqEOM8av3SZm+HS1kuUbkBRg1MPZ32JWLBobv52zYIl6U0vQe1xdhLBDxtOIo5fIGgZTm8YyPLD/gQXD7oAveaPVRefkm0KaCP6bVoTLnut12Xio6yUmuy53w5YIWBcvjn5X7LVJqPwrU2ZdAgSqVenI4PxSF0nhBte+Gqvsv7q311LRFZJEqRtN5B+sq4VLgXZCl9cT/vdn85bu8eUf8IcGtPOH9V7FGp/5mOGa7CkbjkU5UlsuYuFEVn7/TntXGUGBot18UWHbzzniV6VaR5lldEVDxQ7YViQPSZS3HuX+GaYoDP0wH7I75g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GOAzHfzL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GOAzHfzL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbHwW1x7Zz2xdY
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 01:49:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E7A1960123;
	Tue, 23 Dec 2025 14:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C27C113D0;
	Tue, 23 Dec 2025 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766501354;
	bh=V8otbR5wN/LW90Vi/sr/EVRCZfPErAzcyVaSdwl6DWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=GOAzHfzLto6vAp6SZ/TjZzdJcxsNQE5or7D3DJGf7Bmv+k1FWhJ8N0nN4Ik0F+qOO
	 D2xmHHJc/pQ+/D/TE9lRFe9yyXT/vJe/pD6515mbYBsmdu8/BRW+b+R+Qvm3WR7xxJ
	 c39ALj3X22BTqLV09QwqfS3+c0PCXxSSOmsuspsAlVl4n2eZI44HGr5mbOvkB7UM2O
	 Heaj6E6UNr+K5nrqxaAqxqLe+RTnmHoJhStIdz5QWjQ7GwCNP5Zw8WRC4t3ksKRnZc
	 faYRe1bhIVqnssUG9VFxRkzMymY+iuEX1S4Mgs3OS0Ys2GLyHNowImWk++hAoIfr1/
	 fTV9UOvfuMiGw==
Date: Tue, 23 Dec 2025 22:49:07 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Junbeom Yeom <junbeom.yeom@samsung.com>
Subject: [GIT PULL] erofs fix for 6.19-rc3
Message-ID: <aUqr46Y+AqmkowXu@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Junbeom Yeom <junbeom.yeom@samsung.com>
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

Could you consider this fix for 6.19-rc3?

Junbeom reported that synchronous reads could hit unintended EIOs
under memory pressure due to incorrect error propagation in
z_erofs_decompress_queue(), where earlier physical clusters in
the same decompression queue may be served for another readahead.

This patch addresses the issue by decompressing each physical cluster
independently as long as disk I/Os succeed, rather than being impacted
by the error status of previous physical clusters in the same queue.

Happy Xmas and new year in advance!

Thanks,
Gao Xiang

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc3-fixes

for you to fetch changes up to 4012d78562193ef5eb613bad4b0c0fa187637cfe:

  erofs: fix unexpected EIO under memory pressure (2025-12-22 00:18:53 +0800)

----------------------------------------------------------------
Change since last update:

 - Fix unexpected EIOs under memory pressure caused by recent
   incorrect error propagation logic

----------------------------------------------------------------
Junbeom Yeom (1):
      erofs: fix unexpected EIO under memory pressure

 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

