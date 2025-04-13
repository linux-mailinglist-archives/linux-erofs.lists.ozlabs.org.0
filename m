Return-Path: <linux-erofs+bounces-198-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BBA872C5
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Apr 2025 19:04:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZbGwV14SXz2xqJ;
	Mon, 14 Apr 2025 03:03:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744563834;
	cv=none; b=lekup0+IoTvBycI8nf1/Wc1HuKc2Jnu52jXFlZjiRcQpusrB/9Jexi8ktUmR7NIQXe798JCYqupnVbsB7LbT/fp142G7TM0D4q788BLDmT6av43ml9HC0mEOiEdNKADsYlMeVz+Dh1n5kfw/k3zgzqGQEaWBvzsqiNLIFQkuDLJvkUFrqMH5I4LR8yl+sqXXswtoN80iHLs9gRoanCw8rJTxgfashGtgS4zX5QeDEQQG/81Rn0Y6WvTuvRWnjq0dPmMLNEr4HMzuQcONHCxOsVkVM8dywGkfnBGJaCeFruji+paWtv2HQKRDScLGuH7xNb1nrXh4hm54VcArDP5/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744563834; c=relaxed/relaxed;
	bh=TP/qECT/il+sIAPJa9fI80BptWRAG4p/Zgw5mdX3H04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mlwe3NAB6ldNO7SERWLMQFvJh0ikiAKVPtTuUA5TyE7tP4gQ65ZjzsDaLULMvBPGoigw5d5dpPj5F4hCymOu4DI001gsOfZg0ZqentcxCpCbssfg3WScGSu6eTIaduTVLQtbiwFGZww9l4o+4RXlbBsB3xO2pDYRhAUIXkmmj4c+kkVHkPMlGA6xDRtmH/U8MQA+vKM5lYHGbVQQaexsuWR4scCjw3aHQ2lVauc9/O6udJo/GpKhKcaX1hU233pw/KmziIns22ybHLkDd4/Tv75mj/zV0yzLZc6ZUNrDLq8zsbINY01ezbrU4CrTm9BsSYc0fjlo0k/jJjhZu0UJQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J4kRDybo; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J4kRDybo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZbGwR20x8z2xqG
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Apr 2025 03:03:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EAF0AA403FF;
	Sun, 13 Apr 2025 16:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEA5C4CEDD;
	Sun, 13 Apr 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744563828;
	bh=UCLYzL47JucMsbR6qTqiu+oRe6Ro+ITu9qTxJb4BOyY=;
	h=Date:From:To:Cc:Subject:From;
	b=J4kRDybo8oc+xF6r7cdvQt4PEcsHWIhJl9MowvOjAfZ2+gIvfCWyooEmO29ty9pQY
	 NSvtyHQwDtmcOhLfEGTnkpBSil/dQE1eFvJUImFrKMEVFgEy5LsOryquh6bNxnLmQU
	 SBD/B3sf4hiJbNAo0KJEJBrZndcWe8t8MjpM05XrgSCjiCCHwW9hjfkgsjqr7L74lb
	 9grqED8p1tVdR8As6wMx8KPQ/SRUCtyYuF8KYNQsgRE+xkpSdEjjdaXKUP5/NS1ZAa
	 MNOW25IENgkHyP4a/fR1HoRjHr/tkHvUM+UCqZyueO8bqg1hbfNJkK3GIGSE1bzlA7
	 k8DAYpTVzlj8A==
Date: Mon, 14 Apr 2025 01:03:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>, Bo Liu <liubo03@inspur.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.15-rc2
Message-ID: <Z/vubg+MYaiszHm2@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>, Bo Liu <liubo03@inspur.com>,
	Chao Yu <chao@kernel.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider those fixes for 6.15-rc2?

Just a few miscellaneous fixes as shown below..  All commits have been
in -next for a while and no potential merge conflicts is observed.

Thanks,
Gao Xiang

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc2-fixes

for you to fetch changes up to f5ffef9881a76764477978c39f1ad0136a4adcab:

  erofs: remove duplicate code (2025-04-10 14:24:05 +0800)

----------------------------------------------------------------
Changes since last update:

 - Properly handle errors when file-backed I/O fails.

 - Fix compilation issues on ARM platform (arm-linux-gnueabi);

 - Fix parsing of encoded extents;

 - Minor cleanup.

----------------------------------------------------------------
Bo Liu (1):
      erofs: remove duplicate code

Gao Xiang (2):
      erofs: add __packed annotation to union(__le16..)
      erofs: fix encoded extents handling

Sheng Yong (1):
      erofs: set error to bio if file-backed IO fails

 fs/erofs/erofs_fs.h | 8 ++++----
 fs/erofs/fileio.c   | 2 ++
 fs/erofs/zdata.c    | 1 -
 fs/erofs/zmap.c     | 5 +++--
 4 files changed, 9 insertions(+), 7 deletions(-)

