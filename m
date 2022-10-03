Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3845F2F5E
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Oct 2022 13:14:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mgyrq0ZDnz3bjQ
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Oct 2022 22:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ci00h2IS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ci00h2IS;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mgyrg0xNnz2xGk
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Oct 2022 22:13:54 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 46E2F61035;
	Mon,  3 Oct 2022 11:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E72EC433C1;
	Mon,  3 Oct 2022 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664795630;
	bh=TYkEAJtqrEF47EOQjs7AcYg5nunNMI0a9M4M1Ne7U0c=;
	h=Date:From:To:Cc:Subject:From;
	b=ci00h2ISqO6Is76x1eUaaxm5O5Qn9NM4QWMXDRkllpq3oECxNjyJdzrpRGdkiNVGi
	 HK/r4v2xVXldQSFYajhz1P6c0LZjF+5LuY0GIAKcwDuKbBhA0eq0rzeS+X+XHHlYE1
	 GkeZCT9hKecJK9wS1R2WLtNWs3GsjD2PAA+ivmSpXZujkleBS2k2lFArhXSeJ/z4G0
	 7GCpZdqb5HRCdL0tY42qd+0bik1Xp0p7w8yMpAyiGYETJwjsWbc+srSvNkHMrn+nZc
	 WzNL3BXPmEI8jH9y/lTBZd8gvauYhRbft8OMAY5yclYpBctIFqcz+9cq5ywlhxYXcO
	 Mucczu2M/KFCw==
Date: Mon, 3 Oct 2022 19:13:43 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.1-rc1
Message-ID: <YzrD50lgln3c9zEf@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yue Hu <huyue2@yulong.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.1-rc1?

In this cycle, for container use cases, fscache-based shared domain is
introduced [1] so that data blobs in the same domain will be storage
deduplicated and it will also be used for page cache sharing later.

Besides, a special packed inode is now introduced to record inode
fragments which keep the tail part of files by Yue Hu [2].  You can
keep arbitary length or (at will) the whole file as a fragment and then
fragments can be optionally compressed in the packed inode together and
even deduplicated for smaller image sizes.

In addition to that, global compressed data deduplication by sharing
partial-referenced pclusters is also supported in this cycle.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20220916085940.89392-1-zhujia.zj@bytedance.com 
[2] https://lore.kernel.org/r/cover.1663065968.git.huyue2@coolpad.com

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc1

for you to fetch changes up to 312fe643ad1153fe0337c46f4573030d0c2bac73:

  erofs: clean up erofs_iget() (2022-09-27 17:27:45 +0800)

----------------------------------------------------------------
Changes since last update:

 - Introduce fscache-based domain to share blobs between images;

 - Support recording fragments in a special packed inode;

 - Support partial-referenced pclusters for global compressed data
   deduplication;

 - Fix an order >= MAX_ORDER warning due to crafted negative i_size;

 - Several cleanups.

----------------------------------------------------------------
Gao Xiang (4):
      erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
      erofs: introduce partial-referenced pclusters
      erofs: clean up unnecessary code and comments
      erofs: clean up erofs_iget()

Jia Zhu (6):
      erofs: use kill_anon_super() to kill super in fscache mode
      erofs: code clean up for fscache
      erofs: introduce fscache-based domain
      erofs: introduce a pseudo mnt to manage shared cookies
      erofs: Support sharing cookies in the same domain
      erofs: introduce 'domain_id' mount option

Jingbo Xu (1):
      erofs: clean up .read_folio() and .readahead() in fscache mode

Yue Hu (3):
      erofs: support interlaced uncompressed data for compressed files
      erofs: support on-disk compressed fragments data
      erofs: fold in z_erofs_reload_indexes()

 fs/erofs/decompressor.c      |  47 +++--
 fs/erofs/decompressor_lzma.c |   3 +
 fs/erofs/erofs_fs.h          |  40 +++-
 fs/erofs/fscache.c           | 477 ++++++++++++++++++++++++++++---------------
 fs/erofs/inode.c             |  26 +--
 fs/erofs/internal.h          |  57 ++++--
 fs/erofs/namei.c             |  13 +-
 fs/erofs/super.c             |  96 +++++++--
 fs/erofs/sysfs.c             |  23 ++-
 fs/erofs/xattr.h             |   2 -
 fs/erofs/zdata.c             |  51 ++++-
 fs/erofs/zmap.c              | 104 +++++++---
 include/trace/events/erofs.h |  11 +-
 13 files changed, 651 insertions(+), 299 deletions(-)
