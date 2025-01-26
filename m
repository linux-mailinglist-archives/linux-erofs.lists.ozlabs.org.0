Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE0A1CD6E
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 19:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737916299;
	bh=1Zu0Gw+JNHUcXe//EEI0IA43Gvfni+nn864Ou6sHghA=;
	h=Subject:In-Reply-To:References:Date:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gKmC88O9tgOKiLdW6cKiLTW78wrup7jF4GZ5REQ0P6f54HaWuj7pNIs+j9Rv00d6O
	 N1l3RUcqnVBBntCSIg54R6pbpbnexVRgQLxZOZcY19HPCLXQz4gs00vgxWcQtjNr9R
	 PNsGteDoOciaHadtER0jjhRXX/X9maotQiQ7Z/rUP45XBCRDPzOF9Qk3NrG3Abru/Z
	 U4lz43jiuZ6BhszV8HQlATSKKYSh8RelXnKIOX7aDpVLaOC+1A0zzEco3DuDPxzp7Y
	 qol8edwcCPjsdtUAdP0sIxYptw/auIC95iKAY1J2Id6GdWabf4x44aMc4Jg7gyreDG
	 wae2sOq0tHD7g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yh0WH3l7Gz2xZt
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jan 2025 05:31:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737916297;
	cv=none; b=nKwZ1c0LmTRV2x4LeZpXx4a1cyC2xSc5lunp8cu4RjixOXlQ/MD7eoIeDRzZ5UXlaqOWWZquDV7yP/6UosKND9qlYx6sUJJ2ppr4p4tS7FAMNFHFR6IETSh/H4CRcxhQMBSTyl0DDrewbCst2enxhSGFcW+nP3ugqJqbC6ZYFJATOS7jrFwOHwB2cdmzehYv+H5pBaEE0oowxu/xLMo3chQn4nFm7+7CO4gL/l0ogcN0atcNPMy31z7EgECI1J7qCwSBgyGQlvxouzdWodFJlYnUZSwNFLLvmAZA/m6Sc+PPqWqODBJr+VPXpdiGuz4cL5b9Q87P5zJwqKLLYmN9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737916297; c=relaxed/relaxed;
	bh=1Zu0Gw+JNHUcXe//EEI0IA43Gvfni+nn864Ou6sHghA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=maXYpLDRcMQ1L+yJZEsAWwVE/v70BlYJ0AvnYZpkr9SOCkxoUp96M01pZDzflNeD6zwJL3pWvsCAKOeZHiWAofWhmrzuzGJq/PjuPxtvfRtuf+WHSIBAYqATFL+J6t3ZOgLZdt5yjW8l9g6qhEz/Kf/kAluNX+438lvA3aTxu/wNtweYgYUwBnpKKMZOuA/BQNzpeHOjEucn3/V/cvZNuDS1sn43glwYsIwh/T5MZiQ7Uiq5cEZe3pIshOY/AS/3opFAq2GKdxyz+9gJ2io1C33zV6S6vSXqg/vll6p5bBxpT74jVhDMXwicZkfHT/DUnPQJWo7BAVOaf4w7l8UL6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jfffo/z+; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jfffo/z+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yh0WD1KDmz2xZt
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jan 2025 05:31:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E9C815C4A76;
	Sun, 26 Jan 2025 18:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE740C4CED3;
	Sun, 26 Jan 2025 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737916292;
	bh=b0okUDimuXzhhPVmB84wb9L6WHARJdvnyj0RubaQOMQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jfffo/z+xXVqZBRsIfJ/Vy7YtaPRbHYvsGU/tztEG4DJg3OSy0iraJysp2I/ZjBm6
	 4UO4LXswz94FeBPw1cdmH5mKBG/IXgGs0ayGl3Els4REESSNeSpsqip8ljdjbAsopY
	 yLe1uuEZ4Qic88HQPN1Oy6h1HCyTKUqC9dZKhQQVAqkVlksFB6a2J4AdD+X3awIM8y
	 ObjKhhi22SJMj4iji/yTCXubvMDv+MM4qujaUHdRQQJWkPCpg7LDMh7Zxetz5V6cTh
	 fDwfqEMxOLfoFlJzqyZCt/WfBVZ5n97KJilN7/yVtCAgOJM8ie+DWBD2KUPi6InK83
	 GFOI1SACPx/eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA4380AA79;
	Sun, 26 Jan 2025 18:31:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.14-rc1
In-Reply-To: <Z5UJN5GcunLDlH2h@debian>
References: <Z5UJN5GcunLDlH2h@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Z5UJN5GcunLDlH2h@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.14-rc1
X-PR-Tracked-Commit-Id: 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2da8b3f914f83fb9089d26a692eb8f22146ddb9
Message-Id: <173791631806.2840369.11695632308854924291.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jan 2025 18:31:58 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, linux-erofs@lists.ozlabs.org, Ethan Carter Edwards <ethan@ethancedwards.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 25 Jan 2025 23:54:31 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2da8b3f914f83fb9089d26a692eb8f22146ddb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
