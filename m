Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309427F0D04
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 08:51:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qH/Tr60a;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYfpz0cg5z3cRk
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 18:51:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qH/Tr60a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYfpv4lMNz2ykc
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 18:51:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C797BB81050;
	Mon, 20 Nov 2023 07:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B43C433C8;
	Mon, 20 Nov 2023 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700466701;
	bh=6Dy5lixQag+5xA6J3MfdiClmJxKC1ANcF4CazvLin9s=;
	h=Date:From:To:Cc:Subject:From;
	b=qH/Tr60auyxGVkxJaxwaFjtFeS8eh/bLuYf0dSEc+0IrhpSn0NdDXuXI4fWclzdCc
	 NYZjOSuA7HAZp7Q0taRR0FyW2khvO2esrsTCPMKYFk58lz4mLrX+C6Ykfh5ZtSsc6D
	 Ulv9Xpkeh/Di5FZ8HdEZQwbLFkux2nr1msChzyDAAhVroljo2CB1Nlwx/F9mRXEWYj
	 69eu7+MpLsAWgS1q2i5apGUD1nKhao+R0w3pDBD+hq2R11sT2GDtWh0hw/h+RPOY2r
	 1SZjNBttBWEjllfaQplatzvwveiQqF+VWGp/S6/+ae/UYEntlZZWnDfVl/w/TcHL2E
	 RaeIZzKAsA7LQ==
Date: Mon, 20 Nov 2023 15:51:34 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs fixes for 6.7-rc3
Message-ID: <ZVsQBsV2GFTmy+iZ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these patches for 6.7-rc3?

One patch fixes a regression in fscache mode introduced in this cycle.
Another patch adds EROFS webpages which contains more technical
internals: <https://erofs.docs.kernel.org>.  The remaining one is a
trivial cleanup.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc3-fixes

for you to fetch changes up to 62b241efff99fc4d88a86f1c67c7516e31f432a3:

  MAINTAINERS: erofs: add EROFS webpage (2023-11-17 19:55:46 +0800)

----------------------------------------------------------------
Changes since last update:

 - Tidy up erofs_read_inode() for simplicity;

 - Fix broken fscache mode due to NULL dereference of dif->bdev_handle;

 - Add the EROFS webpage to MAINTAINERS, documentation, and Kconfig.

----------------------------------------------------------------
Ferry Meng (1):
      erofs: simplify erofs_read_inode()

Gao Xiang (1):
      MAINTAINERS: erofs: add EROFS webpage

Jingbo Xu (1):
      erofs: fix NULL dereference of dif->bdev_handle in fscache mode

 Documentation/filesystems/erofs.rst |  4 ++
 MAINTAINERS                         |  1 +
 fs/erofs/Kconfig                    |  2 +-
 fs/erofs/data.c                     |  5 +-
 fs/erofs/inode.c                    | 98 +++++++++++++------------------------
 5 files changed, 44 insertions(+), 66 deletions(-)
