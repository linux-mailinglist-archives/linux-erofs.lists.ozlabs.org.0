Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5293D7F5
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 20:07:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MLPBhOJ4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVwhf01k8z3dRf
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Jul 2024 04:07:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MLPBhOJ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVwhX4MwMz3dKS
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Jul 2024 04:07:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9850761853;
	Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B311C4AF07;
	Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017258;
	bh=lDHV427QZRtMqiuL8aDbuoPl1OtHauXkgDahfoLIcpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MLPBhOJ4hPZ70ewuQ8eWWJmidBoBdKf/PV2Sr1LsioD6HMjTcI+UUo8oq/9GyjUwv
	 PSeqiZmAafca3rqBnZ1/TqicvG795zUZOmlux0PROQcH5aExeASUPttBys3VRXatv1
	 pysSEQRJ+W2DbmZbaWu+icS8+DNKRRQi3ifrbou6xdeESVlD7iRfCtJMOVSDu7uowo
	 GGqjIi4ica4vBZkFgzGRCf1G/+p81W7SYTIneZcvNV/UGdVD9Mi8RzQYPS+UcRco5R
	 99tPvkeNfA1zmq1Hgo/USY89/IVwEzCMjl3lw7wFzwbWiMIWItVnigRFINV4BbflWj
	 uz65BiTbztbEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 637D1C433E9;
	Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
Subject: Re: [GIT PULL] erofs more updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqOgy0Xh2hPy4Ojm@debian>
References: <ZqOgy0Xh2hPy4Ojm@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZqOgy0Xh2hPy4Ojm@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2
X-PR-Tracked-Commit-Id: 14e9283fb22d0d259820a5f05c6059678bab9ac5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 732c275394305b6d71b4bb74f5432d2d91f05257
Message-Id: <172201725840.32235.15562992456918184265.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:38 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Fri, 26 Jul 2024 21:12:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/732c275394305b6d71b4bb74f5432d2d91f05257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
