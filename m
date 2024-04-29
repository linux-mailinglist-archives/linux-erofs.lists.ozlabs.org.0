Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FC8B54B2
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Apr 2024 12:04:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jo0RNhTa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VSf7n1VPQz3d42
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Apr 2024 20:04:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jo0RNhTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VSf7g55tQz3d24
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Apr 2024 20:04:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0283460C11;
	Mon, 29 Apr 2024 10:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1D9C113CD;
	Mon, 29 Apr 2024 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714385067;
	bh=TMQs2ZThSKL7ZuJsmgK3ppCSu+w2q9rdEEkumpq08Kk=;
	h=Date:From:To:Cc:Subject:From;
	b=Jo0RNhTax2WmFwOctSSt1zPguvty5QKlc+EsNN8ghhqlFc1IpV3nKEOL5QfmSJBkE
	 3XqnOakkbHXNOpod4aW0HZMchYWg7oC1qnO43EmKAu93k4JQTdJOOToiV3tFX3vLUU
	 hVdkeMz6z44Sv10RyKzVN0AhSdjDK4qFiF420YHsQEHlzBVqzvpBqUlTXBMwUobmUJ
	 LenNHvtmSxAIHa3BvmvJTPWy62yWcY0cjr2fMDRwyhSaBraMScD0PElUiRN8k9O+SB
	 hjqlNGO9ywaLa7XATdi7/m3SHwmjK2fQu8viH73USz8BfYpIBVysa8LQf84ZRqPXWh
	 mVjiOfzBvUbnA==
Date: Mon, 29 Apr 2024 18:04:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs fixes for 6.9-rc7
Message-ID: <Zi9wpiog2uo1wGBb@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.9-rc7?

Here are three fixes related to EROFS fscache mode.  The most important
two patches fix calling kill_block_super() in bdev-based mode instead of
kill_anon_super() as mentioned in [1].  The rest patch is an informative
one.

All commits have been in -next and no potential merge conflict is
observed.

[1] https://lore.kernel.org/r/15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com

Thanks,
Gao Xiang

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes

for you to fetch changes up to 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606:

  erofs: reliably distinguish block based and fscache mode (2024-04-28 20:36:52 +0800)

----------------------------------------------------------------
Changes since last update:

 - Better error message when prepare_ondemand_read failed;

 - Fix unmount of bdev-based mode if CONFIG_EROFS_FS_ONDEMAND is on.

----------------------------------------------------------------
Baokun Li (1):
      erofs: get rid of erofs_fs_context

Christian Brauner (1):
      erofs: reliably distinguish block based and fscache mode

Hongbo Li (1):
      erofs: modify the error message when prepare_ondemand_read failed

 fs/erofs/fscache.c  |   2 +-
 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 124 +++++++++++++++++++++++-----------------------------
 3 files changed, 56 insertions(+), 77 deletions(-)
