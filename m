Return-Path: <linux-erofs+bounces-1362-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEAC57489
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Nov 2025 12:57:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6dzx2RdFz2yvX;
	Thu, 13 Nov 2025 22:57:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763035037;
	cv=none; b=FZdFQjjpyKLEiAzDhrusgWEyE3ZPqmuYdTOLjS6cMniM+NWx8JX4lugZYR6B4rsPzRE4jBLX1v5ElG7vG7tlqHjZUGZag/q29sr7Xi3uIO0HrysGs8nCwj+tN/15opKenda5QIQC8lGbvDMLkK5pPYQ3zXlL7Lg4gxnpOhDJqNmH7xeohaTVjHcEKaAlaVlZqjLhzhQ4a/HH3eoItKr96xMSCWv6tE09eNkr1SMWxWdOmFPOn5kzn+FBLvj5psvoUV9vx3CvSfhNDVvkE2ebgMKrZy4oTi1cmKBTxgcidNZpSCJvolvhY6WMmuzWCh0FICwCmG1SyoKfWPU080FBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763035037; c=relaxed/relaxed;
	bh=eFNmivfx0TYP1VFA1WbotI2C8bP8CD7cj2MnkG1qisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j9WIfFf3U2rd2JSi5i/BWvq90HjL8KWQCYUdbCTt4ZP6qxmxUDrNniRlkk92XRwUj4gt9GlngUX32iyl0agoYOA/yZwTDtqOagr4KgGl3dS8mWW03k+xc/mW0menercqCE5+rIDhxjDlZSqx4zI8n/5EqqD7o9PqfSdVgEjUFKC9bQ5pWJYqkoHU/RlpVLG6XP2NxN3rTaO8859FVcPS3VaFWKYgdydjgQCBjtZhMAWGQ4hwTjz8mp1KQNh7onVQrWb2FCgNU0/O20I0UMBQMH0olSyfXeAiyOFT16Mbfua6KL2R1rWUXqmoRyqVUoPKi7S/FNkZyV/sFkjUNTIFjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m/0w29i4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m/0w29i4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d6dzw3ml7z2yvT
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Nov 2025 22:57:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 70E6260210;
	Thu, 13 Nov 2025 11:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F2C16AAE;
	Thu, 13 Nov 2025 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763035033;
	bh=5pWJJ2yzTtPBpqwMZa8dZYL5BNi7MQ4FfRbbu/Qtef4=;
	h=Date:From:To:Cc:Subject:From;
	b=m/0w29i4zFCD2PhcHjaupuMQP6SI2okdrG8jfE8bZa69b/Tu86DtrWkvDfatu4EGz
	 pT459YCWghl0spvSli4zU8+zUYZZjv2mkzsNC9WWUQanu/Y0mWoh+KZYUQSuvGMzdU
	 HtYePdvi0vcx1tiRvceBAbBRWBMyoFusnVt8pEkept5SwVkbV8poLhpsblcT35X0Tf
	 eTn2vkM7G4f9Uifnl/9fGpMN9+n8/BG93kY8cICVxp7IJw6OfwR3WcGctAtLuBhqT+
	 kjZGIwHsKmY1Ty7LLezh1unaDJsUGXh0Ah7u9le05E+T/lHMTv6oGHc1zBMn049AZl
	 FEmhoJ5NTY5iA==
Date: Thu, 13 Nov 2025 19:57:04 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [GIT PULL] erofs fixes for 6.18-rc6
Message-ID: <aRXHkO5ema3SJwzG@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider those fixes for 6.18-rc6?

Two new small changes as shown below..

Thanks,
Gao Xiang

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes

for you to fetch changes up to f2a12cc3b97f062186568a7b94ddb7aa2ef68140:

  erofs: avoid infinite loop due to incomplete zstd-compressed data (2025-11-07 04:10:45 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add Chunhai Guo as a EROFS reviewer to get more eyes from interested
   industry vendors

 - Fix infinite loop caused by incomplete craftd zstd-compressed data
   (thanks to Robert again!)

----------------------------------------------------------------
Chunhai Guo (1):
      MAINTAINERS: erofs: add myself as reviewer

Gao Xiang (1):
      erofs: avoid infinite loop due to incomplete zstd-compressed data

 MAINTAINERS                  |  1 +
 fs/erofs/decompressor_zstd.c | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

