Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B434CB000
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 21:36:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K85WX297zz3btl
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 07:36:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R0WLJBVg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R0WLJBVg; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K85WP1kdvz3bf9
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Mar 2022 07:36:49 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C2BC661729;
 Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3242EC004E1;
 Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646253405;
 bh=zQy0WNRFfoSF8M6CkM9t9ucOlLwRhJNfydVDE5XAZcE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=R0WLJBVgw5Rd7WcwQstMwaAMW/TWqPU8z2Jb0kND2JvYMZnFx5umnmnfrZXOt2ntR
 lIo4RCVyp1Cy+h3TvWNd9gXwlApckFd7AJ5Ml/Ib98w14sbN1/xY24n91uv5STASAr
 J8JJGDoGK5ahZPBSpznfkpbpCOxGRg7vAjGDYFNINiDh0zypt5Jeo61lHsXJiU2C51
 LVmfhXjodp/MhY/wW7je40jVF9EMtGlgdtt14pk4jcRcj2foNMAmgEhk9nrdJXVufn
 anXn0MyaT/lu85/G4zXPATejtq3pKyC46RREQDXjKVYNzxviO/C1isy00Z8VDE1KAp
 s5ZGqnRSmJrlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1A2B8E7BB08; Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 5.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yh+CCr04nTTappWl@hsiangkao-PC>
References: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.17-rc7-fixes
X-PR-Tracked-Commit-Id: 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ebf5f91b4dd5156886d2509202be0fb4230dfd
Message-Id: <164625340509.15521.3020679417776527674.pr-tracker-bot@kernel.org>
Date: Wed, 02 Mar 2022 20:36:45 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 2 Mar 2022 22:41:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ebf5f91b4dd5156886d2509202be0fb4230dfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
