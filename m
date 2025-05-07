Return-Path: <linux-erofs+bounces-300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E295AAE7D9
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 19:31:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zt2Nf0Cksz2xRt;
	Thu,  8 May 2025 03:30:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746639057;
	cv=none; b=J0Dd2rVchXbeaAu6Hg2Zh4j77Lwrwzby+CZXQUJjrwVxFQHIDIvVZNqndrkflfzR8Ntz6TZrOQHGPVNhUStFMxPTsB7zKL5tk8kQbKIGN8kGn/nIgagpF7A6BmqmiXPVswxAi6bU6WWRrHx8z6FZjJ5GyDsDuVg6ywF3bmDo9yqczWg2kMOSCxhF2Er8Rr0Fn2jnSahJulhQH94aA2Y+SYEgOJp/lckWtiOxxK90QRsxxR6K7izKJrY+k6KYrGYLgeTKVvnYGA6BIJ4bv2349B89EEgn6T/CkFC4W2u9fA6xvd2rxRFx0xx4FeiDbFMifQgKxJ71OFZFi7LpOi5jpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746639057; c=relaxed/relaxed;
	bh=PthYeTfxRl40Ly/Ams7y9AAJPCEU9KpmSmVFpjyvLFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K1/uGSLn84xeK1uXR3CpGpMVMMMwSDcFKmzAWK3OKugL2TajbSzwQh1/iPqT1y3lrevMc1vFXOiMsOKUJ5FtQaYdRg1l6l3dTI+4PWtb8R/YI0fw+dWyT2BNt0VbGTr43sBeFfz+o68NDWz0370O8ngXDzBFUv2AP56JF8cl515DT8LksNzG+27AccjD+JGaacj4qfx5eX0L725Fdpk3GN+lrBiwfkzOS9CqTrZLAiaNVnDsHW2hdvcxkxVNFCWkqR1dbaUslvjgKw7vjXAtE2P0pUDqWpO5tjC6Ce2n1jYv5Bn/znvjQo8wtEo69dufwdxBSa2h9awLYJXCJcIB5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n0PivgCe; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n0PivgCe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zt2Nc5q94z2xCd
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 03:30:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7BFDA5C5616;
	Wed,  7 May 2025 17:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC6DC4CEE2;
	Wed,  7 May 2025 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746639054;
	bh=vDoLSsEGBqiwZ4UyTZJM831Y9USsC+8B3Lf5FH/G3PA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n0PivgCeozcKwBKR35SQ2Ev5F9Ww1+JLBANUurjLf0akbpLPkjfaAOV/eTJ37kYGb
	 9TaIzHJ/bDhvi3mivBFVIThKiLXKJ/+fDVxqT/YFd+HTjt5LRjXmBEOYvIW6xNgmUw
	 nNVDXIAA8FOLXDMJ/9/q32z13S3IXS5j5e4lLqPXv6w750oYcTojnTtEzmxxAMnvXy
	 Y3AVBVsKmR10qyqSvQM+eX1u0oR3QF7t9taGl4fGIozdg748HKClgsacnBjV8nv8+V
	 5lixAkY/pS4tldF5AyG/v8vrA1moKYWQt3NR1Xzh2B+J16DM/3vg+N0Q7+xdKs1Udr
	 Y9CP88O0XIWFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E8380AA70;
	Wed,  7 May 2025 17:31:34 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aBuUXWt2bnmMBR1B@debian>
References: <aBuUXWt2bnmMBR1B@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aBuUXWt2bnmMBR1B@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc6-fixes
X-PR-Tracked-Commit-Id: 35076d2223c731f7be75af61e67f90807384d030
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
Message-Id: <174663909308.2310785.16255285179931253199.pr-tracker-bot@kernel.org>
Date: Wed, 07 May 2025 17:31:33 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Max Kellermann <max.kellermann@ionos.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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

The pull request you sent on Thu, 8 May 2025 01:11:57 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

