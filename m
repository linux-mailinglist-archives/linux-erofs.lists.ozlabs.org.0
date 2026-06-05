Return-Path: <linux-erofs+bounces-3518-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j4zTD1AII2pagwEAu9opvQ
	(envelope-from <linux-erofs+bounces-3518-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 05 Jun 2026 19:33:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5764A319
	for <lists+linux-erofs@lfdr.de>; Fri, 05 Jun 2026 19:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nhU2lg8J;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3518-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3518-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX7n644dYz2yN8;
	Sat, 06 Jun 2026 03:32:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780680778;
	cv=none; b=Y3bEoMEXHmyyYJMNUIZX64oIQCvNyCaLHgQvU1uMc3ARakUVfA/hIsj0x0rWpF9ezwuadb37BNM0OJxUAuQ92xdGvI1719GiC9U1YFkpeWUy07dmDpVxD9JxhUOD6oCgIWVEHApyLbkFJupNWqhcdlhCup+GdzMtJlSzycHwQ88oruVDjRQX2OLT84ifgfrj+nBnfNqSARlu9CuZxIkSVBJ/rh/11IHGbRbvn+mgGPaosLcydF9Rg2x+ABCVlpwHedqmnHLLCL/gqvVQoxTuYrWE1rqkCmiIfRCWb8p6THHufvsNEgaXMI9vOQdQio9LoZ6uonFHWOI0K/ytMHjqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780680778; c=relaxed/relaxed;
	bh=jAzXvXviohgFyzfmPyEzqKnRxVZfMUvWgWHpMMjIoqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FCakcxoGjU2BMt0DX3+5SUKEYoFZE7pny3anaOBb7QzFZM8WoXBk3/URI7xV0rPJuTHntVo+WdNo2hjGs9h7TrH6xPFHN4sQ5gSuNmenLL7VGtehkLikWtYXIg3wAQh5ovZqxXr/S8EiGViPUU7NUUTCrGvqaO/Ys6T8Fr6voLulXCf6HadW57Cb5fJz5Eysf/PQhneC+/rgvtvskJXjSOWyAZh+jgqa6j4JbigqfBjNBzdwDx6hxrpId8mTmXrHPWM/d0QYGU/200Y5t5QxQ2ddIimcMTSlyXVYlF5kIEjr9b0pgQbrAwa6yyGoYF2xuHx05ZPSigKfCivNUwZDJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhU2lg8J; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX7n54J1xz2xdb
	for <linux-erofs@lists.ozlabs.org>; Sat, 06 Jun 2026 03:32:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 65742437B8;
	Fri,  5 Jun 2026 17:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ADE1F00898;
	Fri,  5 Jun 2026 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680774;
	bh=jAzXvXviohgFyzfmPyEzqKnRxVZfMUvWgWHpMMjIoqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nhU2lg8JNUXb1ERmJqR/980N8zvEHupKMvIgVw5Bw7VqXlulZSUBLjdEWAVJsK35Z
	 sfl8LTl2QBQyPQ5WJdURCuBYXkfKUmzGkdtqCwJFEef5Cei7e7rhRj/PXMfMDa5B5s
	 YUUthvM1KWpv99W6iAJ44P/DxpwVqgbqfCM+S3dXCWQQATyYgB0A8TL448F+EccJyY
	 kh93IZroIM/7Nf8gYoUeYPlDoW9jichHImGc0SJhCVOKFEB4vTgxUpOmWhwx23zUmj
	 RS4N9KCDPDWPV7J3EgkuBan0JEgQphi3Z0mQwO3OcH/frMs83dP65Fc9m+x382Muap
	 zEafU2b1wXujg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF43930BAF;
	Fri,  5 Jun 2026 17:32:55 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aiIchc5EH5GPU-UW@debian>
References: <aiIchc5EH5GPU-UW@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aiIchc5EH5GPU-UW@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.1-rc7-fixes
X-PR-Tracked-Commit-Id: 27f2d085bd72abe4235689d34d8654cfc876d568
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b389a573b76f4e3e1e17654eeaced3eb48c2972
Message-Id: <178068077436.3853150.2061686099781873998.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jun 2026 17:32:54 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>, Jianan Huang <jnhuang95@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:zhanxusheng@xiaomi.com,m:jnhuang95@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.ozlabs.org,vger.kernel.org,kernel.org,xiaomi.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-3518-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71E5764A319

The pull request you sent on Fri, 5 Jun 2026 08:47:01 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.1-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b389a573b76f4e3e1e17654eeaced3eb48c2972

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

