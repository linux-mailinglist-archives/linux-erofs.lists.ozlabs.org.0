Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182CA5090F0
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Apr 2022 22:00:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkBNv4zhyz2yw9
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 06:00:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iF8Mq2n/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iF8Mq2n/; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkBNn0NvXz2yNG
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 06:00:24 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EDCA061770;
 Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 577DCC385A1;
 Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650484820;
 bh=QqV87m7fP2qffAEvZHncjqlUzSmtRv+pIC3XzpEiCFc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=iF8Mq2n/imsVVePqo0SXyakpy5l2x5rPjeiJXT/6ldj0laSqB8mLKWwDcEN00Wmcc
 HYZQME20e3Supvi9QThvMwBPMVadW4tAEiz5eqmgif9mzZFMkkphR8vNYpWbOq+K3d
 pWw0ScVj1t+L1EOEqYGULLIrps90LX3eFDGoHvGVmfLgEqbFfE75KZ35APLiS/+nD6
 6rP7/sfklZc0LvhkLP6a/qqvsb/0hpK8RtdhbQWGZq9/SwS5CPL8U/JgcbtHqzoEsF
 46tV7XysExt+fGmt+/y9oZAiQ6JCJsDer/GBM2HjVu6vL1iFE6U1CfwTiuVX2fSw7C
 VS2Mq5pIumaZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3A022E85D90; Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yl2VJEuDCWT4lycg@debian>
References: <Yl2VJEuDCWT4lycg@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yl2VJEuDCWT4lycg@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.18-rc4-fixes
X-PR-Tracked-Commit-Id: 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10c5f102e2be6d816938b168104e8dacdd5bace7
Message-Id: <165048482022.8655.12098974779681773850.pr-tracker-bot@kernel.org>
Date: Wed, 20 Apr 2022 20:00:20 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 19 Apr 2022 00:43:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10c5f102e2be6d816938b168104e8dacdd5bace7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
