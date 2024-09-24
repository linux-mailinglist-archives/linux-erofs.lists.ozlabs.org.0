Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E960984EDD
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 01:20:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCwp1401jz2yVM
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 09:20:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727220037;
	cv=none; b=Zg1wWxV36oLDSoStZwMwqyUvQ7i/xs3jY562J1PSP4FghPtuhAN3knfu8e11u3ZktdQeVrQXkcaUUcrGUpyRwpK5ZxAWq0Kw80pJILCtwPfmDfNslGL4lk46lP6CRtdjQSYdDiOg1rgr4tAGBEBFJb6MH/AIKgFVLMIsBvQCIQdkJJw3WHv1VKD+8ShyOkjrDxhS6OB8mjxK/GNMiwUQPumVG7cgxbCDjv2Tvl2dXfTiblPqKJgpBAC/PdR9SO7a4wSTn8gejrnUgFLZDvtV02ks3Ph/KxsO3prlZQgSVr926gM9nobzGmYAXAf7QzkhA0U3dKjrDl8MHrb73JTtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727220037; c=relaxed/relaxed;
	bh=1R6dWg97gMKWsJa7Y9eW/vCPbW+C/1rDhbmcsNTkNFo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=jhpEgNAtHE3X7b6hM5Yoa+a7YYwbHQEAc2XR87hjKZa3rlTCNEbHjyISSP5SiwT5QOQzlm01R2K5Gu/EIOjpCJ17zxl+wK2Ioa9f1XgDds1AvBkcJTOWjupG3IL1JsTY9//ViwePuEdBlXxUYhFRkgjL9OkIJwAGEEzclVftxVZNeZNFX6msSE3S9BaP0gzRWk+Icd8EpprKFsaH6k80t46oL6HDpxc9eMLoHsHftkQ1aFGkBv0GwHn51FSCTDQVujxPd5e+kh5BCEa8Hbcf2S9V0RHchSScnQiRr27VfT0x5a34v0vZUWLDI1hlldV+t9tQJkMWPpmxIBy8+UbyRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MijpAA0G; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MijpAA0G; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MijpAA0G;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MijpAA0G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCwnw5VrXz2xsK
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Sep 2024 09:20:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727220030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1R6dWg97gMKWsJa7Y9eW/vCPbW+C/1rDhbmcsNTkNFo=;
	b=MijpAA0GSpj6Meh9+0+1KnCCeKnzu9/a6yUcib5LIgN21trC1Y+OGkpiVKtxSLySpaDWXa
	9KRlaudejcNFXDPu5RuegWbfp21OmxAlfDn1pzX/lwr74L+nuRYu84jp/wsWE7tCM5266C
	0/yFaDmqpaJOv10aw5bCXTcK/V3dzIc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727220030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1R6dWg97gMKWsJa7Y9eW/vCPbW+C/1rDhbmcsNTkNFo=;
	b=MijpAA0GSpj6Meh9+0+1KnCCeKnzu9/a6yUcib5LIgN21trC1Y+OGkpiVKtxSLySpaDWXa
	9KRlaudejcNFXDPu5RuegWbfp21OmxAlfDn1pzX/lwr74L+nuRYu84jp/wsWE7tCM5266C
	0/yFaDmqpaJOv10aw5bCXTcK/V3dzIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-rilsnK3MOTSffUsOAE5KMg-1; Tue,
 24 Sep 2024 19:20:24 -0400
X-MC-Unique: rilsnK3MOTSffUsOAE5KMg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 756BA193E8C7;
	Tue, 24 Sep 2024 23:20:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFC4719560AA;
	Tue, 24 Sep 2024 23:20:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com>
To: Manu Bretelle <chantr4@gmail.com>, eddyz87@gmail.com
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1279815.1727220013.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Sep 2024 00:20:13 +0100
Message-ID: <1279816.1727220013@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Could you try the attached?  It may help, though this fixes a bug in the
write-side, not the read-side.

David
---
netfs: Fix write oops in generic/346 (9p) and maybe generic/074 (cifs)

In netfslib, a buffered writeback operation has a 'write queue' of folios
that are being written, held in a linear sequence of folio_queue structs.
The 'issuer' adds new folio_queues on the leading edge of the queue and
populates each one progressively; the 'collector' pops them off the
trailing edge and discards them and the folios they point to as they are
consumed.

The queue is required to always retain at least one folio_queue structure.
This allows the queue to be accessed without locking and with just a bit o=
f
barriering.

