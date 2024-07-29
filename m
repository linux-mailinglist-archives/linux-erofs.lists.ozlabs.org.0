Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23293FA75
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 18:20:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOpjleMg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOpjleMg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXk9c2TsKz3cds
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 02:20:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOpjleMg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOpjleMg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXk9X1bPzz3cW3
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 02:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DvXomQdGvyRIG4lEnvJDoKu3S4z81D4SNbDuP6bJxR8=;
	b=fOpjleMgs4B19aD9Dm0LfYejSocTPWS2WC+Ubw+3QxjwDsaN1GkvBT2ogEps1OMZkijIhR
	PykWtcdoRtlZdOBLrSXi5un73SyklmJVtxRQ9RF9UgFgpts0OcgT4bto9/Qs2ql5JM+J7G
	oVmy7LLYE3uvmK6I+CE0KCSgPg3XdLc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DvXomQdGvyRIG4lEnvJDoKu3S4z81D4SNbDuP6bJxR8=;
	b=fOpjleMgs4B19aD9Dm0LfYejSocTPWS2WC+Ubw+3QxjwDsaN1GkvBT2ogEps1OMZkijIhR
	PykWtcdoRtlZdOBLrSXi5un73SyklmJVtxRQ9RF9UgFgpts0OcgT4bto9/Qs2ql5JM+J7G
	oVmy7LLYE3uvmK6I+CE0KCSgPg3XdLc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-GK5lTh9JNCCiXxwe-IyT3A-1; Mon,
 29 Jul 2024 12:20:21 -0400
X-MC-Unique: GK5lTh9JNCCiXxwe-IyT3A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E49D1955F42;
	Mon, 29 Jul 2024 16:20:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D295119560AE;
	Mon, 29 Jul 2024 16:20:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 00/24] netfs: Read/write improvements
Date: Mon, 29 Jul 2024 17:19:29 +0100
Message-ID: <20240729162002.3436763-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian, Steve, Willy,

This set of patches includes one fscache fix and one cachefiles fix

 (1) Fix a cookie access race in fscache.

 (2) Fix the setxattr/removexattr syscalls to pull their arguments into
     kernel space before taking the sb_writers lock to avoid a deadlock
     against mm->mmap_lock.

A couple of adjustments to the /proc/fs/netfs/stats file:

 (3) All the netfs stats lines begin 'Netfs:'.  Change this to something a
     bit more useful.

 (4) Add a couple of stats counters to track the numbers of skips and waits
     on the per-inode writeback serialisation lock to make it easier to
     check for this as a source of performance loss.

Some miscellaneous bits:

 (5) Reduce the number of conditional branches in netfs_perform_write().

 (6) Move the CIFS_INO_MODIFIED_ATTR flag to the netfs_inode struct and
     remove cifs_post_modify().

 (7) Move the max_len/max_nr_segs members from netfs_io_subrequest to
     netfs_io_request as they're only needed for one subreq at a time.

 (8) Add an 'unknown' source value for tracing purposes.

 (9) Remove NETFS_COPY_TO_CACHE as it's no longer used.

(10) Set the request work function up front at allocation time.

(11) Use bh-disabling spinlocks for rreq->lock as cachefiles completion may
     be run from block-filesystem DIO completion in softirq context.

Then there's the main performance enhancing changes:

(12) Define a structure, struct folio_queue, and a new iterator type,
     ITER_FOLIOQ, to hold a buffer as a replacement for ITER_XARRAY.  See
     that patch for questions about naming and form.

(13) Make cifs RDMA support ITER_FOLIOQ.

(14) Add a function to reset the iterator in a subrequest.

(15) Use folio queues in the write-side helpers instead of xarrays.

(16) Simplify the write-side helpers to use sheaves to skip gaps rather than
     trying to work out where gaps are.

(17) In afs, make the read subrequests asynchronous, putting them into work
     items to allow the next patch to do progressive unlocking/reading.

(18) Overhaul the read-side helpers to improve performance.

(19) Remove fs/netfs/io.c.

(20) Fix the caching of a partial block at the end of a file.

(21) Allow a store to be cancelled.

Then some changes for cifs to make it use folio queues instead of xarrays
for crypto bufferage:

