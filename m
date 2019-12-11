Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3B11BE8B
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2019 21:50:38 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Y8G351nMzDqlc
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2019 07:50:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="mHrh2Qv1"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Y8Ft4zJ3zDql2
 for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2019 07:50:26 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576097421;
 bh=In2OppxUUmMhw77Nh597V626V7rNMRFuadsOqSA+vXc=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=mHrh2Qv1J/uKZr+j6A30SXVsvPImlXoSI1gexIdQDc6E7aZ9jM8YQGTfBSOG59vjs
 mzxlCCZeVSzbhJXQZJRfP6QM4qGmKuu2lse/aMStqDeGqOuO0Sq0ALH1QIPuAaQ+nb
 tfDxENO8aC/bS0roDISpnheby8MbWcqbKrvjrY3I=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191211170950.GA16027.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.5-rc2-fixes
X-PR-Tracked-Commit-Id: ffafde478309af01b2a495ecaf203125abfb35bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 687dec9b94599b19e218f89fd034d6449c3ff57c
Message-Id: <157609742192.20554.6170432426388502768.pr-tracker-bot@kernel.org>
Date: Wed, 11 Dec 2019 20:50:21 +0000
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
 David Michael <fedora.dm0@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 Wang Li <wangli74@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Thu, 12 Dec 2019 01:09:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/687dec9b94599b19e218f89fd034d6449c3ff57c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
