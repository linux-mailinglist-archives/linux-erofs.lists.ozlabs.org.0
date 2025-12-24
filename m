Return-Path: <linux-erofs+bounces-1601-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A6CDD03B
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:58:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc1PL4Ss0z2yN1;
	Thu, 25 Dec 2025 05:58:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766602726;
	cv=none; b=UROG9aziFj8QXcy8U9kAb09Kh3eXQnFmvmi14TqSJMHjwzPv0Cnnp+B7B7J+w2QUTplOkCr4kI9gSrbV1cCubjB/bBuYSKoSKpSt46ynA00jLkMPb4jM/ihN78O4dAEoMGnQ1WW9eWkzF2PrCvmJOkEWFdQPsCs43j3DWJRW52bpf84EJUcZs07diRyzh/LXG3D3wifIQnURy7CGjy8YHRnBPUWK5FtAkor2kKVBhjBywFRowGdwZOB977IKb48QItDtsiAsLfjE/wTdx56k0AXlFpFcdc0W6mpfsq7cr6np+hy3JlhLu//8My/5BnfK50M9jb1rhSrIHyJ/1ivR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766602726; c=relaxed/relaxed;
	bh=4dX2IEj3JbEF7ND4yJ5hfEn72izuVibjy6S2Cm8eksU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MyMfZmzAyEDyCC+Gl09b3X7Ct8Jb7hUCaZtJMJGyE0SxnudwfWWcD41W6dhn4fsx2Q3apulb4tJ4pvc7p05B/AoFC1SN2X74WwAEu/9Hcg5ezr4A0blcWWew/sx0Qa+ofolU/t4+mFr2OLv0Ue9bJ/FH4ywCYcjLfGHzvrNageBudWNvXN86Z14tfvd7KRWGixachn+gyYzhDxRAHE7H2hqCm4Kmb33KavBJGG3SbT2Utirhu2d5dEGz/RIy3Yfl+FlYSKKJZrKaVOHVNPWCHeuyrfTU/J0fBf6B1skhIiNeID/Zcbqlgsid5h0hBsZCdgS3O9ZUj9ZLhxmWEKSzQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lGkQpWgP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lGkQpWgP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc1PK6294z2yG3
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:58:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 096D54430E;
	Wed, 24 Dec 2025 18:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC7C116C6;
	Wed, 24 Dec 2025 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766602721;
	bh=wFO7j1HywCC9IEA9kBCM+4C4nnquimPdDF4DEJ8Moyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lGkQpWgPRrJnnTFva4S4hoIsrjhY1/hPm36QcBktjOwgeNEw/dVWkUnSuKwG6CL33
	 bBTZwg752BwpFVYFzXWrI/XoylXi6zFQq0nuou9lBymuUTyDzY6N1o53m+SdGxQJic
	 YOIwu3IxoEWxPnHG/JPsxRI6bHa0/E7ydvQO4T9MGrwgxaQHJy3IrUKXYZY3+/WoHW
	 gf5L301cBZnyCsSvcW0Iiw2KPaYAydO3H/l9/85KUpWlTMna+xeJ0PyE5D1sK58i9v
	 4BUBDElEMmj1sBC/F9/Q+tbektIOH2JJOaSDIw6KUxKFQJw1EIckI+Z5Gw+U78jvB+
	 YM4gbUbNCYxUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B590F3AAA0CD;
	Wed, 24 Dec 2025 18:55:28 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aUqr46Y+AqmkowXu@debian>
References: <aUqr46Y+AqmkowXu@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aUqr46Y+AqmkowXu@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc3-fixes
X-PR-Tracked-Commit-Id: 4012d78562193ef5eb613bad4b0c0fa187637cfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce93692d681e89d2c31aacedb055c4638deb1be9
Message-Id: <176660252723.1574379.18220891508518710689.pr-tracker-bot@kernel.org>
Date: Wed, 24 Dec 2025 18:55:27 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Junbeom Yeom <junbeom.yeom@samsung.com>
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

The pull request you sent on Tue, 23 Dec 2025 22:49:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce93692d681e89d2c31aacedb055c4638deb1be9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

