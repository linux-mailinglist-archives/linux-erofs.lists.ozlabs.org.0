Return-Path: <linux-erofs+bounces-3724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R2YpGhnmOWpjywcAu9opvQ
	(envelope-from <linux-erofs+bounces-3724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 03:49:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADD6B362F
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 03:49:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OB6rBFAY;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3724-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3724-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknzn5KXWz2yYK;
	Tue, 23 Jun 2026 11:49:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782179349;
	cv=none; b=JFzYOJgHW9+AYe4PzyIKdNmVhr8Z0GMpVV/nNZ2B/4hFEYRvC3lrNnwyCzpiyPMD4SZq7Th8AcrHeihONf6Q5cHwW3Oz2JdBA5IrKDGlDD8fweywY2nq0VD4L0LWNMoDfouLqxmSBqeIV5FSN2yYvRfeJhwkGH03l6DNCwUk62+ygr7HIXUuMmJHcjzgQ46toEry/2+qp/NLdn6o8PI1BVi3jT3etjs+D8gZ1HFc93nlUp0MyC8O9QqW9h+PsSuPYNrLzT4vsVG4krZOLo+7DD1DIgNlPZiGbpOLPDXA/rxCzh6VMijSDKtIeDB+Y/vCOus0cF/P/y0iKaHF5V8AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782179349; c=relaxed/relaxed;
	bh=JpXkAlpSrtzX4S0uWhclvszM6QkPW5mXP07UTqXJIQY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mWXBZ1Qg4xyG/0SYIB463U84tdCPcbrn/+JW+QSHaxgxbreF+7i1gkJzxlVBao5s0oeHRqXjqzX5AauS184VAvV6BssdP7LxxB1WVZCMTzMUEsIc1M1bZYIFKQkjnlWoCE7K5t/9OOMqDpier8N9BRgQB9x/FV+Dzee1iA97wcscKhh4p/pvUe6ekFm7ui/pXGTKdkIvP+/Ywt7Us4tmK3KE2l8/wGtjxFDVrILMlutXTFcBZj3TiAtmcIsOO4jXbnRjry7H0k4UQApzn/l54aXR3oWW0K9TjI4CbcCH6kAuUDvTbqkSNvJMTx2FguSOV9Gy7qzmRfKGkZDaK6rQpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OB6rBFAY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknzm2ZFnz2yWK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 11:49:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E9AD44539;
	Tue, 23 Jun 2026 01:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CA1F000E9;
	Tue, 23 Jun 2026 01:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179346;
	bh=JpXkAlpSrtzX4S0uWhclvszM6QkPW5mXP07UTqXJIQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OB6rBFAYGGe3pV2mAmYSfTienTMG2MKnptCyN+YqnclzYvMHDQEeYcH1XEgmYnuM6
	 Z0IM38/tflRNHE+eoGTlxn3XeiNSNUcYBNCDPX3itegANxTO6Y1ui9UytoSTgNNVU1
	 ViDLbqbSGD29Gf9MNzB+RSUnR1nE15W+Z+5ukp1bmn/ca10uG0WKGdlvK+304HdOYY
	 QSERnpcL1e9k0AqvisjlnFKhewlyJpTD9BFZej2zS3sYjfaDp6f07D/IOog7NPhRuu
	 7ufIDblKgonvRSb+aj/WbLUhuJNQ3jI7HgjV3/VPz7aTZm3qVyh2dQW8L2rZlXIB4b
	 lQ5JPL8oXbb7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C2A3930A08;
	Tue, 23 Jun 2026 01:48:57 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajlRA7jYcsnYPXiw@debian>
References: <ajlRA7jYcsnYPXiw@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajlRA7jYcsnYPXiw@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.2-rc1
X-PR-Tracked-Commit-Id: 803d09a554055aba160a62abd1e4b1260b899dc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 502d801f0ab03e4f32f9a33d203154ce84887921
Message-Id: <178217933610.1501619.2826771492086150971.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jun 2026 01:48:56 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>, Hongbo Li <lihongbo22@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:zhanxusheng@xiaomi.com,m:lihongbo22@huawei.com,m:jefflexu@linux.alibaba.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3724-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FADD6B362F

The pull request you sent on Mon, 22 Jun 2026 23:13:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/502d801f0ab03e4f32f9a33d203154ce84887921

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

