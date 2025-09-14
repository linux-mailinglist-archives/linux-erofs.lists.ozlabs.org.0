Return-Path: <linux-erofs+bounces-1029-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F130BB5640D
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Sep 2025 02:41:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cPTqX0Xpmz30FR;
	Sun, 14 Sep 2025 10:41:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757810472;
	cv=none; b=UtJygZrmLn78LcnEyg1wdrgq3IUBgAa6lLgrxjQlQiFPwvdazaXZnJV54qWc2vkFlfimuHc5eLF/jXBvLz3O7PaFaaY2dy1MzetKfRDFtgpPjYARWQzoywxa63CBZnaUM+p7BiPBToFfHGEs5c2ohmjzhGMuZT+QKx3UHb7FQQw6gSRVsZGcP4nsbcu+Cnn/7C9LRPCfU+QdVRXt20MJ8VDMte7z9n5lhU8nSz2yct2tZUAoopoDx1VCXPb/kVXEa7iJJCLz8nj8Q72mUjVHH2f/efglx2kGAfPzOZcB+FG+Oe79XnVip3AvRrNJxpWB4aVKXDRgRSf4MUidrxngtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757810472; c=relaxed/relaxed;
	bh=EupQ4fwtOeRZK5UWvMFU5U6NGoRR2mCvOQPbLpO62nk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q7wbMNJ3st9P/iDVN5MGiYvMaT2OWkMmsIrWI5TRavbljIOze/66CXy/ubHnaiFt5QcjxKdrjwsAG3bHpx46qtFe4K/F5o40yBFMiAHpl2jfGzXsj4S114LRjB3LUMiQyTNZDBQTaL0wdOLUK7EQ7oT1/eylSw0OwOcgvM6MCZZ9RJUs+vob+QEXXqepyR8rG49s2qhPsl3tEFgtxckDtskbyWQYgAL27YiF880dN2G2H8YKkWw9/4oPG2Wb3L3UkFZ2WDP6/aaX1z+lho/aT27tDfk9sWANmdQ9TO8sXeAS6Iu45Sj+lHF3nPL2oscgG3HI6Shjzxa3PiOUhJhOZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B+5Lqycv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B+5Lqycv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cPTqS4LrCz304f
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Sep 2025 10:41:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E15EB60250;
	Sun, 14 Sep 2025 00:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7DC4CEF7;
	Sun, 14 Sep 2025 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757810465;
	bh=OAUb8ZvYxN36zVsX7xEQ0Pg09I6w5MYWXOCYnHvxvNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B+5LqycvwYenDk0DWunYKipABIPpLnJoz9Mv6/l48ucKT1FIlZ9ryHsP5sJk9KxSn
	 txWhYuB2oEbkElnYIZTBwTUBVU79L5SMphB+IKkpMWk5sRUIeu660AZUJDurSNzZUg
	 B7BtCJMvHuURV7EryaLLoAUicVFGA4pEC+5Fm3rNV13A58R32eKab7S09sAWenYoba
	 JUvFmZB6W/hQ2gffNRoPVU5as9jaDx/HnVOIFsxo7AvM1nU8hC9S9Ql2Y3U6dMhW0u
	 gmnrl2ltPZ1CfMWUS238vase3Hr8xpR2xzm3p8BIjW1SEz8l8HCcjKZu0cBIiLTe80
	 sZnBBwlQ9uWbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9B383BF4E;
	Sun, 14 Sep 2025 00:41:08 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMYGn1hQjWaQCaiM@debian>
References: <aMYGn1hQjWaQCaiM@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMYGn1hQjWaQCaiM@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes
X-PR-Tracked-Commit-Id: 1fcf686def19064a7b5cfaeb28c1f1a119900a2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f83a4f2a4d8c485922fba3018a64fc8f4cfd315f
Message-Id: <175781046727.3349841.6826201067650734287.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 00:41:07 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
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

The pull request you sent on Sun, 14 Sep 2025 08:04:47 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f83a4f2a4d8c485922fba3018a64fc8f4cfd315f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

