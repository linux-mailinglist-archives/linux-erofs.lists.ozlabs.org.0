Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A258C5E6D
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 02:53:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rt8yHAJS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VfF8P1G4kz30Vl
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 10:53:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rt8yHAJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VfF8H29FNz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 May 2024 10:53:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B7F74CE1318;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C88C2BD10;
	Wed, 15 May 2024 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734394;
	bh=I03mcCPgdRUXLvpgTfzgvZ9T2eX5GqqDmNocK7lBxEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rt8yHAJSnMtYnovW8i2iwIoqoA5cMJoqGFhC853pyyOab9XTNxQ8VUFZGW9hJ3sx9
	 hWRjmwiYG8y6lLBpYoGgJbOPCE7Y8jQ6NEeybMSdu1AkrxZOQP1PG3E+t1lCPIMDJk
	 4luY3kMO+YZ91IzH4Wg6pILuefBlp0ElBjvcbIS3DlEe7JGOtnX3YVSe740whB0XH7
	 oXuKJod1N+PfQ3JofkGt8wU+qZzHHdial5KpJ+I//aryDai+tV+tJEG34ri+vftEct
	 fTCWDZGcDqj2kcxv7HSjxVikv8LZ2gRZD5nYWnM8STrVmfMJh1/kwZYoc1LCdeMdxc
	 B/GPYYORDWl6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2189C433A2;
	Wed, 15 May 2024 00:53:14 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGuZ319TzAiLS+Z@debian>
References: <ZkGuZ319TzAiLS+Z@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGuZ319TzAiLS+Z@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1
X-PR-Tracked-Commit-Id: 7c35de4df1056a5a1fb4de042197b8f5b1033b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
Message-Id: <171573439485.24206.13430232406721811500.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:14 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 13 May 2024 14:08:39 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e9bff7fc042b28eb4cf375f0cf249ab708fdfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
