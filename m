Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925FF6B4DC9
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 17:58:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PYC1C2dSbz3cfB
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Mar 2023 03:58:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LU6L/dAQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LU6L/dAQ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PYC1425qJz3bqw
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Mar 2023 03:58:16 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ACD7061C99;
	Fri, 10 Mar 2023 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1101DC4339C;
	Fri, 10 Mar 2023 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678467491;
	bh=kwM21xhk7G7fTmTDdea+n+uRzVWAm9irNixHTfQ7jcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LU6L/dAQbztIk3GVxzLER4oxvbygY53X8MzneuFHzGjsBwpIEU4EzBAwI2MS+4Nwc
	 gEINdUlLJ3Ysm6gnaF+3m3a7ibEE5p9rO9Mw+xg/IPkTDPAnRaDE49/e+Q8Aw7spUq
	 mnGAd2GVURnW5eFV79uGA0FCqohmxkNNWu5h/oFYOuLTB1AMOPYuB1w3EanTfSOVN2
	 gVg01oFiMyRjtOSoCssn5aGuQ8XZLxLEA4EMwH1mHjkvkU3pUeU9h5rrmbGrJKpz1C
	 xjbldmJtDNdYVkZvsI7HH03FeRb9umjd+sCQ636nkCqOk8i+2gv3JDisaCiTnr5neP
	 UZVA2l7deNnqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF0E8E21EEB;
	Fri, 10 Mar 2023 16:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZAtdbhFmLD4MCRk+@debian>
References: <ZAtdbhFmLD4MCRk+@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAtdbhFmLD4MCRk+@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes
X-PR-Tracked-Commit-Id: 3993f4f456309580445bb515fbc609d995b6a3ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 388a810192fd383acce6933e7f272dd6a6802bb0
Message-Id: <167846749097.19444.4560208674172683124.pr-tracker-bot@kernel.org>
Date: Fri, 10 Mar 2023 16:58:10 +0000
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
Cc: Yangtao Li <frank.li@vivo.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 11 Mar 2023 00:40:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/388a810192fd383acce6933e7f272dd6a6802bb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
