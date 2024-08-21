Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35495A802
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 01:01:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724281304;
	bh=t4G6nia3WR2L+b69lP+1cA3o7raNnr9DA7bhxtN9azg=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=h4Xon/Dh8qYrsnt/GKDSXP3OnV6FP3U9HiRgvd7q5lAdM9j2pYvV0uQbxbLVqlsAa
	 ThXgp2fx7SeVgc/M5qu63Qdysjy2MMs+/q8xM5hyDIwr0VcYAlxnknnaH9Ng89FdB8
	 ONJcylYXGhXEBcFeulYHe7P+rbbHLN5xdf+Nz/5escQgxxVsN91E4c+NJF3gcVjOpp
	 lCHU6psNq37PXR+bDmWAqXEQMYnC34XFy6mSOgAPRDhAIDyQhUgsINCxs4nqO+JLh+
	 wYZR2G3FBkdb8DuZl7TBrt1twBMomtnDl/vtk13Xa1iu4IDV4i1XV9m6wjTJ3AGBeH
	 GKSaOxTyhQ2pQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wq1zr1SsNz2yVD
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 09:01:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6BjnmTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 360 seconds by postgrey-1.37 at boromir; Thu, 22 Aug 2024 09:01:42 AEST
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wq1zp2d4Gz2xvh
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2024 09:01:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D8DF3A40E02;
	Wed, 21 Aug 2024 22:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D5C32781;
	Wed, 21 Aug 2024 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280939;
	bh=q7ktxr8tTsMhKc/w1B8gsiAP4VfjqPmzW/xIx2RxF+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6BjnmTE3LUGfLCTiq2xL3qvM4zaBhwRhi3ojf+bXGqb8fqaU+5K7RFZf+pveEPkt
	 nbit6C/Q6pX+plsIDrrrydJ3EjglUv+VICF+G+U9VvHPviwVfPKhlKqiEC2DECTeiN
	 KpSmhupPThD1INySWpgwOBimR46r3YjhiJ9KQS9l/chjb9CDZT43tSWJkU1mYRl0Wz
	 ADKwehQ5tLXtSAE1BCPObKJE1do8EQTktDEV/mRMPqHqgxGLFrqNIVTxrvGrACJwhl
	 C8twrbGw4uDZEaWR4mN+xx3ygCnYeYYy1sd4jTlxlp0AsnDYl6kg3TYTi42AKoSSrI
	 qiLq/jh3w8Xqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4B3804CAB;
	Wed, 21 Aug 2024 22:55:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.11-rc5
In-Reply-To: <ZsXcfPaKq3X+Wa5h@debian>
References: <ZsXcfPaKq3X+Wa5h@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsXcfPaKq3X+Wa5h@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes
X-PR-Tracked-Commit-Id: 0005e01e1e875c5e27130c5e2ed0189749d1e08a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c6154ffd40c5bca1eb01f9bf5a4d2b6d18d55bd
Message-Id: <172428093863.1853724.3618790591899091014.pr-tracker-bot@kernel.org>
Date: Wed, 21 Aug 2024 22:55:38 +0000
To: Gao Xiang <xiang@kernel.org>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: pr-tracker-bot--- via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: pr-tracker-bot@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 21 Aug 2024 20:24:28 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c6154ffd40c5bca1eb01f9bf5a4d2b6d18d55bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
