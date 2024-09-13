Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B594978725
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 19:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726249723;
	bh=qyj6uUlXu31uAUa2LKaDFkiqsjhTVtTHPYj4mqn1L5s=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZeTBwaAqZgRAb4kYValMd3qgFTzPlmYDjdoRjVDTsx35LJoAiT5ELex+UGrvDu9N8
	 jbpyujOenahUxBKg2lU1hu3kKQfU2qomUNwFc0H9Y7KENd8+oYMuVS8Fi+LoRXr2fF
	 C5hQ9pcsgK0n9KXr8cq852acuQt9bgmB1QVnwKSLsrjvzUM+FNkTjBAvuTbiJom9G0
	 UCujHRtMQxB2++GuMMFPgG7pxHPOiEpYRiwenxWnM9D0+HtuuQw0zvhsS+hewG1vqf
	 5M+V+LB8J92ObHWXsGSJDj+JaS4NnWKuCeP2TYseHzUkRkEc/JO7PEqOwNDiW7ptqv
	 D5yo/bgZSJT/A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X51y33J8Jz2ywh
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 03:48:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726249721;
	cv=none; b=GVpUQ8Bfk/Ia9I27kYBTUtAUL1O23Rp193KMXAqj3+u02cIK9eTNdI4oOeJ0APLdGXXKo/j5aNd3mbXPYDlDlDi78V7yRp65t71fJgGdNqqtOXKSdHrndAFSJsvxOMk80Q/zhsoQlshYmPstErQPSUChtVdAfmp2Z7zR/C7kuhG4ZkmRew10THKotz/WA+c2tzEUd0HwD5zzhu7gmuCndtIW8+KdpZj6UUqNsD+5k4H5M9MlkGyHCYihvOnNnw+nwJkU/xDQSpYb6CtgBwVqiIQH3xs+laM2zWzDDplhpRfAahxfZPdufWsZcN4HiZ2jh5xsN9IMOiuaxQvR+wZ9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726249721; c=relaxed/relaxed;
	bh=qyj6uUlXu31uAUa2LKaDFkiqsjhTVtTHPYj4mqn1L5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m9WAQRP2jIenCY1dzmpGnzddMmXr+T8sS17NxSoFV1DD8fWCv6ApvxwCZlPEGoaENVqahCe0RFOdQ4a7/B4CwaY9mLJ0ZBCA4iHZNs+ZXF5kWLO5VIc/go8EOG2X6LTvYV+dY7nYu0OXGq1l/GtNA7/kFmavjzh+hlTqL1PIAMhMSGNxmedn92Uprp9JiY/MJpAqYJ46Od9YnV9wh1inp+nO1IEwEx/u1QFlE11/T2z1CB7IYNB+HcuwQKcdboa3idkVv8i2VgkCdUwAouQoOWvidog83YcVF/3QJ33qmUTARpL0R8USO7PS9qRd8kc3RFji7dSoWCuk2Cc+qcZrxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B9Tq02fW; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B9Tq02fW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X51y06X6pz2ym2
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Sep 2024 03:48:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F4C65C1CC4;
	Fri, 13 Sep 2024 17:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F2C4CEC0;
	Fri, 13 Sep 2024 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249717;
	bh=Y5gQ40zmMeWnVA/ZC0/AJPglvrv6zNXwP2X+yYqn3YM=;
	h=Date:From:To:Cc:Subject:From;
	b=B9Tq02fW45jqkSbXtFOm+kioCJNAQSd7QyYnJmGNTmaixZ3Qe/24zcvG3vMfotRWC
	 nLVBvcEiZ8NeQ0wovVd/S8qBy7YtEmxOXHPjmqY4NK/zfHyQrDbDIqnEQ0SQ7dDl4n
	 ZVnNYH8EXZfuO4qiFIjqmEfEcegYlP+8WP9boVqthqkTC+1uCx+9cTJa1mtjR4IqMp
	 YrzfYXGfiM6KXtvuoTntPU0EqCQO4m1YA/yJYt3r77dsrG8l+PHRSirvehyB8liAuQ
	 bF7CwOGCtoputDlOaSlIDn3UwttsC1viR9u0R4Ol0OvX6waav8wA90dUJc9o/eD+Y0
	 A1RvwLLuVwLew==
