Return-Path: <linux-erofs+bounces-598-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55955B02BBB
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Jul 2025 17:41:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfXrB3Fgsz2yRn;
	Sun, 13 Jul 2025 01:41:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752334906;
	cv=none; b=grJ+xyRkfQMYDkvAZoerrK8TCkr911B9R5izORiEsue/Xu/AqbGjkSNkMw+MuMHsQQhOdDupbQGhzXAGgvfeg8yM55XETsoNzSq+b0wMKDFbLeau+5PloCXEdamYJKBVUwxzRsQS1Ba0GBaUR0/L9bOQ2zv+ChKBbhCvUY6IJZwsiutlbZkAw7ehNo13j56zVHhRunEYpKHVjOwoloILyF/oaP4DhHUCe5yFxoMOy1MMYyzlQ7h2Z2u3pFdeNq6O1qHy4aKQc2ga8LTH3B926oXlzlNd4pehTd98X56+AapKXSKQG9mMUReKtoR5v4BHmyCEf4YjICB3vJu95KJTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752334906; c=relaxed/relaxed;
	bh=KZs2sHY/ax1MCgxdiwcm/0IPdGtkP7kSBz5wSL9XUnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j2B7t2mLrtKbl9EZzskCHeLn6FWrcbYw7SIfAEH+uywweVBxBxMNHudX2F1AMiqJsuMrClvVGY08AONvWeUSJN4u2tLsnSn/StqHAZhct6ldPL8yhj9aFz3ff3SorwE9oHxl5aqac0BwkYzJqb7PKHsEWaEK0uTrXf6QDDTLqxWyHw/vPDuABJW5VSMwtI0lD6TXez094w1VbUqc2agsJtwoYLOqcLphOoYoOsW6FaSp3xJuDo53FF3rUQOJdj2fwdl54xCHDoXyB9TvElj4GaTAYin/cVti4g0z0vIHjQzPmc3YbJ2B5I7NPXVZ0eSZUaTySz9QXU0h58oLKC4wlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YRMkk1i1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YRMkk1i1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bfXr93LqWz2yRD
	for <linux-erofs@lists.ozlabs.org>; Sun, 13 Jul 2025 01:41:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 80E1B60008;
	Sat, 12 Jul 2025 15:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFBDC4CEEF;
	Sat, 12 Jul 2025 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752334901;
	bh=YYFSm1m5FX2KuQrL4dOdK866ohlLLkmCOxC11uddIe4=;
	h=Date:From:To:Cc:Subject:From;
	b=YRMkk1i1L9v5qE6reJtbuypMbpIY/Ssiy3zdNzFwTqjsUkF3D/1aL4421hCjgVTC7
	 e0RdTKGZrS60Gs35Q6VPvtXWTQXNGuAE3nurd2y4N8JFKrwHEccjMj5t2oPbCb/oxg
	 5gGE5ZT4RXH2YNB54vL49KjoU9Ff2DCQcmRkEHIsVKKq4q+nAhMP0cb8boUz3f+RZl
	 9lB0NwBE1xhcYe/3E/8DZWjwQi0i6CZyFajUMSyY2U4yrJxeS05zlbVERFB/9e4QJH
	 zKhMBxxhtz0s616sS7Rja9CoHue+lHf1smC0yVtZ9NIXiL//INSKy/IWYk1nVmyJ7q
	 Lv2mEc+ejjY1A==
Date: Sat, 12 Jul 2025 23:41:33 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs fixes for 6.16-rc6
Message-ID: <aHKCLQaEYGPRR6mN@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider these fixes for 6.16-rc6?

One patch fixes a cache aliasing issue by adding missing
flush_dcache_folio(), which causes execution failures on some arm32
setups.

Another patch fixes some large compressed fragments, which could be
generated by -Eall-fragments option (but should be rare) and was
rejected by mistake due to an on-disk hardening commit.

The remaining ones are small fixes as shown below.

Thanks,
Gao Xiang

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.16-rc6-fixes

for you to fetch changes up to b44686c8391b427fb1c85a31c35077e6947c6d90:

  erofs: fix large fragment handling (2025-07-12 04:02:44 +0800)

----------------------------------------------------------------
Changes since last update:

 - Address cache aliasing for mappable page cache folios;

 - Allow readdir() to be interrupted;

 - Fix large fragment handling which was errored out by mistake;

 - Add missing tracepoints;

 - Use memcpy_to_folio() to replace copy_to_iter() for inline data.

----------------------------------------------------------------
Chao Yu (3):
      erofs: fix to add missing tracepoint in erofs_readahead()
      erofs: fix to add missing tracepoint in erofs_read_folio()
      erofs: allow readdir() to be interrupted

Gao Xiang (3):
      erofs: use memcpy_to_folio() to replace copy_to_iter()
      erofs: address D-cache aliasing
      erofs: fix large fragment handling

 fs/erofs/data.c         | 21 ++++++++++++++++-----
 fs/erofs/decompressor.c | 12 ++++--------
 fs/erofs/dir.c          |  6 ++++++
 fs/erofs/fileio.c       | 14 +++-----------
 fs/erofs/internal.h     |  6 ++++--
 fs/erofs/zdata.c        |  8 ++++----
 fs/erofs/zmap.c         |  9 ++++-----
 7 files changed, 41 insertions(+), 35 deletions(-)

