Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 113827DFA0A
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Nov 2023 19:37:58 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KsJ+Ic0D;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLt0g6thzz3d8J
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Nov 2023 05:37:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KsJ+Ic0D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLt0c2C4Jz2xqp
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Nov 2023 05:37:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C5490CE2160;
	Thu,  2 Nov 2023 18:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E39EEC433C8;
	Thu,  2 Nov 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698950269;
	bh=uoSyNnn8TnPOudI/MAFSQ3CG1Cmr0JQndA9X3SCZFsQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KsJ+Ic0D8RitkITUhM8yYhX8ABC4dfmWy4iNq1RjYd1LgUl4CxDl7p8fi2AGYBIhW
	 3VRejO4vY07KFc8DMg3fvMlQ9nN47freI1nL9JLgMiqr6vBLEy9ZkZgtNswYX14+ck
	 JRHU1ou5oCw1FHgN7S0hssG47LvLx9WErmgl5YThcFJWElUnw95JSFsfzOGYJoiCUg
	 r74mOdilEbwu13FiGa7ab87RtUeqxnAsOenNfmyNtzqYitEUPW95QSEM4OpG7JI2DP
	 Qkbu14SC4AxtvoPBuOuGOMMwB23lqTGK2I60fuKV7pV6o+lx+RLGwo2ORGeizp81Z1
	 7eR9ai7oyROkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D28FBC4316B;
	Thu,  2 Nov 2023 18:37:48 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUHVoP/682uPjvfj@debian>
References: <ZUHVoP/682uPjvfj@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZUHVoP/682uPjvfj@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1
X-PR-Tracked-Commit-Id: 1a0ac8bd7a4fa5b2f4ef14c3b1e9d6e5a5faae06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87a201b43bbe14ddf8dc2d73fa15741b7403afc3
Message-Id: <169895026885.19486.11527466095548971454.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 18:37:48 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 1 Nov 2023 12:35:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87a201b43bbe14ddf8dc2d73fa15741b7403afc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
