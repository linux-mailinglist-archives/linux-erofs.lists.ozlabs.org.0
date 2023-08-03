Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7D76EF7D
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Aug 2023 18:31:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bNw613xk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGvVB45xLz3byX
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Aug 2023 02:30:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bNw613xk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGvV30DgNz2xnK
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Aug 2023 02:30:50 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6BA6E61E3A;
	Thu,  3 Aug 2023 16:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA438C433C7;
	Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691080245;
	bh=B/B/iwYde+o5hrsKd2KWu9SZHOApuMVDyPMm+nQQrH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bNw613xkgEGhMVHr6GHQZ1Bc4laeLYRpVe4D+cF8MN3+8sso9bQJo5Cgq9F7eH3qX
	 PQZrFpRJbPl4MfpRsukN3GhMQ/VHlTy7lhslTTOFsf8/cd+y0k2N2TW3xLhWC3E08H
	 FPC6zWC4ZbxieGj7qpN05DJ57nnlHqnAy+tyfuIdgeJXLVZywQ22Zdl9omgbruYqPP
	 wAkqDLCNEba8TTity4mEairQEA/12Y0FmoFFM+i2D+AWiXCPw6PSbrTO50kQtoEkeA
	 NSrHMocvEipTeiEcAjqCpUJcEyrCYuAIDjYNa+1Z9n8e8tmUO8ZDM4G1u+QCb8yFHj
	 osGZd9JQlZPlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A21FCC43168;
	Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.5-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZMu+q8oCAVG6PqK1@debian>
References: <ZMu+q8oCAVG6PqK1@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMu+q8oCAVG6PqK1@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc5-fixes
X-PR-Tracked-Commit-Id: 4da3c7183e186afe8196160f16d5a0248a24e45d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556c9424e271abff7ada9196007418f7b8431c6e
Message-Id: <169108024565.31872.3627744786111502086.pr-tracker-bot@kernel.org>
Date: Thu, 03 Aug 2023 16:30:45 +0000
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
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Shijie Sun <sunshijie@xiaomi.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 3 Aug 2023 22:50:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556c9424e271abff7ada9196007418f7b8431c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
