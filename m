Return-Path: <linux-erofs+bounces-1804-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C07D0CFD0
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 06:24:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dp6WY6Q5tz2xRv;
	Sat, 10 Jan 2026 16:24:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768022649;
	cv=none; b=FqUowG/saguoYue8IK0mX8Fy0tkcrjVIY5t3OR26DbcTr4UR7gEeA3u+FgODNeW201AVTL/tGYwIUxESdn//AOVCTHt7/h2o0MSIfoesM4ZTln5xBBR5QvwZyXg/lUVnr0lL4q41hHLOsvCimEK4sSkDoGKWPJ7pm6lsjl1S3TC5Yg0WhUDyqXwKr3Pb8E8X5hlQacTqNO55xGELXBazHP/DEdurgC+VqTya4r9CZl5V3+M9M1Msriyr63Okt4STJ6CRl7AP9NKMh4bSH/GwwftkTH43Y/x7iuYBWJHZfHwMFSOES3zoOTv5hoAOgLIpJSLBUzgqtZiJ+MRVlVYfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768022649; c=relaxed/relaxed;
	bh=cJ0dIzb5ljX0jw/3k3KswTW2eC/oeN3x4YiCqx2ewY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YkFJgC7WMJix8uTLFab8N0DKcy9LUalMRhgrwxiX+LQV7k2NDtCdCekjDGf26dm9jWJJA4HIpENeF+MVy99ch76wwLsGNha5gSWEQQe3fJDrE5BVCX5mqc02VDR9wS6q3Y3ABHyWjnNwhE1bdFf55MJiZeHrR6NB4ukC4lSQXHAgjDeMVYPTvOjWehJHs3dVc9QWJYAuqfpw4YTM6jZorTk0tVh8bpqIyL71TsLsrYUtrEfSdYV/kIk8T64eya5tk49zoKjkQtrX0IjBmAh8DyCANJ4qiR+uivHbu4tfRqlyUP41SPzkJ6NVpdbvAdDPPSWiLjnpoBCYvGxCa3PAQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N17uFM2U; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N17uFM2U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dp6WX6pQvz2xQs
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 16:24:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A53CA42AE6;
	Sat, 10 Jan 2026 05:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63143C4CEF1;
	Sat, 10 Jan 2026 05:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768022646;
	bh=GWbyWFYrmb4EWy/l9bzQ5vz/debNK3Oc7mF5MOtNXCE=;
	h=Date:From:To:Cc:Subject:From;
	b=N17uFM2UgxUZA7FSErYEX+ycdhudIqu2CeiVZkd8ehQoFM0OXj+Z/yjk2c5Fq5a5a
	 qffzcE1QTf4fRWTgWcP1oeWT/KCqu+/jETkqrJoxe/cBuYRJXSRDcQXPsF4LBSZGXV
	 BCiiSgZKFEfN59u0ttvRi5o5lOu9HbK3RULkDii0jNnd/+0M6bRpvoW2XGfrqKH+69
	 FMpQL57fyA8vGQBWtM/DZKpIBdJYIiC24r2dOIdeF88sljuCbMo0jGvJuAg3GTGCnq
	 AaiVCnukEXFBHUl+5gm/YPF6/ypC8w8oRgcmWtsdVBcImXZityrgEk86Q0Nc2YEsZh
	 L3P6/9ZWniiFg==
Date: Sat, 10 Jan 2026 13:23:56 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [GIT PULL] erofs fix for 6.19-rc5
Message-ID: <aWHibOkAT18Hc/G5@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
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

Could you consider this urgent fix for 6.19-rc5?

Actually upstream commit d53cd891f0e4 ("erofs: limit the level of fs
stacking for file-backed mounts") causes composefs regressions since
EROFS + ovl^2 cannot be mounted properly anymore and we all agree to
land this band-aid fix as the first step.

The more backgound details are shown in the commit message.

Thanks,
Gao Xiang

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc5-fixes

for you to fetch changes up to 072a7c7cdbea4f91df854ee2bb216256cd619f2a:

  erofs: don't bother with s_stack_depth increasing for now (2026-01-10 13:01:15 +0800)

----------------------------------------------------------------
Change since last update:

 - Don't bother with s_stack_depth increasing to band-aid
   regressions in some composefs mount setups (EROFS + ovl^2)

----------------------------------------------------------------
Gao Xiang (1):
      erofs: don't bother with s_stack_depth increasing for now

 fs/erofs/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

