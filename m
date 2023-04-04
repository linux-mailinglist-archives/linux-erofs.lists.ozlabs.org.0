Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 979796D690F
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:39:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrYQD3RXzz3cdn
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 02:39:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tJNnG55g;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tJNnG55g;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrYQ95Q0tz3bVc
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 02:39:45 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D95FA635E2;
	Tue,  4 Apr 2023 16:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF72C433EF;
	Tue,  4 Apr 2023 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680626383;
	bh=OE3ZhwpdXPaUqbe2ZMl6jqgbpE3w1OI7ZuqJWZhJ9Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJNnG55gT+GKx8EnOOA6ED0jlulGw+gVV0uR2fvkQGmBLoTW8kHPNJOMV7FBxSufn
	 dQ6/dxTCxv0WdL24xSib3p+lvOBS/TDA4kXAnGYIzlxe2k7rkZGU5uelrlH/1TuWPs
	 yEXk1dgkFPFmYWePJES61x+0w3pEDZOEPB3thyFUZtzF0nlmVDQa7+ghsComnWSias
	 LI3aYMXUxu2hok4/tjUi0aFNwpi2/WfUjsE3vfGiYEw+bpKXq/yy9T+U44wDrXCe6x
	 Fj6GXpUyixej+22neU4W2/gEdnaOnDLAV3CUAF1uwIu3tRUa+fdqn3Z9sMBM5sHqfD
	 BxUbxmwwlxfNw==
Date: Tue, 4 Apr 2023 09:39:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230404163942.GD109974@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> Hi all,
> 
> This is V2 of fs-verity support in XFS. In this series I did
> numerous changes from V1 which are described below.
> 
> This patchset introduces fs-verity [5] support for XFS. This
> implementation utilizes extended attributes to store fs-verity
> metadata. The Merkle tree blocks are stored in the remote extended
> attributes.
> 
> A few key points:
> - fs-verity metadata is stored in extended attributes
> - Direct path and DAX are disabled for inodes with fs-verity
> - Pages are verified in iomap's read IO path (offloaded to
>   workqueue)
> - New workqueue for verification processing
> - New ro-compat flag
> - Inodes with fs-verity have new on-disk diflag
> - xfs_attr_get() can return buffer with the attribute
> 
> The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> 
> Patches [6/23] and [7/23] touch ext4, f2fs, btrfs, and patch [8/23]
> touches erofs, gfs2, and zonefs.
> 
> The patchset consist of four parts:
> - [1..4]: Patches from Parent Pointer patchset which add binary
>           xattr names with a few deps
> - [5..7]: Improvements to core fs-verity
> - [8..9]: Add read path verification to iomap
> - [10..23]: Integration of fs-verity to xfs
> 
> Changes from V1:
> - Added parent pointer patches for easier testing
> - Many issues and refactoring points fixed from the V1 review
> - Adjusted for recent changes in fs-verity core (folios, non-4k)
> - Dropped disabling of large folios
> - Completely new fsverity patches (fix, callout, log_blocksize)
> - Change approach to verification in iomap to the same one as in
>   write path. Callouts to fs instead of direct fs-verity use.
> - New XFS workqueue for post read folio verification
> - xfs_attr_get() can return underlying xfs_buf
> - xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
>   blocks
> 
> kernel:
> [1]: https://github.com/alberand/linux/tree/xfs-verity-v2
> 
> xfsprogs:
> [2]: https://github.com/alberand/xfsprogs/tree/fsverity-v2

Will there any means for xfs_repair to check the merkle tree contents?
Should it clear the ondisk inode flag if it decides to trash the xattr
structure, or is it ok to let the kernel deal with flag set and no
verity data?

--D

