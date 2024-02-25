Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F8862A78
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 14:47:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M7TNzUul;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjQ5w2T9rz3c9r
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Feb 2024 00:47:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M7TNzUul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TjQ5p12qrz3bnB
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 00:46:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6A0A8CE0E76;
	Sun, 25 Feb 2024 13:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB7C433F1;
	Sun, 25 Feb 2024 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708868810;
	bh=EKsadki2iNG4Syzhlhtr+rJTqBhxRey8Twe4U6+4Wqc=;
	h=Date:From:To:Cc:Subject:From;
	b=M7TNzUuldXkWTht6AigEB7Bks3NsIrFyL7SgpQThL7YVDn/k9mxq1OdvYQ2ANxULS
	 cdm5taY4N8xIgx1des8RCFoolZZrC4dR7HP7habnfU68ktNYUs48zb7GRpB3WUSDuV
	 h0alij2IGwr8aFIL0rH7/eHoKlFcgsxmqQMBg8/LUPQXODxTvKMFl/ifDmL0dqnBS5
	 MWkLLvAbzCXjBSeDFo08+7bBRHpkxRAENgs7FJLgyfXpQvoiz7HodjZHRcQ0erNPcq
	 CR2LmgAM/RJPRE5qEGogQ9dZlAUppVekOk8vl1+YrunDv+4VKjRQwgq/ImZTgMUtnv
	 Wk6AD6fQWgXvQ==
Date: Sun, 25 Feb 2024 21:46:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [GIT PULL] erofs fix for 6.8-rc6
Message-ID: <ZdtEwtN2BsCYnCeY@debian>
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

Could you consider this fix for 6.8-rc6?

The detailed description is as below and I think it'd be
much better to be landed now than later.

It has been in -next and no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes

for you to fetch changes up to 56ee7db31187dc36d501622cb5f1415e88e01c2a:

  erofs: fix refcount on the metabuf used for inode lookup (2024-02-22 15:54:21 +0800)

----------------------------------------------------------------
Change since last update:

 - Fix page refcount leak when looking up specific inodes
   introduced by metabuf reworking.

----------------------------------------------------------------
Sandeep Dhavale (1):
      erofs: fix refcount on the metabuf used for inode lookup

 fs/erofs/namei.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)
