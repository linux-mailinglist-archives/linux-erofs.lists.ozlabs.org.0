Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140C46010E
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Nov 2021 20:06:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J1h1G3br8z3c6N
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Nov 2021 06:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mmZTvR2S;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mmZTvR2S; 
 dkim-atps=neutral
X-Greylist: delayed 498 seconds by postgrey-1.36 at boromir;
 Sun, 28 Nov 2021 06:06:40 AEDT
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J1h1D114Tz3bXV
 for <linux-erofs@lists.ozlabs.org>; Sun, 28 Nov 2021 06:06:39 +1100 (AEDT)
Received: from mail.kernel.org (unknown [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4F12260EC1;
 Sat, 27 Nov 2021 18:58:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id B32D160174;
 Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638039496;
 bh=8nQ53Up+ro1K0NzJ9qoy6TvyU4mDwcYEHjLnlaxulNo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=mmZTvR2SBtukDiPVwOMMh/uvzFFRzXORAhRm2tlL+U6xglULRdWQi8th+RMaKin7P
 EX9A6utcWA1dmMlXwndVZrdKGDSl5tR8Q5lS21XjM60F4NgwXbrfbDCTVbf14wXJ+4
 HRjCcqrqrSJgOElrsRoQW4uC90htb8B73U8YYQviw35fsUe6f2H8fo2Qz4BaQGND/3
 be+mEw7IXfhPjzZXL6C2A0Bm5UrArp0YNUHQLY8Jqj+9D89SscNUQojpDRDqTjv/EF
 6LNLHkX811fh2zRRuh67L0h4bO+oH4+mbPM+6d9mks2tiRDFsw83bXynCaOG7NXnxQ
 Rkn16I9+wehhw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD91C60074;
 Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.16-rc3-fixes
X-PR-Tracked-Commit-Id: 57bbeacdbee72a54eb97d56b876cf9c94059fc34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52dc4c640ac5521cc95b3b87f9d2d276c12c07bb
Message-Id: <163803949670.17852.12698146502651849127.pr-tracker-bot@kernel.org>
Date: Sat, 27 Nov 2021 18:58:16 +0000
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 27 Nov 2021 12:53:09 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52dc4c640ac5521cc95b3b87f9d2d276c12c07bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
