Return-Path: <linux-erofs+bounces-713-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B9B144C2
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jul 2025 01:40:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brZhc32Zsz306d;
	Tue, 29 Jul 2025 09:40:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753746000;
	cv=none; b=VWaqvFeCJfVmUAupE8eM+YoYvWEpL+njQroHr72kYOeYE8JngNVLgexA6rxc1AZ5C026yWXw5gsjmG0WUSWglW5GmMpnwhbiCPu05Y4JfW8RkdHqdRXOiDJeqYecaQBwWXt3+WkmS6KUvHHGJtKUp1+nK74aBtyK2Pblz7dnyX34h5TiyCFRiw41VcROvnlDItElvJRjwvitStcljFTVpm874/PVE6N6FWEO6bjSQs3agOkRjBAUKDLMMxxkgyu5zaPCFduoBmpEnNT9SjlGh6hX/2H1bRAcMYMikUkEYdGimZALCuJK5kEoAza0VAd5p7QLn97KE7T679b2x13CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753746000; c=relaxed/relaxed;
	bh=aZzYA0pcb0PGC6Dm/aSf/yMhqKmsJw1PeULuhmwZhG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=apxUvmcg5g+azZDlvKL3h8+xkSIP+HfRyBgR05AovIo+RyPA0XO97d1UMWZax0oak2m8txc2HRS88eH6pQjNhKVrjgm3jB2FH63ARqoiqO4No7OM16cwEWNa8VM2bXPIGlawJqWVyhpNm2zmZEZQQRgddHmbOiJ5tP2sgPBog+aWgFBrM/AVzHJ741tCM1Xl4LD39+yozuqZiUPMR9cU6mjG3uQMJ6UwD4bDh019VTaDLtrPrz4BI7Mb+Q+IHq7ZqRp9fkG1XnrDCD8GjcC7DZYoyvXCR/sK5ZuPXsh/rAnkLNNpfFqJMlj7ctwMWLYQMjSAurDvil5WJgl7/7uuPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q4TJW2XC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q4TJW2XC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brZhb490Xz3064
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 09:39:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 32C82601FE;
	Mon, 28 Jul 2025 23:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D339CC4CEF6;
	Mon, 28 Jul 2025 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753745996;
	bh=QMnkIaz0iXZsmhCIeosTXR1G8DaDTmolWiccwcRi0VA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q4TJW2XC4CF15hX0HGmKVIyVkl/tZRrEWTwIZ02S7589+61svFtjRnmnMAvgvyEkP
	 1Ot4DEYiRRK2nyRu8DUmE/Rmf+00DndH6t45pe6nm0nCsxuttHoba8vv+DwKScCpIx
	 H7lJhqj/jqf3sWAabFqVPSWk90Dabjj+P1ZvmExSWdHFj0CB+CHmbqRj/Lq2HimHMW
	 dCLOAJKIq4cFZVcpuQrirxIVc1gFSBcO3qomBp3b3Em1AfmgrUOgVrH7Kguxb4q66s
	 uQF1Z1qVRNfiITM+Fa+KXryGGd64k1u8jYsVragJgr0DYR4tTr0JICUVfNw+6HLWFQ
	 vLOOSyfvSTCog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A2888383BF60;
	Mon, 28 Jul 2025 23:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIblpKzSWEEYwQ06@debian>
References: <aIblpKzSWEEYwQ06@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aIblpKzSWEEYwQ06@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1
X-PR-Tracked-Commit-Id: df0ce6cefa453d2236381645e529a27ef2f0a573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76a9701325d39d8602695b19c49a9d0828c897ca
Message-Id: <175374601352.885311.5248850551297933254.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:13 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, Hongbo Li <lihongbo22@huawei.com>
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

The pull request you sent on Mon, 28 Jul 2025 10:51:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76a9701325d39d8602695b19c49a9d0828c897ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

