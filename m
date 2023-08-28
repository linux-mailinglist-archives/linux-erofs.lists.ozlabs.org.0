Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B978B94B
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Aug 2023 22:15:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jFLCcWJm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZMHK3VYkz2xdK
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 06:15:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jFLCcWJm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZMHG48gPz2xsY
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 06:15:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 922DD63F86;
	Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6332BC433C7;
	Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693253704;
	bh=3ng2EVepeu+LjlvxfUFzmhwRGPo9wZ3EclHN+yIA/mA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jFLCcWJmV64XAulkPzkGLVBUvDXTdRVW4r1oAR3KCCl8Act3Rvfb2XXrqWWE41RNx
	 NJfbTXWIiMbObwP20tWZp5nUkeuB5AjC+c1mhRFlB6v8LnU4GsiHiAkg9Ct23/kc6Z
	 gGpBOmGk6yoMoZG/2gTbns3GL0xStg8r82BxyE92E38OAwBRASveucy631UMbOtfOa
	 Dk9h2jw6jYPKJdcexOpTwtZAvo+Cf1Y7xt6j+I9P9kc+mjYm/+F2XMuM+yQvYzswrE
	 CyFQD8T1CwzLu1zNJt7/irVlbGrly752//6G2vtqIz6StndWnG3uKOGoN41JN8gu6P
	 IOmzuf1PDAUQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FD25C3274C;
	Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.6-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZOvu8n2Js03Oa7lN@debian>
References: <ZOvu8n2Js03Oa7lN@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOvu8n2Js03Oa7lN@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc1
X-PR-Tracked-Commit-Id: 91b1ad0815fbb1095c8b9e8a2bf4201186afe304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd2c0198a8365dcc3bb6aed22313d56088e3af55
Message-Id: <169325370432.5740.11272705112357051863.pr-tracker-bot@kernel.org>
Date: Mon, 28 Aug 2023 20:15:04 +0000
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
Cc: Yue Hu <huyue2@coolpad.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ferry Meng <mengferry@linux.alibaba.com>, Alexander Larsson <alexl@redhat.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 28 Aug 2023 08:48:50 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd2c0198a8365dcc3bb6aed22313d56088e3af55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
