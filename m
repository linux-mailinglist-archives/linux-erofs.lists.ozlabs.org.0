Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 674884AA13A
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 21:34:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jr6j60C0Dz3bVt
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Feb 2022 07:34:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d53Car1S;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=d53Car1S; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jr6hz5Wnqz30NP
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Feb 2022 07:34:43 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB506154B;
 Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF00FC004E1;
 Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644006879;
 bh=0Sen2f3umn7SRfZFRSW7rfzbXRg1rWParT+di94Polo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=d53Car1S2A5Y9r7m+O6RJID3QsZ48/+1qeZW5Zgomtke/xTn4fszBIPH99yQVPcy8
 H7XveJILR14bruAy3j8Hz6u49Ik3O2mtCdyPeE3VXGNeP4TIyO+NE8TeKifGXrUnSF
 vMt+zptS7ZRQiq8iwu/Vdnln9a5yEJEWbOUcRagBpN/DCmUdLpWy3HF1VoVRq7UX6d
 pTv0nStE81QrjDV9Z3I9xGrgDjF8lTQCTnC9bX1jKR+1SKKJ1nQJVFURhQPtK7bB1L
 ldaTO18b52+SlvOcYiUaFHfohJ/jl8i2FuXSNvTW5ZDDLF/DF799XnxNfogy5OWCWg
 VLsY78LWhL0lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 AB848C6D4EA; Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.17-rc3-fixes
X-PR-Tracked-Commit-Id: 24331050a3e6afcd4451409831dd9ae8085a42f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0bc0cb8157d5f09493a235e1ee73e84dd182ff9
Message-Id: <164400687969.31755.10506987054248222205.pr-tracker-bot@kernel.org>
Date: Fri, 04 Feb 2022 20:34:39 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 5 Feb 2022 03:12:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0bc0cb8157d5f09493a235e1ee73e84dd182ff9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
