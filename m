Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F768216F
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 02:38:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5SP74pLWz2yxQ
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 12:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y/W/VgyP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y/W/VgyP;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5SP127bjz2yWF
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 12:38:13 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D9C39B818EE;
	Tue, 31 Jan 2023 01:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78657C433D2;
	Tue, 31 Jan 2023 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675129087;
	bh=p8rjZ2ZSEPjYMVeONqI71+TRmPhpzTGSPlp4lOd32CA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y/W/VgyPoIN7rq7iQdpEymtUzWijQCBPF7nQ0mGuJ30YgqpxR0PAhTF2F+7UIQ5a5
	 0R6JGhsLcfIUL3gN8VND2m2ekcJKgr9qgqRu1kDv64fS7ZyebkakVRB3y+Ss2H9JXd
	 A5NdeE2+sl2/qwp+KizR97BsNauedXaU7aKZF6+VQwtJ4vBwXA/lB8wSkfe8KvgwhQ
	 +SFODQYnJh1jaBZGM2efvWXbqawpiwLeGlhc+fbzcDUWy/H0bkO97pfp8N6W73I2Rp
	 7P4LX/yk2QrY8jtRxMmSrvsf8UZbFvXl3wWywHniBYuXOSg34ByMOQoQ7M3KcI86lh
	 HurKPywxWOMLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624EDC04E36;
	Tue, 31 Jan 2023 01:38:07 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Fix incorrect mixing of wake/wait and missing barriers
From: pr-tracker-bot@kernel.org
In-Reply-To: <3425804.1675083883@warthog.procyon.org.uk>
References: <3425804.1675083883@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3425804.1675083883@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20230130
X-PR-Tracked-Commit-Id: 3288666c72568fe1cc7f5c5ae33dfd3ab18004c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a
Message-Id: <167512908739.24036.4996707554388866402.pr-tracker-bot@kernel.org>
Date: Tue, 31 Jan 2023 01:38:07 +0000
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
Cc: Hou Tao <houtao@huaweicloud.com>, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, houtao1@huawei.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 30 Jan 2023 13:04:43 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20230130

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22b8077d0fcec86c6ed0e0fce9f7e7e5a4c2d56a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
