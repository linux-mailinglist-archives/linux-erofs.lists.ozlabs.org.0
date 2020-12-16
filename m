Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E342DB9B6
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Dec 2020 04:44:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cwgwj01t8zDqKb
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Dec 2020 14:44:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SbmFEbbm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cwgwb2JHgzDqK5
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Dec 2020 14:44:14 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs update for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608090251;
 bh=2o+HUjbZOYAW9WX3CUsIxMGF/SZnDeVn+fubxMOp2jg=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=SbmFEbbm0O2a4CnU0BTgJowDF7EmAmhLkcLiZlhsrzVpiYa3US9GpmzUJ9O99Ahxv
 L+FAXLDRjyC4dhsnxfyKTcCwBI2a5KnmCz+V0hDam79kUTBDFo4gCZXpMf5rPa1MDh
 UYM+lc+nIzA+NaxY87elA6Ff9tDTe99r/RX06cOgvWCtgKh8bwhvxacKapWp+8cpn5
 ECDd/0lgXOWzxXbME3hZPVfKDoVD1/gfggFhLDcgRrPz66dquFGajoy6toamWvv+VH
 5CQRbXQJ2NRiRlzosdx8K0xkgpuAjMGXTY+PmLLOG78QX/LCPpGAqj8O7h73Rjs/V5
 4yUKcSZ6Y44TQ==
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201215100855.GA581189@xiangao.remote.csb>
References: <20201215100855.GA581189@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201215100855.GA581189@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.11-rc1
X-PR-Tracked-Commit-Id: d8b3df8b1048405e73558b88cba2adf29490d468
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88bd82698af86887e33b07d48a1aec263cbeddb
Message-Id: <160809025181.9893.10836368355158236700.pr-tracker-bot@kernel.org>
Date: Wed, 16 Dec 2020 03:44:11 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 15 Dec 2020 18:08:55 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88bd82698af86887e33b07d48a1aec263cbeddb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
