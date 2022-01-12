Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27B948BBA6
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jan 2022 01:13:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JYShw3NBrz2yxm
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jan 2022 11:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kXUSvKGM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kXUSvKGM; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JYShp2MqTz2xY1
 for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jan 2022 11:13:46 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id A3AD6CE1BB5;
 Wed, 12 Jan 2022 00:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226CDC36AE3;
 Wed, 12 Jan 2022 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641946421;
 bh=mYFAr0fdiwChTVqjFuOpPztelIHQR5xDLGgL3UOsfRw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=kXUSvKGM9LDqJ20N+oRPOZh8UY1BWZMx1aq4RvIvKNiRuRCB1f8iMMumIVjwHrU1o
 ct4hEdTfo17xwK7P68EJiHoMRR3xiKTgZRWwqvmpIDIADR7OxyMjbk8Ifrc+0zdRbf
 35cMw9cPo1/TJZuoWuMj7P9SD6U9wnKMPANMKLpz/4GiRBV+ChT2ggZgZcUCR7H20H
 cmhbbFQGf2jn0/vWzMufYBZeopDHpTM4ksFlC8dV74SR30mO2SnZ/kk2u0qPS9xL+v
 RWeHWrt4XEV5DJIz7/6B5SaMhk5CYVQl327SHte6m+++VHMk2CSgo+cMJh0E5+TTs/
 79YC6jINhy+NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 087CEF60794; Wed, 12 Jan 2022 00:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20220110023303.GA26979@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.17-rc1
X-PR-Tracked-Commit-Id: 09c543798c3cde19aae575a0f76d5fc7c130ff18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9149fe8ba7ff798ea1c6b1fa05eeb59f95f9a94a
Message-Id: <164194642102.21161.13755763655607396721.pr-tracker-bot@kernel.org>
Date: Wed, 12 Jan 2022 00:13:41 +0000
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
 linux-erofs@lists.ozlabs.org, Peng Tao <tao.peng@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 10 Jan 2022 10:33:09 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9149fe8ba7ff798ea1c6b1fa05eeb59f95f9a94a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
