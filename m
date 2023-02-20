Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70069C44A
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Feb 2023 04:03:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PKnKs70kNz3c6Y
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Feb 2023 14:03:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XP1MxDD2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XP1MxDD2;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PKnKp5tW3z3bT1
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Feb 2023 14:03:10 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 94970B809E3;
	Mon, 20 Feb 2023 03:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00220C433D2;
	Mon, 20 Feb 2023 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676862185;
	bh=K4g+VWnYi5actU4XQ7u2VfOjBh1wfqtMcWd25MgtzYY=;
	h=Date:From:To:Cc:Subject:From;
	b=XP1MxDD2uR2PcAJ7G3afM0U1tJyCa5WqVHcG2X1jM3nZm6l5qdJnm+8MACuNmpr36
	 bbVddT3X1TYN0YJ9wyVCbBtrOQqnis1T8dlriLryiXG86rYp9gzp9HqfASZ7E03FYm
	 7GqAZQw8RTl2ld2GPxsI80Qlnk11U53UpP38V/rxMIXvT251/rpAMKYTx+hcNEK8gP
	 RyqDPI4vgzzyD3X0g82Quy0UzAPdagJ0IdrL5rvD4CDBzP0L48xVS42VVaRwqfVPTI
	 XfxuZbGtLOQH42/VfYpXI3+jY/ivaHm8KOIXizeqaQ4haD8WRKeWcZL6wplpVfk4h0
	 Q0h9VtRsoeiGw==
Date: Mon, 20 Feb 2023 11:02:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.3-rc1
Message-ID: <Y/Li4s7qPOArhcSm@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yue Hu <huyue2@coolpad.com>, Yangtao Li <frank.li@vivo.com>,
	Dan Carpenter <error27@gmail.com>, Chao Yu <chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: Dan Carpenter <error27@gmail.com>, Sandeep Dhavale <dhavale@google.com>, Yangtao Li <frank.li@vivo.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.3-rc1?

The most noticeable feature for this cycle is per-CPU kthread
decompression since Android use cases need low-latency I/O handling
in order to ensure the app runtime performance, currently unbounded
workqueue latencies are not quite good for production on many aarch64
hardwares and thus we need to introduce a deterministic expectation
for these.  Decompression is CPU-intensive and it is sleepable for
EROFS, so other alternatives like decompression under softirq contexts
are not considered.  More details are in the corresponding commit
message.

Others are random cleanups around the whole codebase and we will
continue to clean up further in the next few months.

Due to Lunar New Year holidays, some new features were not completely
reviewed and solidified as expected and we may delay them into the
next version.  All commits have been in -next for a while.

Thanks,
Gao Xiang

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc1

for you to fetch changes up to 8d1b80a79452630f157bf634ae9cfcd9f4eed161:

  erofs: fix an error code in z_erofs_init_zip_subsystem() (2023-02-16 22:51:53 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add per-cpu kthreads for low-latency decompression for Android
   use cases;

 - Get rid of tagged pointer helpers since they are rarely used now;

 - Several code cleanups to reduce codebase;

 - Documentation and MAINTAINERS updates.

----------------------------------------------------------------
Dan Carpenter (1):
      erofs: fix an error code in z_erofs_init_zip_subsystem()

Gao Xiang (10):
      erofs: clean up erofs_iget()
      erofs: remove linux/buffer_head.h dependency
      erofs: get rid of debug_one_dentry()
      erofs: simplify iloc()
      erofs: get rid of erofs_inode_datablocks()
      erofs: avoid tagged pointers to mark sync decompression
      erofs: remove tagged pointer helpers
      erofs: move zdata.h into zdata.c
      erofs: get rid of z_erofs_do_map_blocks() forward declaration
      erofs: tidy up internal.h

Jingbo Xu (6):
      erofs: update print symbols for various flags in trace
      erofs: remove unused EROFS_GET_BLOCKS_RAW flag
      erofs: remove unused device mapping in meta routine
      erofs: maintain cookies of share domain in self-contained list
      erofs: relinquish volume with mutex held
      erofs: unify anonymous inodes for blob

Sandeep Dhavale (1):
      erofs: add per-cpu threads for decompression as an option

Thomas Weißschuh (1):
      erofs: make kobj_type structures constant

Yangtao Li (1):
      MAINTAINERS: erofs: Add Documentation/ABI/testing/sysfs-fs-erofs

Yue Hu (1):
      Documentation/ABI: sysfs-fs-erofs: update supported features

 Documentation/ABI/testing/sysfs-fs-erofs |   3 +-
 MAINTAINERS                              |   1 +
 fs/erofs/Kconfig                         |  18 ++
 fs/erofs/data.c                          |  23 +-
 fs/erofs/dir.c                           |  17 --
 fs/erofs/fscache.c                       | 146 +++++------
 fs/erofs/inode.c                         |  42 +--
 fs/erofs/internal.h                      | 146 ++++-------
 fs/erofs/namei.c                         |  18 +-
 fs/erofs/super.c                         |   3 +-
 fs/erofs/sysfs.c                         |   6 +-
 fs/erofs/tagptr.h                        | 107 --------
 fs/erofs/xattr.c                         |  20 +-
 fs/erofs/zdata.c                         | 424 ++++++++++++++++++++++++++-----
 fs/erofs/zdata.h                         | 178 -------------
 fs/erofs/zmap.c                          | 253 +++++++++---------
 include/trace/events/erofs.h             |  17 +-
 17 files changed, 667 insertions(+), 755 deletions(-)
 delete mode 100644 fs/erofs/tagptr.h
 delete mode 100644 fs/erofs/zdata.h