When a new subrequest is prepared, its ->io_iter iterator is pointed at th=
e
current end of the write queue and then the iterator is extended as more
data is added to the queue until the subrequest is committed.

Now, the problem is that the folio_queue at the leading edge of the write
queue when a subrequest is prepared might have been entirely consumed - bu=
t
not yet removed from the queue as it is the only remaining one and is
preventing the queue from collapsing.

So, what happens is that subreq->io_iter is pointed at the spent
folio_queue, then a new folio_queue is added, and, at that point, the
collector is at entirely at liberty to immediately delete the spent
folio_queue.

This leaves the subreq->io_iter pointing at a freed object.  If the system
is lucky, iterate_folioq() sees ->io_iter, sees the as-yet uncorrupted
freed object and advances to the next folio_queue in the queue.

In the case seen, however, the freed object gets recycled and put back ont=
o
the queue at the tail and filled to the end.  This confuses
iterate_folioq() and it tries to step ->next, which may be NULL - resultin=
g
in an oops.

Fix this by the following means:

 (1) When preparing a write subrequest, make sure there's a folio_queue
     struct with space in it at the leading edge of the queue.  A function
     to make space is split out of the function to append a folio so that
     it can be called for this purpose.

 (2) If the request struct iterator is pointing to a completely spent
     folio_queue when we make space, then advance the iterator to the newl=
y
     allocated folio_queue.  The subrequest's iterator will then be set
     from this.

Whilst we're at it, also split out the function to allocate a folio_queue,
initialise it and do the accounting.

The oops could be triggered using the generic/346 xfstest with a filesyste=
m
on9P over TCP with cache=3Dloose.  The oops looked something like:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 ...
 RIP: 0010:_copy_from_iter+0x2db/0x530
 ...
 Call Trace:
  <TASK>
 ...
  p9pdu_vwritef+0x3d8/0x5d0
  p9_client_prepare_req+0xa8/0x140
  p9_client_rpc+0x81/0x280
  p9_client_write+0xcf/0x1c0
  v9fs_issue_write+0x87/0xc0
  netfs_advance_write+0xa0/0xb0
  netfs_write_folio.isra.0+0x42d/0x500
  netfs_writepages+0x15a/0x1f0
  do_writepages+0xd1/0x220
  filemap_fdatawrite_wbc+0x5c/0x80
  v9fs_mmap_vm_close+0x7d/0xb0
  remove_vma+0x35/0x70
  vms_complete_munmap_vmas+0x11a/0x170
  do_vmi_align_munmap+0x17d/0x1c0
  do_vmi_munmap+0x13e/0x150
  __vm_munmap+0x92/0xd0
  __x64_sys_munmap+0x17/0x20
  do_syscall_64+0x80/0xe0
  entry_SYSCALL_64_after_hwframe+0x71/0x79

This may also fix a similar-looking issue with cifs and generic/074.

  | Reported-by: kernel test robot <oliver.sang@intel.com>
  | Closes: https://lore.kernel.org/oe-lkp/202409180928.f20b5a08-oliver.sa=
ng@intel.com

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    |    2 +
 fs/netfs/misc.c        |   72 ++++++++++++++++++++++++++++++++++---------=
------
 fs/netfs/objects.c     |   12 ++++++++
 fs/netfs/write_issue.c |   12 +++++++-
 4 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c7f23dd3556a..79c0ad89affb 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -58,6 +58,7 @@ static inline void netfs_proc_del_rreq(struct netfs_io_r=
equest *rreq) {}
 /*
  * misc.c
  */
+struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq=
);
 int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio=
 *folio,
 			      bool needs_put);
 struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wre=
q);
@@ -76,6 +77,7 @@ void netfs_clear_subrequests(struct netfs_io_request *rr=
eq, bool was_async);
 void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
 		       enum netfs_rreq_ref_trace what);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_reques=
t *rreq);
+struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gfp=
_t gfp);
 =

 static inline void netfs_see_request(struct netfs_io_request *rreq,
 				     enum netfs_rreq_ref_trace what)
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0ad0982ce0e2..a743e8963247 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -9,34 +9,64 @@
 #include "internal.h"
 =

 /*
- * Append a folio to the rolling queue.
+ * Make sure there's space in the rolling queue.
  */
-int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio=
 *folio,
