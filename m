Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9D879E73
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 23:24:17 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfi0oUT6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvSqM1nzqz3bsn
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Mar 2024 09:24:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfi0oUT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvSqC5PQVz2ygZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Mar 2024 09:24:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2D04C61336;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDB98C43390;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282245;
	bh=NDwBSQ2LV62fTEQ0G2MaEUwSk9ffYrpsVoU2mBwIPqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jfi0oUT6uSOelnJtwvxB4B0z8hn4bDacFzcK7GRQ0lJfbUqP3yLsTWxl095UhuFQb
	 Yxxe3GJJ5SRRHgYa3KTyC/sZp0jAns3h5YbnJv1IAdyyhBNkWMCnpeODBKk/qMj6st
	 vVw+VrNRoZGsfx4WdUTzGRxVgcHwKc2qiyPYg1n6/oTWsQ8KoBr+jbZNkW+bdbhlux
	 tDMsb7RM8AW9AgA/zvqqsMO/gWNotSlbq9kB+h7mZ/VbOW8rGBjnOumIOSYctBi6p1
	 sCDPLAh0WUlAk9w+lHmK/5E3aQ//au/VP735FEUtxaGyn4xd7HSNV8W5t9IFAd4N0A
	 kLzTSGaV+S2aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE73FD95057;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze/oXlaiQfdspyNX@debian>
References: <Ze/oXlaiQfdspyNX@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Ze/oXlaiQfdspyNX@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1
X-PR-Tracked-Commit-Id: a1bafc3109d713ed83f73d61ba5cb1e6fd80fdbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f153fbe1ea11939e2514ba4b3b62bbd946e2892c
Message-Id: <171028224484.16151.240329771196733706.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:04 +0000
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
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 12 Mar 2024 13:30:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f153fbe1ea11939e2514ba4b3b62bbd946e2892c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
