Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A0586E6E
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 18:18:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxNZs3Fbhz2xtT
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Aug 2022 02:18:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQCBqek5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQCBqek5;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxNZk35V2z2xmk
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Aug 2022 02:18:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 927AD60E08;
	Mon,  1 Aug 2022 16:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF67C433C1;
	Mon,  1 Aug 2022 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659370682;
	bh=sT3zuzgRt8w5uFTOCXg5Oir3O7KYZNoeVUz6YW3xGgk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gQCBqek5g02tUKaYpp8CdgADICgCEQG4KiSXisC1A08b5ll60Mrta8zkjFnNIJSg1
	 L6UymPNJ2naqJBsbYeykxTYb9CO5D8EIM3+Ko7b7jO9l8JkbVdkzieTXay5+9RC/PJ
	 Fexgzxklw7cFclf4dpqPTdO7VGYhg0I5lRnqQk29wsGyCe+rrvhYlTslr9/fjUA7D4
	 /P6EDSyaK+kudaScVBKlIFp7Fr/YNK8aMKZ4FdBuSaPu1Xo1CTcExqoICg8A2JF/M0
	 4lPZ211Q1hHjpIaABS4Lj+why4iIZwYDxEemFgYtR9md96Iim3XgrUN8wSndUHj2SY
	 xggAjb63YGYiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72A4C43142;
	Mon,  1 Aug 2022 16:18:01 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.20-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YucDJOcnlB7EOD8g@debian>
References: <YucDJOcnlB7EOD8g@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YucDJOcnlB7EOD8g@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.20-rc1
X-PR-Tracked-Commit-Id: ecce9212d0fd7a2d4a4998f0c4623a66887e14c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88745dcfd9de5c7de1c17f81e7cecec3d88871d
Message-Id: <165937068187.17475.15354625708863816235.pr-tracker-bot@kernel.org>
Date: Mon, 01 Aug 2022 16:18:01 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 1 Aug 2022 06:33:08 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88745dcfd9de5c7de1c17f81e7cecec3d88871d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
