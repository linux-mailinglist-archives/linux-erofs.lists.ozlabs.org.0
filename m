Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2798B5E49
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Apr 2024 17:57:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i5XEOK4K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VSnzG31HPz3cX8
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 01:57:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i5XEOK4K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VSnz51pLcz3cS5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 01:57:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D8F4D60E65;
	Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AB6EC113CD;
	Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406252;
	bh=V+kKALgBUFrCSd3iERim7a+BS/b1pVtfqSotzhpBpEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i5XEOK4KoAL5hu+7ezsB2L25L4ZFFfszPx9AtvtRwyISg45U5QHTFvl1RlLkTZbFw
	 2csagYz0FNDwGNU8KKFo8Ece+F45k78HrnqyFwBRbqilea+GZFkDliF+YSxz2sz4t+
	 5UiDbaA1n9BYwI3uz/YynOXpY5noG2IvsfbVuH2AEY5zXsNIoOMTSU9PsbahiBGKik
	 SS9eSfTLgFRFM70bIk1cywDS05TGOUbnOLa5vYndSYmPHJ0vQOsfGW8H9KMbwKe1Br
	 BzMJvwxQzpsbiHWkv4iq8OaDeC3XhaozhcqtIcFUb1CHAqr9CRyzgbhm7W9QFx+MYe
	 2etnHsDdbbDYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 715C9C43613;
	Mon, 29 Apr 2024 15:57:32 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi9wpiog2uo1wGBb@debian>
References: <Zi9wpiog2uo1wGBb@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Zi9wpiog2uo1wGBb@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes
X-PR-Tracked-Commit-Id: 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b947cc5bf6d793101135265352e205aeb30b54f0
Message-Id: <171440625245.25744.17856946532911858716.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 15:57:32 +0000
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
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org, Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 29 Apr 2024 18:04:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b947cc5bf6d793101135265352e205aeb30b54f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
