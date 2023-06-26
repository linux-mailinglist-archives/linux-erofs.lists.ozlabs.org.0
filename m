Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5073EB59
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jun 2023 22:02:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aOwikcGf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qqf0D3gpwz30gc
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 06:02:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aOwikcGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qqf062bc7z2y9d
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 06:02:46 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4616135C;
	Mon, 26 Jun 2023 20:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FC5BC433CA;
	Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687809762;
	bh=q1AYkOo0C8d8bzUL4fGWSkmp4uaLYnCzLu3ARo76SDY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aOwikcGfuaQzIiWEhkZQPjq6RkGcGHX0pzPbw5nuK7pVZq2DA/QWquaGPukkiH3Ss
	 gFnb2Kfk5o7LjPARYLRPsRP+g2LlBoIV8nZaZ/m1bbWu/MIUQpRzYSsXg8x795XGcg
	 pX5e0VlMCDGL0ET92HGwe9VAKemfJGVmROK29WewM0StWTwqmWJ328a1tucjN67+rd
	 WJO1XFKkLClmyD22agHyIWjDp4vIxV++Zl6DBztLkokce2kh09ToOeb3e8GsS7lhV9
	 7s+BDsGcfs3Tuid13a5x1B4DVAkC5tFJyUu+yhNabjoOVLZLHbk87OtxKVcpF7wf04
	 VLUMvRXkTk4/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E708C43170;
	Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.5-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZJkWa+t/WBCXs9XT@debian>
References: <ZJkWa+t/WBCXs9XT@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZJkWa+t/WBCXs9XT@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1
X-PR-Tracked-Commit-Id: 8241fdd3cdfe88e31a3de09a72b5bff661e4534a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 098c5dd9cf96fc6d7f35429561ef58cd7c5fcecf
Message-Id: <168780976257.7651.3821421140079280801.pr-tracker-bot@kernel.org>
Date: Mon, 26 Jun 2023 20:02:42 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 26 Jun 2023 12:39:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/098c5dd9cf96fc6d7f35429561ef58cd7c5fcecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
