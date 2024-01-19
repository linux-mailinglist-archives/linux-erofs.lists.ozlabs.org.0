Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB35832366
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 03:40:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iHx1d36j;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TGP4205NLz3bsS
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 13:40:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iHx1d36j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TGP3v17KKz3bZ6
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 13:40:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 43657B818F0;
	Fri, 19 Jan 2024 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E913C433F1;
	Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632021;
	bh=3LQLFqkSRwpBdrvgaAJzv+QRr4GqaLfcGn2KjUktbXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHx1d36jRgOWao3gPv4TmShkzfW0+uDB+zPKNzHT/9qPlLrYxR2rVwlWBUNDx3sBc
	 4IpLHSdr+nAPY2qI+sPeLzJz5Kjccq2ifPPmBJU2uS9LUPLYuOk7N3xe5HzkITOxAv
	 D54rm9JGL/XLrdw8EpfcdfFsn9Ub6V2z80uWsAbIZL/AEvjYJAq5P0yuy25r6046Px
	 fL1pqpf9grbKn7Su+ASoOb3aE+wJB6kZFa9GFPbsiEO5gcW9jIRCgzxDkl+Kw38/tB
	 jKCNk9/wvYUto4Np2TzfuWTrF3F8HrQIydq4b4plXtoDrJNsVKkh9QQrb0J9rB8jCc
	 Gw4rlupbTOZBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89958D8C987;
	Fri, 19 Jan 2024 02:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalEiKJWhdH2D9JV@debian>
References: <ZalEiKJWhdH2D9JV@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZalEiKJWhdH2D9JV@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-fixes
X-PR-Tracked-Commit-Id: 2b872b0f466d2acb4491da845c66b49246d5cdf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3625006b157c5a460970ca4d651b100bfa67bf
Message-Id: <170563202155.16016.7679623835755808959.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:21 +0000
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linuxfoundation.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 18 Jan 2024 23:32:24 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3625006b157c5a460970ca4d651b100bfa67bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