Date: Sat, 14 Sep 2024 01:48:29 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.12-rc1
Message-ID: <ZuR67f12ntVf59FZ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>, Sandeep Dhavale <dhavale@google.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Yiyang Wu <toolmanp@tlmp.cc>, Chunhai Guo <guochunhai@vivo.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.12-rc1? It's a bit earlier
due to our mid-autumn festival holidays next week.

In this cycle, we'd like to add file-backed mount support, which has
has been a strong requirement for years.  It is especially useful when
there are thousands of images running on the same host for containers
and other sandbox use cases, unlike OS image use cases.

Without file-backed mounts, it's hard for container runtimes  to manage
and isolate so many unnecessary virtual block devices safely and
efficiently, therefore file-backed mounts are highly preferred.
For EROFS users, ComposeFS [1], containerd, and Android APEXes [2] will
directly benefit from it, and I've seen no risk in implementing it as
a completely immutable filesystem.

The previous experimental feature "EROFS over fscache" is now marked as
deprecated because:

 - Fscache is no longer an independent subsystem and has been merged
   into netfs, which was somewhat unexpected when it was proposed.

 - New HSM "fanotify pre-content hooks" [3] will be landed upstream.
   These hooks will replace "EROFS over fscache" in a simpler way, as
   EROFS won't be bother with kernel caching anymore.  Userspace
   programs can also manage their own caching hierarchy more flexibly.

Once the HSM "fanotify pre-content hooks" is landed, I will remove the
fscache backend entirely as an internal dependency cleanup.  More
backgrounds are listed in the original patchset [4].

In addition to that, there are bugfixes and cleanups as usual as shown
below.  All commits have been in -next and no potential merge conflict
is observed.

Thanks,
Gao Xiang

[1] https://github.com/containers/storage/pull/2039 
[2] https://lore.kernel.org/r/CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com
[3] https://lore.kernel.org/r/cover.1725481503.git.josef@toxicpanda.com
[4] https://lore.kernel.org/r/20240830032840.3783206-1-hsiangkao@linux.alibaba.com 

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1

for you to fetch changes up to 025497e1d176a9e063d1e60699527e2f3a871935:

  erofs: reject inodes with negative i_size (2024-09-12 23:00:09 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support file-backed mounts for containers and sandboxes;

 - Mark the experimental fscache backend as deprecated;

 - Handle overlapped pclusters caused by crafted images properly;

 - Fix a failure path which could cause infinite loops in
   z_erofs_init_decompressor();

 - Get rid of unnecessary NOFAILs;

 - Harmless on-disk hardening & minor cleanups.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: allocate more short-lived pages from reserved pool first

Gao Xiang (10):
      erofs: fix incorrect symlink detection in fast symlink
      erofs: clean up erofs_register_sysfs()
      erofs: handle overlapped pclusters out of crafted images properly
      erofs: add file-backed mount support
      erofs: support unencoded inodes for fileio
      erofs: support compressed inodes for fileio
      erofs: mark experimental fscache backend deprecated
      erofs: sunset unneeded NOFAILs
      erofs: restrict pcluster size limitations
      erofs: reject inodes with negative i_size

Hongzhen Luo (1):
      erofs: simplify erofs_map_blocks_flatmode()

Sandeep Dhavale (1):
      erofs: fix error handling in z_erofs_init_decompressor

Yiyang Wu (2):
      erofs: use kmemdup_nul in erofs_fill_symlink
      erofs: refactor read_inode calling convention

 fs/erofs/Kconfig        |  22 +++++-
 fs/erofs/Makefile       |   1 +
 fs/erofs/data.c         | 109 ++++++++++++++++++---------
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |   5 +-
 fs/erofs/fileio.c       | 192 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c        | 138 +++++++++++++++-------------------
 fs/erofs/internal.h     |  26 ++++++-
 fs/erofs/super.c        |  80 +++++++++++++-------
 fs/erofs/sysfs.c        |  30 ++------
 fs/erofs/zdata.c        | 196 ++++++++++++++++++++++--------------------------
 fs/erofs/zmap.c         |  42 +++++------
 12 files changed, 544 insertions(+), 299 deletions(-)
 create mode 100644 fs/erofs/fileio.c
