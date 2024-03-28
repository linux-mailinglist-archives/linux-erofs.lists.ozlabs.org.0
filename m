Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617488F5E9
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 04:30:12 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=og1JxUQl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V4pvP6HR9z3fQH
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 14:30:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=og1JxUQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V4pvG4XCVz3bv8
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Mar 2024 14:30:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B8C9616CE;
	Thu, 28 Mar 2024 03:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7CFDC433C7;
	Thu, 28 Mar 2024 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711596599;
	bh=CEfsYmiNVGgb93ohKnebxF59cvd3q6hputQVYN/pFU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=og1JxUQlAW07TW7zEGaMvOQ+WlliLwHCxU+Mc5hq8/wj3qPEMpUDxmrICVGgOyC82
	 YhSEpB+vKwHDmsMdv8iSpxujDQDQEjbKE0/ae0ofQL6c8Ac2KSSl6If+Rudhi4auna
	 aRf0+nt72PAEWEQpAz+uQQYCk2CqDceHNPrUJP7r1xJcUkzQ5yv11TzrvwB2ifo6pw
	 XMpA1QBOCaMbAHYLYAIF9O8AgBcGO4OSDuaU9SbmOqLi2MRmITauUiBUYWrR9SIdDR
	 LZwgQRt/MZJlj1q2734etDpDxm/jHsijWWv5xE1Gqt5N/FEGS1O4c0XPiAvgcv2XSQ
	 iEACgTP67n5FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5559D2D0E0;
	Thu, 28 Mar 2024 03:29:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgTb62/wsjacMpC8@debian>
References: <ZgTb62/wsjacMpC8@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZgTb62/wsjacMpC8@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes
X-PR-Tracked-Commit-Id: 7557d296ad439f66a87cd34917af2a4172517826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d025e2092e29bfd13e56c78e22af25fac83c8ec
Message-Id: <171159659979.21268.10017313312226024950.pr-tracker-bot@kernel.org>
Date: Thu, 28 Mar 2024 03:29:59 +0000
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

The pull request you sent on Thu, 28 Mar 2024 10:54:35 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d025e2092e29bfd13e56c78e22af25fac83c8ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
