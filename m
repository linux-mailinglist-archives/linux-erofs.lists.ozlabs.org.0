Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF9793AB50
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 04:42:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hIL7ROVi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WTJGC1x4Wz3cgk
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 12:42:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hIL7ROVi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WTJG125WRz30WC
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2024 12:42:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JiDuGWepnTN0n5fOJFOEWm8213iD+rPD3GF635ET/sc=; b=hIL7ROVi5AnmZcVmdQRUZmuHtq
	YVU8jb+yGoZVKxE+oZcvlwLZqzcO2LBCBjaXWj3l/PXXXn5YqZkdMXasU923zdj/Nb1haFF4usofX
	ZIPG60eC1sFCmXiBHxjuFVulX/jkJWbQaN+727yqLDIrYgB9G3UgdpRARzPXRPiMoA+PgrAuj/q9v
	pZQcvppPlZb5ILdzXJQxFvTfv+Ke+8wXW3ejlylZyy+vECisfyUKFUeVywb8FjmiFR4LvHnfMLIs+
	Dhf4UVXUGlNnIFFqPlCryS2PxCkKFCzDBwENRrxQuYH7Ck8fQ1nw48NOlu3rDHOtEtwmwEX/P4q7g
	7uhve9mA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWRxM-00000007R8m-00FS;
	Wed, 24 Jul 2024 02:42:20 +0000
Date: Wed, 24 Jul 2024 03:42:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqBqCwuUtD1guNsC@casper.infradead.org>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
 <ZqBaQS7IUTsU3ePs@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqBaQS7IUTsU3ePs@dread.disaster.area>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 24, 2024 at 11:34:57AM +1000, Dave Chinner wrote:
> This is to prevent the deadlocks on upper->lower->upper and
> lower->upper->lower filesystem recursion via GFP_KERNEL memory
> allocation and reclaim recursing between the two filesystems. This
> is especially relevant for filesystems with ->writepage methods that
> can be called from direct reclaim. Hence allocations in this path
> need to be at least NOFS to prevent recursion back into the upper
> filesystem from writeback into the lower filesystem.

FYI, we're making good progress on removing ->writepage.

$ git grep '\.writepage\>.*='
fs/ceph/addr.c: .writepage = ceph_writepage,
fs/ecryptfs/mmap.c:     .writepage = ecryptfs_writepage,
fs/f2fs/checkpoint.c:   .writepage      = f2fs_write_meta_page,
fs/f2fs/data.c: .writepage      = f2fs_write_data_page,
fs/f2fs/node.c: .writepage      = f2fs_write_node_page,
fs/gfs2/aops.c: .writepage = gfs2_jdata_writepage,
fs/gfs2/meta_io.c:      .writepage = gfs2_aspace_writepage,
fs/gfs2/meta_io.c:      .writepage = gfs2_aspace_writepage,
fs/hostfs/hostfs_kern.c:        .writepage      = hostfs_writepage,
fs/nilfs2/inode.c:      .writepage              = nilfs_writepage,
fs/nilfs2/mdt.c:        .writepage              = nilfs_mdt_write_page,
fs/orangefs/inode.c:    .writepage = orangefs_writepage,
fs/vboxsf/file.c:       .writepage = vboxsf_writepage,
mm/shmem.c:     .writepage      = shmem_writepage,
mm/swap_state.c:        .writepage      = swap_writepage,

so mostly just the usual stragglers.  I sent a series to fix up gfs2
earlier this week:
https://lore.kernel.org/linux-fsdevel/20240719175105.788253-1-willy@infradead.org/
