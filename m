Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D36ED6E3
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Apr 2023 23:45:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q4zG30SMHz3bdm
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Apr 2023 07:45:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cbfBMkx+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cbfBMkx+;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q4zFv2PYWz3Wtr
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Apr 2023 07:45:39 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CEAB062953;
	Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31684C433D2;
	Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682372735;
	bh=HUnZzgCKUHUfilPp2qY2dzIsVqnaG0ylfpU11ZB8bCg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cbfBMkx+Q5/NIKyBTVZcugifVtQgjAaEpYHQB00MzMVP5fPRHoYmduczA4juc0DJx
	 5LLY8Ojr23P4Ynp1ZFR5chfjQ61JQa4FKhd+VeJJEnWzqJ7c+X2oxLR2ZLkZYjIyPg
	 K3W9WUtCgrGALzJOEzBaQkLrLctTGuuMSkU/iJ+3OxxXrB/jq+GJbn8dlCTqOMeybb
	 GyGX+rove1lpUuTxkEkv04btm/1LczZZMIlN6zbr9yVihfqd/2CUikWgfYHUX+4vfO
	 H8eIzs7gBF5ShUXo0vdk+HXphBXZUfeOynO3L+/h8g98gKOTCOYmRK0S2yhw5yeucK
	 lvevqI8bEMjpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DDB0E5FFC7;
	Mon, 24 Apr 2023 21:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZEX/1kWqrA8pU/g5@debian>
References: <ZEX/1kWqrA8pU/g5@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZEX/1kWqrA8pU/g5@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc1
X-PR-Tracked-Commit-Id: 745ed7d77834048879bf24088c94e5a6462b613f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61d325dcbc05d8fef88110d35ef7776f3ac3f68b
Message-Id: <168237273511.2393.17852620444983688131.pr-tracker-bot@kernel.org>
Date: Mon, 24 Apr 2023 21:45:35 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Christian Brauner <brauner@kernel.org>, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 24 Apr 2023 12:04:38 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61d325dcbc05d8fef88110d35ef7776f3ac3f68b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
