Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14077BB09A
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Oct 2023 05:50:20 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7/UWQhz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S1vZy0Nlkz3cSQ
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Oct 2023 14:50:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7/UWQhz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S1vZq50Rvz3bX1
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Oct 2023 14:50:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 151FBCE217C;
	Fri,  6 Oct 2023 03:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46477C433CA;
	Fri,  6 Oct 2023 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696564207;
	bh=f/8a4cC4NCWswVWtS7qHd7MQdEwfhxD030udLKp0ROc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R7/UWQhz0mdOdG1sbCaBNhFS+FD+XKqB7pdn41djlTo1XDGN337YqlY53gORzR7pt
	 emMhKlAcjOOJdZo4iPhgfjJU/OBwr9Oyz027UJLLcOeHInohk37aPMEkq6GrjLVd0l
	 HmSThHjNQhDtz7IbVvvpWuYD+wit5EGXeDxSCoEEmgy52JebSxvctNydcdBRTaUfaA
	 /IQDe5qJWu/dbvxBIV6Rd0TS6qPq0sJPC9wkYPsEFqKAPIpGrnLKDaVMy+qld1QV73
	 /Jrxc2tvg+UbrxSrzx+selnUkRzlipOIBmK+c8ujtr7M3YbO3eGgFsmYfz8T9uxwLA
	 4dKc1A7odKu1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21D2FE11F54;
	Fri,  6 Oct 2023 03:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.6-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZR8Fyu+gi7yw6HMh@debian>
References: <ZR8Fyu+gi7yw6HMh@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZR8Fyu+gi7yw6HMh@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes
X-PR-Tracked-Commit-Id: 3048102d9d68008e948decbd730f0748dd7bdc31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b78b18fb8ee19f7a05f20c3abc865b3bfe182884
Message-Id: <169656420711.12601.12535394337239272246.pr-tracker-bot@kernel.org>
Date: Fri, 06 Oct 2023 03:50:07 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 6 Oct 2023 02:51:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b78b18fb8ee19f7a05f20c3abc865b3bfe182884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
