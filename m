Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E897A032
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 13:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726485967;
	bh=CH473fk/GKytn3ydEEAT92oC33qR+OjeL0PTL6FdcTI=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jgBk5tV/4uE733xPm07GPwL/cEqVthicQtVObtRk7tnwNlyruVjMDXnKUPXL0IGdu
	 JTQLAq1o5KHVlu6lM+UkLpzKfQukknoskg1lzBkQdmVOqI9nb9Q0EZ1u169NZFcEA5
	 sX7+ymRn5jQYBBQiODcug2VGmKnGUWz0jmCIg64VGO6r3hYy4rwBAbcgHLsPY3lWVI
	 woJZSv7YynQne6w1yxl3cS3TFxE9GtROZdsMpL8AcsZRJzjVkNXO/ojdW1e0ar7Q/S
	 R33WNi3Kb0UJEko7JmqwKJw9s+9Bao98hALDEqZQxgJCpZ8LMlU1M7BXjD+93/g1s9
	 +QA/4wzB41rdQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6jKC4679z2yWr
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 21:26:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726485961;
	cv=none; b=EjZ1odNwmJYMMrRjYFCoAIoMhGfz8lS4pFdD/X57kqOGeJWb7Vu1vaxD7bfeLGcqYJ1CdvNNQYITRK1tk8KxysZwDKGXUREGK3kFSv2vDfpWYqThDuZhi4GziEIWLteI/iQKB2EDtHtUtvho28JiXkP/1hRwl2VwGQvXO8Is1iqE0E/fYARjhx5bx+mB43VmRwM9uKXC13jqPZIcka8oD4r7BZYI/gOIycl03zSns4nBqfN7599ztXDlxFrIoQMz7WusFs/pPUkOfA2cgRMjJI+lMOoH0Tu3BmCj/xxKgXidvl7jL7SCD8SVyWWbUcYuoToeVy7YbA4O274Rbtb9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726485961; c=relaxed/relaxed;
	bh=CH473fk/GKytn3ydEEAT92oC33qR+OjeL0PTL6FdcTI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BaZsPJ8RrFzB1KaLlUleLQLosFgmiU6LYsBXYTK1NKOeAKNDi66SJPpxbMODxx0IyKnX92FlzR2R37HXiSeVUUdJ8dWsfcW/cti+/5Fr3Uk8paDejObK4p/f42D3MPMRlnZIjZrDnrhV3FAYO9niIEpuq82rFNxOyWu7AhdQjt0KQ6EzRhS3a/VBXr8yAM5yfi7N3ZxvuXrmCpyf7y2GPMdOdM2mlIrId7I7Ux6363yRbI1voWqWc8g6yMhsYcTiMhBhlLSz86BICvO8VCogDSRzxNOimPrc6pdYyMztHtJQngEkcIHyivceoJx2yKsWzrzLoe09tDYk//zwu8G8Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GxXnQ+IS; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GxXnQ+IS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6jK50vlnz2xsH
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 21:26:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BBC3BA413FD;
	Mon, 16 Sep 2024 11:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6717BC4CEC7;
	Mon, 16 Sep 2024 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726485958;
	bh=djY62pJeIQ4FC3PgNlSMECUIaJ6uETnhddIf+NjYRJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GxXnQ+ISXV6OdLn6Pw0CVn4xnfOq58X8mJUoND1IXJnRRJlpdDIDglhG9+0OttWbP
	 PN25LxL+BiHJuq9paeLkhwftez3zkmf4cYuJCMsN74U6aalrMMBpfnh4CEpsiRWu6B
	 ZXqTmypm9nTwb7kSC6TC6aRU6jm86Ac4WvPRjr3ykN1Sj8PYEe6wOB8wceO3mGn8OV
	 GpW5imoOuOLuxNE+vCIgADUN+aDOGNFUfqwlwKoKsUdDGaSCFwtSpwQgBCn3YKF/B1
	 WNl7dru4oGxQksHrywvDURWLXmjGPwTrz6UAtIAKsM6m0XHQc71Of5rPMBpRXOoVFI
	 hjiYYmoHP9m/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD73809A80;
	Mon, 16 Sep 2024 11:26:01 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.12-rc1
In-Reply-To: <ZuR67f12ntVf59FZ@debian>
References: <ZuR67f12ntVf59FZ@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZuR67f12ntVf59FZ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1
X-PR-Tracked-Commit-Id: 025497e1d176a9e063d1e60699527e2f3a871935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69a3a0a45a2f72412c2ba31761cc9193bb746fef
Message-Id: <172648595965.3656894.161718696410625414.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:25:59 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
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
From: pr-tracker-bot--- via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: pr-tracker-bot@kernel.org
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 14 Sep 2024 01:48:29 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69a3a0a45a2f72412c2ba31761cc9193bb746fef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
