Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A066D65E1
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:54:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW5B6JdVz3ccr
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jEl8gdgx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jEl8gdgx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jEl8gdgx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jEl8gdgx;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW525b9Yz3cBX
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:54:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD3C5F3LGtukmBxzahEExE7hRIVYDTE1CCzX3qZAvIY=;
	b=jEl8gdgxbntUy+UZO+dtMGSkwNQQDW81AcIjmamB4S6uVNVBy5s4LCHIehFr5PMlUBELvN
	TvtELr/mn7e7tpvLKebpe+yarwNrzcj2zhsLEegMT86MypqPLA58M9VnYDbKOGr0RO2CWc
	U0XVEVqG/F2qis9J1wDA01RuoDRjkO0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD3C5F3LGtukmBxzahEExE7hRIVYDTE1CCzX3qZAvIY=;
	b=jEl8gdgxbntUy+UZO+dtMGSkwNQQDW81AcIjmamB4S6uVNVBy5s4LCHIehFr5PMlUBELvN
	TvtELr/mn7e7tpvLKebpe+yarwNrzcj2zhsLEegMT86MypqPLA58M9VnYDbKOGr0RO2CWc
	U0XVEVqG/F2qis9J1wDA01RuoDRjkO0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-3vIqOQBwMmuUijDX3eN3uQ-1; Tue, 04 Apr 2023 10:54:41 -0400
X-MC-Unique: 3vIqOQBwMmuUijDX3eN3uQ-1
Received: by mail-qk1-f197.google.com with SMTP id 72-20020a37044b000000b0074694114c09so14710988qke.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD3C5F3LGtukmBxzahEExE7hRIVYDTE1CCzX3qZAvIY=;
        b=Kjxqx784IZNVf/y91Ic07dCb++UoqR2xkc1E7FKFFbG+etRGIUXGsmvUoPWjNZ6Oz1
         xqg21fc8CVzlKPjJuSiZjypFD2fYgvM1S5dT3WhjNHKNKTJhGGjnc9OSE5ctU6NaJrdQ
         363ne0unrOCU5RXOv6RUae2m+qVbU/Gfd5nm6TIAdKnsHo6XlCJ+f0q7wWfbs3elTJn/
         LnRF6jlnztviMMmnZ29skul+/AWt/eySf52sz5XkHIL5tp+Wu5CgHqQg2itBthMxvb9x
         s0+pz8zJyrT0kAuJmMpDE+zXB+gveoEbTlk+tfeJczULVFtS+jQVuRe4CBoGiP0wyCSd
         R2zg==
X-Gm-Message-State: AAQBX9ePyQsfIgREsIA4T7eCS2lJ4WeXykQxdVC6Ve3mWsul/wZgxrFl
	/2NlFE8UwVPVMhbLJFWAnKbtqK41DeFmXxxwvJH4JOzLht+CKDPmtBtNUHgen4Qe4h7/ortcOxw
	AtJJ7WbWP8GRhj6V3lO05NVk=
X-Received: by 2002:a05:622a:183:b0:3e4:9f9a:54b2 with SMTP id s3-20020a05622a018300b003e49f9a54b2mr3125025qtw.65.1680620080397;
        Tue, 04 Apr 2023 07:54:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350aQaTUsx1W6QCtRYW4E/BPPbSUPOo7MRSxPdoArP74ywpcoKBragJvpDtJCE5UocjgeAZeoJA==
X-Received: by 2002:a05:622a:183:b0:3e4:9f9a:54b2 with SMTP id s3-20020a05622a018300b003e49f9a54b2mr3124990qtw.65.1680620080023;
        Tue, 04 Apr 2023 07:54:40 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:54:39 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 00/23] fs-verity support for XFS
Date: Tue,  4 Apr 2023 16:52:56 +0200
Message-Id: <20230404145319.2057051-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

This is V2 of fs-verity support in XFS. In this series I did
numerous changes from V1 which are described below.

This patchset introduces fs-verity [5] support for XFS. This
implementation utilizes extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes.

A few key points:
- fs-verity metadata is stored in extended attributes
- Direct path and DAX are disabled for inodes with fs-verity
- Pages are verified in iomap's read IO path (offloaded to
  workqueue)
- New workqueue for verification processing
- New ro-compat flag
- Inodes with fs-verity have new on-disk diflag
- xfs_attr_get() can return buffer with the attribute

The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.

Patches [6/23] and [7/23] touch ext4, f2fs, btrfs, and patch [8/23]
touches erofs, gfs2, and zonefs.

The patchset consist of four parts:
- [1..4]: Patches from Parent Pointer patchset which add binary
          xattr names with a few deps
- [5..7]: Improvements to core fs-verity
- [8..9]: Add read path verification to iomap
- [10..23]: Integration of fs-verity to xfs

