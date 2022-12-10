Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E21649000
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 18:29:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTvyh5jH4z3bgZ
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 04:29:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kMSpuHF7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kMSpuHF7;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTvyY3djxz2xbC
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Dec 2022 04:29:25 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFCDE60C73;
	Sat, 10 Dec 2022 17:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE5C433EF;
	Sat, 10 Dec 2022 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670693361;
	bh=wiKXS951R0J+e00NOnz0xf3GpSwcSCJH0lNaVupW9nI=;
	h=Date:From:To:Cc:Subject:From;
	b=kMSpuHF7sqpW85DL5XJkXQKYMtiAuEYhuNgN51FDAJvmcdOL6MssYdhHd6lO1h87I
	 1XVMiQWszGqFcDrS9LMJOh6rxSg4vmeXEKg8z7+/dfBQlHkmmzi0utn0gKsh9J3/ga
	 fNdXeUlrSx0Bs62FCtIPqphI3/vS+bBW1ISf6lknyqvby+TIlK8sEYWPxysf/tcQFC
	 gBLSkAKMBWeSwb4Guui3Bnm2EyohjiiWpBgYsBYHKZNAEQTPPkTzeKFfkj9FaTOOot
	 OKLXUZRPEjFZ+AAqk8IQk5Ugx8LkhpZKKlpGh293g2YeHgKOAQOHQPdcQ7D1lAbz/+
	 tO8xEtS25vCMA==
Date: Sun, 11 Dec 2022 01:29:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
Message-ID: <Y5TB6E77vbpRMhIk@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
	LKML <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Hou Tao <houtao1@huawei.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, Chen Zhongjin <chenzhongjin@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Hou Tao <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Once the merge window opens, could you consider this pull request for
6.2-rc1?

In this cycle, large folios are now enabled in the iomap/fscache mode
for uncompressed files first.  In order to do that, we've also cleaned
up better interfaces between erofs and fscache, which are acked by
fscache/netfs folks and included in this pull request.

Other than that, there are random fixes around erofs over fscache and
crafted images by syzbot, minor cleanups and documentation updates.

Note that there could be a trivial conflict between erofs and vfs
tree according to linux-next report [1].

Happy Holidays!
Gao Xiang

[1] https://lore.kernel.org/r/20221205092415.56cc6e19@canb.auug.org.au/

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1

for you to fetch changes up to c505feba4c0d76084e56ec498ce819f02a7043ae:

  erofs: validate the extent length for uncompressed pclusters (2022-12-07 10:56:31 +0800)

----------------------------------------------------------------
Changes since the last update:

 - Enable large folios for iomap/fscache mode;

 - Avoid sysfs warning due to mounting twice with the same fsid and
   domain_id in fscache mode;

 - Refine fscache interface among erofs, fscache, and cachefiles;

 - Use kmap_local_page() only for metabuf;

 - Fixes around crafted images found by syzbot;

 - Minor cleanups and documentation updates.

----------------------------------------------------------------
Chen Zhongjin (1):
      erofs: Fix pcluster memleak when its block address is zero

Gao Xiang (5):
      erofs: update documentation
      erofs: clean up cached I/O strategies
      erofs: use kmap_local_page() only for erofs_bread()
      erofs: fix missing unmap if z_erofs_get_extent_compressedlen() fails
      erofs: validate the extent length for uncompressed pclusters

Hou Tao (1):
      erofs: check the uniqueness of fsid in shared domain in advance

Jingbo Xu (5):
      erofs: enable large folios for iomap mode
      fscache,cachefiles: add prepare_ondemand_read() callback
      erofs: switch to prepare_ondemand_read() in fscache mode
      erofs: support large folios for fscache mode
      erofs: enable large folios for fscache mode

 Documentation/filesystems/erofs.rst |  38 ++--
 fs/cachefiles/io.c                  |  77 ++++---
 fs/erofs/data.c                     |  10 +-
 fs/erofs/fscache.c                  | 408 ++++++++++++++++--------------------
 fs/erofs/inode.c                    |   2 +
 fs/erofs/internal.h                 |  13 +-
 fs/erofs/super.c                    |   2 +-
 fs/erofs/xattr.c                    |   8 +-
 fs/erofs/zdata.c                    |  80 +++----
 fs/erofs/zmap.c                     |  15 +-
 include/linux/netfs.h               |   8 +
 include/trace/events/cachefiles.h   |  27 +--
 12 files changed, 344 insertions(+), 344 deletions(-)
