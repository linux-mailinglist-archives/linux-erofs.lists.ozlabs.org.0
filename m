Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E236BAE9
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Apr 2021 22:57:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTcfd72vJz2yyP
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Apr 2021 06:57:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QASn3CCb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QASn3CCb; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTcfc0Rvbz2yR4
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Apr 2021 06:57:43 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 60B1E61040;
 Mon, 26 Apr 2021 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619470661;
 bh=TEYAr62AnBVTOciTzmc7DZY7DKSb+xBt7EG0vntXkTY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=QASn3CCb2CVoMAbHQPpv5ZbQgSCl5Xkt2RFCA/OHmeKnD/1TTWNtBgUn7xItnUyxd
 9MANjKEE9bLaelBW8rZuvz1yU7NozmlW0GJZJK+wENq5yyBjypBQFK39wJOvNUlzO5
 GwBjxtEbjn5v7/rcvTrn8v/2iYSXxWebOSUQBwJfJhxnIJN+VkOg1tVBkyugrvfvpn
 2SoM91xcnTqPoFlQe3K1pKmJ2slsn++6T9DPu/xhohCxl4O73YhwzdA0OR/EpU6Mv0
 RDX6OMx14+FvSnapJgpltAO5FX0roRT/cyBdgOPMTQ68EveZUYGGXdFMpkHYAMSU73
 OfQwm1kuz/dyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5A7AD609B0;
 Mon, 26 Apr 2021 20:57:41 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210426105733.GA4060072@xiangao.remote.csb>
References: <20210426105733.GA4060072@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426105733.GA4060072@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.13-rc1
X-PR-Tracked-Commit-Id: 8e6c8fa9f2e95c88a642521a5da19a8e31748846
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5b3097d9cbb1eb3df0ade9507585e6e9e3b2385
Message-Id: <161947066136.16410.13880106197001243863.pr-tracker-bot@kernel.org>
Date: Mon, 26 Apr 2021 20:57:41 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Yue Hu <huyue2@yulong.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
 Guo Weichao <guoweichao@oppo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 26 Apr 2021 18:57:34 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5b3097d9cbb1eb3df0ade9507585e6e9e3b2385

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
