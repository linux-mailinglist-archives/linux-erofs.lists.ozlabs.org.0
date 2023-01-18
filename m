Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F734671D78
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Jan 2023 14:18:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NxmY931Lmz3fBJ
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jan 2023 00:18:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ovM5RSgX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ovM5RSgX;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NxmY33m3Cz3c9G
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jan 2023 00:18:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 91442617C0;
	Wed, 18 Jan 2023 13:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0E0C433EF;
	Wed, 18 Jan 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674047908;
	bh=etRSyexaS7lKbqSE4du4p/95DwyYLBtFmlpNtRNPPuU=;
	h=Date:From:To:Cc:Subject:From;
	b=ovM5RSgXPoDJsfcJTyCDMZdrECwUmy0zlmZLgKpWF13ffxheqn2JunkHddIdVyVaI
	 eoFZq0RahuoDiIhU2rI1wZo65E9JSrbZIbZdYuT0HE3W1r6FfZlZHTWM9NounHg947
	 9WqlNi2DkPcstcA5Or2Lzjq+X1Z5GWsO5MJCjONrt2F7I8XUb0wPawxKgv3rwDH+e0
	 T0tgahFM94fssrjQ6OyadtsV7UM84BU3to+JaZai+Clxy3sue+Urywchea72B7JYeZ
	 ROPJhYKK6mRutC1H5Nvvi0f554Oe2lhgE6Rn4Esi7Nj1Pb90TxcyVTVVuj61Zy1CWv
	 HI27XMef2yimA==
Date: Wed, 18 Jan 2023 21:18:21 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.2-rc5
Message-ID: <Y8fxnV7ol9OP6JSz@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Siddh Raman Pant <code@siddh.me>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
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
Cc: Siddh Raman Pant <code@siddh.me>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.2-rc5?

Two patches fixes issues reported by syzbot, one fixes
missing `domain_id` mount option started from v6.1 in
documentation and a minor cleanup.  Details are shown
below as well.

All commits have been in -next for a while.

Thanks,
Gao Xiang

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5

for you to fetch changes up to e02ac3e7329f76c5de40cba2746cbe165f571dff:

  erofs: clean up parsing of fscache related options (2023-01-16 22:39:47 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix wrong iomap->length calculation post EOF, which could
   cause a WARN_ON in iomap_iter_done() (Siddh);

 - Fix improper kvcalloc() use with __GFP_NOFAIL (me);

 - Add missing `domain_id` mount option in documentation (Jingbo);

 - Clean up fscache option parsing (Jingbo).

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix kvcalloc() misuse with __GFP_NOFAIL

Jingbo Xu (2):
      erofs: add documentation for 'domain_id' mount option
      erofs: clean up parsing of fscache related options

Siddh Raman Pant (1):
      erofs/zmap.c: Fix incorrect offset calculation

 Documentation/filesystems/erofs.rst |  2 ++
 fs/erofs/super.c                    | 13 ++++++-------
 fs/erofs/zdata.c                    | 12 ++++++------
 fs/erofs/zmap.c                     | 10 +++++++---
 4 files changed, 21 insertions(+), 16 deletions(-)
