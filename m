Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B993E5AF01B
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 18:16:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMVrN55NLz30NS
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Sep 2022 02:16:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GckO6Dab;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GckO6Dab;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMVrF6wx3z2xn5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Sep 2022 02:16:29 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A17CC6159A;
	Tue,  6 Sep 2022 16:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB517C433B5;
	Tue,  6 Sep 2022 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662480985;
	bh=8WcaE0tiCNvuuwz8DZZ6kQiMgY1Udyvw/3H0BR4qL04=;
	h=Date:From:To:Cc:Subject:From;
	b=GckO6DabkKG7qGxm3/LoYg2wK75NSR1IFK7DOkEqi1HMfbsyqZ4V6eqpZ4GNJvAsr
	 kEf5Zy9c1l9SQ68aZTh0wJ3qfVlDjj2dTKgNwD2MchkefmzXGBDnQMooi7/CNvRZMM
	 Psovo/bRSch79Zwo4gp9hjMmKAAdCuhjkRf9XqZUV9ohyP5EZBjgUnJpcAKdF4j6Ah
	 KYPQ4A7paV5wfTmVi4jIqidlmmYlh7C5H6iEvUpoYGe2sOeST9tEiYpzjGYNj0vkWh
	 jLfLmIa3SVFan2IzJp67qli/+26nFYrNsxjwaz7bznl3xVCLleQ+E3kdgiErYgupi5
	 YGqODi5M50ijg==
Date: Wed, 7 Sep 2022 00:16:19 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.0-rc5
Message-ID: <YxdyU26Us1vmDxVJ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Sun Ke <sunke32@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Sun Ke <sunke32@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these three fixes for 6.0-rc5?

One patch fixes error paths in fscache backend.  Another fixes a
use-after-free on UP platforms whose path is now dropped directly.
The rest addresses potential wrong pcluster sizes for later non-4K
lclusters.  It should have no effect on the existing fs images but
the fix is small and straight-forward so that it'd be better to be
fixed from now on.

All commits have been in linux-next and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes

for you to fetch changes up to 2f44013e39984c127c6efedf70e6b5f4e9dcf315:

  erofs: fix pcluster use-after-free on UP platforms (2022-09-05 23:23:30 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix return codes in erofs_fscache_{meta_,}read_folio error paths;

 - Fix potential wrong pcluster sizes for later non-4K lclusters;

 - Fix in-memory pcluster use-after-free on UP platforms.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix pcluster use-after-free on UP platforms

Sun Ke (1):
      erofs: fix error return code in erofs_fscache_{meta_,}read_folio

Yue Hu (1):
      erofs: avoid the potentially wrong m_plen for big pcluster

 fs/erofs/fscache.c  |  8 ++++++--
 fs/erofs/internal.h | 29 -----------------------------
 fs/erofs/zmap.c     | 16 ++++++++--------
 3 files changed, 14 insertions(+), 39 deletions(-)

