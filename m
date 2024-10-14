Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A402F99D741
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2024 21:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728933790;
	bh=DW8vMO/zWtxkJ2I3OB/JA0MpfH2i/3sTbWTX4vvHKgM=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cENVOk8wDaOgugOyNJFF2BmOuTyrRO4SDakmF2uF+wqqDPuj7M3pPUiOafrAalG2f
	 KDc0Sf87GhX1xFKXOp4w2NIVISszfD3zanIjWF0GAWhJ+dUMzxPnhDos+Gry+Z5G3c
	 hTOwdT0t3yOcsOKMzQVGK6+YmHJOObzcD2UB/L2rTRt+NTnCMdBkIx/wkUM2nofiW+
	 MUA0KmRYmk9NnwySjjUmThQcza6eJDDLx/w7F2FAwoM38gMnaIGx8fV5qkB40DoDs5
	 V9fUyq+wTj+p6+ghnG7rq/CRduE572yfRDm1oySPsr1NyuEOit7EdGs6BURAE/UGtG
	 34yGtm28C7JEg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XS6Zk221Dz3c17
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 06:23:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728933787;
	cv=none; b=hW3nS3J9SqDAtwIM1yl1JKMZhc+6JKgIfysAnuFn7u7UkSBLifu4VleQwQ4eVnwjOdoGNp9fqzFzYzIRKjJ3ZeDM3IfiCnE8We+LgZE46KZDPFX1LJOlNxNF8prt/LC6LER+Z4qQuoNZ72gaE31w6SCU6q1kbAbIPILWm0u9LlF0bGhndMX3tryMJIlYqbmDewcCUT4yqdv3kJNVAV36lxJoh+CtJHRC/KxoHrxk6heBVlV2ebU+mhkV4Kho2u/tC5Itd/3tQX9XEwrEmSnNpYnahdxxMB/jeGjvL3WrI7fARwPxOqxbpcgYDnGNWT57cCCS/HFcoSOxe1oCC3ZhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728933787; c=relaxed/relaxed;
	bh=DW8vMO/zWtxkJ2I3OB/JA0MpfH2i/3sTbWTX4vvHKgM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wm/g030Wh0yATONvwHV61Z87LAF8vO3o8rTdDQl/SzqtTa1xsj6AkdohlE7fxG5LtXMAl9pQ1EQ8R6EL08RqXKVNJo4JElmJnvffvh8660jQYGybrgOnYEn024RmgExePnFEZM4W/ZwBHssVSIuk/ZoEz2B+qkfi5MjViV+OqQMaO91GCNkD8r+wOXIrFiQioIEV7ZUQLt+bXERTmJrZOPKIJRSo4Wj38TYm+eGzXAQfxftVdCsWb2Owj3tOfVcKraUx5zPCFAmgPkALU6PXM7CRF0Epl3GlGrtu+mM6rgZZlfHbBFv/x89tahReBRcnD5rpeuASljrGi/PM2AR4Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qAz9tIGE; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qAz9tIGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XS6Zf74mNz30gn
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 06:23:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4EBE45C5B79;
	Mon, 14 Oct 2024 19:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29C1C4CEC3;
	Mon, 14 Oct 2024 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933783;
	bh=dCUME0CI55Wl+NRXuXAKP5D7ZiIsOcTukDnUZQ5AyaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qAz9tIGEcu6tlP5ZdtvuowBiz8iMvGl3uqNCWrHQI6LCTJEOmma/qDpi1rxuAZK48
	 oP+7cN5Rx72ilIXCU4G3lkydMy4lwE822m8boIaQkOtw8lRYd/gv9sxd2UMqM2+htt
	 vQF3BHDwhkzlWPDgloOQ9p6P8xJfMWZEJIIHD4nDinE8RlCubYNccPmVWMKoUsHGFh
	 D92LqkBP6CYDkO71XDY8IufAeMBHQgq4AmR7PnhGqxOxFqVAgDdeSPRPkmxXLGfpOK
	 GZvuU6HaTppnAQphjwa0P6QXn0Qo4t3AxpqGBlMwFaoE8bdR9XntxEaEQv9ydQDMrS
	 bb+U5UQj5Uvpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E333822E4C;
	Mon, 14 Oct 2024 19:23:10 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.12-rc4
In-Reply-To: <Zw0g5xS5WXYve0Hj@debian>
References: <Zw0g5xS5WXYve0Hj@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Zw0g5xS5WXYve0Hj@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes
X-PR-Tracked-Commit-Id: ae54567eaa87fd863ab61084a3828e1c36b0ffb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63fa605041843b50ebc8dca6483dbfa6e835c61a
Message-Id: <172893378871.615880.7545042172265090461.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 19:23:08 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: pr-tracker-bot--- via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: pr-tracker-bot@kernel.org
Cc: linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 14 Oct 2024 21:47:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63fa605041843b50ebc8dca6483dbfa6e835c61a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
