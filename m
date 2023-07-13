Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9187752C4F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 23:41:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UuCYnx35;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R27NN0zFTz3c4t
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 07:41:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UuCYnx35;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R27NG5JQMz3bZK
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 07:41:34 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C23361B6B;
	Thu, 13 Jul 2023 21:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0745CC433C8;
	Thu, 13 Jul 2023 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689284491;
	bh=zGzXoM0u04bgU98YlFEDAFt+ZgG3JOfNU4FRvqkvpW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UuCYnx35ZBqO0FTru00ZbUPsPYxVIGrf+34R1b41M8oxpz9T9nqXhwZj8/M+G4Q92
	 ql1LTN7v5O9hVTlzNvbyB4RgjYKVTRHC/SvLszDPT/5gsoQPEqMmjzKDXxGUqXE7FR
	 3Tgw9eOO5+kf0IqR7wu94lHHhqDuzldP4ynHWs8N7F3kdEeYom/1umr2T1uXRkSSvr
	 hKPDBGgq/jfjxrLGzpb6sx1bDEndPpUZPKzXu4nD5qCfQ/oC0nFNT/g0as1/UZaFl2
	 oWyFlDeqnHLOPrrox4yl/p9281jp9SAoKOPDzqEZ9NplKVvLbEgnCRcEHXp6DRFmxU
	 sMDt3MVskDqeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9B83E29F46;
	Thu, 13 Jul 2023 21:41:30 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.5-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZLAX9WApf3wGm5Q+@debian>
References: <ZLAX9WApf3wGm5Q+@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZLAX9WApf3wGm5Q+@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes
X-PR-Tracked-Commit-Id: 18bddc5b67038722cb88fcf51fbf41a0277092cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b810bf037e524b54669acbe4e0df54b15d87ea1
Message-Id: <168928449095.12038.10202336583193139465.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jul 2023 21:41:30 +0000
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 13 Jul 2023 23:27:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b810bf037e524b54669acbe4e0df54b15d87ea1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
