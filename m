Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E698B77C8
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:01:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KZAddHjR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KZAddHjR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMLP1685z3cSC
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:01:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KZAddHjR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KZAddHjR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMLK3TJBz3cLl
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:01:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K3Irydl6Xh7jL+cMJWxpcSfsWrNZFzC5/LPeqTp0XrU=;
	b=KZAddHjRG780fcaBzs1RBCGNA+ZahF40ltRDDLkt/ta5lOGGXBexN9eH2lJV4h2mHrHOqd
	ipXrLcqSoV5wrhxjjbTK3FW7j0AYYASnkR6lUMTr9IxPT1jx1g0SAYCwSu26zAGvexw7vf
	HUy+QlDeX+xxWdkYbiCmvIyp89Ub/HY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K3Irydl6Xh7jL+cMJWxpcSfsWrNZFzC5/LPeqTp0XrU=;
	b=KZAddHjRG780fcaBzs1RBCGNA+ZahF40ltRDDLkt/ta5lOGGXBexN9eH2lJV4h2mHrHOqd
	ipXrLcqSoV5wrhxjjbTK3FW7j0AYYASnkR6lUMTr9IxPT1jx1g0SAYCwSu26zAGvexw7vf
	HUy+QlDeX+xxWdkYbiCmvIyp89Ub/HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-lzol3MtxNXm8_iyxwxlWwA-1; Tue, 30 Apr 2024 10:01:04 -0400
X-MC-Unique: lzol3MtxNXm8_iyxwxlWwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD4D8802352;
	Tue, 30 Apr 2024 14:01:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D94C40C140B;
	Tue, 30 Apr 2024 14:00:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 00/22] netfs, afs, 9p, cifs: Rework netfs to use ->writepages() to copy to cache
Date: Tue, 30 Apr 2024 15:00:31 +0100
Message-ID: <20240430140056.261997-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Willy,

Here's an updated version of my netfs writeback rewrite.  There haven't
been any major fixes.  So far...

The primary purpose of these patches is to rework the netfslib writeback
implementation such that pages read from the cache are written to the cache
through ->writepages(), thereby allowing the fscache page flag to be
retired.

The reworking also:

 (1) builds on top of the new writeback_iter() infrastructure;

 (2) makes it possible to use vectored write RPCs as discontiguous streams
     of pages can be accommodated;

 (3) makes it easier to do simultaneous content crypto and stream division.

 (4) provides support for retrying writes and re-dividing a stream;

 (5) replaces the ->launder_folio() op, so that ->writepages() is used
     instead;

 (6) uses mempools to allocate the netfs_io_request and netfs_io_subrequest
     structs to avoid allocation failure in the writeback path.

Some code that uses the fscache page flag is retained for compatibility
purposes with nfs and ceph.  The code is switched to using the synonymous
private_2 label instead and marked with deprecation comments.  I have a
separate set of patches that convert cifs to use this code.

-~-

In this new implementation, writeback_iter() is used to pump folios,
progressively creating two parallel, but separate streams.  Either or both
streams can contain gaps, and the subrequests in each stream can be of
variable size, don't need to align with each other and don't need to align
with the folios.  (Note that more streams can be added if we have multiple
servers to duplicate data to).

Indeed, subrequests can cross folio boundaries, may cover several folios or
a folio may be spanned by multiple subrequests, e.g.:

         +---+---+-----+-----+---+----------+
Folios:  |   |   |     |     |   |          |
         +---+---+-----+-----+---+----------+

           +------+------+     +----+----+
Upload:    |      |      |.....|    |    |
           +------+------+     +----+----+

         +------+------+------+------+------+
Cache:   |      |      |      |      |      |
         +------+------+------+------+------+

Data that got read from the server that needs copying to the cache is
stored in folios that are marked dirty and have folio->private set to a
special value.

The progressive subrequest construction permits the algorithm to be
preparing both the next upload to the server and the next write to the
cache whilst the previous ones are already in progress.  Throttling can be
applied to control the rate of production of subrequests - and, in any
case, we probably want to write them to the server in ascending order,
particularly if the file will be extended.

Content crypto can also be prepared at the same time as the subrequests and
run asynchronously, with the prepped requests being stalled until the
crypto catches up with them.  This might also be useful for transport
crypto, but that happens at a lower layer, so probably would be harder to
pull off.

The algorithm is split into three parts:

 (1) The issuer.  This walks through the data, packaging it up, encrypting
     it and creating subrequests.  The part of this that generates
     subrequests only deals with file positions and spans and so is usable
     for DIO/unbuffered writes as well as buffered writes.

 (2) The collector.  This asynchronously collects completed subrequests,
     unlocks folios, frees crypto buffers and performs any retries.  This
     runs in a work queue so that the issuer can return to the caller for
     writeback (so that the VM can have its kswapd thread back) or async
     writes.

     Collection is slightly complex as the collector has to work out where
     discontiguities happen in the folio list so that it doesn't try and
     collect folios that weren't included in the write out.

 (3) The retryer.  This pauses the issuer, waits for all outstanding
     subrequests to complete and then goes through the failed subrequests
     to reissue them.  This may involve reprepping them (with cifs, the
     credits must be renegotiated and a subrequest may need splitting), and
     doing RMW for content crypto if there's a conflicting change on the
     server.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-writeback

