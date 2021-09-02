Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B93FF273
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Sep 2021 19:37:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0p5z25jpz2yLl
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 03:37:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UNkwfzAI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UNkwfzAI; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0p5q5MFCz2xtr
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 03:37:19 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 29DC7610F7;
 Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630604236;
 bh=QBYTml/x3K/PePcy/qE1VF3LU3rtoHrlLGNyqEMZ92s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=UNkwfzAIAzBZQlZojuPKcz1iQUGdPUJ56ZnZbHxPIB4qOBTqBnKKfgn2KFlXyFTrr
 HwiYtpU3pGvxHJcEDsAUwcZx84Ql7pGyArhsu6WRUbEPumM4PW65hKzqx/aC+LyZmO
 RvCokvVoyd5LZ+PGNwMqopjPhXa2buEShtUiv6ZFZu732n7iLiiG0uOL6/aGlxUofV
 FcQWQij7soMcGV5B3ECHDx/JsyqPNw3JJpOSIZQQsVmLLKAJLbEiMssfjaPAPl8Kl0
 4N9ix8Av1PiN4mIrsvUrLqxFubleSVi2gh+Ph7FsYx45TwGTRmt0x6umjLiWWiQ7h1
 hjJgASIqS3kvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21B2D60A0C;
 Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.15-rc1
X-PR-Tracked-Commit-Id: 1266b4a7ecb679587dc4d098abe56ea53313d569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 412106c203b759fa7fbcc4f855a90ab18e681ccb
Message-Id: <163060423613.29568.6718988652036312622.pr-tracker-bot@kernel.org>
Date: Thu, 02 Sep 2021 17:37:16 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 Peng Tao <tao.peng@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 1 Sep 2021 06:59:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/412106c203b759fa7fbcc4f855a90ab18e681ccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
