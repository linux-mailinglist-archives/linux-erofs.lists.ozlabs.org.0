Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E296969D594
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Feb 2023 22:12:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PLFV76jCKz3c6s
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Feb 2023 08:11:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IlCSkZ26;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IlCSkZ26;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PLFTz6Q1rz309V
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Feb 2023 08:11:51 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75D38B80DE9;
	Mon, 20 Feb 2023 21:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCD9C433D2;
	Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676927504;
	bh=2rLYfRCcCLPopVZzced5ClDRYrFbfbCWJPitYY2V3Ec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IlCSkZ26i3+T3k9vBQ6snswDqq3+ZVr7ipO0diVrBtIF1BAPt5xXiBZkUdXgttICE
	 HJQu16J+FljA0L2AziHDFXRy9MT+60qlGEUaUNhaEHXCN3twyqH6K6uwWrd0VNRqpk
	 hok4H1M9Xm+vhCEh/UPFby1yq/mYhkZpTfrqjKJbTW0l68ZYBxc9Tfj8m7fb1QSQYP
	 qkdRVOAdyU6bNnHxEQkvlHNTptEf4CtjMbhGSZkHOZ6kx5Cy4v+0iMC9DdxsUJS5I8
	 ud/kEsxyUsIAHMQXoAvgh1Atu1hCt5hMLMix9E0FUrGgyjiU0Kq1We6bq48+PdzuuF
	 W0GH5oMX9yiwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0D3BC43161;
	Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y/Li4s7qPOArhcSm@debian>
References: <Y/Li4s7qPOArhcSm@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Li4s7qPOArhcSm@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc1
X-PR-Tracked-Commit-Id: 8d1b80a79452630f157bf634ae9cfcd9f4eed161
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc483c851ff9a3505069cb326221dc0242d44015
Message-Id: <167692750398.16986.2751628578621415778.pr-tracker-bot@kernel.org>
Date: Mon, 20 Feb 2023 21:11:43 +0000
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
Cc: Dan Carpenter <error27@gmail.com>, Sandeep Dhavale <dhavale@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yangtao Li <frank.li@vivo.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 20 Feb 2023 11:02:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc483c851ff9a3505069cb326221dc0242d44015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
