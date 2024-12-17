Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A49929F530D
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 18:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1734456299;
	bh=14GzxjDK/S3YYwHbKCRpwfQ9SEoXUZxVLLUkAJGy88k=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Tm+pIW4azc9iWEow2PXuYOTvHhpSdDxou6eD6OyrTmfsXx8XM6X6qQUeGMrgc/mUf
	 VjSGIK0451r54icder0glJT2axk7tKECsi+FRgEPJuRS6nGSkz6aDhOaqq53SThVyg
	 9rIOus3mgd7dZ314kIeR7jrccDlMWIQ8+opby5s+ANu94VQ4bbA5qjNHbmNXzYEDwp
	 6Fgw/c09iNhZs7Q2bxl6fHOPzuR2whKyB8Gkp8OyA+EmZry7uRSqnfQP/d077Qd0fE
	 tJB9/i9aCLF3AdXsjyAF6RoutHxCZhUn2pJkj1rtnW+ChbjsfibZW3yaoE2rYmgmdU
	 T1UDl74NaBkMQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCNwq37bDz2yRZ
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 04:24:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734456297;
	cv=none; b=TAWlbUQfL3LRobt62apAGSfR1syiIuB0Nw0hPNyjtVOBfJM9rhEhxGff9X+jl5Ya20PFzwqP5nWtAl7TGCixJkxom5/c+v4GrCT7diKylGLiL86sL/ooZHe96hKZzH7Wr2DhOjm8ANULqzXSDJGEQzXhzqO4+g70UvGnD+J/E7o57UiQF9uZv312IJhMxYfwshYktB6e8nv2Vp9iRMcsEUMks2G7DtC4+J2+pq+FkgXxl8hjF8g5TxvprcXkydY+bGddUK1FXRqSMt6oRj7UP5sI8WsGwT+Z8ZtiNhakFvgYiSii2l90336MUslBAZ+WakxFXEoAEnjdAuLwp1M1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734456297; c=relaxed/relaxed;
	bh=14GzxjDK/S3YYwHbKCRpwfQ9SEoXUZxVLLUkAJGy88k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HGZ1D+rCNcAy2pKxpANSTMjAeeBuU2fLh/Cu6WSUUVE1bAM9bOAcB6op8Gk5SN0c2yV/A9kQ9wTf4+Epnh66IwzlGTWLc0OPdW8d/5Ij8q0be/ebZ4raiZ2/eDpRvFwL45qwvkp0sacUbiQx+g1X9e4gnki/NG3Irjc5Al1GAxMejucfQQuvQPhdu5yKvayRuAJZXQZiyinRS4q7VQI2zJOQm2pq2siJAm255xwZK2TqGgHe4bfebM4ZQ5nqXHIxenPesSh0m4ssHSc1LR0/zM23eelCSwQ/UjHz8UOAmnypVLfXwLKkFa/1LFz5Jv3BBP0cu1CLvUPG7DnnaKJrew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BMhcEoMr; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BMhcEoMr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCNwj42dQz2yFP
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 04:24:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5FA915C6705;
	Tue, 17 Dec 2024 17:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357D5C4CED3;
	Tue, 17 Dec 2024 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456277;
	bh=oGndJHx3kPL6sY3zlsI7/o1jzzaoLFH/0rOCy8bQ5zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BMhcEoMr7JiqOVabmymFXIBDa0fYt8C7RQhWqXiZbI3nyCR37RNwrXOxsEt2mEcDo
	 hBkN6ETFm1Iny4OpER/lBrQtgnNpJUXCWCHbGFA1aU+WOoue3kHIZjXhiUXL8tlAX8
	 PuqFNYoNRu+sNxhAbZwlfkjvC/Ep2Glix3OjilZ2j1sqfYQorZE+8/aoweEIQePeFo
	 luvS/imLwR+T2PNeGcNB8KlE4Lgk4iB4d4vWGO29v0aFytQJ7x1oTfMzBWZS6vmImi
	 lrmPsymM0Lrm4pS+Qb2R5MV6i5u7usTfV+yeShQuh55Aoidl9AxUgvOyu6UODynddu
	 pSD1wzOmrItGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1363806656;
	Tue, 17 Dec 2024 17:24:55 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.13-rc4
In-Reply-To: <Z2GJfmDTrzh0mM8P@debian>
References: <Z2GJfmDTrzh0mM8P@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Z2GJfmDTrzh0mM8P@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes
X-PR-Tracked-Commit-Id: 6422cde1b0d5a31b206b263417c1c2b3c80fe82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed90ed56e4b1311797302c2e6107f5049ba4586d
Message-Id: <173445629432.974395.9252918788891852590.pr-tracker-bot@kernel.org>
Date: Tue, 17 Dec 2024 17:24:54 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Tue, 17 Dec 2024 22:23:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed90ed56e4b1311797302c2e6107f5049ba4586d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
