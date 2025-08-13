Return-Path: <linux-erofs+bounces-814-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2BAB252C4
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Aug 2025 20:07:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2GYB4Qk6z30Qk;
	Thu, 14 Aug 2025 04:07:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755108430;
	cv=none; b=KbY6KrUIDQJ6PX9TFvCxswoK3UOxOs7ozJQZhSYK1cYjFaxuxc5NqAvQ3/tISXl0DRmLX5RrdWLnD9EifxLfoECPnopg1BaPWJPHcNwc8RoqWMp3SkMYddk588xuoK9rKIijo6nWZXkYXs4p/0d0c8IgzdkjPUEtwit8WIfweki2y+dEV0bhVQ+QPHfS4xyftYrcQAtQCefRCFDAOmy37G8/iJIg9nOzxtsW4mf+ZVyB44gyELY3mZEd3phn66RBGQtfqm3v49ULOywchCFaSfojDyh5k9f3FO3Ukp3zjK+EkWd3XUIf4gohhQfnLJAgk59wlWPUI0172wVx8SXXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755108430; c=relaxed/relaxed;
	bh=ITJBGRhamGnyBp/EgHi+nYHEM5kxmdLFtumY11162os=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvA8UWU1caGc57IeCrz5Yffe/3PhEIcKFHDlAUdBDhbqTGeYJhUcVOs+GeU5dxuHhugKuSqifcrW+AlFfczfm+KzanGScXYD14CsbDRc7vWAoZyJcpeBEmnJGIUgwmIIZbE10mcc/sj3eROOj5+fDAAHOLXMLneklVjUC0ys62ZpmZUIaP1BBJRofuWqZiBGM0oI8nRt0UYWUkyIgCXO+5cl7I6x3jnnqnXK8l9XV4zCyu4FhRCIIpYIuPTbn3XfETHUjBeUjbKZCsUMmyyITxJDcZfUz7Xf+U98UH+tnW+bHGy3KZsS2DKA0Vonox/xVMvUpmvtf44nIDCnIsTQ8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QOwUtetC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QOwUtetC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2GY96fd5z2xcD
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Aug 2025 04:07:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1667F601EF;
	Wed, 13 Aug 2025 18:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E7C4CEEB;
	Wed, 13 Aug 2025 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108424;
	bh=+K9KYoI/qcqMa4qi+5gllF4t7CU9GMSaqAwo+mhZGmw=;
	h=Date:From:To:Cc:Subject:From;
	b=QOwUtetCILxOt/fAZivXi9wD1UCcdgpxGkKxgWPIPBCrPprJY9oGmMQKp/PME2Yns
	 MKwY+pj5/CnQj78SQ1AiYQ8/D8uuwb6TcUxw6MaVLHEdUFIdTwcJBjqjSjeXu/YYsq
	 +xmr8uvqxY/Q+EjVP+Ks5oZ8joIbGS9E3sc7MELGmm21ir0YJ2wSumFe5rfk5PxX2W
	 TCbMFWreEEXOsSDKPpmnhe8AsRe3A0rPWIDzJf2DFIxnRZYXRzktipeHKCIBwbv0LB
	 QrGSTIvZiwIEC6oOPdCCKdi2fV9oBp0aCEi7ph3LwVIAy3bEv5HYRmRVnNvtWN2Ikg
	 L8tmSKYi3lmHw==
Date: Thu, 14 Aug 2025 02:06:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.17-rc2
Message-ID: <aJzUQt58S0ZEv0zn@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
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

Could you consider those fixes for 6.17-rc2?

A few recent random fixes as shown below..

Thanks,
Gao Xiang

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes

for you to fetch changes up to 0b96d9bed324a1c1b7d02bfb9596351ef178428d:

  erofs: fix block count report when 48-bit layout is on (2025-08-11 06:31:19 +0800)

----------------------------------------------------------------
Changes since last update:

 - Align FSDAX enablement among multiple devices;

 - Fix EROFS_FS_ZIP_ACCEL build dependency again to prevent forcing
   CRYPTO{,_DEFLATE}=y even if EROFS=m.

 - Fix atomic context detection to properly launch kworkers on demand;

 - Fix block count statistics for 48-bit addressing support.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix block count report when 48-bit layout is on

Geert Uytterhoeven (1):
      erofs: Do not select tristate symbols from bool symbols

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

Yuezhang Mo (1):
      erofs: Fallback to normal access if DAX is not supported on extra device

 fs/erofs/Kconfig | 20 ++++++++++----------
 fs/erofs/super.c | 28 ++++++++++++++++------------
 fs/erofs/zdata.c | 13 +++++++++++--
 3 files changed, 37 insertions(+), 24 deletions(-)


