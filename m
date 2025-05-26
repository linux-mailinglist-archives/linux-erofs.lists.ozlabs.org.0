Return-Path: <linux-erofs+bounces-368-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA51AC44B2
	for <lists+linux-erofs@lfdr.de>; Mon, 26 May 2025 23:19:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5pYf6dgcz2xRs;
	Tue, 27 May 2025 07:19:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748294374;
	cv=none; b=T1V3plpKikOQJugmSUrkoGZgqqdyDdohL7+8SrF0LAQxRz0wrng0lG1niarM2lkfWFrvy6K6G4M8YKk6wJCB16IkqUbDaSkdHh7DQqBLFRoup5yvmv74sCErGsQg3lf3zBfC4j68Q/Kc6WUqNYK156cYSek7kYJYOb+IgcxB5GoyS4Xqwj5DmhDw0JqLDNsBqNB3J0QQY/Ml6M0weA2G+eCwDNBKJStt9IU2XyJaD/gSYLhADHSjZ7AljO+jAPgOpVoF6tGbH4T6OndrHIJUfqUc0ZpNa96OozXkLrQEugL2pe2xv+Rl5ZFbZfQ1Z4JtCsEW75hsSOqRExyK2F/maw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748294374; c=relaxed/relaxed;
	bh=bf+wAxvHDDFpTv3NmtESq5iDvGBALYQBB5Yn58SkSE0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X1skPylgFrgDtXZl35sAhnYvgSohsVbID9UT94D1K8sSq6gY1Tnfd8zXNGHt3Hf9hCdBvPmC0G5mDirjkdVS+BZXhqSYeEXk5OWfTVGebyCc+mcp9Ag1JAmtGBljndua0+SAvU03Imaj/6s1nsej1Du1LqOp+e0d2MQRVQg1lKZoWEKroP+IxgSl3y03mVYGgeMW+ASS8N5iisTByrzgBd5cNzi+KZZt2QFkCf9OG45nBCATIR0D26ZS4UA385YLil2iihKZEaXK4DzCLNmWojzlvfpmIk1mpYUOG9YZKhNAnsmdYvxSF2vtFVD6oPleFi0/KzVfMaEISc3ucHHhiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mu4hIzw1; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mu4hIzw1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b5pYd5kBNz2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 May 2025 07:19:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB0225C4D8E;
	Mon, 26 May 2025 21:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BE5C4CEEF;
	Mon, 26 May 2025 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748294369;
	bh=K+LQg1LQttFKAs79e3Wwkg8grS3r4IoL6BsKrP6Y9QU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mu4hIzw1eHBa8xwTk1c3icrTS9X6jR3AhT712yGOJqaR4fQ0s9yaTdYTojOn0oxUQ
	 f70gDk/8J9Y/dPPGXJXK6vwH/MLy6K0xpPcj/lcJL6ACIo8/kecW7O/lIFqRDpBzRn
	 lpAFIRQm8ph7CLhIZHvGBJ5KazBgBeFNAaGlSqZgsiiDup3X73il/RtW4FEO12hTYm
	 9HBvDbU5O39VJAHwNfzLJGaqch0Hc2cc9Xr1/Jha2oWEUkIs1AMLhRMBd/4iUslcjY
	 NGxuYNJlregbhLiQT0Ox/71N0MFE0XpBbxHjskGcSpANjrucbLCX5RB58dGbg5ncBz
	 dd2Gtnwf/dq1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 354D0380AAE2;
	Mon, 26 May 2025 21:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDPu/jffhb499L49@debian>
References: <aDPu/jffhb499L49@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aDPu/jffhb499L49@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc1
X-PR-Tracked-Commit-Id: b4a29efc51461edf1a02e9da656d4480cabd24b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79b98edf918e8146047e08817e2a42937428be02
Message-Id: <174829440407.1051981.9879376881607405870.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:20:04 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Sheng Yong <shengyong1@xiaomi.com>, Sandeep Dhavale <dhavale@google.com>, Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Mon, 26 May 2025 12:33:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79b98edf918e8146047e08817e2a42937428be02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