-			      bool needs_put)
+struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq=
)
 {
-	struct folio_queue *tail =3D rreq->buffer_tail;
-	unsigned int slot, order =3D folio_order(folio);
+	struct folio_queue *tail =3D rreq->buffer_tail, *prev;
+	unsigned int prev_nr_slots =3D 0;
 =

 	if (WARN_ON_ONCE(!rreq->buffer && tail) ||
 	    WARN_ON_ONCE(rreq->buffer && !tail))
-		return -EIO;
-
-	if (!tail || folioq_full(tail)) {
-		tail =3D kmalloc(sizeof(*tail), GFP_NOFS);
-		if (!tail)
-			return -ENOMEM;
-		netfs_stat(&netfs_n_folioq);
-		folioq_init(tail);
-		tail->prev =3D rreq->buffer_tail;
-		if (tail->prev)
-			tail->prev->next =3D tail;
-		rreq->buffer_tail =3D tail;
-		if (!rreq->buffer) {
-			rreq->buffer =3D tail;
-			iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
+		return ERR_PTR(-EIO);
+
+	prev =3D tail;
+	if (prev) {
+		if (!folioq_full(tail))
+			return tail;
+		prev_nr_slots =3D folioq_nr_slots(tail);
+	}
+
+	tail =3D netfs_folioq_alloc(rreq, GFP_NOFS);
+	if (!tail)
+		return ERR_PTR(-ENOMEM);
+	tail->prev =3D prev;
+	if (prev)
+		/* [!] NOTE: After we set prev->next, the consumer is entirely
+		 * at liberty to delete prev.
+		 */
+		WRITE_ONCE(prev->next, tail);
+
+	rreq->buffer_tail =3D tail;
+	if (!rreq->buffer) {
+		rreq->buffer =3D tail;
+		iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
+	} else {
+		/* Make sure we don't leave the master iterator pointing to a
+		 * block that might get immediately consumed.
+		 */
+		if (rreq->io_iter.folioq =3D=3D prev &&
+		    rreq->io_iter.folioq_slot =3D=3D prev_nr_slots) {
+			rreq->io_iter.folioq =3D tail;
+			rreq->io_iter.folioq_slot =3D 0;
 		}
-		rreq->buffer_tail_slot =3D 0;
 	}
+	rreq->buffer_tail_slot =3D 0;
+	return tail;
+}
+
+/*
+ * Append a folio to the rolling queue.
+ */
+int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio=
 *folio,
+			      bool needs_put)
+{
+	struct folio_queue *tail;
+	unsigned int slot, order =3D folio_order(folio);
+
+	tail =3D netfs_buffer_make_space(rreq);
+	if (IS_ERR(tail))
+		return PTR_ERR(tail);
 =

 	rreq->io_iter.count +=3D PAGE_SIZE << order;
 =

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index d32964e8ca5d..dd8241bc996b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -250,3 +250,15 @@ void netfs_put_subrequest(struct netfs_io_subrequest =
*subreq, bool was_async,
 	if (dead)
 		netfs_free_subrequest(subreq, was_async);
 }
+
+struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gfp=
_t gfp)
+{
+	struct folio_queue *fq;
+
+	fq =3D kmalloc(sizeof(*fq), gfp);
+	if (fq) {
+		netfs_stat(&netfs_n_folioq);
+		folioq_init(fq);
+	}
+	return fq;
+}
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 04e66d587f77..0929d9fd4ce7 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -153,12 +153,22 @@ static void netfs_prepare_write(struct netfs_io_requ=
est *wreq,
 				loff_t start)
 {
 	struct netfs_io_subrequest *subreq;
+	struct iov_iter *wreq_iter =3D &wreq->io_iter;
+
+	/* Make sure we don't point the iterator at a used-up folio_queue
+	 * struct being used as a placeholder to prevent the queue from
+	 * collapsing.  In such a case, extend the queue.
+	 */
+	if (iov_iter_is_folioq(wreq_iter) &&
+	    wreq_iter->folioq_slot >=3D folioq_nr_slots(wreq_iter->folioq)) {
+		netfs_buffer_make_space(wreq);
+	}
 =

 	subreq =3D netfs_alloc_subrequest(wreq);
 	subreq->source		=3D stream->source;
 	subreq->start		=3D start;
 	subreq->stream_nr	=3D stream->stream_nr;
-	subreq->io_iter		=3D wreq->io_iter;
+	subreq->io_iter		=3D *wreq_iter;
 =

 	_enter("R=3D%x[%x]", wreq->debug_id, subreq->debug_index);
 =

