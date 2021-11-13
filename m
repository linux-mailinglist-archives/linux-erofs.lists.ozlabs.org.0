Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE844F502
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Nov 2021 20:44:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hs5WD4R8vz2xtc
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Nov 2021 06:44:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E1xbLlzg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=E1xbLlzg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hs5W95QMhz2xBq
 for <linux-erofs@lists.ozlabs.org>; Sun, 14 Nov 2021 06:44:21 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CDD961056;
 Sat, 13 Nov 2021 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636832657;
 bh=SOohovcpMYj76l5StA5OySttoJ9fEJLI96EwedJXHXQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=E1xbLlzgg9V9w7H4b3rHUBD0kGD/hCJ0jNun9af1DGyCIwyKmPX1Io0u8g+6KopJy
 JwKWf1IsqAz8NB5/OqSt7TxEY34PRGhMa9JzeHKZbBXWHYJ2ZVrjX7FXlmc1Czql/a
 zTtsNoteWgsERSFQFQ+re32O+AMxOnfxAa1WW49727ApT5v9ZywtLccZjCUVUV/htQ
 Ehq1UUBX0Pe1pv8UqpYua46bulUL6EKZsnE2SEkoWreUvhxoZVYwAgzaPYKbU2kizU
 vBs0OAJI9ci+2Dg9or6b7QSzmdQNhCTGh8uh/ms7ukSzsF7x/pLS++nTV+lPZjM/KD
 o3HKoy2hfT9Bw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 16A4A60721;
 Sat, 13 Nov 2021 19:44:17 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.16-rc1-fixes
X-PR-Tracked-Commit-Id: 4c7e42552b3a1536f3cdf534aba8c4262ee26716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a27c085874caf1a2d944bc0acc4b4ee76ffa9296
Message-Id: <163683265708.24678.6013028869466264092.pr-tracker-bot@kernel.org>
Date: Sat, 13 Nov 2021 19:44:17 +0000
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 12 Nov 2021 23:13:06 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a27c085874caf1a2d944bc0acc4b4ee76ffa9296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
