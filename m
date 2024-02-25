Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD6862C6B
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 18:58:13 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lPmzk/2U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjWgk4368z3c2F
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 04:58:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lPmzk/2U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TjWgc3Txlz3bl7
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 04:58:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 05828CE10FC;
	Sun, 25 Feb 2024 17:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D868C43390;
	Sun, 25 Feb 2024 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708883879;
	bh=Tlli2nQbyZyMNmz5Q3DJIVV4D/y6FRnznxHtHXDK99o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lPmzk/2UF0F6JSPrx7cCffW0nBZ14t4lDZMtJc7upuEJXe49AhXs2/Q7U2BVl66BD
	 do1VeaTxmrROyX8dGNZcLRzM04A5YSVpGbpjDQ8mp6JucfnC4+9JYl6oFcdvzcAQ4+
	 qLne/k22u8EUvBal14MExsh53Q+6ZP28tPN2oOUonNz1Uc4AfThJUIuIuyFVfY1D07
	 1jYRgNRpK9TD+x3nD8nf+Kn0hcR79E5zCJwfNMF3crrAXcIZF5Ag8BMWVHuUstAJ9h
	 YJg8L4M7tA3hZTd1PmbO1+DHb+XZHxL+3RvbKeqyb/N8WmNTuA4nThbnGrqQSh6ueF
	 sJrn+wfDJDlwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B581C04D3F;
	Sun, 25 Feb 2024 17:57:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdtEwtN2BsCYnCeY@debian>
References: <ZdtEwtN2BsCYnCeY@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZdtEwtN2BsCYnCeY@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes
X-PR-Tracked-Commit-Id: 56ee7db31187dc36d501622cb5f1415e88e01c2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ca0d9894fd517a2f2c0c10d26ebe99ab4396fe3
Message-Id: <170888387916.1439.4286947576052324363.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 17:57:59 +0000
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
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sun, 25 Feb 2024 21:46:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ca0d9894fd517a2f2c0c10d26ebe99ab4396fe3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
