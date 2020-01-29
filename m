Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F1114D15C
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 20:50:23 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 487Dbw5PNQzDqSv
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jan 2020 06:50:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=mygKdnzP; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 487Dbl1nNSzDqMV
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jan 2020 06:50:10 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580327408;
 bh=QVc3M1p6hOZL9NmKs704mTG8RxiuAPw0MZhCrwfmV8g=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=mygKdnzPsvPt43UG1G+jLkMKz3bJctVOmPk+ISuRvnwWTouZMTXHVeAryU0Jry5dl
 Uv3pvH8jFCgS01la5Vz8wRXR8w03nZoGGavRykeJk+agOnxW/k/udrirqkPt1AecmU
 KOZazYITLwDOd7ED2v4oUFpcOlDywV5grtzINb8c=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200129020451.GA5348.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.6-rc1
X-PR-Tracked-Commit-Id: 1e4a295567949ee8e6896a7db70afd1b6246966e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3893c2025fec6f0fa4b2d794f36bd56a55e46dec
Message-Id: <158032740852.31127.11742982511993883563.pr-tracker-bot@kernel.org>
Date: Wed, 29 Jan 2020 19:50:08 +0000
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
 Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Wed, 29 Jan 2020 10:04:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3893c2025fec6f0fa4b2d794f36bd56a55e46dec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