Changes from V1:
- Added parent pointer patches for easier testing
- Many issues and refactoring points fixed from the V1 review
- Adjusted for recent changes in fs-verity core (folios, non-4k)
- Dropped disabling of large folios
- Completely new fsverity patches (fix, callout, log_blocksize)
- Change approach to verification in iomap to the same one as in
  write path. Callouts to fs instead of direct fs-verity use.
- New XFS workqueue for post read folio verification
- xfs_attr_get() can return underlying xfs_buf
- xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
  blocks

kernel:
[1]: https://github.com/alberand/linux/tree/xfs-verity-v2

xfsprogs:
[2]: https://github.com/alberand/xfsprogs/tree/fsverity-v2

xfstests:
[3]: https://github.com/alberand/xfstests/tree/fsverity-v2

v1:
[4]: https://lore.kernel.org/linux-xfs/20221213172935.680971-1-aalbersh@redhat.com/

fs-verity:
[5]: https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

Thanks,
Andrey

Allison Henderson (4):
  xfs: Add new name to attri/d
  xfs: add parent pointer support to attribute code
  xfs: define parent pointer xattr format
  xfs: Add xfs_verify_pptr

Andrey Albershteyn (19):
  fsverity: make fsverity_verify_folio() accept folio's offset and size
  fsverity: add drop_page() callout
  fsverity: pass Merkle tree block size to ->read_merkle_tree_page()
  iomap: hoist iomap_readpage_ctx from the iomap_readahead/_folio
  iomap: allow filesystem to implement read path verification
  xfs: add XBF_VERITY_CHECKED xfs_buf flag
  xfs: add XFS_DA_OP_BUFFER to make xfs_attr_get() return buffer
  xfs: introduce workqueue for post read IO work
  xfs: add iomap's readpage operations
  xfs: add attribute type for fs-verity
  xfs: add fs-verity ro-compat flag
  xfs: add inode on-disk VERITY flag
  xfs: initialize fs-verity on file open and cleanup on inode
    destruction
  xfs: don't allow to enable DAX on fs-verity sealsed inode
  xfs: disable direct read path for fs-verity sealed files
  xfs: add fs-verity support
  xfs: handle merkle tree block size != fs blocksize != PAGE_SIZE
  xfs: add fs-verity ioctls
  xfs: enable ro-compat fs-verity flag

 fs/btrfs/verity.c               |  15 +-
 fs/erofs/data.c                 |  12 +-
 fs/ext4/verity.c                |   9 +-
 fs/f2fs/verity.c                |   9 +-
 fs/gfs2/aops.c                  |  10 +-
 fs/ioctl.c                      |   4 +
 fs/iomap/buffered-io.c          |  89 ++++++-----
 fs/verity/read_metadata.c       |   7 +-
 fs/verity/verify.c              |   9 +-
 fs/xfs/Makefile                 |   1 +
 fs/xfs/libxfs/xfs_attr.c        |  81 +++++++++-
 fs/xfs/libxfs/xfs_attr.h        |   7 +-
 fs/xfs/libxfs/xfs_attr_leaf.c   |   7 +
 fs/xfs/libxfs/xfs_attr_remote.c |  13 +-
 fs/xfs/libxfs/xfs_da_btree.h    |   7 +-
 fs/xfs/libxfs/xfs_da_format.h   |  46 +++++-
 fs/xfs/libxfs/xfs_format.h      |  14 +-
 fs/xfs/libxfs/xfs_log_format.h  |   8 +-
 fs/xfs/libxfs/xfs_sb.c          |   2 +
 fs/xfs/scrub/attr.c             |   4 +-
 fs/xfs/xfs_aops.c               |  61 +++++++-
 fs/xfs/xfs_attr_item.c          | 142 +++++++++++++++---
 fs/xfs/xfs_attr_item.h          |   1 +
 fs/xfs/xfs_attr_list.c          |  17 ++-
 fs/xfs/xfs_buf.h                |  17 ++-
 fs/xfs/xfs_file.c               |  22 ++-
 fs/xfs/xfs_inode.c              |   2 +
 fs/xfs/xfs_inode.h              |   3 +-
 fs/xfs/xfs_ioctl.c              |  22 +++
 fs/xfs/xfs_iomap.c              |  14 ++
 fs/xfs/xfs_iops.c               |   4 +
 fs/xfs/xfs_linux.h              |   1 +
 fs/xfs/xfs_mount.h              |   3 +
 fs/xfs/xfs_ondisk.h             |   4 +
 fs/xfs/xfs_super.c              |  19 +++
 fs/xfs/xfs_trace.h              |   1 +
 fs/xfs/xfs_verity.c             | 256 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h             |  27 ++++
 fs/xfs/xfs_xattr.c              |   9 ++
 fs/zonefs/file.c                |  12 +-
 include/linux/fsverity.h        |  18 ++-
 include/linux/iomap.h           |  39 ++++-
 include/uapi/linux/fs.h         |   1 +
 43 files changed, 923 insertions(+), 126 deletions(-)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

-- 
2.38.4

