Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2694E2189
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 08:46:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMRWT5lZqz30JD
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 18:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ck3ZkIUB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ck3ZkIUB; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMRWL32mwz3036
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Mar 2022 18:46:06 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E0DB360FE9;
 Mon, 21 Mar 2022 07:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED36C340EE;
 Mon, 21 Mar 2022 07:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647848762;
 bh=QldX2CgA/jrZgyN9GjhxNhil+DepyQR7nCll9agSBts=;
 h=Date:From:To:Cc:Subject:From;
 b=ck3ZkIUBA/csRuIiZRzDFv38GO5nDKZGp0SGz/GCchIIjtdylPAk/J2XzfDMA6mhh
 o2/cWWKkBHWwkDoCkBvnj0NyG31Td0W2ZPRFkuTpjmrzJnhkAlLM9MXbcNWzTuhwUe
 IuO9n29T9FTriCzPD5OgNzceksvOsGW16SSEVXXGIQBXeue8E7ycmQ7hfvqAhIr/Al
 rzMyTTyXyJe0dOEwz9cmJZ0I0Cf+rZ0nFfm+pfQPOgVzsP2JUP01SpDg0KDRurD4o8
 sj2PYRKf8AHmR0vbvSDwW10cHL3Li54zG3/XighK5Sf96QUiUZMmweMUi9uddHCCHn
 F24SDRw0PF6Uw==
Date: Mon, 21 Mar 2022 15:45:38 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.18-rc1
Message-ID: <YjgtIqJK0Io+zYeI@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>,
 lihongnan <hongnan.lhn@alibaba-inc.com>,
 Dongliang Mu <mudongliangabcd@gmail.com>,
 David Anderson <dvander@google.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Dongliang Mu <mudongliangabcd@gmail.com>,
 lihongnan <hongnan.lhn@alibaba-inc.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.18-rc1?

In this cycle, we continue converting to use meta buffers for all
remaining uncompressed paths to prepare for the upcoming subpage,
folio and fscache features.

We also fixed a double-free issue when sysfs initialization fails,
which was reported by syzbot.

Besides, in order for the userspace to control per-file timestamp
easier, we now switch to record mtime instead of ctime with a
compatible feature marked. And there are also some code cleanups
and documentation update as usual.

All commits have been in -next for a while and there is a minor
trivial merge conflict with folio -next tree [1].

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20220315203112.03f6120c@canb.auug.org.au

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc1

for you to fetch changes up to a1108dcd9373a98f7018aa4310076260b8ecfc0b:

  erofs: rename ctime to mtime (2022-03-17 23:41:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Avoid using page structure directly for all uncompressed paths;

 - Fix a double-free issue when sysfs initialization fails;

 - Complete DAX description for erofs;

 - Use mtime instead since there's no (easy) way for users to control
   ctime;

 - Several code cleanups.

----------------------------------------------------------------
David Anderson (1):
      erofs: rename ctime to mtime

Dongliang Mu (1):
      fs: erofs: add sanity check for kobject in erofs_unregister_sysfs

Gao Xiang (7):
      erofs: get rid of `struct z_erofs_collector'
      erofs: clean up preload_compressed_pages()
      erofs: silence warnings related to impossible m_plen
      erofs: clean up z_erofs_extent_lookback
      erofs: refine managed inode stuffs
      erofs: use meta buffers for reading directories
      erofs: use meta buffers for inode lookup

Jeffle Xu (1):
      erofs: use meta buffers for erofs_read_superblock()

lihongnan (1):
      Documentation/filesystem/dax: update DAX description on erofs

 Documentation/filesystems/dax.rst   |   6 +-
 Documentation/filesystems/erofs.rst |   2 +-
 fs/erofs/data.c                     |  12 ++-
 fs/erofs/dir.c                      |  21 ++--
 fs/erofs/erofs_fs.h                 |   5 +-
 fs/erofs/inode.c                    |   4 +-
 fs/erofs/internal.h                 |   2 +
 fs/erofs/namei.c                    |  54 +++++------
 fs/erofs/super.c                    |  21 ++--
 fs/erofs/sysfs.c                    |   8 +-
 fs/erofs/zdata.c                    | 184 +++++++++++++++++-------------------
 fs/erofs/zmap.c                     |  71 +++++++-------
 12 files changed, 189 insertions(+), 201 deletions(-)
