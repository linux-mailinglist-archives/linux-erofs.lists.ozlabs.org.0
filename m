Return-Path: <linux-erofs+bounces-1483-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51223CA259D
	for <lists+linux-erofs@lfdr.de>; Thu, 04 Dec 2025 05:51:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMMXn51Lsz2xC3;
	Thu, 04 Dec 2025 15:51:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764823881;
	cv=none; b=iH6LTdG8J53uvQlqhMlpGSdyIwXCahKN5Xq6jy8/xDLGe3ZS9xk9YQ5KDeCIrIPSgWYPt419lkzn+yvfYK0RIKD00ivl6Fbh3V511FtGtGsD5MXEYGCjqtry7ZgKBppOXfWnS/7kjkoquCI3tBjgrQmIR9Qdydsoj5xddiRVtp/UD3Y9FoY/nDdwgFH8j3zBcSZBBEd8hj4XsI1FlyFS6+kipopT+OgWTyb3MF6ewTsKyz7/OaNoSe7h6CJOgXjxufMK+HsJgRWDHmSpNEUbZyBSTvzEZg3qEYf0q8mWZfWv91sfj4zmkdaDbnSYfPI87dqV0lk+6Ry315jUHW9GKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764823881; c=relaxed/relaxed;
	bh=CH3+h6QPM9TjhGdW+hR5LZ2u0pLnwcQwZhtc700qSQo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jH5IG+0xJCDbJ6WdyyHzYDvQL39g0PkzJG7toMxAPxWyzEaoR0h8LWeU+F0kHo7UcVB+qjXE5mJyNIQvXeNBnPvJeAcbNlYcFERviBdIoyq1YuHIRHQ3jLiOQgORmF3S9WQDnSkvLW50h9nF8VxEuU/D/20B6LvTxR0vIkL4M2OQLXfZmt2PPV/bU9lzQeP1nRQhLz+w2t9n7YWVXfxeF1lmdEW4SImueauwvO8g9fdwb89NekBZdweDR3AqlzMBouTAAKHjbeGpOUbtEGMMTY8mqJwiMdZJmzNdLIkA7ybd5McRx3MA86OjxU8X+9Ri5E5gyq7tvZiKENtonJ49qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g9VuuXie; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g9VuuXie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMMXm3tHJz2xBV
	for <linux-erofs@lists.ozlabs.org>; Thu, 04 Dec 2025 15:51:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2FDE442DE;
	Thu,  4 Dec 2025 04:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28F5C113D0;
	Thu,  4 Dec 2025 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823876;
	bh=giz+C39eNneeBABy+c6qEetaLaq6QDSpIMrr7wQNKpw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g9VuuXiezy+vVS0sCqZ1FXw/Npno0SsFW75N+JcAov47DJzar5dFUiSltWAnZ4Qz1
	 QX4ejJAY7rhZG9R4Zw8+oaxsumzjZPaCu1htqlWAYfz7F0Zv8sYAx8McCnALmQWXl+
	 2hyDFO56BF2+4X+6o4yf4iS7SnDBGZasvSSENGIy8FAkpQubbUPgwVL286/pGK8yxg
	 bTuMQZ+iB77/WV3UEIy5C/MzggtDrT5ErSpOuu35sMQlcxCHgZAiUHF8/+QrokNbUt
	 7xYzNGRwdy66AI4k88FZfgxjfbvu8rozz8ETgOzaTiQc3F5kC64q7Hfgee9t7aax55
	 4JOt6UhT2ZE+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789473AA9A8A;
	Thu,  4 Dec 2025 04:48:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aS2AFm3vf2aJWJCB@debian>
References: <aS2AFm3vf2aJWJCB@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aS2AFm3vf2aJWJCB@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc1
X-PR-Tracked-Commit-Id: 0bdbf89a8bbeb155644b69dc2d071a1ce23414f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477e31fd1e81ef925ce55931bcdbf609ba2207c8
Message-Id: <176482369510.238370.5157840103634230103.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:48:15 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
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

The pull request you sent on Mon, 1 Dec 2025 19:46:30 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477e31fd1e81ef925ce55931bcdbf609ba2207c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

