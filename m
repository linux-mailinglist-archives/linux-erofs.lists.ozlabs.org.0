Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F660289F
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 11:45:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ms8B4422qz3c3Z
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 20:45:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GNfiAcGQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GNfiAcGQ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ms89y33ZNz3bjW
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Oct 2022 20:45:42 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 53875614F9;
	Tue, 18 Oct 2022 09:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01ACC433D6;
	Tue, 18 Oct 2022 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666086338;
	bh=ynFfTnsMzotOvesw2GH8zo+VK9nmB0W4W0cdoZ7kzQM=;
	h=Date:From:To:Cc:Subject:From;
	b=GNfiAcGQnrrL6bKw5nbO7Vgu6yGNgbpkmhdRW+jVcUF0qgEKNUPr8N0Xqewf537SH
	 /5fVLtG/mhOF6s+5bnKJ4J8iCv8EFA+1u/w0Y1yxCfeCWK6oAFu10y6AZWvXllcn+T
	 gOtgsmOKL+Kc2IGmntilHIMpSlnyRaEuc2ynpjYJ3VQXkTrTRYhEnfD+n7PM9C2P0e
	 tIz5PZOs2ggc6f1M561ODPlMCfwEWKXJmEi6MgWZ4VYH3r0U1EQDOOuYr7NYrWvFH+
	 v/hFIK2C9JYaXZkUQjspuOOKR08uCZeVHH07r/u4YwTXQp9aoO1iWPqL+zn8RzDo/F
	 KD38S88m0uPFQ==
Date: Tue, 18 Oct 2022 17:45:30 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.1-rc2
Message-ID: <Y051uhn/opotPmAo@hsiangkao-PC>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Dawei Li <set_pte_at@outlook.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, Dawei Li <set_pte_at@outlook.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(sorry, forgot to send to related mailing lists... resend now)

Hi Linus,

Could you consider these fixes for 6.1-rc2?

There are some bugs reported these days and the following patches
address them.

Some issues looks trivial but the compressed data deduplication one
can only be reproduced with the stress test for almost two weeks.

Anyway, I think all of them needs to be fixed immediately and details
are shown as below.  All commits have been in linux-next and no merge
conflicts.

Thanks,
Gao Xiang

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes

for you to fetch changes up to ce4b815686573bef82d5ee53bf6f509bf20904dc:

  erofs: protect s_inodes with s_inode_list_lock for fscache (2022-10-17 14:57:57 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix illegal unmapped accesses when initializing compressed inodes;

 - Fix up very rare hung on page lock after enabling compressed data
   deduplication;

 - Fix up inplace decompression success rate;

 - Take s_inode_list_lock to protect sb->s_inodes for fscache shared
   domain.

----------------------------------------------------------------
Dawei Li (1):
      erofs: protect s_inodes with s_inode_list_lock for fscache

Gao Xiang (2):
      erofs: shouldn't churn the mapping page for duplicated copies
      erofs: fix up inplace decompression success rate

Yue Hu (1):
      erofs: fix illegal unmapped accesses in z_erofs_fill_inode_lazy()

 fs/erofs/fscache.c |  3 +++
 fs/erofs/zdata.c   | 17 +++++++----------
 fs/erofs/zdata.h   |  6 +++---
 fs/erofs/zmap.c    | 22 ++++++++++------------
 4 files changed, 23 insertions(+), 25 deletions(-)