> xfstests:
> [3]: https://github.com/alberand/xfstests/tree/fsverity-v2
> 
> v1:
> [4]: https://lore.kernel.org/linux-xfs/20221213172935.680971-1-aalbersh@redhat.com/
> 
> fs-verity:
> [5]: https://www.kernel.org/doc/html/latest/filesystems/fsverity.html
> 
> Thanks,
> Andrey
> 
> Allison Henderson (4):
>   xfs: Add new name to attri/d
>   xfs: add parent pointer support to attribute code
>   xfs: define parent pointer xattr format
>   xfs: Add xfs_verify_pptr
> 
> Andrey Albershteyn (19):
>   fsverity: make fsverity_verify_folio() accept folio's offset and size
>   fsverity: add drop_page() callout
>   fsverity: pass Merkle tree block size to ->read_merkle_tree_page()
>   iomap: hoist iomap_readpage_ctx from the iomap_readahead/_folio
>   iomap: allow filesystem to implement read path verification
>   xfs: add XBF_VERITY_CHECKED xfs_buf flag
>   xfs: add XFS_DA_OP_BUFFER to make xfs_attr_get() return buffer
>   xfs: introduce workqueue for post read IO work
>   xfs: add iomap's readpage operations
>   xfs: add attribute type for fs-verity
>   xfs: add fs-verity ro-compat flag
>   xfs: add inode on-disk VERITY flag
>   xfs: initialize fs-verity on file open and cleanup on inode
>     destruction
>   xfs: don't allow to enable DAX on fs-verity sealsed inode
>   xfs: disable direct read path for fs-verity sealed files
>   xfs: add fs-verity support
>   xfs: handle merkle tree block size != fs blocksize != PAGE_SIZE
>   xfs: add fs-verity ioctls
>   xfs: enable ro-compat fs-verity flag
> 
>  fs/btrfs/verity.c               |  15 +-
>  fs/erofs/data.c                 |  12 +-
>  fs/ext4/verity.c                |   9 +-
>  fs/f2fs/verity.c                |   9 +-
>  fs/gfs2/aops.c                  |  10 +-
>  fs/ioctl.c                      |   4 +
>  fs/iomap/buffered-io.c          |  89 ++++++-----
>  fs/verity/read_metadata.c       |   7 +-
>  fs/verity/verify.c              |   9 +-
>  fs/xfs/Makefile                 |   1 +
>  fs/xfs/libxfs/xfs_attr.c        |  81 +++++++++-
>  fs/xfs/libxfs/xfs_attr.h        |   7 +-
>  fs/xfs/libxfs/xfs_attr_leaf.c   |   7 +
>  fs/xfs/libxfs/xfs_attr_remote.c |  13 +-
>  fs/xfs/libxfs/xfs_da_btree.h    |   7 +-
>  fs/xfs/libxfs/xfs_da_format.h   |  46 +++++-
>  fs/xfs/libxfs/xfs_format.h      |  14 +-
>  fs/xfs/libxfs/xfs_log_format.h  |   8 +-
>  fs/xfs/libxfs/xfs_sb.c          |   2 +
>  fs/xfs/scrub/attr.c             |   4 +-
>  fs/xfs/xfs_aops.c               |  61 +++++++-
>  fs/xfs/xfs_attr_item.c          | 142 +++++++++++++++---
>  fs/xfs/xfs_attr_item.h          |   1 +
>  fs/xfs/xfs_attr_list.c          |  17 ++-
>  fs/xfs/xfs_buf.h                |  17 ++-
>  fs/xfs/xfs_file.c               |  22 ++-
>  fs/xfs/xfs_inode.c              |   2 +
>  fs/xfs/xfs_inode.h              |   3 +-
>  fs/xfs/xfs_ioctl.c              |  22 +++
>  fs/xfs/xfs_iomap.c              |  14 ++
>  fs/xfs/xfs_iops.c               |   4 +
>  fs/xfs/xfs_linux.h              |   1 +
>  fs/xfs/xfs_mount.h              |   3 +
>  fs/xfs/xfs_ondisk.h             |   4 +
>  fs/xfs/xfs_super.c              |  19 +++
>  fs/xfs/xfs_trace.h              |   1 +
>  fs/xfs/xfs_verity.c             | 256 ++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_verity.h             |  27 ++++
>  fs/xfs/xfs_xattr.c              |   9 ++
>  fs/zonefs/file.c                |  12 +-
>  include/linux/fsverity.h        |  18 ++-
>  include/linux/iomap.h           |  39 ++++-
>  include/uapi/linux/fs.h         |   1 +
>  43 files changed, 923 insertions(+), 126 deletions(-)
>  create mode 100644 fs/xfs/xfs_verity.c
>  create mode 100644 fs/xfs/xfs_verity.h
> 
> -- 
> 2.38.4
> 
