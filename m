Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 485F662A168
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 19:37:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBZfL72pmz3cGk
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 05:37:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gx6gn3BU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gx6gn3BU;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBZfC67znz3bXR
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Nov 2022 05:37:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E60B76199C;
	Tue, 15 Nov 2022 18:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512CBC433D6;
	Tue, 15 Nov 2022 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668537423;
	bh=DXtBqwAJNzvabhEQWkg/v9TIqBl57Z8uQGQkk8DLJik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gx6gn3BUolDn9LKLn3SiegK/aNplpPWVpSisRC2HEjW0evz1s6J82zuOJ4hyJOJWe
	 J1k6iEM9O5uiqWTI4fGxaytNLcChn4nSsEgq7SrVtbqqh5Lf1fy4p1O7JZdaGqivEx
	 EVspKIdTkQDsf/u3HsCKChs/QMEjn3dXYzdkQpigFVivu4AVlnbN5O1HsM20Un++fi
	 0L+jU7eJEjI7sHbcg+GjlCTv0mQo3+PMSpROpfAOaXrf4b9fG9iKfjy+ipNzbNaVXq
	 UCwUHtMDZsrtEtnFRXLc7US238553xOarR/XQFtO5UY9dmKfiWhmnOzSBsDIy5q3Jz
	 dq40ypaEJPNxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D74BC395FE;
	Tue, 15 Nov 2022 18:37:03 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y3OhbojEWZa35DVf@debian>
References: <Y3OhbojEWZa35DVf@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Y3OhbojEWZa35DVf@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc6-fixes
X-PR-Tracked-Commit-Id: 37020bbb71d911431e16c2c940b97cf86ae4f2f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81e7cfa3a9eb4ba6993a9c71772fdab21bc5d870
Message-Id: <166853742324.15464.2205805184353773016.pr-tracker-bot@kernel.org>
Date: Tue, 15 Nov 2022 18:37:03 +0000
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
Cc: David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 15 Nov 2022 22:25:50 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81e7cfa3a9eb4ba6993a9c71772fdab21bc5d870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