(22) Use raw iteration functions rather than manually coding iteration when
     hashing data.

(23) Switch to using folio_queue for crypto buffers.

(24) Remove the xarray bits.

David

David Howells (23):
  cachefiles: Fix non-taking of sb_writers around set/removexattr
  netfs: Adjust labels in /proc/fs/netfs/stats
  netfs: Record contention stats for writeback lock
  netfs: Reduce number of conditional branches in netfs_perform_write()
  netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
  netfs: Move max_len/max_nr_segs from netfs_io_subrequest to
    netfs_io_stream
  netfs: Reserve netfs_sreq_source 0 as unset/unknown
  netfs: Remove NETFS_COPY_TO_CACHE
  netfs: Set the request work function upon allocation
  netfs: Use bh-disabling spinlocks for rreq->lock
  mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of
    folios
  cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
  netfs: Use new folio_queue data type and iterator instead of xarray
    iter
  netfs: Provide an iterator-reset function
  netfs: Simplify the writeback code
  afs: Make read subreqs async
  netfs: Speed up buffered reading
  netfs: Remove fs/netfs/io.c
  cachefiles, netfs: Fix write to partial block at EOF
  netfs: Cancel dirty folios that have no storage destination
  cifs: Use iterate_and_advance*() routines directly for hashing
  cifs: Switch crypto buffer to use a folio_queue rather than an xarray
  cifs: Don't support ITER_XARRAY

Max Kellermann (1):
  fs/netfs/fscache_cookie: add missing "n_accesses" check

 fs/9p/vfs_addr.c             |   5 +-
 fs/afs/file.c                |  29 +-
 fs/afs/fsclient.c            |   9 +-
 fs/afs/write.c               |   4 +-
 fs/afs/yfsclient.c           |   9 +-
 fs/cachefiles/io.c           |  19 +-
 fs/cachefiles/xattr.c        |  34 +-
 fs/ceph/addr.c               |  72 ++--
 fs/netfs/Makefile            |   3 +-
 fs/netfs/buffered_read.c     | 677 ++++++++++++++++++++++++-----------
 fs/netfs/buffered_write.c    | 309 ++++++++--------
 fs/netfs/direct_read.c       | 147 +++++++-
 fs/netfs/fscache_cookie.c    |   4 +
 fs/netfs/internal.h          |  33 +-
 fs/netfs/io.c                | 647 ---------------------------------
 fs/netfs/iterator.c          |  50 +++
 fs/netfs/main.c              |   6 +-
 fs/netfs/misc.c              |  94 +++++
 fs/netfs/objects.c           |  16 +-
 fs/netfs/read_collect.c      | 540 ++++++++++++++++++++++++++++
 fs/netfs/read_retry.c        | 256 +++++++++++++
 fs/netfs/stats.c             |  23 +-
 fs/netfs/write_collect.c     | 243 ++++---------
 fs/netfs/write_issue.c       |  92 ++---
 fs/nfs/fscache.c             |  19 +-
 fs/nfs/fscache.h             |   7 +-
 fs/smb/client/cifsencrypt.c  | 144 +-------
 fs/smb/client/cifsglob.h     |   3 +-
 fs/smb/client/cifssmb.c      |   6 +-
 fs/smb/client/file.c         |  71 ++--
 fs/smb/client/smb2ops.c      | 218 ++++++-----
 fs/smb/client/smb2pdu.c      |  10 +-
 fs/smb/client/smbdirect.c    |  82 +++--
 include/linux/folio_queue.h  | 138 +++++++
 include/linux/iov_iter.h     | 104 ++++++
 include/linux/netfs.h        |  44 ++-
 include/linux/uio.h          |  18 +
 include/trace/events/netfs.h | 140 ++++++--
 lib/iov_iter.c               | 229 +++++++++++-
 lib/kunit_iov_iter.c         | 259 ++++++++++++++
 lib/scatterlist.c            |  69 +++-
 41 files changed, 3175 insertions(+), 1707 deletions(-)
 delete mode 100644 fs/netfs/io.c
 create mode 100644 fs/netfs/read_collect.c
 create mode 100644 fs/netfs/read_retry.c
 create mode 100644 include/linux/folio_queue.h

