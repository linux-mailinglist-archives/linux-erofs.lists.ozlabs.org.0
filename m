Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B6875438
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 17:35:06 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HueRRVog;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrFJj4pdQz3c2F
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Mar 2024 03:35:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HueRRVog;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrFJf5RWrz2y1Y
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Mar 2024 03:34:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 955B760F14;
	Thu,  7 Mar 2024 16:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AF4C433F1;
	Thu,  7 Mar 2024 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709829295;
	bh=ySbGTSB9I9fG9R/a3i18Zv97SxzmylETa0cRNS5mA7w=;
	h=Date:From:To:Cc:Subject:From;
	b=HueRRVogxP9lY8mdHcBw2/cuFe3o0qkDMci6WxrJU9Twszu23HCnq7cD/XFCqOuOo
	 q8fPngYEUI1u6zrR9UI5pTWnQntIiwv0wBdov3OP8WT3IN3qY6OfOTS/uGPbNX5iyX
	 nAP5HITvj9eTnOvwMsQMOuTKLoOSM9kAArCqH31DtZAaRXhduaiS3o8inuidKUMCU0
	 RSB6kQu6UFPzrUCIDU0pPNioPx2IO7F1lknPmQYT8zNLcNLKKKSc6VrrG+nmk7aPwP
	 XUAFzYY+9BrAj9wNhMXEuc9ap/KN6oJyYx4lrqxXLELwNG9o0jNLOROkUqz8rNTT70
	 uz04nnmXh6cpQ==
Date: Fri, 8 Mar 2024 00:34:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs fixes for 6.8-final
Message-ID: <ZensqX1/c0L/hZJf@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this last-minute pull request for 6.8?

The main one is a KMSAN fix which addresses an issue introduced
in this cycle so it'd be much better to fix before releasing, and
the remaining one fixes VMA alignment for THP.

All commits have been in -next (with rvb tags added today) and
no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes

for you to fetch changes up to 4127caee89612a84adedd78c9453089138cd5afe:

  erofs: apply proper VMA alignment for memory mapped files on THP (2024-03-07 10:21:10 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a KMSAN uninit-value issue triggered by a crafted image;

 - Fix VMA alignment for memory mapped files on THP.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix uninitialized page cache reported by KMSAN
      erofs: apply proper VMA alignment for memory mapped files on THP

 fs/erofs/data.c         | 1 +
 fs/erofs/decompressor.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
