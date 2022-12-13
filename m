Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1364AED8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 06:00:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWRBt0QcFz3bgv
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 16:00:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NFiP/3iH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NFiP/3iH;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWRBk5qsyz3bXJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 16:00:14 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CC75C6131B;
	Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3680FC433EF;
	Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670907611;
	bh=tgquSFO3EMDZ6wt5lb3LFjKaGzBC0H9z3whmK4epp20=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NFiP/3iHpGLqsb7kyxqUlXft9/H9srYeazSJDe9WRCAmzgc5IwUaSmmgUx2GfvL94
	 GFfypG9p+lg6EJIj5CGakR+SVL3NK4Kip9JYbJEky3ivkKd7PHRcrRNnVepIybAJvR
	 DbYZpXX71ZisL2VMbPKN1RJNTWF4mKX+ZHz0/bnW865aBEOtwsvGL2L1rlms/XMSd1
	 4CRhdxSA1KGqJv2tU9l+he9ZRA5to52Oa1EUjQDIsCV2tSjsXspPTjNU8OQV0ECQCt
	 UTEqGsNFWQPd4xVAwOgdxKX0QhPKlNJXn9dgVyUdNTil8TR0DQh9pwGk8RUbLR7Sgw
	 gL5fXL/UxpvSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FF4FC395EE;
	Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y5TB6E77vbpRMhIk@debian>
References: <Y5TB6E77vbpRMhIk@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5TB6E77vbpRMhIk@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1
X-PR-Tracked-Commit-Id: c505feba4c0d76084e56ec498ce819f02a7043ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a6bff1187409f2c2ba1b17234541d314f0680fc
Message-Id: <167090761112.4886.12716661902911748332.pr-tracker-bot@kernel.org>
Date: Tue, 13 Dec 2022 05:00:11 +0000
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
Cc: Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, Chen Zhongjin <chenzhongjin@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Hou Tao <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sun, 11 Dec 2022 01:29:12 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a6bff1187409f2c2ba1b17234541d314f0680fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
