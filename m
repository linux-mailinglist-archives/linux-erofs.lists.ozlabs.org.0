Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDD0A4199A
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 10:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1740390835;
	bh=Krn4gjvkBmqA/FwymkhlEO2A4LIP8vepXPsLolf9PO8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KBcyFGBG9PSqEJ+fkR/IyOqYxvtxI4ji26ZgtNy/UqQDFhOCRrgaOLkXbewPKUDki
	 5VdvGp8g6VacTCzryvuvV8+NhXc1Q1Gbv4LP/SipGtoF1fI8dbh5zoShH1droNvenT
	 uVU2awRN1uzF7TQ7RhzLwU4lafcyLmc9I+rqcxotyTXi9mr/9uAhQdaMMEnv5JX9j9
	 ge0itnURPBKRjUh4BEiXtezIVT15uL6SpD7kJlR1tXUlCmO5X72cDemYSl/Y8PSs6a
	 EcemZAHQBfZkfi588CcncdEfBk8tmX81/M6wHzm+6FVszgH4HGL/k1Kig5zxMxl4Vo
	 r9bLaJgXxp9mA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1bfW1bX4z305D
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 20:53:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740390833;
	cv=none; b=BY3igau21GJkFBItvvNL2t93coXNysjRFIn0n7t3qXn0q0Dwh/RaA6eSjaRFsB5ndn9nqKRrzcmUylrwvC0DWakoLYYhZbAeaA3FSwf5w3s9enCcZY2dC1iqQrzAf1yXx9ZRTlDZyKARUOMIlu0Z+Rk7leTCy7YdNK7vvSzA0XkbiAc41XSQCR0iLmjePpAiG92lxtzwnNNyxU1EAIIKCD+O5xMk5SDXMxDKqDK9s/3I3nHNJi1y1ulOidWvX4rnvQgTj3MYYYLA1na81lnE8+XX+C+wCptnRuK0w6uFOn8mkQ4x6GoJ8BhROO5Y1amLon1JHaYoeUZhqQLhvGqn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740390833; c=relaxed/relaxed;
	bh=Krn4gjvkBmqA/FwymkhlEO2A4LIP8vepXPsLolf9PO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LzYHiB5fHQJsbrOv5J9HifHsQEJwz+ZySYNBz+Prrd0dn1WhaeU/KQvmNiTqnLOdkxNrHXKe3VbJUwMAefOiMEzKSWtA2vscxxhhXGLhSYsmmlVdIoqnk9dessP/UYcVz2n9SOs8aFASebxluQGr9FyA++PxCDkhOjsMjvtHyc6nmex5Ip502Hex0foZNmhieWuHSmoWYdNn83mIgGQXgwZAQRPgf7iTStXHa3nsErSiPWTxO8zIQZifXsY8otbm9Vr4iMKkPbJoyBKWMMW8FquD4A0Wb44y8xxPD/TckeBtloGITQD7YwD0mjtNXnqeCJTrg/dG1ocZkeoC9dS75g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u0usiYCP; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u0usiYCP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1bfS2HTzz2xgv
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Feb 2025 20:53:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10BE75C5D8E;
	Mon, 24 Feb 2025 09:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C1C4CED6;
	Mon, 24 Feb 2025 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740390829;
	bh=g6VMlunQlRDJng03dDx4fAmN66ot/J1KNDpnUBk3Uyk=;
	h=Date:From:To:Cc:Subject:From;
	b=u0usiYCPpGjJz7W/r+tTDedwSQMO7Lzj2OGrQ7vpI1I6Ni/J58p4fjs01N0vVrCAy
	 CupqoMmeyJpmyBT33Swem7HP4O4OA6qZfthw2HnsZgFr0H9T56aiYr5z8HSIvhJ3wo
	 ILS61Ps7NSn2v37GJTsxM5FAS2tS1WmZhYCJYPxRjxaqBATn6A3KKZsis22HoJbvBC
	 y5bUAgcJHr9xYjQfadxhzbrj9AfhEsQrt1QeJxY+PA7PsZYrl0y2GkNEOsO7eMJumX
	 eTDcPsCHnH8iIhJ75t4YE7EeEjvUZNPoyVSCrYXZ1Xo9lYedRKjQFhXI8schHBm7m7
	 B5W68rNG+/KDA==
Date: Mon, 24 Feb 2025 20:23:38 +1030
To: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/8][next] Avoid a couple hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1739957534.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: "Gustavo A. R. Silva via Linux-erofs" <linux-erofs@lists.ozlabs.org>
Reply-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, linux-hardening@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch series aims to fix a couple hundred -Wflex-array-member-not-at-end
warnings by creating a new tagged struct `struct bio_hdr` within flexible
structure `struct bio`.

This new tagged struct will be used to fix problematic declarations
of middle-flex-arrays in composite structs, like these[1][2][3], for
instance.

[1] https://git.kernel.org/linus/a7e8997ae18c42d3
[2] https://git.kernel.org/linus/c1ddb29709e675ea
[3] https://git.kernel.org/linus/57be3d3562ca4aa6

Gustavo A. R. Silva (8):
  block: blk_types.h: Use struct_group_tagged() in flex struct bio
  md/raid5-ppl: Avoid -Wflex-array-member-not-at-end warning
  xfs: Avoid -Wflex-array-member-not-at-end warnings
  erofs: Avoid -Wflex-array-member-not-at-end warnings
  btrfs: Avoid -Wflex-array-member-not-at-end warnings
  nvme: target: Avoid -Wflex-array-member-not-at-end warnings
  md/raid5: Avoid -Wflex-array-member-not-at-end warnings
  bcache: Avoid -Wflex-array-member-not-at-end warnings

 drivers/md/bcache/bcache.h     |  4 +-
 drivers/md/bcache/journal.c    | 10 ++--
 drivers/md/bcache/journal.h    |  4 +-
 drivers/md/bcache/super.c      |  8 ++--
 drivers/md/raid5-ppl.c         |  8 ++--
 drivers/md/raid5.c             | 10 ++--
 drivers/md/raid5.h             |  2 +-
 drivers/nvme/target/nvmet.h    |  4 +-
 drivers/nvme/target/passthru.c |  2 +-
 drivers/nvme/target/zns.c      |  2 +-
 fs/btrfs/disk-io.c             |  4 +-
 fs/btrfs/volumes.h             |  2 +-
 fs/erofs/fileio.c              | 25 ++++++----
 fs/erofs/fscache.c             | 13 +++---
 fs/xfs/xfs_log.c               | 15 +++---
 fs/xfs/xfs_log_priv.h          |  2 +-
 include/linux/blk_types.h      | 84 ++++++++++++++++++----------------
 17 files changed, 107 insertions(+), 92 deletions(-)

-- 
2.43.0

