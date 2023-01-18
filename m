Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B45672B90
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jan 2023 23:47:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ny19K3tKlz3c7h
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jan 2023 09:47:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qsdkKqI2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qsdkKqI2;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ny19B4xppz3bcw
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jan 2023 09:47:10 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 268C6B81F73;
	Wed, 18 Jan 2023 22:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FA3C433D2;
	Wed, 18 Jan 2023 22:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674082024;
	bh=nIl9sSo4GTkpmGJJnKmrU0lojQLRNTxIRKzjL5q9Y0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qsdkKqI24JPKCPq8X/FgYhYZPvtV7cUigROIIkwF4A3wJ2FLBvHDEGg531qA0Ir6d
	 Lor4iqqwWKPDN/uN/iBp+bFH5eRa5aHmtmKKw1fTv6tVg1YRLhhXkgnDArVg/ySHNG
	 /EgBDAprpXNoV+PEUXJK9LeSOQyVOCGR55/qEK6CeT4Lgou5fap9URX9Lm1FGHKZy9
	 f+RyoXCqV45HY6GRoA84ahGu6hJvON1vXcHpVll2mpkVGLgfjf43kkx2pJWZBQQBpz
	 Wn7R4pQnXfe/+Bgv6mDLb6IOK8keidZ3fec16JDqDtVQ3nfEai9Bk52vYFqkUIWzwq
	 6/UR1ft85H4IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD2C1E54D2B;
	Wed, 18 Jan 2023 22:47:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y8fxnV7ol9OP6JSz@debian>
References: <Y8fxnV7ol9OP6JSz@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Y8fxnV7ol9OP6JSz@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5
X-PR-Tracked-Commit-Id: e02ac3e7329f76c5de40cba2746cbe165f571dff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fbad44dddf560ba03e247352e8040992c7e95e8
Message-Id: <167408202476.14684.4740220252510854276.pr-tracker-bot@kernel.org>
Date: Wed, 18 Jan 2023 22:47:04 +0000
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
Cc: Siddh Raman Pant <code@siddh.me>, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 18 Jan 2023 21:18:21 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fbad44dddf560ba03e247352e8040992c7e95e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
