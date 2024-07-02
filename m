Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53F924887
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 21:42:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5a7idKd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDCxH4WJSz3dCV
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 05:42:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5a7idKd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDCxC6XMrz3cY1
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 05:42:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6CF7ECE217C;
	Tue,  2 Jul 2024 19:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B47E7C116B1;
	Tue,  2 Jul 2024 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949356;
	bh=lHoEuYJVwsq0uHEkMg3tkYBJkvxa8nn1eomG7AVC/1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P5a7idKdZtQNxcaPb25fqugvl1j9qozueC8p6XvhxzSu6wKwgdSM6F7hYmEL7FPi1
	 zHGLnei7zdN+FIJA8pyAZ2omxl9ncS6cj99OKza/V7h6JDVKj1p8Ezx5d9UkiD/gBG
	 wxYLUzS3q4mjkmCussOnJ5B1yo8BuAPHFJ63zRxO/ZixgPzZs8tczp6qoJ7MyRTt9R
	 +2+lyukpUo+WyJ9WNAl3KjPMLiikJrm6nrePE5Ut9AHb3GgYVXRzeMrM4nCqayvdmG
	 iQGblwwWBs5XC+LRj1rwcpIL9ZawOpPQ15PFCPRziALeNq7LCCFHy/fyv1WCoNgN0P
	 h1L2+ymZrMG5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2CD4C43331;
	Tue,  2 Jul 2024 19:42:36 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZoQFEp+U+689DPdO@debian>
References: <ZoQFEp+U+689DPdO@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZoQFEp+U+689DPdO@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes
X-PR-Tracked-Commit-Id: 9b32b063be1001e322c5f6e01f2a649636947851
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 734610514cb0234763cc97ddbd235b7981889445
Message-Id: <171994935665.24472.6677336924467756417.pr-tracker-bot@kernel.org>
Date: Tue, 02 Jul 2024 19:42:36 +0000
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

The pull request you sent on Tue, 2 Jul 2024 21:48:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/734610514cb0234763cc97ddbd235b7981889445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
