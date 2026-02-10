Return-Path: <linux-erofs+bounces-2296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F7gA+iAimlaLQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2296-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Feb 2026 01:50:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67587115BDE
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Feb 2026 01:50:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f92zl546zz2xVT;
	Tue, 10 Feb 2026 11:50:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770684643;
	cv=none; b=lhcpQ8MnBfrBZ1PqCH4UQj6JF1GW+HqyJHxgoSIKSELgseGQI6s+5rfzg0EbM8fdwGzbGNDxspDTzCzp0MDLywdkunUokjYgEtjkfUfP7GzFErt/wbzaCYESWbuntb9SRsHRf0Se/FTboxnLl2yl+R1GGU8bOwCfu2lOOK5/vX6Q7R6qYURzGtgaHqra0fZTaHauDD7wgPJjKmuc7GtnteeTbBxQFipmG8kwgIImJVy0HEk7RRNJgedE//uLZHcp1t+1OFCUNmYwcMd+BdXfLLewlrpxB/to1vbcWaDOsdJjYoQSIzW+UkczKBn+cdtFY8sqO1XKX6aJDzif+Mkrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770684643; c=relaxed/relaxed;
	bh=oxlIXR1mWEKFO0rBywhhtGsnsFgcCIjmBIM7tOZc2q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XmVMKY28rX4+HGci1bWXGvqcOqq9k5Lx8ns0P7TwUz2M3XgjvQZRsK280f4mSR9Z5DNro/o9VR3/LrcabbSQ9uzqlZbhUJGADwEIUH6pjNW7lHDjIYAinINEE62UKrGWkZLG5eo9oMLUNspDX0K5YxRrDunQrFDt5SiJWLjG22QsO9uuOjTnjNATyS4bXBioGnSiZRHKuxhIwYig64Oq5zxAJCZPg+2uwwA2Np9uFqSjbA9OCleQSAa55cmZonkapKZBByHASWs3Mt+IOjCJoWkwLUT4mZYoqNlJhOpRd+NhgwDRIa4nf2fNluxq33yvrDBgnjdduJP2t360+wMqwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iotBhK9L; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iotBhK9L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f92zk5t99z2xNB
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Feb 2026 11:50:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 43FFB44546;
	Tue, 10 Feb 2026 00:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9ADC116C6;
	Tue, 10 Feb 2026 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684640;
	bh=eaLA5I1cwTGFUPcLePjGQOIebelfbCipj6T+7Kl1HTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iotBhK9L89mxggZiFLJJCzDcUsNxMyyYbbS6ZwlLcbFQ4LiZjxzVm8vsULcI6ch/g
	 CGi8kzShQhdHDLsJdWTKypG7qY/RJfi9QmrRWcDp3pCg7B+Ve7+Wm5WWvYCw51FY8M
	 Sz9TTmxLRJDO62eabmIzpt2dtiPRVj1GHx8DYCAJfk5jSaQ6p1mhjBEW3GzadAgu0N
	 dNZBrY0uzX/tDcBvpAA62M/uD+xXvxAjxWHX+8YrnIUwKyukaPg8Hh3vL13AE9ksMI
	 EVsRvUzCm0AEdcDiUeZBKXACrwvyMU3xmP88nf305T794QrphGP2LIS/ZwnPmuGDUp
	 zvc4wQW1IusQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0A8380AA49;
	Tue, 10 Feb 2026 00:50:37 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYlkynqBRVbO5WtD@debian>
References: <aYlkynqBRVbO5WtD@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYlkynqBRVbO5WtD@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.0-rc1
X-PR-Tracked-Commit-Id: 1caf50ce4af096d0280d59a31abdd85703cd995c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3893854000a81897a1a332ec50931f74761fbf71
Message-Id: <177068463565.3270491.11841019104816563875.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:35 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, Hongbo Li <lihongbo22@huawei.com>, Ferry Meng <mengferry@linux.alibaba.com>, Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:ywen.chen@foxmail.com,m:lihongbo22@huawei.com,m:mengferry@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:amir73il@gmail.com,m:djwong@kernel.org,m:hch@lst.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2296-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.ozlabs.org,vger.kernel.org,foxmail.com,huawei.com,linux.alibaba.com,kernel.org,gmail.com,lst.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 67587115BDE
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 12:38:34 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3893854000a81897a1a332ec50931f74761fbf71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

