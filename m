Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECE56C4AE
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jul 2022 01:17:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lfq205CpFz3c5G
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jul 2022 09:17:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WbhihxDG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WbhihxDG;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lfq1s6M8yz3bYy
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jul 2022 09:17:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8C95AB82A16;
	Fri,  8 Jul 2022 23:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B415C341C0;
	Fri,  8 Jul 2022 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657322252;
	bh=B+2TKIgb0kymI4gIoHFlRXXuiSc4mxiGgxCK/sB3R1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WbhihxDG+Qxgup006C2dG9JmAeZb6a0ru29GLxN2eAvvLcH9v+I9785oriGcmASem
	 4SLLEOx8VZHNGhhbdg5uAfK/1wgQ6NXmkXJGHcHvxA/sXB5sTYJ/yUWqQZokG+HC1/
	 Y2htKRANoQztFRa/pkM9s/vLTht6B9f3R9/nB+T4yn8rVUijA5ZlvrDek6qDbGQ13m
	 LshF/vIJXK3KEnLcOvCk+NFUVyB6m9aDoF2A+p9o4HOBGLA0kdXid85t7fWRPfF9fA
	 byjsjx7PcJzYKd9hChpQHkX6XaHoNpa2qwhLpPxohS3WsUMN06rc+qfwZrrjnUJQF9
	 M/rvT2hW9Rnkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35996E45BDB;
	Fri,  8 Jul 2022 23:17:32 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Miscellaneous fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <3753787.1657315951@warthog.procyon.org.uk>
References: <3753787.1657315951@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3753787.1657315951@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220708
X-PR-Tracked-Commit-Id: 85e4ea1049c70fb99de5c6057e835d151fb647da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5524c2a1fc4002a52e16236659e779767617a4f
Message-Id: <165732225221.30799.13034712144647468572.pr-tracker-bot@kernel.org>
Date: Fri, 08 Jul 2022 23:17:32 +0000
To: David Howells <dhowells@redhat.com>
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
Cc: linux-cachefs@redhat.com, Max Kellermann <mk@cm4all.com>, linux-erofs@lists.ozlabs.org, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 08 Jul 2022 22:32:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220708

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5524c2a1fc4002a52e16236659e779767617a4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
