Return-Path: <linux-erofs+bounces-600-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B5B02C55
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Jul 2025 20:14:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfcDx3RyHz2yRn;
	Sun, 13 Jul 2025 04:14:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752344097;
	cv=none; b=b2TLmXPunpUMIwqasmC+WzviX9nX1tEoMpXloj9qaRAB9XkwMOC3HtexVb1sxPdny4Tw1/PGPQaYHxWkoTtCLN4j/Ns4b98kLWuAqW4olL24F3EwrjpozYmCxghEGoIvS273eV9uUAObiSbU3jbR/iiT3NSM1QIWUQvDPuFtLJuL5vub2jzf2FS4BX8aG4MforIQkAbFxKp7wd92+1bL0g04uiuV28mJ70img3hiQsMlUQjjqzOqQcTgN2vXvVlBxoaqK5S2CrN8PjIW0kAb+8CGFXs3W/SV3+rAvo/666iDzmsgL3ZUuqshezo++8ApcN3FgNxSUCtsmk2Lt0ncTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752344097; c=relaxed/relaxed;
	bh=cTXtQl2w72HtnRo0tkCGwn6tM3V11RzVVn9rWMa6H2s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ecq8S1HGaj5DTAd6vLPL/DqM67gwZPr3rzrogKHmB4SvAO2Vu8CZ8UqTOhs/inflcochDc9DNxb2aJWROXyKfMP2/C3IT3zEYbn3yS6BcowR86OwTBX2b+VQscsEMM9giJ94LnmTvXYgjMFpgpB1bfR2PqleXBB4CkFt6ygQD9vPyx4xIASr48CD8gBE398w5cCtBumYnELO48N/BePQ3T8nFsE5C3aCJiAtZD/LePmpxBjH47lCzXh4bBy805df78Wz8GUxFCI2ntgzY3TNAqckne/xgIOqELuIdjyARZLvDQs2/bkRWaQZjzWGyqSMzAafP4oEJlw2qFONaUEj4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KgOuigec; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KgOuigec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bfcDw6c3Lz2yRD
	for <linux-erofs@lists.ozlabs.org>; Sun, 13 Jul 2025 04:14:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 037C55C4C2E;
	Sat, 12 Jul 2025 18:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30FC4CEEF;
	Sat, 12 Jul 2025 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344093;
	bh=kdFAdGwoMszgWNtgiLDa//5zXP77tT6O0euO7TMeLh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KgOuigeco2c+rDrZdzdEIEKQeH5WB+H4g6QR0JVmKtwP13k7Ry5WwYFwhN53ScbF8
	 ILFMr0ob2b8+ZP/zB00Bqiejs9sdwc4KBXM+fzZwwF/xbTMmIKtOvm43oFIKvUZeVv
	 IalU2xH12YkbKP3+dtCZRRVq5/sIhiHqFuA1+d3jbdBGU2v72IoleGykce+XUOixO7
	 QAIBGdyXo3DAbBs1wuAdKducu7jJSiEWnE307NoBzA1Y8JDEnhUlD1faRV0sWzB6pW
	 xh5Dz86WjAJWQOWMLmcsv7PrrDk0pUl+yPP3g8CVNEdB4NJM53HcT+rG2kkzGx7s7y
	 4uWAjZaI7WxFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71124383B276;
	Sat, 12 Jul 2025 18:15:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHKCLQaEYGPRR6mN@debian>
References: <aHKCLQaEYGPRR6mN@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aHKCLQaEYGPRR6mN@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc6-fixes
X-PR-Tracked-Commit-Id: b44686c8391b427fb1c85a31c35077e6947c6d90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b428e1cfcc4c5f063bb8b367beb71ee06470d4b
Message-Id: <175234411505.2616006.3550691267364268376.pr-tracker-bot@kernel.org>
Date: Sat, 12 Jul 2025 18:15:15 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Sat, 12 Jul 2025 23:41:33 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b428e1cfcc4c5f063bb8b367beb71ee06470d4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

