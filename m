Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A33B6B5C
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jun 2021 01:36:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GDPBp3XPYz30Cw
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jun 2021 09:36:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CNA5eqno;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CNA5eqno; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GDPBj0LHkz30B4
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jun 2021 09:36:28 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id DF0FB61CBA;
 Mon, 28 Jun 2021 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624923384;
 bh=qXmWFItnTdYoBR9+K5Sc4/OlhXsrkNE6YdO//n+SAFA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=CNA5eqnoG6eXHQqdINNHO0//vMVfS/rdX06vcDvw0nvJQUkzNmFfvWOGzFD+H+hVV
 YlhXK8bxSlDtlyNiSA7k0krt1lO4GeRVbdE7BQnhq74Eo3BHJCIBLVsE4WA322DcO+
 WDP1WLaNageZyaE2xzY5pWe8jukejJyLZElj0gJfWkGSvqubAspEAe5VRX7hP9TYHa
 OZzI9WIGq3w/u4t9/rCFvHYJFlFrJAeuxEVOLieA/guP3kHy/vGtcDlTEOrSJ9rkPb
 Fie2U3uSfpsMZ/u8jweHDwedlH7PcOnHr8HWxTjccRnQg7mvNftgjIInMbgT+EWh/W
 FDkEEu5nNFZtw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CBF2D60A3A;
 Mon, 28 Jun 2021 23:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.14-rc1
X-PR-Tracked-Commit-Id: 8215d5b7f15f8643bf12fe005b2bc0cc322aff62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aed4d57b113f81214bea1ddb10480f620ade800
Message-Id: <162492338477.13806.9034684085428438298.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jun 2021 23:36:24 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>,
 Wei Yongjun <weiyongjun1@huawei.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 28 Jun 2021 23:30:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aed4d57b113f81214bea1ddb10480f620ade800

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
