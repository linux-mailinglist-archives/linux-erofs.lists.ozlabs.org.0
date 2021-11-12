Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202544E9C3
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 16:13:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrMXw0p0yz2yp1
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Nov 2021 02:13:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L69Vwjz+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L69Vwjz+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrMXr73yJz2xY4
 for <linux-erofs@lists.ozlabs.org>; Sat, 13 Nov 2021 02:13:16 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC33D61039;
 Fri, 12 Nov 2021 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636729994;
 bh=5hnz5F+TE+0eKQ93EziZ9HPbLm9MBzXgmdtn1ecVitE=;
 h=Date:From:To:Cc:Subject:From;
 b=L69Vwjz+yv0SKlETQvfDj8scuC7W3UwvTxyMdv87bjz2jCFxEIBfjOrgBJgDnwuWv
 EriGUFHVqiySrDzersjajR0DAEAXh46oQZVfPNzOCkHIrTIrant82hSgzpa08t+JtE
 cCdbu9vbaCCgl7wqLz4XbZ5tVWohPvFmIbuzRrDkC4ln65OfUddbDkn1/8ukN5mWFL
 OOsi2hUsfdyfzHusdhnbH6d2tdVX+bs/BNpl6zHySapOWPm3tnpsW7cbKL3dvG1WpT
 zJHH8QfEAuVoF1NP6o3HplN9aNVDw9j2AGKdW1dq+n8Yz+ygMHY25IuSXmdtmD8vPi
 AkS0FE99yb+dA==
Date: Fri, 12 Nov 2021 23:13:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.16-rc1
Message-ID: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
 Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you please consider these 2 small erofs patches?

One patch fixes an old corner case which can hardly reproduce
but cause unsafe pagevec reuse. It needs to be fixed right now.

Another patch is a trivial cleanup which gets rid of the unused
DELAYEDALLOC strategy which has already been replaced by TRYALLOC.

All commits have been in linux-next for a while and no merge
conflicts. I think no need to hold on these until 5.16-rc1 is
out and I could plan for 5.17 cleanup/development stuffs then...

Many thanks!
Gao Xiang

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1-fixes

for you to fetch changes up to 4c7e42552b3a1536f3cdf534aba8c4262ee26716:

  erofs: remove useless cache strategy of DELAYEDALLOC (2021-11-08 10:02:34 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix unsafe pagevec reuse which could cause unexpected behaviors;

 - get rid of the unused DELAYEDALLOC strategy.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix unsafe pagevec reuse of hooked pclusters

Yue Hu (1):
      erofs: remove useless cache strategy of DELAYEDALLOC

 fs/erofs/zdata.c | 33 +++++++--------------------------
 fs/erofs/zdata.h |  1 -
 fs/erofs/zpvec.h | 13 ++++++++++---
 3 files changed, 17 insertions(+), 30 deletions(-)

