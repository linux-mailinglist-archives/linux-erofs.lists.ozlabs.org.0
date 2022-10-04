Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA25F3BBB
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 05:45:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhNrK08M5z302k
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 14:45:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FYD8xpXz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FYD8xpXz;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhNrC39DCz2xfV
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Oct 2022 14:44:59 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D2B0EB818FB;
	Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C62EC433D6;
	Tue,  4 Oct 2022 03:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664855092;
	bh=NoqojNcFXzfUqgBFfqu+BYWlUYNJaSSg4ZYHNlhpHEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FYD8xpXzShMy/4cBu+x5kC/55BpajXb0/Z31I/dj5gHQiJe7ZQlYmvkhgAQZDh0Uz
	 ydJLfUCc/pf1OqoIhIobL7SXjrcg/YJveNALPQ+9DxKN1wMEo9r7m+cdWrv16f/ECG
	 VM98JuWZ+wW2GaXz/YfTjMxnWBi3A8GbvMlyeHn+Xh/S/cyMDB8yRuN6Rh0XuSDQ/y
	 lOFeS1zZfnL6P9VmK5DFD6gAvqu5MHi8FwFzqjMd/p+RUFBcDE7WPK1nS5rezYPIQy
	 ss11mdYhoaxUPjZqxISv4bCjCx8o2aGIKs6NYxPiUVnBvzEzVFcf3fii23TNZ3Ca8p
	 +eyrXr7eVVzKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82974E49FA3;
	Tue,  4 Oct 2022 03:44:52 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YzrD50lgln3c9zEf@debian>
References: <YzrD50lgln3c9zEf@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YzrD50lgln3c9zEf@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc1
X-PR-Tracked-Commit-Id: 312fe643ad1153fe0337c46f4573030d0c2bac73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3497640a80d77cd098d45c9f3ab235b1aa472dbc
Message-Id: <166485509252.18435.13778164711420552778.pr-tracker-bot@kernel.org>
Date: Tue, 04 Oct 2022 03:44:52 +0000
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 3 Oct 2022 19:13:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3497640a80d77cd098d45c9f3ab235b1aa472dbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
