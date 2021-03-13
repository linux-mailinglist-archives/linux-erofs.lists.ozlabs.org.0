Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321B33A120
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Mar 2021 21:45:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyZT46h6lz3cGx
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Mar 2021 07:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xp7rKFZb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Xp7rKFZb; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyZT24cwbz3bcs
 for <linux-erofs@lists.ozlabs.org>; Sun, 14 Mar 2021 07:45:42 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 0411B64ED6;
 Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615668340;
 bh=OxclE0IRvk0O9yDw59ilEel2JELIYvpEdhMsDCBRMOM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Xp7rKFZb8/nlyfPuqwEVzUDHau92kOpSA3RFljxt28Wih/XFxrpBsSOwXEktZs25O
 i8hHYkjWCr4ZtY4/OlGq+dHHoEKPGLxzerU+AssNeeTuV7oBeXb2k03v226X5dDC5+
 szuzNtp0dyr3NSrxpKmTRO/jejJxzdfIDzXR0GChFTJx0zbw3GEFSGOYNhJv2twCke
 uT+cdsX8UqIHUmj/rAFN68irHrSyqpL5qJzrQniCIeo0bTk4VoIcdTZ7mnVKoxSB9S
 X+IeAMtXLmysjG4CH+hHtwvwodTb9ZBTqrPxD3b/IoRQV6JJhMjdzKdDadry3IauAe
 a92bJqst3v4cw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F3D3660971;
 Sat, 13 Mar 2021 20:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 5.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210313124044.GA488856@xiangao.remote.csb>
References: <20210313124044.GA488856@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210313124044.GA488856@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.12-rc3
X-PR-Tracked-Commit-Id: 9f377622a484de0818c49ee01e0ab4eedf6acd81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 420623430a7015ae9adab8a087de82c186bc9989
Message-Id: <161566833999.19597.9631392118505520065.pr-tracker-bot@kernel.org>
Date: Sat, 13 Mar 2021 20:45:39 +0000
To: Gao Xiang <hsiangkao@redhat.com>
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
Cc: linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Martin DEVERA <devik@eaxlabs.cz>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 13 Mar 2021 20:40:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/420623430a7015ae9adab8a087de82c186bc9989

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
