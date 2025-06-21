Return-Path: <linux-erofs+bounces-483-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B30AE2A55
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Jun 2025 18:35:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPg252P4Jz2xlL;
	Sun, 22 Jun 2025 02:35:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750523741;
	cv=none; b=bLuCtwhlMaK5LnlqaoRP8aWxI5PgJbgG28sXIttJxOTwHdMNBCeotuvcqY9yP9Er4kKTreUmGYylAYk9ofCon1Cl4VH6wOwk/4fV+3W/Mf1AfPWQYvU3whTGiNrVU9jJceyBYeXNrsGsIz3Ao30wprhFaJqZJ27j1qANlxFbSu5e9AAquZTCL0xBGnfOd/y+wL9Cw6bv+DMnhrqgbADlt+bIHU5Q+1bR9K6lPTa3qRC5vbhRxVQ6qq4trSenOreTkO5LJnC553gNqP50+GzEkKwPV9ZCQxjv2bfkhccyB64RUWJFfQfAO8J+hbEehZYKS9fXAz8mesTWlubWBDDV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750523741; c=relaxed/relaxed;
	bh=tGhScSNhYyoLxmCATNO3yqLkPXca6d2QK1ujiuvFJso=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UeM/JINMV+lA5puR144iV+hgelX5/fpjgFfsuUqZtTGZOtTRSNPI0/oV6+qjgfrFHrWEjOW0wzhBDZicFO9S7de9T4ymb+1DcNbc9y1dBoa1SkeaJ+NfnA0nQy4lQkWUUmDsm940Aikitm0D+lfezvhbOlA8Pz1zIkWbmXnfcgHDTNwMZRaX1wszCZq3NOtdlEAtqm6HF83qhsH5q51/jz5FKJHVpL5pt84Y9T62B8K/h4dcbZZN6DmWnXj45ecsKec445Mq7y9qOeX3C3Rgj69BFGn4WdBA6iewRTDFYOk8PrN7A9N4Ot4cbAXpW/RLpTTFZtlUYoMvgAKix3Ss/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S+vZksUd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S+vZksUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPg243FwBz2xPc
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Jun 2025 02:35:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 009694A64F;
	Sat, 21 Jun 2025 16:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D300DC4CEEE;
	Sat, 21 Jun 2025 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750523736;
	bh=zwX3PSozj6/GLOmVZwxvGwE85lFfWGoGDVeisaH3FCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S+vZksUdSYMEQYajwEtzQw7Ldf9OfT37zlIwO3hUeMaUdl+vz+V4BWemxvjEMIvtc
	 jO/scsxNUtuikSmWaEbxICav3bv9IC82khKItem7sgkEDhD2tOQPiECmYgY9YR19Zd
	 MZ8GyG/qS49ejFsQpVrWF7yY69x60HbzmOpNH5jxRhrDWsJ+1/y3X4VColLoqMb51h
	 UIuqnS2NvhzpSQQrI2lXtScyYOLmyciXW1iAB5hDt/fA78vopE3gVLSbTQEVGMVsoi
	 klIdrARH4kmGCSavU+jDJl01Gh8oqwZCbmTreh5qb5GiE91ENub9TQ5f7Dk138k3n3
	 v2w+NoU7VLYxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0238111DD;
	Sat, 21 Jun 2025 16:36:05 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aFbFC3q0SNO7ZkQi@debian>
References: <aFbFC3q0SNO7ZkQi@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aFbFC3q0SNO7ZkQi@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc3-fixes
X-PR-Tracked-Commit-Id: 417b8af2e30d7f131682a893ad79c506fd39c624
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f9378d4a7dd862b28d83a062a2dcc6ef1a0daa7
Message-Id: <175052376417.1897727.2751233102628770913.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 16:36:04 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

The pull request you sent on Sat, 21 Jun 2025 22:43:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f9378d4a7dd862b28d83a062a2dcc6ef1a0daa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

