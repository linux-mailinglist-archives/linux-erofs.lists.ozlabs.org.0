Return-Path: <linux-erofs+bounces-126-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D1A73F74
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Mar 2025 21:47:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZNwhW3tbDz2yrM;
	Fri, 28 Mar 2025 07:47:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743108459;
	cv=none; b=fjgjIt5KKmnM56Kj7BG1t3FtvJfSnPz/H5skssMcwv2Py3uDuQFTjEK6NYxlOwsnPw4DyUVfCG9kcz6f+NZsm4o1b5L7z/3fAzjWVXSJwABQb3LlNy0LORZc9yVdqa2dLRiZUZBXcGAw8wrbL26uPUpM81MHjxvslMPYm1OPf3eFgsD5rMlH9mD36W99t54rcEKjUhN+IFM9HhbaZvt4cxFypP5ubd5pLRaspoqtDhgW6slMnlpi2SYZKetG38KPc2w9MwaH+C5qSaYIUKy3IesIbIvGSNY0se/KOg7WP0ggEn24jVGn7gniqyX1FrxC1N/HKjk0vC/gxVeIyHb1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743108459; c=relaxed/relaxed;
	bh=vPUZ4VOHmNcx1kex9XxcdGc+P1857lP541v/eK+YDsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HoCIolWoUffQnSMsIUAJbrm1I/UIWsaa1fC1FL6/k7IDxDRaP7d6i8qX40SkMjf0TnMm4leOc5CUAKPwQ9f0MVD76cbCXkA8lYMxGoiG5JiPmlIPl9FvCTCMHhklz+JsimHonHrtNPV2alAD1/NoJq2sqh4obUDTkxSG9CDa6fp06PQY5thp8jBK9r2RLmRy5xm07bhRvkGOXhGYeNAiyjDMspmEQRsZeN6HBrZiqXBtXXI2PJWaImI9AHRDfN+PyCRlIN2/fID5m5OpK9POcyv/AMq5NAcz+UYpgVwJEp82XAJiRBaOZikQBxvxPA8Lc5cM73FjpY2m+oTgXB7SnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=snS2yRYA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=snS2yRYA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZNwhV4b2Tz2yrL
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Mar 2025 07:47:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 96BB144BF5;
	Thu, 27 Mar 2025 20:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6BFC4CEDD;
	Thu, 27 Mar 2025 20:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108453;
	bh=SSqSR2X3QA5PuAbVG1rRSO63kEdL1Kgl815d31E3FgE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=snS2yRYA29QZFTKsfBmPg3E1/um9tfEwTODkHByHcrZaPX7l4T3UDV5X6ij5C1H8x
	 r2eIvaykXTsSsUSHkjbF87pnfk5Eqankh4zpQV6UfwYBz6Mj+Lv63MGrWUB70SXQ3D
	 XvkYtHXOz2rcP7xFk3hBfV4edGpzChejAFjfl8S/YzbWZrR/4zrE6D0GbSTOPNPci8
	 rxe5iO1I60MZJBg9GdYY1duIdxXCbB2cgqZ7SjtGhhlb5SGiw/5HTBV2XbrtXya8Ov
	 gNox/Q/VPsmRyTbKO6Copk8sU2jvRfzu3rLhfmCMmENT4GwZpzOSnikNDa/oFntXbV
	 on/XY4jhH+73A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF4380AAFD;
	Thu, 27 Mar 2025 20:48:11 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z+A9XO3+rPjpLUa2@debian>
References: <Z+A9XO3+rPjpLUa2@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Z+A9XO3+rPjpLUa2@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc1
X-PR-Tracked-Commit-Id: 0f24e3c05afeac905a9df557264cc48f3363ab47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2e7b0ffa56185d04871c6fe317b36d30ce2861d
Message-Id: <174310849004.2212788.17116773693429135615.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 20:48:10 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

The pull request you sent on Mon, 24 Mar 2025 00:57:00 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2e7b0ffa56185d04871c6fe317b36d30ce2861d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

