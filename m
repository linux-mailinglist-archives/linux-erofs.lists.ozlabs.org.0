Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A7875552
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 18:39:15 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K+XnL7PX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrGkn38hsz3cDw
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 04:39:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K+XnL7PX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrGkh6YqXz3bsd
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Mar 2024 04:39:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 769CBCE2596;
	Thu,  7 Mar 2024 17:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8681C43390;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833142;
	bh=oM4uNQBsXyZN8KJ4oiekxNVeuoHLyJp4B1XAD6FI0zk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K+XnL7PXs/XrQREfoJh9BZlafNSSi6T2CPvFluvNTuXHQojpw4fiEKdH9gquIwvcb
	 8jPgB2FgA+q1W1FSBOhXu4UuuH9H4jCrZFgyWDYaCObJkpgwljfB+GdDXQn/30t37c
	 /aKZFgKzqwLSTWCoGkqibXmF1yEj/RY2X0OBq5l6jgnbRPcbMPAKbyQfENH6YLYlYP
	 w9MP85ck8Y3QEAMo3oEhP5ussSS+aVREI4Cexcfz30Ya/cIA1KKAPxT9SAZw19fIUo
	 zNFLP/4agVYc/e44TFTg3D7u7DDA6YZRQvdW5HCWhpjXsmRYuhGc4YVjarCW6N76GB
	 yvxeW91q0c0CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BACCC04D3F;
	Thu,  7 Mar 2024 17:39:02 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZensqX1/c0L/hZJf@debian>
References: <ZensqX1/c0L/hZJf@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZensqX1/c0L/hZJf@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes
X-PR-Tracked-Commit-Id: 4127caee89612a84adedd78c9453089138cd5afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0e88885b8865ad1d57d9fd991f85d410175143b
Message-Id: <170983314256.22258.12631287813216370479.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2024 17:39:02 +0000
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
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 8 Mar 2024 00:34:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0e88885b8865ad1d57d9fd991f85d410175143b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
