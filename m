Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D540198589
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2020 22:40:20 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rkqP0VJ1zDqdZ
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2020 07:40:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=YcDeCn9G; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rkqF4NcpzDqcP
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2020 07:40:09 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs updates for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585600806;
 bh=cHzfQoKbVQUqHdX+/LrYyMnzkUBykPIX2ElSc3E/KmM=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=YcDeCn9GSXm1aCDZN566cLL2fkG7pRnwvJO7+wq5xigfGK9CBKRiPp0a653slMD+1
 LK2AnFWxUXh+4luqOikeyBMBoUQnvPPuUQq9xIMFUpYWevdR3ou27OmS6yZfPuz3vl
 sHnPFWcJhcuXhS6D4444uQdXnTcM2SJnJB10lFyc=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200330023830.GA5112.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.7-rc1
X-PR-Tracked-Commit-Id: 20741a6e146cab59745c7f25abf49d891a83f8e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 377ad0c28c1df7b0634e697f34bdea8325f39a66
Message-Id: <158560080684.3259.12757063213872171906.pr-tracker-bot@kernel.org>
Date: Mon, 30 Mar 2020 20:40:06 +0000
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

The pull request you sent on Mon, 30 Mar 2020 10:38:40 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/377ad0c28c1df7b0634e697f34bdea8325f39a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
