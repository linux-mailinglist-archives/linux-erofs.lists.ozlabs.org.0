Return-Path: <linux-erofs+bounces-199-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DAA87325
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Apr 2025 20:24:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZbJhl4PCFz2y34;
	Mon, 14 Apr 2025 04:23:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744568631;
	cv=none; b=LodFw61syoOkHlkf429uwEMmn52J09ug0nJaqp2YMrDqiEXRD2r8UW0Ke01fmqar3JX1+TmRYRMZf2D1e0DGDtgf/m3aMzYVP8/jYxgB4YhzX7Z3xxeU9i8rO6mTJzwH/6w83irU9+y5a1xE9KnBB30s4rnNYhXxDHKNcNP68TSJyMWyadnt2OCYumCYATUSELXDUrtASKgSgaW0lN7aDF/7PMwLqNsOjoN5OTou71WHOfS3klNAw0OURQMhFVgO8iAgpE78xkPHk8jjaItmrCMo85e3irFYpIEM9Xen3f2MlatLVQfct63hpirODKXXIctqVIianLM3JtLsiLvq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744568631; c=relaxed/relaxed;
	bh=j/fjrDF1sX3H6oZ611f61fh5Jh/kltrHQXZ6DqEUxDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dvVGC1RFPCo4Yui6RJRhwCnP6SUwG5gYQIcSrpV+b8WTObiSGceqCGgxxybdXHDjlCiWA4wSh7g/913B+5+JABSZRNtQ06NFGGFnQ9pLG5zREnwoXhY3HJVmzkdhg47WTYY5vLuSu7Qh6q9FL0TazwbTM++UZ5sfRe64J3jZ6zyl1MTxqJLBqxR6R0g+WH1KUwklCKEL+yzB8x3EfhzKqdvbVQmTMALjISBaIePuJYR9JI0yA20A81n5G5Dg3b8jb02wRfoiBbCX/KS/WLM9rwsqYiH+hfqgVIH2pl0cT2eo/ps1vv7uM5b5V2E8LKXmBiJGsTV7G8ha3bVI3L9iEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gVnTmVkY; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gVnTmVkY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZbJhj73tVz2xqJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Apr 2025 04:23:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ABE32A42E6A;
	Sun, 13 Apr 2025 18:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64976C4CEDD;
	Sun, 13 Apr 2025 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744568626;
	bh=jEwpVw+oHQmNW+ILSw2idMCiUVWbHMNleBmVtQjVKng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gVnTmVkYKOabHix0WGUzuFrTlVZ9ZeuTXAHzHpHoPYCF91d2QXgTH4klunH2pdkq1
	 qYTO3ZuihCYUmXhOog/bs+j5NHxN3llxezu4YHVeSnp4xn6oG+4BymiWzcPjsacWwi
	 hEpGr9cVbqo1X2VI4AO77eh8aC12txRMhjyeq70ZlpNnjFSXAX8+JZKsamzZ0azQ30
	 AbVD3AynGfIdGkmbsorYtuC1j0Q9iDAyKzweqBiFvKd9eecnf/IsJ8/IjwxEU+mRJl
	 ttvTgmibR3Jc8WRq7nZtO8A3s3MuF1Ej1cBV8NO/b1cQADIO0mLcpCFmQKl/emQ5Bz
	 9i4/icB97sJXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710FC38111DD;
	Sun, 13 Apr 2025 18:24:25 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z/vubg+MYaiszHm2@debian>
References: <Z/vubg+MYaiszHm2@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Z/vubg+MYaiszHm2@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc2-fixes
X-PR-Tracked-Commit-Id: f5ffef9881a76764477978c39f1ad0136a4adcab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 004a365eb8b9c6d7d409bbeb5687a4a5ebf8f110
Message-Id: <174456866398.949293.17563812017915309732.pr-tracker-bot@kernel.org>
Date: Sun, 13 Apr 2025 18:24:23 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sheng Yong <shengyong1@xiaomi.com>, Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Mon, 14 Apr 2025 01:03:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/004a365eb8b9c6d7d409bbeb5687a4a5ebf8f110

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

