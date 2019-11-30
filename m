Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AA10DEF4
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 20:40:52 +0100 (CET)
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47QMDc0QL8zDqv6
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 06:40:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="tF2bZD0Z"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47QMDD5QtRzDqsh
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Dec 2019 06:40:28 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575142825;
 bh=YgkJswfgiig8ZdaD6RHBZPUYYGoSPSFIx9vRKPxCGF8=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=tF2bZD0ZgrSQBYEuqtqYcXkFec/DVhqqMNMayQCNZuBMUTuf3TU+D8216H+2pXR0J
 ntTFrhc9W8jvtmLAwMkTrF9GaRPFbQD3shzoI65A9kPk+GDaNaYnRPFf/w40YZlnJN
 nrDifMrdNRvvG4Hbuo+NQW0WMYnp2QXw5YlBlK7Y=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191128152711.GA4993.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.5-rc1
X-PR-Tracked-Commit-Id: 3dcb5fa23e16ef50b09e7a56b47d8e4c04ca09c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2d73c302b6b0a8379a679120590073b813d5e7f
Message-Id: <157514282582.12928.6503250259230440672.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2019 19:40:25 +0000
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 28 Nov 2019 23:27:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2d73c302b6b0a8379a679120590073b813d5e7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
