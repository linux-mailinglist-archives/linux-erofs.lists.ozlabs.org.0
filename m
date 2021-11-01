Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAB442155
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 21:05:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjkXc4hRbz2yHP
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Nov 2021 07:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6ETw+jm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F6ETw+jm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjkXZ2vBxz2xh0
 for <linux-erofs@lists.ozlabs.org>; Tue,  2 Nov 2021 07:05:02 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 314D760FC4;
 Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635797099;
 bh=zB6FquU3FizSgEVNz2wf/9ZogROCeYf8bVP8abqHgps=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=F6ETw+jmByXG2Kv1BnKMPvCeMaEGxZHgC+dWjQ1W/ALzrnqmIzvGahNm0YS8b22X/
 w2Jyr9pr4Xymm849FW46xHJJjwJy9HCfCSchpuT3+IpHBBMBg/YmrMM+6sjydRJezs
 AAlJm2oKeleA8ZqzaNnlxSrf59zs7neCcR68HGyEKVGgZSayKfbsdtNJKMEKbY0T52
 8ox0c5+SPJZvkJFRi2/fDgVNTusCeC/1tEe3nH8BC6xOIEPnCfCXofAPnznEDFYDKb
 yes7zvmhJTsyWrGX2Xeefy3oDxOIuk1VaOmw6IkXn/pJgJn01FxfDJigMKxP5Hl0BE
 jnLQ36wJSzksg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 29C8C609EF;
 Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.16-rc1
X-PR-Tracked-Commit-Id: a0961f351d82d43ab0b845304caa235dfe249ae9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67a135b80eb75b62d92a809b0246e70524f69b89
Message-Id: <163579709916.1875.15474563954203260409.pr-tracker-bot@kernel.org>
Date: Mon, 01 Nov 2021 20:04:59 +0000
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 1 Nov 2021 08:40:32 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67a135b80eb75b62d92a809b0246e70524f69b89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
