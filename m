Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228853AD3D
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jun 2022 21:35:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LCzr23Q7mz3blx
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jun 2022 05:34:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8waOipn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8waOipn;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LCzqv5nsXz2x9p
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jun 2022 05:34:51 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7EA9BB81C4C;
	Wed,  1 Jun 2022 19:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0760FC385B8;
	Wed,  1 Jun 2022 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654112086;
	bh=UdpTW9Gy69BdEVInp3sI8aauVuoLZKYRoAEZvBK+D0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N8waOipncG7vdnHa+5gKgOGoCY1LXayvCngfS//eSYKHWoCYC0k8bhAL6j4s+gbEY
	 um8KhHpOCCeWKqTqzjmNGfHZsnc1i+eK5yTxbQGkKRKY+bez9JVDcsu11vTT9PPV6x
	 PhXCNmADkQN1Q4YtL8ITSx0DjvSFVrwDKl0S+UyUmqqOp0GSzv2Yu2+snh6BO0dGff
	 +h4zlVQDR+qDadTPTH1GHSYOf4GF9yzi8DBTUg1PTF4BJxsqwcxxPXg+q4lTZZv4Fb
	 iX27sbdFMM149ZbavWGlvNbQN1pgO75dzVKzACIx4xKgP6xSbWcOtANbxuTSywE1fp
	 MSCrz2x+1fGKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6E14F03944;
	Wed,  1 Jun 2022 19:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YpebV0BiGsrl8UDQ@debian>
References: <YpebV0BiGsrl8UDQ@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpebV0BiGsrl8UDQ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes
X-PR-Tracked-Commit-Id: 4398d3c31b582db0d640b23434bf344a6c8df57c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8171acb8bc9b33f3ed827f0615b24f7a06495cd0
Message-Id: <165411208594.25874.3614907223802868163.pr-tracker-bot@kernel.org>
Date: Wed, 01 Jun 2022 19:34:45 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 2 Jun 2022 01:01:11 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8171acb8bc9b33f3ed827f0615b24f7a06495cd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
