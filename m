Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76325AF457
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 21:22:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMZyy4wfwz3bXZ
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Sep 2022 05:22:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QGi+dzdr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QGi+dzdr;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMZys5sbNz300F
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Sep 2022 05:22:29 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC4E61636;
	Tue,  6 Sep 2022 19:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33D2C433D6;
	Tue,  6 Sep 2022 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662492146;
	bh=jqh6xuQgKJlV7O/dZmQDjPjv7R2ccUKSljtIZ02JbkQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QGi+dzdr0xJVGyCvAssL9qc7xQohCA98+jehmM9F0wxfI6zWA4YMoG1lIiAVqhmFO
	 hBXPHXZBHHoS+iTrooOhDgWKZ65ZdpIvX7lUNKU+oyRVuTtGBut7pG7A/A7rbjxlfr
	 OnLQs70Mg3PItwAtYN2K2bS/I3dv4D3L7vE9Qz5CAQwpFWtFQEpIaozIZJlpsWv4F9
	 a/me+vtg+IHT4sE2uEmv53ZfB6rjOn0l+Qoe25rlVi7nyxkPhhYAQu3BMpyKlWusN+
	 C/zPuItje/71oHQ3qcOCgr9K5hULkKr3qhwqqf2QHioOiEK1BDmWDP67RvEBj4k3GG
	 HobKUJ5G0iApw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2E08C4166E;
	Tue,  6 Sep 2022 19:22:25 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <YxdyU26Us1vmDxVJ@debian>
References: <YxdyU26Us1vmDxVJ@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YxdyU26Us1vmDxVJ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes
X-PR-Tracked-Commit-Id: 2f44013e39984c127c6efedf70e6b5f4e9dcf315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2ec799d1c1be847d6a70704fe586ac4d14265c8
Message-Id: <166249214590.30445.1453272856392064922.pr-tracker-bot@kernel.org>
Date: Tue, 06 Sep 2022 19:22:25 +0000
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
Cc: Sun Ke <sunke32@huawei.com>, linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 7 Sep 2022 00:16:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2ec799d1c1be847d6a70704fe586ac4d14265c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
