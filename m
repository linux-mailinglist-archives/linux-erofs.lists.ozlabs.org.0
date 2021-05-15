Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD63819D0
	for <lists+linux-erofs@lfdr.de>; Sat, 15 May 2021 18:29:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fj9nn6tWTz2yjc
	for <lists+linux-erofs@lfdr.de>; Sun, 16 May 2021 02:29:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BRNVqj10;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BRNVqj10; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fj9nk0GZbz2xfx
 for <linux-erofs@lists.ozlabs.org>; Sun, 16 May 2021 02:28:58 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C891613C1;
 Sat, 15 May 2021 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621096135;
 bh=1aAjMb/PMKY8MpaIcSW7Q3Y+qQrQc14gOdA0O0yknbQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=BRNVqj10Io1ifiqgZKM2mU7KS6b7lBEo/GMkbcqH9XcC52xsIlwMGt9m7WXKBumJg
 S16ufRzKaGaDfznPXCvwXMjHjkDteIVBi1YuYACqhilKVWYFNle5HjGi9Q7tGwycaf
 rX3elxqasOXua4Zecbu1xU6oH0X4qn9IJFCg464s1dy0Kuo6btoSTTwSwQVAEjqo4z
 n38oamFDnLNM3Iwc24GqCvHu2q4HErlPftQ+iT1+RnaHKFyDgGFtU5XQhqtTVHMBjc
 UiVHWsiNj/8ipK22oFUhr1U8Dg0uZXZcrYS8uO/zciM0YVYwNGZDjhJeYRN30IZ4yk
 /kj/Z3UDMZErw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain
 [127.0.0.1])
 by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A1BE60727;
 Sat, 15 May 2021 16:28:55 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.13-rc2-fixes
X-PR-Tracked-Commit-Id: 0852b6ca941ef3ff75076e85738877bd3271e1cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41f035c0626521fb2fdd694803c3397dbaddc9f3
Message-Id: <162109613523.13678.12019869520982105265.pr-tracker-bot@kernel.org>
Date: Sat, 15 May 2021 16:28:55 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 15 May 2021 10:07:31 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41f035c0626521fb2fdd694803c3397dbaddc9f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
