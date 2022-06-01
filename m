Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B553AB77
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jun 2022 19:01:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LCwQy72FGz3blH
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jun 2022 03:01:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UmMIsjoy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UmMIsjoy;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LCwQr5CTRz3bkk
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jun 2022 03:01:24 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E77ED615E8;
	Wed,  1 Jun 2022 17:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1100C385B8;
	Wed,  1 Jun 2022 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654102880;
	bh=DjugIgjMpnLg2sPBAyVxP39aECuON049MwOKV8GD/bY=;
	h=Date:From:To:Cc:Subject:From;
	b=UmMIsjoydp/DWM+rFLQIuL6vrWZFbRyhSN0liZ9qDgnSMo3elq5ZpczKUlwrvd9f7
	 slJWRA4AEhiohX/gQjucXYUsSgRRh1pN3bZRsz2SerbNg+V3PxZy0IfY7QRKp64RQC
	 xRt643mCy4ZNZ8/qa8Tf4faVIgChe7+tq0BgUb/oE1/FfwGQyoUQTSTCGnuDIqK1IG
	 1FNdbiBjKwfOqnKLM+BrKCTN66b/4wlfIK8rhhwyrqaFIf474lpDBTXtgUG5gsDzEI
	 5+RjcrfB+eFrev1pkGaz8GsM+ebWMul1vfpydoEnenZIoUwDAoBVyjZvoQ+udqcDyr
	 Vvc4N2wxdbevw==
Date: Thu, 2 Jun 2022 01:01:11 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.19-rc1
Message-ID: <YpebV0BiGsrl8UDQ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

This is a follow-up pull request including some fixes of fscache
mode related to compressed inodes and a cachefiles tracepoint.
There is also a patch to fix an unexpected decompression strategy
change due to a cleanup in the past.  All the fixes are quite small.

Apart from these, documentation is also updated for a better
description of recent new features.

In addition, the reason why I decided to post these now is that
I'm working on folio adaption for compressed files with widely
cleanups.  It seems that some trivial cleanups without actual logical
change can be submitted in advance, so I could have a more recent
codebase to work on folios and avoiding the PG_error page flag for
the next cycle.  It'd be better to submit them in this merge window
instead of post-rc1 since they are not fixes strictly.

All commits have been in -next and stress tested.
Please consider this request!

Thanks,
Gao Xiang

The following changes since commit 65965d9530b0c320759cd18a9a5975fb2e098462:

  Merge tag 'erofs-for-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2022-05-24 18:42:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1-fixes

for you to fetch changes up to 4398d3c31b582db0d640b23434bf344a6c8df57c:

  erofs: fix 'backmost' member of z_erofs_decompress_frontend (2022-05-31 23:15:30 +0800)

----------------------------------------------------------------
Changes since last update:

 - Leave compressed inodes unsupported in fscache mode for now;

 - Avoid crash when using tracepoint cachefiles_prep_read;

 - Fix `backmost' behavior due to a recent cleanup;

 - Update documentation for better description of recent new features;

 - Several decompression cleanups w/o logical change.

----------------------------------------------------------------
Gao Xiang (4):
      erofs: update documentation
      erofs: get rid of `struct z_erofs_collection'
      erofs: get rid of label `restart_now'
      erofs: simplify z_erofs_pcluster_readmore()

Jeffle Xu (1):
      erofs: leave compressed inodes unsupported in fscache mode for now

Weizhao Ouyang (1):
      erofs: fix 'backmost' member of z_erofs_decompress_frontend

Xin Yin (1):
      erofs: fix crash when enable tracepoint cachefiles_prep_read

 Documentation/filesystems/erofs.rst |  64 +++++++++-----
 fs/erofs/fscache.c                  |   1 +
 fs/erofs/inode.c                    |   5 +-
 fs/erofs/zdata.c                    | 167 +++++++++++++++---------------------
 fs/erofs/zdata.h                    |  50 +++++------
 5 files changed, 136 insertions(+), 151 deletions(-)

