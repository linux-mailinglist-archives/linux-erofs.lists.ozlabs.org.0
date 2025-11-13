Return-Path: <linux-erofs+bounces-1363-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF6C57881
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Nov 2025 14:05:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6gVd0Kmyz2yvX;
	Fri, 14 Nov 2025 00:05:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763039128;
	cv=none; b=OjdazOg9O0wvvfXAZLlJH6VOBj+lYMGpA3G89oIjq1LiRdAa8ha1c0/TzL+LoWq4zl7dv37ZpPO3Ctfa2l3fI1i9ACZU5xRtX3fkkMFatdFXshBG2PLy/modx34gJ5hggz0WOCugjZiJThHtvZ8Euiik+AJeNiPbSFn3fB60BHF0rsyp+IbmH+TvAQXTANtk6VeeKzQI/a0dGlyDVUj8oCrg4R5I0XVgpIwdy+r/SieFJfLKpp9UuA0/7eJFiQ4WIPr4I+FPmmdKfbwBqeTe2UyGk1Y+R+XHnh/U/SEHji5XNgLIOsGlmUaFCuzd4JrTRCH3Nj7XuM1pas3MzJUgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763039128; c=relaxed/relaxed;
	bh=Yh7EABFyiNYXKwmTy9YK7JnXwxn4N/Ra0p2lK3sIBz4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HsvdVmqXuzAKDiR/SVdKjYTUSwka25v2qy+c522WgVr6MJfepDM0fl82h6PwSuZKuCXVRRGMyrVGEhljoJiBr9rVfWOQd3RHLnDZx/smlmVkRDyaon1vbQfcoSCY94Y3plp7wYTzPtWJ8qGb1VQA8di5kteuqYO8PvXA/JC5rvExz0a/Z4ispxrXT7qcc0Jjd18XjNe3WiC3rxq2B+i2ubfJpKNqwZ4bmkYCOFrD7hk0RkYfRWzc34MVquxMAgd9CaHYfi/LVlXcF2SIcefAC4QayudXy+MqZGKxSWbEd38WDwPDomGH9mLWrk1w3kjdTT/PuuUykD0VqvxHiXAnYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oTEs9ZhB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oTEs9ZhB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d6gVc0TvHz2yvW
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 00:05:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D97F4601BB;
	Thu, 13 Nov 2025 13:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EB2C4CEF8;
	Thu, 13 Nov 2025 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039123;
	bh=WSE8IWfi37i2v8p8N47uXB4pJyyoZ47u+xWx9rOeJMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oTEs9ZhB0hQeIN64TvWgMlob7Xrb60KxnVO4hkpGc31ikk+JmH9l3kewvv5WhYA8N
	 6xLax9WVyAWuE/NY18XJRPFwtJ4cHU6/M4NrAGTewUutIisOd4caqydg4CWYyyQ0T3
	 LQa07lZeBuClM364DW7t4ypewj7m0ytlgi0onenNIsKulj3HZtdow5AKatJ64g0R3m
	 KodM9rrn1ijbDynsTaPaJepficLUQtXNUy8cd3Xc4+bAnwWkvzsFUYDTJLPRl8giMN
	 PvPa19b7+jsqe25me2ivTwbDzSgnNgshh8Or9Blui5hubRExKLHe6GZfkCOJ/BJ4HB
	 oKkhKknyZXGgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC53A41034;
	Thu, 13 Nov 2025 13:04:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aRXHkO5ema3SJwzG@debian>
References: <aRXHkO5ema3SJwzG@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aRXHkO5ema3SJwzG@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes
X-PR-Tracked-Commit-Id: f2a12cc3b97f062186568a7b94ddb7aa2ef68140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ccec5944606ee1389abc7ee41986825c6ceb574
Message-Id: <176303909244.842124.11811051251466879893.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 13:04:52 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
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

The pull request you sent on Thu, 13 Nov 2025 19:57:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ccec5944606ee1389abc7ee41986825c6ceb574

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

