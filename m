Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F3501B6A
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 20:59:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KfTJz1RPSz305j
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 04:59:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qZeSw6bL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qZeSw6bL; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KfTJq6WJYz2xKT
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Apr 2022 04:59:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F0E0E61AD2;
 Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A6BC385A1;
 Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649962744;
 bh=x/weOCQCdvFtzXlyiWa6EIeco2L9fkCRTJx4jP9BVB8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=qZeSw6bL4FtjZRW3tzVe2uFuhoR3SUjEm3HOUGziwpkmqJ1Pk7NB1/leWB8ZiBMGt
 Rft4mPS/efypPjma7PByAB+7ON1sYITnhY/WoUiy2AwgU/q/GdJ8YF2gQmgKUAyvLx
 OCxTo0FxIjd3hwSmaKEmrqehfb8lBhOd1wqHt15t7RZlJDDeBVtb2W36+rlWGDuxOi
 GQp2nMlwK8Brl6cK/rqWJ0r0eT2n0OMwsXHdv/Hed6T8cCOuwDJY8P4NN/56W8ueht
 /ABZcHckXUHG/0zUMQ/dwP45qjN1bgAPCrHlaEAJC8VyhlaNahvzi95euV6qjAtopu
 zyH9IFhcju24g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3E806E85D15; Thu, 14 Apr 2022 18:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Miscellaneous fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <2266868.1649864097@warthog.procyon.org.uk>
References: <2266868.1649864097@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2266868.1649864097@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/fscache-fixes-20220413
X-PR-Tracked-Commit-Id: 61132ceeda723d2c48cbc2610ca3213a7fcb083b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec9c57a7328b178918aa3124f989060bc5624a3f
Message-Id: <164996274424.15440.4867741345263392092.pr-tracker-bot@kernel.org>
Date: Thu, 14 Apr 2022 18:59:04 +0000
To: David Howells <dhowells@redhat.com>
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
Cc: linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-fsdevel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 13 Apr 2022 16:34:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec9c57a7328b178918aa3124f989060bc5624a3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
