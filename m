Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E4505C97
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Apr 2022 18:44:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kht7Q233Mz2yn2
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Apr 2022 02:44:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BvV/Unb2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BvV/Unb2; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kht7J1fwhz2yQK
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Apr 2022 02:44:12 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 1453ECE1000;
 Mon, 18 Apr 2022 16:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED97C385A1;
 Mon, 18 Apr 2022 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650300246;
 bh=JvnW2ozespb52lH6msQpgKbA7utUCamhmI6+q8wdsec=;
 h=Date:From:To:Cc:Subject:From;
 b=BvV/Unb2MbsQjxbXEqoYLkWXM1VRP325ae+RXseFDJVIzs4eP8A9pAUD406f5/dPL
 DxBQmuAYfNs288XsZJaMBSmOqOmrRAImDN7Lny81VLQiv2yNFAOnohidpJn7nJfBO5
 Ov49mdJgC13+xEoGrNs5ol3u4fVwnu0TUlhrSXyoQLo8ZPMV6mcnHbtCmcV5HQq2GM
 HlzzCfox97vHKXFEtWb3zNWYGMFPtRsk0bqB0vKPuG/dfIVcqRIKjVsIzEirGoeObX
 PVDKxFJqf7GYDo7o6h8eZn8gTqUAcVgwOR5U6Ypmr6Eb70nWpOPZBOsWfh91qQGyyh
 quD9Jg+Q01Y1w==
Date: Tue, 19 Apr 2022 00:43:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.18-rc4
Message-ID: <Yl2VJEuDCWT4lycg@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Chao Yu <chao@kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
 Hans de Goede <hdegoede@redhat.com>
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
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these two fixes for 5.18-rc4?

One patch fixes a use-after-free race related to the on-stack
z_erofs_decompressqueue, which happens very rarely but needs to
be fixed properly soon. The other patch fixes some sysfs Sphinx
warnings.

All commits have been in linux-next for a while and no merge
conflicts.

Thanks,
Gao Xiang


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc4-fixes

for you to fetch changes up to 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55:

  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors (2022-04-15 23:51:54 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix use-after-free of the on-stack z_erofs_decompressqueue;

 - Fix sysfs documentation Sphinx warnings.

----------------------------------------------------------------
Hans de Goede (1):
      Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

Hongyu Jin (1):
      erofs: fix use-after-free of on-stack io[]

 Documentation/ABI/testing/sysfs-fs-erofs |  5 +++--
 fs/erofs/zdata.c                         | 12 ++++--------
 fs/erofs/zdata.h                         |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)
