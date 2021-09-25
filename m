Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9D418356
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Sep 2021 18:00:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HGtrz3cnTz2yPK
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Sep 2021 02:00:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DcLigCXJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DcLigCXJ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HGtrr6gqYz2xtC
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Sep 2021 01:59:56 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0274610FD;
 Sat, 25 Sep 2021 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632585592;
 bh=WAwJ0O+4kCyValty29Ksr2SWwdodXAMeTHDUEnDGDYM=;
 h=Date:From:To:Cc:Subject:From;
 b=DcLigCXJtlu1DMG1XJ29mzkug5nIR1ZZX85k6kuviG43w9fQEMEvp6rf1bNC0Tena
 grawWtx1nCTh7lXawApXm2pWK9i66jt5KLNeLBkl/KaGCCfbGnORC+yZCKbnqHkjsn
 oB87mt1DUbOBgOnSl+TC8qo6cEAD0uKDxfeYwcTPXYbcPD+EhGgr2v7miImeBJPv5D
 RIb0dWprARJcN3KiCLB4uciY+97T8pYe9jBX4jLQmjjcchdv2IY17wUAkbv4TLijk4
 1ktHPkzx/S5DBoXbNBcClHGdlGYZAMxrFkqeX8vVyNgkD2wmO4lBasCI2zQMax8AnR
 i/nOSe5YYQ/1w==
Date: Sat, 25 Sep 2021 23:57:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.15-rc3
Message-ID: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
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
 Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.15-rc3?

2 bugfixes are included in order to fix the 4KiB blockmap chunk format
availability and a dangling pointer usage. There is also a trivial
cleanup to clarify compacted_2b if compacted_4b_initial > totalidx.

All commits have been in -next. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc3-fixes

for you to fetch changes up to c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263:

  erofs: clear compacted_2b if compacted_4b_initial > totalidx (2021-09-23 23:23:04 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix the dangling pointer use in erofs_lookup tracepoint;
 - fix unsupported chunk format check;
 - zero out compacted_2b if compacted_4b_initial > totalidx.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix up erofs_lookup tracepoint
      erofs: fix misbehavior of unsupported chunk format check

Yue Hu (1):
      erofs: clear compacted_2b if compacted_4b_initial > totalidx

 fs/erofs/inode.c             | 2 +-
 fs/erofs/zmap.c              | 3 ++-
 include/trace/events/erofs.h | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)
