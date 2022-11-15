Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33000629C0F
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 15:26:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBT4f1mSxz3cKY
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Nov 2022 01:26:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l5Pktcy4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l5Pktcy4;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBT4V1tZvz3cDM
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Nov 2022 01:26:02 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 60FB6617BC;
	Tue, 15 Nov 2022 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B16C433C1;
	Tue, 15 Nov 2022 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668522356;
	bh=WXu6kxIQDc98LvRRfjvGWQ6aV8piv1ExqJ/ldXVYpBg=;
	h=Date:From:To:Cc:Subject:From;
	b=l5Pktcy4VNyVfeoHn/2Ew9ji3BKPDu9R7l6pExb9L6//QezjtM2LdxsQNKvWkIna3
	 UGeyfbozku4nrUT6EXVh6Wax0HFY56IGO0PJtval45STmpqB47j/3ISqwC5NRNJTjk
	 4RaXby5tZyGHvgp7iZVz5u72lLWqUUle5+4vDjjhTj+JxMMlYymJhA/J66137bHR4S
	 4CaOC3QpJejOZhCjCS3bv7ZWahpkILMwIfB6Y3h79thjaYUxEF5PcYaL0IlFXhZgns
	 VJWSwSiHBBlTb9WD+ZOBJbCJ/hS4JjiKQTU49np/CO4poxmJFP21u3r3ZM2C5qxFXe
	 Bp8tPeDEBDIVQ==
Date: Tue, 15 Nov 2022 22:25:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.1-rc6
Message-ID: <Y3OhbojEWZa35DVf@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org,
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
Cc: LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these three fixes for 6.1-rc6?

Most patches randomly fix error paths or corner cases in fscache mode
reported recently.  And the rest one fixes an invalid access relating
to fragments on crafted images.  Details are shown as below.

I should submit earlier for -rc5 but actually delay a bit since one
commit message got minor updated.  All commits have been in linux-next
and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc6-fixes

for you to fetch changes up to 37020bbb71d911431e16c2c940b97cf86ae4f2f6:

  erofs: fix missing xas_retry() in fscache mode (2022-11-14 23:48:38 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix packed_inode invalid access when reading fragments on crafted
   images;

 - Add a missing erofs_put_metabuf() in an error path in fscache mode;

 - Fix incorrect `count' for unmapped extents in fscache mode;

 - Fix use-after-free of fsid and domain_id string when remounting;

 - Fix missing xas_retry() in fscache mode.

----------------------------------------------------------------
Jingbo Xu (4):
      erofs: put metabuf in error path in fscache mode
      erofs: get correct count for unmapped range in fscache mode
      erofs: fix use-after-free of fsid and domain_id string
      erofs: fix missing xas_retry() in fscache mode

Yue Hu (1):
      erofs: fix general protection fault when reading fragment

 fs/erofs/fscache.c  | 35 +++++++++++++++++++++--------------
 fs/erofs/internal.h |  6 ++++--
 fs/erofs/super.c    | 39 ++++++++++++++++++++++-----------------
 fs/erofs/sysfs.c    |  8 ++++----
 fs/erofs/zdata.c    |  3 +++
 5 files changed, 54 insertions(+), 37 deletions(-)
