Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 43D368CE8F2
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 18:51:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STgF2q6O;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vm9ry5sntz87gX
	for <lists+linux-erofs@lfdr.de>; Sat, 25 May 2024 02:45:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STgF2q6O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vm9rp6sKmz87dd
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 May 2024 02:45:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9851163215;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A278C32789;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569127;
	bh=ozTP1Gzp6c9BpT25/+sBCPNKeJIm8Q21Qstys50GJCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=STgF2q6O6KFzjP9KG6Lkslrs3yQ119HQlsBpTVdMqvUWYrVrvDxL1mrmILCZxqh2k
	 EZKsCWaNCzYIR/qZ+WmpXrx+2Wvn6HugHK/YPSe33XR1CMLyWGGhI4NP0jvzuiSi7W
	 sOzRNGYxxPKoLd5QsUl0CcEdMi2JetiKvkMIysHSBQUqCDe8ArxIpNvq8DeabGNS6b
	 ygUfDl3ez70nP9g2KiH4Kxq9laF+U5rhMlEm09xH1oiwHSvoWduXD88CDS2xpCqW4b
	 titNqbmZEha7DsGn/9VNfdKXN5U8wfa4u4XONs2ZDgORou6HGK8eJ/EwPoHJMQuDB6
	 mn3NGnGZUZUBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC56C4332E;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] erofs more updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlCc2s0h0H1v16er@debian>
References: <ZlCc2s0h0H1v16er@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlCc2s0h0H1v16er@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2
X-PR-Tracked-Commit-Id: 80eb4f62056d6ae709bdd0636ab96ce660f494b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcb9f48667824399e496113f2374d08e6aa59770
Message-Id: <171656912737.29701.1703227778398439623.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:27 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 24 May 2024 21:57:46 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcb9f48667824399e496113f2374d08e6aa59770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