David

Link: https://lore.kernel.org/r/20240328163424.2781320-1-dhowells@redhat.com/ # v1

Changes
=======
ver #2)
 - Rebase on v6.9-rc6 to accommodate some fixes that went upstream.
 - Make netfs_begin_writethrough() actually return an error.
 - Move the cifs invalidation patch to the cifs-netfs branch.
 - Mark writeback_iter() EXPORT_SYMBOL_GPL.
 - In p9_client_write_subreq(), use 'int len' rather than 'size_t len'
   because of the varargs packet formatter.
 - In netfs_perform_write(), don't wait for writeback if we don't need to.
 - Don't do the AFS StoreData RPC inline, but keep doing it from a
   workqueue.
 - Remove a couple of redundant checks where the second used to be inside
   a lock.
 - Add missing linux/bio.h for BIO_MAX_VECS in cachefiles.
 - Change a comma ending a statement to a semicolon.
 - Make filemap_invalidate_inode() take a range.
 - Make netfs_unbuffered_write_iter() use filemap_invalidate_inode().

David Howells (22):
  netfs: Update i_blocks when write committed to pagecache
  netfs: Replace PG_fscache by setting folio->private and marking dirty
  mm: Remove the PG_fscache alias for PG_private_2
  netfs: Remove deprecated use of PG_private_2 as a second writeback
    flag
  netfs: Make netfs_io_request::subreq_counter an atomic_t
  netfs: Use subreq_counter to allocate subreq debug_index values
  mm: Provide a means of invalidation without using launder_folio
  9p: Use alternative invalidation to using launder_folio
  afs: Use alternative invalidation to using launder_folio
  netfs: Remove ->launder_folio() support
  netfs: Use mempools for allocating requests and subrequests
  mm: Export writeback_iter()
  netfs: Switch to using unsigned long long rather than loff_t
  netfs: New writeback implementation
  netfs: Add some write-side stats and clean up some stat names
  netfs, afs: Implement helpers for new write code
  netfs, 9p: Implement helpers for new write code
  netfs, cachefiles: Implement helpers for new write code
  netfs: Cut over to using new writeback code
  netfs: Remove the old writeback code
  netfs: Miscellaneous tidy ups
  netfs, afs: Use writeback retry to deal with alternate keys

 fs/9p/vfs_addr.c             |  60 +--
 fs/afs/file.c                |   8 +-
 fs/afs/internal.h            |   6 +-
 fs/afs/validation.c          |   4 +-
 fs/afs/write.c               | 189 ++++----
 fs/cachefiles/io.c           |  76 +++-
 fs/ceph/addr.c               |  24 +-
 fs/ceph/inode.c              |   2 +
 fs/netfs/Makefile            |   3 +-
 fs/netfs/buffered_read.c     |  40 +-
 fs/netfs/buffered_write.c    | 825 +++--------------------------------
 fs/netfs/direct_write.c      |  56 ++-
 fs/netfs/fscache_io.c        |  14 +-
 fs/netfs/internal.h          |  55 ++-
 fs/netfs/io.c                | 155 +------
 fs/netfs/main.c              |  55 ++-
 fs/netfs/misc.c              |  10 +-
 fs/netfs/objects.c           |  81 +++-
 fs/netfs/output.c            | 478 --------------------
 fs/netfs/stats.c             |  17 +-
 fs/netfs/write_collect.c     | 808 ++++++++++++++++++++++++++++++++++
 fs/netfs/write_issue.c       | 675 ++++++++++++++++++++++++++++
 fs/nfs/file.c                |   8 +-
 fs/nfs/fscache.h             |   6 +-
 fs/nfs/write.c               |   4 +-
 fs/smb/client/file.c         |  16 +-
 include/linux/fscache.h      |  22 +-
 include/linux/netfs.h        | 196 +++++----
 include/linux/pagemap.h      |   2 +
 include/net/9p/client.h      |   2 +
 include/trace/events/netfs.h | 249 ++++++++++-
 mm/filemap.c                 |  60 ++-
 mm/page-writeback.c          |   1 +
 net/9p/Kconfig               |   1 +
 net/9p/client.c              |  49 +++
 35 files changed, 2502 insertions(+), 1755 deletions(-)
 delete mode 100644 fs/netfs/output.c
 create mode 100644 fs/netfs/write_collect.c
 create mode 100644 fs/netfs/write_issue.c

