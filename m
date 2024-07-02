Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C798923F6F
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 15:48:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hL1xQkTe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD44G2kbkz3d2m
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 23:48:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hL1xQkTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD44B2pNlz3cTw
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 23:48:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0FA64CE1DE8;
	Tue,  2 Jul 2024 13:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA54C4AF10;
	Tue,  2 Jul 2024 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928088;
	bh=cvHBMVkFw0cdu8CqXT2tcn8q1A8BbAKQJOw7cbYh+PU=;
	h=Date:From:To:Cc:Subject:From;
	b=hL1xQkTe78IaQIpZ+hZSpilbOGr94FXS4BIXNKzjyG2uTOS+E2N2g4xRNTexbh2oX
	 F6Xvc5pGyU71I9t96h2dd8/1qfxY9Gryak47fH8wHARvc/+sCJrbgL3yEvc+vH5cov
	 vmUGU4lUZGQ4Ysnw7GwqdW3mrzHpzkESeSIS1LVlGxRM1MJDT9YqY6jwxQx1bCUcNP
	 yTOO1txNNUdPBtyzSJzLw1sc/ADkxfKCOpSJu41iyqVYA88dOeCc8g3CkYXJiOGb0G
	 AttlS2lZwy+WzMmMJHgNVjakYmGHSsz39puhca265ag5zm8TfR2yUo5ncy4MBCkNXa
	 17KzUWDxxu+uA==
Date: Tue, 2 Jul 2024 21:48:02 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.10-rc7
Message-ID: <ZoQFEp+U+689DPdO@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>, Chao Yu <chao@kernel.org>
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

Could you consider these patches for 6.10-rc7?

The most important one fixes possible infinite loops reported by
a smartphone vendor OPPO recently due to some unexpected zero-sized
compressed pcluster out of interrupted I/Os, storage failures, etc.

Another patch fixes global buffer memory leak on unloading, and the
remaining one switches to use super_set_uuid() to keep with the other
filesystems.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes

for you to fetch changes up to 9b32b063be1001e322c5f6e01f2a649636947851:

  erofs: ensure m_llen is reset to 0 if metadata is invalid (2024-06-30 10:54:28 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix possible global buffer memory leak when unloading EROFS module;

 - Fix FS_IOC_GETFSUUID ioctl by using super_set_uuid();

 - Reset m_llen to 0 so then it can retry if metadata is invalid.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: ensure m_llen is reset to 0 if metadata is invalid

Huang Xiaojia (1):
      erofs: convert to use super_set_uuid to support for FS_IOC_GETFSUUID

Sandeep Dhavale (1):
      erofs: fix possible memory leak in z_erofs_gbuf_exit()

 fs/erofs/super.c | 2 +-
 fs/erofs/zmap.c  | 2 ++
 fs/erofs/zutil.c | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)
