Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E12AC620
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Nov 2020 21:46:01 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CVNLZ4J6qzDqf9
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Nov 2020 07:45:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=A7ce3J+S; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CVNLL6bQhzDqVl
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 Nov 2020 07:45:46 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604954743;
 bh=uj9klgc3PjWdBU1rWFimPbEWG5+P6C3Ao8mhNRNXhuQ=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=A7ce3J+SuOjs6Qyi8XoWr2SSLgD8No4Rev7OSspeAUte7AuD/UaU7Jzaam/f/WSYh
 WhbOkgl666/8eVPGZ+pzxF6dCMOAxsr1bBQmRNhz7M6XMLFCSkBsaKCaW44kfLTyoh
 e/tlJ0nua6laJeg/GlaVyKfE2dBFTCcIRzBixdAY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201109144023.GA2232414@xiangao.remote.csb>
References: <20201109144023.GA2232414@xiangao.remote.csb>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20201109144023.GA2232414@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.10-rc4-fixes
X-PR-Tracked-Commit-Id: a30573b3cdc77b8533d004ece1ea7c0146b437a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df3319a548cdb3f3bcbaf03bbd02822e39a136c6
Message-Id: <160495474299.25406.2199314582052116726.pr-tracker-bot@kernel.org>
Date: Mon, 09 Nov 2020 20:45:42 +0000
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
Cc: nl6720 <nl6720@gmail.com>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vladimir@tuxera.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 9 Nov 2020 22:40:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df3319a548cdb3f3bcbaf03bbd02822e39a136c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
