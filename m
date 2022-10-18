Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D347F603301
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 21:06:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsNdX544jz3c87
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 06:06:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i+jeyJtA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i+jeyJtA;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsNdS4jk6z3cf2
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 06:06:52 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D974E61668;
	Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3654DC433C1;
	Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666120009;
	bh=AhZSPrQ+ySyLQOwegsh0IpWm98ikHtRgqAp05ODo4K4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i+jeyJtA8NDTpBqPAMXKb64ElrntEDRYo8xZsoQzFVPPsfl570+eaHlIsPtQf4TkA
	 fbkBE9Fh+cY+6PqKIOf/WYyC7IzkCMiSiHjhK29V4Q115mQJU9u2dwYg8WGhDSzhQt
	 KzaWVdcGExDn0qFrzkiJvJf7iUlSyJMKXkR0hJniX0QUxjlE/3fLC9Q3uOrfnWqdWI
	 B7LlJLjXOdldAxtrMThXK71GEnKbIylO+s46N014uoOCVnSO40Q/U6Bo805GPsNfj8
	 Vft39g9mhc6JyM7mervO0qj0VFm9001vTdsi+A+DQlfxtGQ9bSOzJmqymAMAFgEQgL
	 2QDm1FBeNeQ6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2336FE21ED4;
	Tue, 18 Oct 2022 19:06:49 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y051uhn/opotPmAo@hsiangkao-PC>
References: <Y051uhn/opotPmAo@hsiangkao-PC>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Y051uhn/opotPmAo@hsiangkao-PC>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes
X-PR-Tracked-Commit-Id: ce4b815686573bef82d5ee53bf6f509bf20904dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ae460973d3455371a1182297357eeb9fafb0227
Message-Id: <166612000914.5469.8048419574604088110.pr-tracker-bot@kernel.org>
Date: Tue, 18 Oct 2022 19:06:49 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Dawei Li <set_pte_at@outlook.com>, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 18 Oct 2022 17:45:30 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ae460973d3455371a1182297357eeb9fafb0227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
