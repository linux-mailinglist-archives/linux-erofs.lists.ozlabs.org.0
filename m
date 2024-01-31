Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17883843617
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jan 2024 06:31:02 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q4wBA036;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TPrH80jT2z3bqC
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jan 2024 16:31:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q4wBA036;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TPrH41RvSz30NY
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jan 2024 16:30:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 121F6CE1CE3;
	Wed, 31 Jan 2024 05:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B65C433F1;
	Wed, 31 Jan 2024 05:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706679051;
	bh=rC3sfYrLQD6PwbHwcd9T+mFvFCPjsMTtROWzuMYyAXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q4wBA036YZEGmHhRr5Dlh9sJ8RPg8a0Lo7BMbEMgNAolchjRKduhglsnVzi3IqNzD
	 zT/EC5qriPRBFCWt8DR9neHHKg+q1zFkw819S9COylFdTjO1ZXhYFv3DJrYdturt4Z
	 icke7R8I0X/NHw7WWzcj91J4Do9d4oTWBVxjdl7hEqwDMWuedrNNkQisQRW9if67TB
	 N8xzwwmIZwyBSgMbdef48H/fbDCVERL7Z7C1IDk8sjbmSNfPfTq8OwkH8N9ZUbd2Ne
	 nmYOniLqwmp6elea0vb7yl6KeAGCi4blOxN9VIds3zBTd/JFB2d8sdUGhIZwUu/IAR
	 kNmLFuIIvo91w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EECDDC99E4;
	Wed, 31 Jan 2024 05:30:51 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbnCP71bgYBzzHA3@debian>
References: <ZbnCP71bgYBzzHA3@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZbnCP71bgYBzzHA3@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes
X-PR-Tracked-Commit-Id: d9281660ff3ffb4a05302b485cc59a87e709aefc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
Message-Id: <170667905118.426.9560450734798875531.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jan 2024 05:30:51 +0000
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
Cc: Chunhai Guo <guochunhai@vivo.com>, Linus Torvalds <torvalds@linuxfoundation.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 31 Jan 2024 11:45:03 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
