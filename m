Return-Path: <linux-erofs+bounces-1279-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC47BFCD13
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Oct 2025 17:17:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csCTW3lTpz3bfF;
	Thu, 23 Oct 2025 02:17:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761146271;
	cv=none; b=P/eY/HaQCBHI+28G/c4PIclA/ZWi0A+nARdD8fEs25Amg2iVgeMAexdMAc1NAp3r0dpJ/T02DJafBuWOW+bBRqcS7Evhw+AVA+8stnLXhI/z0TAt0KaZ/qwoj3KAQ94ZydSZR/SJ5bHI4DbSxW9UvYaVw2fT+jAOcMJZeeyNAC7ThGZRyhncA7dAcMZXFJvXVw13EblfFr+NjLUGTvGMMpop7E4Pnx/lUXjjSfA+Rj7EYbh0EDGdCiDNnLt6IpGwpVmXY4kmaJKTpclFmz1fm0epo7s0zgFLDx85WpqLVAueJ63wzRsS+oEb7CCyQ2C1HFJV/ocL78aXIDk8djiITg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761146271; c=relaxed/relaxed;
	bh=FLP1JbqtFFTPClk6gOmmXIw39K25oVVMCsfmEItKL7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JDO8hEH1wM9KI+Xw3SCITgWSZJWWtFCnoHqEL24oyaVETW1d01o1RfP7YzY/JrIA6q70Wa70A3tA+wUvpdV+2IE8irGB/upz7S7J9V15kr8kPfwnXEDdOEJk1II2UDc+Katt1aAUuAHj3YSwSPuCoWj2CSzy+aMUmoaoVZMaBJUbEyWBy9+3lFYQH1TmWT2O0QuT8QkUYqRtMz/ta3SAgZ5vrCcaLHh2ELvJKCtzgXrf17QuVCPJhSwKr25Q9UMKgARv5G8qNCx4xMwWdkbCCBYFAe4ejnThhR6B3YvEIyLrpFym/AmlSiAPnZI5G61NEQ8bnTZ3cRK4I1Fj/9xr8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G8xrS+EH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G8xrS+EH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csCTV4x7yz30V7
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Oct 2025 02:17:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6BB9A604FC;
	Wed, 22 Oct 2025 15:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7FFC4CEE7;
	Wed, 22 Oct 2025 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146268;
	bh=Xt+lKHQhO5uqz21P3uQZy09wOgF1ujie9GTUJ388NwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G8xrS+EHuFW2JEH2qhgr/uVPrJGDYMgjQvqk9PoKCPZAF4pBQxIAjDAPSrtl0JnNY
	 9m54eHgzJiHiZqy8gIe4pnzeoHdmesynkHbjP7wXcWUvavBFkwzEPjdvNm1y4IN95x
	 5fXZ2h/uhpO1vo/WmrDr6+fy4Ix+imSAt9glP4OnkkCrzF4vRpj29M5hh9oqQLhLgu
	 88ReI9/1qGN4PpAIsW4ERIM+dTQTfSzbqlWX5JRXZqkZaXJV/CuYLW94J/NIx8sYg/
	 sm8W5h+nfihgrSDOVbXHqVwPaEnk8Mor8DdpHSFbnmaYNrUyIGwu/QUZnucP83TTJI
	 Yb9bx4vHWG58g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343873A78A6C;
	Wed, 22 Oct 2025 15:17:30 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPjpkWvwoMrKHxvc@debian>
References: <aPjpkWvwoMrKHxvc@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aPjpkWvwoMrKHxvc@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes
X-PR-Tracked-Commit-Id: 2a13fc417f493e28bdd368785320dd4c2b3d732e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 250a17e8f9555f5c5207581068ebfa2aa1f540a2
Message-Id: <176114624867.1971781.6453629058093549500.pr-tracker-bot@kernel.org>
Date: Wed, 22 Oct 2025 15:17:28 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Wed, 22 Oct 2025 22:26:25 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/250a17e8f9555f5c5207581068ebfa2aa1f540a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

