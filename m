Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5E41840F
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Sep 2021 21:07:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HGz0l3cj4z2yNZ
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Sep 2021 05:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HKZqWR+z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HKZqWR+z; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HGz0c1dT5z2xtj
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Sep 2021 05:06:56 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D50061077;
 Sat, 25 Sep 2021 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632596813;
 bh=E3XCLKC9Qh6rBwCl2SNh6TUGSBEEmNTtGj2TFLQzLo0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=HKZqWR+zGDEZTxU2XePVsvCf1ocZrDYuN+oUjCY5eoC8p9Zi3LvLiFjAL6s1buQDv
 xYdb7j4hQMvMUDiB9OsO1WBYWLcngi44jY/SQpz8D4637rNTdCyoGoMQY3JD4q9bwX
 IMTxXEy75xLW0/DGbTZDJnhee8pheXITNfletzNWV71v2BnWxB0QWnvhjHOJdA5XKK
 RXzRO0AYW3Isy+p+sTKWZYWEZNggpKRwIlS3aARjrubBcPYknIk47p0L66sY6kROZ2
 jiLfx9k26YhwXkY0dBaIFVLcSI7Y6QXc60eYGKi6dtkEXpR3fBoNU5i5lywFUVuTll
 JSEwszHeIGzJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4135260721;
 Sat, 25 Sep 2021 19:06:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.15-rc3-fixes
X-PR-Tracked-Commit-Id: c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e0aceabef618e2bb3d96c096002d8326d46a83
Message-Id: <163259681326.4077.6964995249381369146.pr-tracker-bot@kernel.org>
Date: Sat, 25 Sep 2021 19:06:53 +0000
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 25 Sep 2021 23:57:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e0aceabef618e2bb3d96c096002d8326d46a83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
