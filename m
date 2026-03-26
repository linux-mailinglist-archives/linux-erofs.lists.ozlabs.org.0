Return-Path: <linux-erofs+bounces-3011-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBYJJ2uRxGnH0gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3011-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 02:52:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29E32E0FF
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 02:52:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fh6Gt01D6z2yTH;
	Thu, 26 Mar 2026 12:52:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774489957;
	cv=none; b=Yu4HQyFXOkQlC13mhsEDbfiUq2wIlcogJq+RhYav//mo5Ofk3BMcM4skwad+hOFbliA6e56bEfILBuSXWO12V54gnNL29GntJjZ8fuxvEuBEC+2H+KV3mPy4o/W2Q/kWxDXo1SPY2Eb6FlK4Aag5Fs9owEuK1ADE3GfUH0gDu7PUm7WuLLoY55SNEBjfaTmnmHUBnPOPqBsB7ji05qVEBQs0aB7YWE6cgwfeC1149lnKIxMhVbQknaGmr0JSiyQ7yYyS7V/9H2yfVCKT5pmOPImJCw+ZX/4GkYuH8UEoTkhqR6K2t64F1Pjm+llLVV1qNIXvNlKFNipHu9c3qqu5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774489957; c=relaxed/relaxed;
	bh=Ot6K4vj7FzLj1ehzYg9hhhIEfNeQM4jvUa75UyHAsrU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RmLE6b5E9ZbZYKxn/yYAYgbmsd+bCgD8OY6vL9qe+Fo0NB892r1bS1ZG/mHU1Y1Y4KEzpHNJ96o4feB4lPGW2yqA2q8gA1jUP6gqw9HeBTK1NYl5oOlh2Q94FElv8FRJim9Zqr6VnSg5yuCJUvgo6YNLlwV8RXX9Txxi6hdvum+4Mdssg2IUCEoZRlUj8FPc+TwBOJnYtG9yWj9Wz+vjRmEnULe+gKhKxI7rYZPZ86Rev5y3sPHL9uL3S2jVr/sM3u5R++wM8tHXotw+X88ik/GstUBoogHycweQTUq25uRrekjdqhDbB6eYPhPdXKXoQlGqJXFcQvPTyMa+G6JgXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mNF4GqXh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mNF4GqXh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fh6Gs2Jndz2xlP
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 12:52:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6A6B60103;
	Thu, 26 Mar 2026 01:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779BC4CEF7;
	Thu, 26 Mar 2026 01:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774489954;
	bh=mVHl+3cV0AvIHhDgBx3Yug9OVvwXNJPWh9GUtQ+uMH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mNF4GqXh6ZJBTzv73Ho36ddUK9DOzKRSA5oDUNbeeAiZfVrvyCbIwLpzk9wipnkh6
	 IC/OQpMINNH1NF4mJ4RoOZtuYzbDlmwyPcZUCVQ/iq4PuYQHif+PfARnPmJ2M7Zxwf
	 b5ZBnRVyfk96l2HJu3vvNunhxvZv7R7amk2GQDBlecofJtjdgW2/5yU0Yan7VcH2S9
	 kuXWFNSWHreAT+BHJ+1X52cjK1sZXxYVP1vubB8Thjig3/nwCxW+OryDf/tuzLsucZ
	 +CVVXK9y9qZl3dstBQkySd3IISDCeQDOTqZlU61KzEjoOsuANcevqgLoAn+eC+j6rq
	 wQkAJkkxYVCXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2E13809A08;
	Thu, 26 Mar 2026 01:52:22 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <acSEi76uD7DCHJ6d@debian>
References: <acSEi76uD7DCHJ6d@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <acSEi76uD7DCHJ6d@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.0-rc6-fixes
X-PR-Tracked-Commit-Id: 2f0407ed923b7eb363424033fc12fe253da139c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
Message-Id: <177448994125.2282714.4650367375025006887.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 01:52:21 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sheng Yong <shengyong1@xiaomi.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>, Hongbo Li <lihongbo22@huawei.com>, Chao Yu <chao@kernel.org>
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
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3011-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:shengyong1@xiaomi.com,m:jiucheng.xu@amlogic.com,m:lihongbo22@huawei.com,m:chao@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: DC29E32E0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 26 Mar 2026 08:57:47 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.0-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0138af2472dfdef0d56fc4697416eaa0ff2589bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

