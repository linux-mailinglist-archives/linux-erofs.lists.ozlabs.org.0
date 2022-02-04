Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F944A9FCC
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 20:12:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jr4tJ6cl4z3bZG
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Feb 2022 06:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ndhH1LGq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ndhH1LGq; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jr4t90gLPz30Nj
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Feb 2022 06:12:33 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E063561C3A;
 Fri,  4 Feb 2022 19:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5390C004E1;
 Fri,  4 Feb 2022 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644001949;
 bh=bVbFbjLZfm71Rb7hG9w4qG3XkI45O+ysPOPG+cSXIvQ=;
 h=Date:From:To:Cc:Subject:From;
 b=ndhH1LGqfmADGowF3Iyto9Ac2amhDEoE5fNLbMAvW/ZRivgi7Y7BdBmswmv/1hRWs
 danOKq9aWaUXN2M+2KEIdl25MAY71tIQlav/5Em6kBdT7OR9a66iUBOxUOXCNhlqMG
 LD5zayLFJKTEycUGbczTcqwtw4e81KyvNruj3elYNr/5lxZ0pUGklc/g0CaYrdmXwt
 5QxgwLZPxnEhvrmlCNe8NTuxULVUl6BPtdxzzmXuz4aSmVCskM9nh8kbrkwVoW774d
 aKglnb3ckvNFbgmeGZriL66BoGrhkxcxtLiAQltLapjs+bAy0hmH62FwBNIgUOmaWh
 0BCRAk1Lk9Z2w==
Date: Sat, 5 Feb 2022 03:12:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.17-rc3
Message-ID: <20220204191213.GA18192@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Yue Hu <zbestahu@gmail.com>
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
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.17-rc3?

This includes two fixes related to fsdax cleanup in this cycle and
ztailpacking to fix small compressed data inlining. There is also a
trivial cleanup to rearrange code for better reading.

All commits have been in -next and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc3-fixes

for you to fetch changes up to 24331050a3e6afcd4451409831dd9ae8085a42f6:

  erofs: fix small compressed files inlining (2022-02-04 12:37:12 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix fsdax partition offset misbehavior;

 - clean up z_erofs_decompressqueue_work() declaration;

 - fix up EOF lcluster inlining, especially for small compressed data.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix fsdax partition offset handling
      erofs: avoid unnecessary z_erofs_decompressqueue_work() declaration
      erofs: fix small compressed files inlining

 fs/erofs/data.c  |   8 ++--
 fs/erofs/zdata.c | 113 +++++++++++++++++++++++++++----------------------------
 fs/erofs/zmap.c  |   7 ++++
 3 files changed, 67 insertions(+), 61 deletions(-)
