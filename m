Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B522BC932A
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2019 23:00:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46k7nm57HvzDqW4
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Oct 2019 07:00:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="qMF4rCuy"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46k7nc75TrzDqFs
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Oct 2019 07:00:20 +1000 (AEST)
Subject: Re: [GIT PULL] erofs fixes for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570050018;
 bh=lnqWT3HXwWR4KU58WzmU1vAViNtSyLf2IW1JrqTUg3Y=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=qMF4rCuy4Vt+ANcph1DvWjwPFyR+2qf2iJ2WhHDXugSI97tEFBH8vuWDB19zYagVD
 fY+jnmHFFVhL3h+bo1jqCXESvQKzjSvgcvp04lZ+VDoLx/KAbDl01R+yItd35tGNDw
 Jw7WFSIC6+U2HtAcbTMBUWoBC4XK+khtysV7/yMM=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.4-rc2-fixes
X-PR-Tracked-Commit-Id: dc76ea8c1087b5c44235566ed4be2202d21a8504
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65aa35c93cc014c72bae944675ea6e88c47a5497
Message-Id: <157005001798.25857.18035498047418829076.pr-tracker-bot@kernel.org>
Date: Wed, 02 Oct 2019 21:00:17 +0000
To: Gao Xiang <hsiangkao@aol.com>
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
 Linus Torvalds <torvalds@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 1 Oct 2019 17:09:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.4-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65aa35c93cc014c72bae944675ea6e88c47a5497

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
