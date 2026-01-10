Return-Path: <linux-erofs+bounces-1805-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29370D0D058
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 07:04:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dp7QH5sqjz2xRv;
	Sat, 10 Jan 2026 17:04:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768025079;
	cv=none; b=AaxLxmhcPxybHLCm62QXnp+a9zIFQD/fcceKf3VlAfqhKNmQFTzTdCH3VVYRlWKtkEJONfrA8nTSKpUmiN0b2iVG5IG2wXEEV9Km9hekgMDVc/5F9DOUX5F5nPRKkTY26jA3Fnmc0yzBly9RfarJOxIRxfQIjoV4AysdghYN8ifqjNdODJ2H1cj7lekJlU+UYM227r/rzBydUO+DkkcXjCrUnEYOt2t4TLuaSAL0ItcnLS7vCf1ZHwFqYvTMIiEDOpdebSiEqQoJ1qRSuUNq+SkimWzGnWIAypAUZKAsiZ/dK1NE+W8e5NAL78eMjEUB7eJho7U+/rONcTqBUrIucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768025079; c=relaxed/relaxed;
	bh=YIdoW1uqPnPlIu6ei3GjTFHz143Zw3KJa46HheT1VDU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XZ8WlG+G+XEptEpj9k5wS9T/6jraMqNrZ3g0haxOgrofNZh/U54LfoczAYx1twUGVhXzdP/+7FMJYwrPHkr4ItLaFuW1XdL1hqFYWTtIm295JGfCOgT9l+ex7X3F3gutId9xGIco9VxaI0hPX/RXI/9uxPQv7aRi6iLjEHq8USBNNrdb+bUavuSGwsuTbMGYfRqSK8jhLEBg0O/rW60H+uOqpLW83gz2+ZmVoaeokS5b5lWwouW4uIvPN+KUSNaDt+pv9OQpQ9/L6X6GLAfANH6DtBzsHiRh6FBTt71XkKvECft1nbyuvb3bWK/crEgy1I10DejULBt0apK02USEzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LW7s9a9G; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LW7s9a9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dp7QH1GS9z2x9W
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 17:04:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A06A600B0;
	Sat, 10 Jan 2026 06:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F6C4CEF1;
	Sat, 10 Jan 2026 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768025075;
	bh=uva8fEbJe+7z0uvXFT/0Lck0PuDoZZ7bKPVLm3tDGS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LW7s9a9GLaV8A3FjZLoG5eJKEstug71NvxfBcqOMYp2LYaWbd5bLnuk1mHnrCQSAK
	 HmHzyazOSRpjrn2jgwkXkCJSlKdKTjQRpBCKH8ktLbkYpFZtWfa1D5TIMKgISlNUSk
	 jBTHTr0NTjp2GH6UeMGLbDHE76cUGwc9jeQxcwZmtjkmLx6BySdj/KU+Qvm/pgUOpp
	 mBXZYf+THFxmRb1AK28USdRCFzni7ncN+WjkWuZpQX60dj+D6n+UGcI1dOiZmBrzpp
	 L1Rhqg+KbMSOlvYadOSkhZ4/Q0lwMKFHchVeggFOgW1/ILUSEJNABXPVrS3E7HU/Q5
	 YVcWzB4XTyqWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78E6E3AA9F62;
	Sat, 10 Jan 2026 06:01:12 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <aWHibOkAT18Hc/G5@debian>
References: <aWHibOkAT18Hc/G5@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aWHibOkAT18Hc/G5@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc5-fixes
X-PR-Tracked-Commit-Id: 072a7c7cdbea4f91df854ee2bb216256cd619f2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba
Message-Id: <176802487104.497868.10703084032360468484.pr-tracker-bot@kernel.org>
Date: Sat, 10 Jan 2026 06:01:11 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>, Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>, Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Sat, 10 Jan 2026 13:23:56 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6151c4e60e5f695fac8b5c3e011cfcfd6e27cba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

