Return-Path: <linux-erofs+bounces-1135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FABAABCF
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 01:23:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbHKz5qMqz3057;
	Tue, 30 Sep 2025 09:23:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759188183;
	cv=none; b=SFRfXoidpw4K+zoU8qC1SuUpG7IM6VLSYYcyN34P6k/6kiEUjh6GPKg7p6dr2a1c8VzDLxLuwcEI0NswWjyYK4HbYo+ZiptoX+CJlPu3r6UG39bqvgLjXbKmo0aIukrcCkuzEon9EfYPXPVOe6IN2malH20Zlopbakoe00FEaH8IrDWMsK1ZaWOT7y7Ij+XyfrShTlek5+aJ9e6o1C7W0fR6uu3WCBH6+ApXSQ8juzSwMPemuhql01m70Y5K3KWiaeAV3/5KU3vq2n703PDX+g0YAbrAcB6xS6w1eHhnuijo6+lgMBxnPHIjtbNw2Y/SwzHFNk6ySa8A1OlXPiNrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759188183; c=relaxed/relaxed;
	bh=HfGNu6wdrmhy9xqDAKVYeoWCcqYNykq1jVU1afJeYKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X3odYtPb7eauPjpdjtKrUISkbZO6SxbUUYWANH20z9yFQte/Rp3UdcleVuDbsxWhazBW4EJqtcF7+zf/pO9eRT08NfbDdZg5czsj90pu0L0NLba47sKcG0ZsklquIp51jgQHsAwNmlSHenLWaZyGBCRCpemedwyFbICpS6ml6ROF/6zBT8XgqaX+CRBBruCaQBEotcqq6lJ0QWkd+LdrdbaemqWOW4S0rOO5YLmVPXWpzZ5r221VsTegVBDT60LAFOyZ8IIDgEQkccyEwVj9bR7wWIW4VhELCVXSTpPLIDYKgfLS5U0Wu3lnKDfmOGNAa0lXePK+Y8UPOlkqZCCsfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H+EP6hyT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H+EP6hyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbHKy3T7nz2xnM
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 09:23:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E96C48C4D;
	Mon, 29 Sep 2025 23:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7691AC4CEF4;
	Mon, 29 Sep 2025 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188178;
	bh=mRXmguWRKqQeBkWx0PpUv1EQNoYuDPaQjTmU8rHZpS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H+EP6hyT17VCAipO1qpt8o3LCzwOzM2DgLOq/w+b4xEKfD08S/CRzHNt0rGgvYcqV
	 Qz0VObHdiU3VH1omUxeU2ISBFlJmKLzqglmPohOnJVs3bXEbUcyy5IqWmOxFhO9Blz
	 ZySnp0Qnenn8VujcZCFlo+EC/zjhXKfsXWRDxT1rHohRFfs2cx7Qo2hZbWM9EWBK1V
	 RbzB+g5IWT1hnMTbBjnSLpSbsVoyKxt4FgiO5DLgQGITcQYlWUF40wYpR122A6YojK
	 eK7HAdDCBxeDWeqeW4UCxTqtduSWk4wJQ7pdvCn2p83Vr3xb7GUNdCo7/B9BRzRQ8I
	 /wDBtI7EOOx0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBF39D0C1A;
	Mon, 29 Sep 2025 23:22:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNqZE+ex0ci1etXU@debian>
References: <aNqZE+ex0ci1etXU@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNqZE+ex0ci1etXU@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1
X-PR-Tracked-Commit-Id: e2d3af0d64e5fe2ee269e8f082642f82bcca3903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5928397f5739fb94559350575826d94fa8c35929
Message-Id: <175918817183.1748288.12528740975921892274.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:51 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
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

The pull request you sent on Mon, 29 Sep 2025 22:34:59 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5928397f5739fb94559350575826d94fa8c35929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

