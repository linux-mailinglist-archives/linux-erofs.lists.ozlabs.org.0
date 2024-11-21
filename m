Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E49D524F
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2024 19:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1732212314;
	bh=cQWslKoJ4809CHLI2ENkdQgG892Rfcq0QztDto3Atp8=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LrfUKdCkd6eVb2+5QRFdOek39T7ZUVm2yUNy7fkJa+XI1Mn0o1CZCkbKaMvE4xmFM
	 KRTcpLDtePtDJhHJMlYL3z543hnRW0iAPKi14dyx6VDYicvE7r2H7eYSvvrCpdToyK
	 M91VwlDOrVE+/aIXU4iZwVCu+FbrVmjC1s7pGieZcAvhval8RWI2k454I5JqIgBgEV
	 HuBuhA3ZlVHB3KHW+Gnr+cePpkp5RXC0byvEVXJEREFeRNACsfb5U7A4X78kpjDgo9
	 IEMcp+gwkR6PANE9Ql5L5TZ9IYqfUONemUfkrnbqhIt0gAUwSzPZekWCL36noCEkAv
	 vpTFYg8defOqA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XvR3G0mtTz2ywR
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Nov 2024 05:05:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732212312;
	cv=none; b=R/lbOGot40sQq+KA1U2r6U7tG+BuKwK187yL01fYkKFEOs+hk7DmJZrQ/rWVtr+VhMhyYCQTRLA2KShDDq2LcuRqiIVeUB47s/NmmxdwyLxgWPs79nUZfsYgyeSIADkbf3+8gmWBkP0biFSCChYYLg6Qp5KE1PhRw0opQHrDSn2LCAijPVDIUlvW80QMlsi+udxmFdlrBFPWk7/7mIyYs3qA0vMnQ20YhC+Eet2ZB09iTfgG4TepFj1mpKFemGwQOS6kLh6gkii/iPXM11/+7ml6uh0qOW1JnNCY03b1nmff55y98BGtWrSBoumR8dneaGcrjstzBH0sjcsAVzI/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732212312; c=relaxed/relaxed;
	bh=cQWslKoJ4809CHLI2ENkdQgG892Rfcq0QztDto3Atp8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DLU1dfdAQfKqw5X/fG0jQRd4EiWLSgXYNb6GtAw1jx7Z4Opf7Fl9oFpdYDPW/XdBJx0OwiWdNGlLpZjtXJaQLitNPzyRJBfNcLurYvLJE3xAAhiKQnsVt3ZOMIV8EdOmfgn3nfyFJ7RLvrLrGmVRBaR0ipK7+4YrOrQG6WEO/MaIsuAwr4FHK8nDLkaZ3zy3LZFNRXSZ1NwqpxZVixzPQWvSqsdUOhS46h1P4bSMsJ+foqD2OwIlxj+szhFd5i59Fn5m4V4ps/1Q/RUcVTEI11CM2uyEuESP9ODMLSh4YBQcitrSe71SoVWbgf9dhWArOOksexMUpOHLGTsYUyJFsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V7lxX7Jz; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V7lxX7Jz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XvR3C1Szjz2xst
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Nov 2024 05:05:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 63CF45C541C;
	Thu, 21 Nov 2024 18:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B768C4CECC;
	Thu, 21 Nov 2024 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212308;
	bh=wF8Ad6kilhgNHogcqaHFl2gIdzn8xpZQqvWZscLTqco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V7lxX7Jz6c4FkzVD3vQCS3bD9I50bkA03AsgjqT9kBkXTCkLLmUnxgKgFqa5uMxs2
	 uCT4JrcH27pPrVAvW8dFzjaQWNSbOX/0/wd4w3gW6EO284z5FY3GCywIIJh1xHlLwy
	 q8FOHw0x0VKegzGt4TBHJwmJM1w+V7JTMLFUlUNYVdFQXZIshYseosdGOTVWLnP8pl
	 BOR1M76jDfDFhJPEyCgaVx8vvRGdVn+DQAbYxuPQIoF/qzYSVz/tIw8Gm/Ss+gRImC
	 nxeYUSs898BapCGvgdbSjIzqX7NYX6uJX2lkv1gR9E8QHIuTvHX7oGX4EIVne4lPz8
	 3qlktmNGRnpvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E753809A00;
	Thu, 21 Nov 2024 18:05:21 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.13-rc1
In-Reply-To: <ZzynU2PQOgkWy6BM@debian>
References: <ZzynU2PQOgkWy6BM@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZzynU2PQOgkWy6BM@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1
X-PR-Tracked-Commit-Id: 0bc8061ffc733a0a246b8689b2d32a3e9204f43c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a19b744de3a4fb51aee2edd8f2b9a4b14c9878
Message-Id: <173221231982.2032550.9499251371642487333.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:05:19 +0000
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

The pull request you sent on Tue, 19 Nov 2024 22:57:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a19b744de3a4fb51aee2edd8f2b9a4b14c9878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
