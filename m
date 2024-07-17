Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9893431D
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 22:18:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K/dQIXPS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPS1L0q63z3cWY
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 06:18:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K/dQIXPS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPS1G5Sh1z3bYc
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 06:18:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0A034CE1843;
	Wed, 17 Jul 2024 20:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524C9C2BD10;
	Wed, 17 Jul 2024 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247486;
	bh=99hewUQFCa+n1CuASCpxgHA6nPQjfGtYl5t5s4FBO88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K/dQIXPSVGZrnOGFdioB6g9LEdbvhyRSC2ZueOVWsUq33w8XRj0cW0w8Z7t2CmLIe
	 PCeOWq7AB2OYhlbl+qGCayRTAhAkj4DwU+ereaTLj+91OQvl7OWETzRcSkqTqPMjSG
	 VIM9GtkNn95mCLZN5CWOYHgFqLQ4Fj9mMt8ZhMp49Q4AcgXSu+VrK4A/CjeIndCAj4
	 gV4aycbZMrjpDmM+E2SkFh2y09fs5vaOnB3Piqwip96g8dAvix+KfrGoIIS4H1o0oy
	 /ktI25dg3NsED8ClLSKn/s0lTpsCbOTbDnwp+AuSMaQk+QEyZCx024nEhjeoD8TDcp
	 pCRRc4S3Y/dsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B2AC433E9;
	Wed, 17 Jul 2024 20:18:06 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpTAI1mLZ1pfTnz8@debian>
References: <ZpTAI1mLZ1pfTnz8@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZpTAI1mLZ1pfTnz8@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1
X-PR-Tracked-Commit-Id: a3c10bed330b7ab401254a0c91098a03b04f1448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586f14a6a182bbdb9404dc66464dcd8d0ac175a3
Message-Id: <172124748623.12217.7538948678125379696.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:06 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Hongzhen Luo <hongzhen@linux.alibaba.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 15 Jul 2024 14:22:27 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586f14a6a182bbdb9404dc66464dcd8d0ac175a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
