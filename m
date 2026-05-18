Return-Path: <linux-erofs+bounces-3422-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH7tBw2TC2ohJgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3422-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:30:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC49E574776
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:30:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKCDl4CdLz2xMQ;
	Tue, 19 May 2026 08:30:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779143431;
	cv=none; b=a8wSPMi6WKNNAOwEmg6mG/onWFzknZaETa/+aAfSqEjuKVut63Www1wlZstwx0NHlSoH8kiaH/347Ffehhs57T3/+l1hMkJ49+3Y03d9uWRclmBI6a1cpytq1MnGKvthGUvdlgw2+LLU6vt4+vOPafi2B0mAajlahDHeclFvfz3Fkq8ZcT2/vnjAJKaG6yAVPThi7NUceLi1DBekZu4MLPaZLCTd1y7ETGh4eMIXUKy+6SUzRWY3PkUG15/6Rkakk/XRZ5JCkUHPnwqFy3D1RWq71xe4km+c1uTWHQMe+G5UzD2hsVhQhZ5iVNuYf3RNlzlDX/aNXuMkyuqt68n7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779143431; c=relaxed/relaxed;
	bh=XKlg/PVJ6lY/p4wmIQDvsoHAGDkFSM169T8+EP2u5/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mCAt7P5Qvx2dP8rpcHc2Z3CjFVl/9ebBgFieGM1QqkIZlpSREXmfvQxTOXonkzSK85hC+SoWA5SqJh3n5PPxkxIuxgCXJxfCkRrFBpnhSEbUoobPVmHi/RHVe5VwJXzREck2AuBRWKR98xXi5LOB79WibxyFmBD6Focb29+HzsCAeD1p4IAEE1dWz5DkycIX0UyzVH9bJLiXx5GWgTq5dxgeMgH4ApEW8CWf7Pcup58wM8GgJA4yLVCfTCwo/n5UCCOXQFrcvvn2Vuo+rbOcFZzMo+SL0KY2EVq6vWlw8+HoMyWJGHoKQzefM4PtYokHQgVj5w4eC1Wf5LYonzrUDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NvA71shc; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cgHYsyc9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NvA71shc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cgHYsyc9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKCDj3KHPz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 08:30:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XKlg/PVJ6lY/p4wmIQDvsoHAGDkFSM169T8+EP2u5/w=;
	b=NvA71shcaEzi++uD1MDSQbdL+UFTzJQO4ygCeNzXq3fmFRmM4i4ymQdIzCqluzZDUamTmh
	9zIijMxrGeMY+dnTwjsV4/Rlv2yyDRcWnM4v+TiV7OrZe46hhnQz4gPl5B0OHaVX23vmBo
	xgsjqhM1gjI5qz8zt0G1MasdVyRQWRs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XKlg/PVJ6lY/p4wmIQDvsoHAGDkFSM169T8+EP2u5/w=;
	b=cgHYsyc9dEZzpHMolAcGvluhX7CcH/aYnsFU8JEq1GAakgycNTHe/4uZqL5T7VBVXT0R9J
	df/HsP6GJaa7DxLxOJAchWxCt7+6MMGWR019tUMvNvxiD0SBS3BTAywW2VISMOxzMtJXKf
	CF6p3tDj12V/3HFZlWRGh8SyowRBCa8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-NrD_legDOMiE3PLHJOks1Q-1; Mon,
 18 May 2026 18:30:18 -0400
X-MC-Unique: NrD_legDOMiE3PLHJOks1Q-1
X-Mimecast-MFC-AGG-ID: NrD_legDOMiE3PLHJOks1Q_1779143415
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4C131956046;
	Mon, 18 May 2026 22:30:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DC0330002DC;
	Mon, 18 May 2026 22:30:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/21] netfs: Keep track of folios in a segmented bio_vec[] chain
Date: Mon, 18 May 2026 23:29:32 +0100
Message-ID: <20260518222959.488126-1-dhowells@redhat.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: zKDOcPOQCKBP1bxhUStPrhnD7NwAM0aiqKBWmuAXNqM_1779143415
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3422-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: DC49E574776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christian,

Could you add these patches to the VFS tree for next?

The patches get rid of folio_queue, rolling_buffer and ITER_FOLIOQ,
replacing the folio queue construct used to manage buffers in netfslib with
one based around a segmented chain of bio_vec arrays instead.  There are
three main aims here:

 (1) The kernel file I/O subsystem seems to be moving towards consolidating
     on the use of bio_vec arrays, so embrace this by moving netfslib to
     keep track of its buffers for buffered I/O in bio_vec[] form.

 (2) Netfslib already uses a bio_vec[] to handle unbuffered/DIO, so the
     number of different buffering schemes used can be reduced to just a
     single one.

 (3) Always send an entire filesystem RPC request message to a TCP socket
     with single kernel_sendmsg() call as this is faster, more efficient
     and doesn't require the use of corking as it puts the entire
     transmission loop inside of a single tcp_sendmsg().

For the replacement of folio_queue, a segmented chain of bio_vec arrays
rather than a single monolithic array is provided:

	struct bvecq {
		struct bvecq		*next;
		struct bvecq		*prev;
		unsigned long long	fpos;
		refcount_t		ref;
		u32			priv;
		u16			nr_segs;
		u16			max_segs;
		enum bvecq_mem		mem_type:2;
		bool			inline_bv:1;
		bool			discontig:1;
		struct bio_vec		*bv;
		struct bio_vec		__bv[];
	};

The fields are:

 (1) next, prev - Link segments together in a list.  I want this to be
     NULL-terminated linear rather than circular to make it possible to
     arbitrarily glue bits on the front.

 (2) fpos, discontig - Note the current file position of the first byte of
     the segment; all the bio_vecs in ->bv[] must be contiguous in the file
     space.  The fpos can be used to find the folio by file position rather
     then from the info in the bio_vec.

     If there's a discontiguity, this should break over into a new bvecq
     segment with the discontig flag set (though this is redundant if you
     keep track of the file position).  Note that the beginning and end
     file positions in a segment need not be aligned to any filesystem
     block size.

 (3) ref - Refcount.  Each bvecq keeps a ref on the next.  I'm not sure
     this is entirely necessary, but it makes sharing slices easier.

 (4) priv - Private data for the owner.  Dispensible; currently only used
     for storing a debug ID for tracing in a patch not included here.

 (5) max_segs, nr_segs.  The size of bv[] and the number of elements used.
     I've assumed a maximum of 65535 bio_vecs in the array (which would
     represent a ~1MiB allocation).

 (6) bv, __bv, inline_bv.  bv points to the bio_vec[] array handled by
     this segment.  This may begin at __bv and if it does inline_bv should
     be set (otherwise it's impossible to distinguish a separately
     allocated bio_vec[] that follows immediately by coincidence).

 (7) mem_type.  Indicates how the memory attached to the bio_vecs should be
     disposed of when the bvecq is destroyed.  It can be one of:

	BVECQ_MEM_EXTERNAL	- Externally tracked ref; don't put
	BVECQ_MEM_PAGECACHE	- Pagecache; must be put
	BVECQ_MEM_GUP		- Pinned by from GUP; needs unpin
	BVECQ_MEM_ALLOCED	- Plain alloc'd pages; can be mempooled


I've also defined an iov_iter iterator type ITER_BVECQ to walk this sort of
construct so that it can be passed directly to sendmsg() or block-based DIO
(as cachefiles does).


This series makes the following changes to netfslib:

 (1) The folio_queue chain used to hold folios for buffered I/O is replaced
     with a bvecq chain.  Each bio_vec then holds (a portion of) one folio.
     Each bvecq holds a contiguous sequence of folios, but adjacent bvecqs
     in a chain may be discontiguous.

 (2) For unbuffered/DIO, the source iov_iter is extracted into a bvecq
     chain.

 (3) An abstract position representation ('bvecq_pos') is created that can
     used to hold a position in a bvecq chain.  For the moment, this takes
     a ref on the bvecq it points to, but that may be excessive.

 (4) Buffer tracking is managed with three cursors:  The load_cursor, at
     which new folios are added as we go; the dispatch_cursor, at which new
     subrequests' buffers start when they're created; and the
     collect_cursor, the point at which folios are being unlocked.

     Not all cursors are necessarily needed in all situations and during
     buffered writeback, we need a dispatch cursor per stream (one for the
     network filesystem and one for the cache).

 (5) ->prepare_read(), buffer setting up and ->issue_read() are merged, as
     are the write variants, with the filesystem calling back up to
     netfslib to prepare its buffer.  This simplifies the process of
     setting up a subrequest.  It may even make sense to have the
     filesystem allocate the subrequest.

 (6) Retry dispatch tracking is added to netfs_io_request so that the
     buffer preparation functions can find it.  Retry requires an
     additional buffer cursor.

 (7) Netfslib dispatches I/O by accumulating enough bufferage to dispatch
     at least one subrequest, then looping to generate as many as the
     filesystem wants to (they may be limited by other constraints,
     e.g. max RDMA segment count or negotiated max size).  This loop could
     be moved down into the filesystem.  A new method is provided by which
     netfslib can ask the filesystem to provide an estimate of the data
     that should be accumulated before dispatch begins.

 (8) Reading from the cache is now managed by querying the cache to provide
     a list of the next two data extents within the cache.

 (9) AFS directories are switched to using a bvecq rather than a
     folio_queue to hold their contents.

(10) CIFS is switch to using a bvecq rather than a folio_queue for holding
     a temporary encryption buffer.

(11) CIFS RDMA is given the ability to extract ITER_BVECQ and support for
     extracting ITER_FOLIOQ is removed.

(12) All the folio_queue and rolling_buffer code is removed.

Cachefiles is also modified:

 (1) The object type in the cachefiles file xattr is now correctly set to
     CACHEFILES_CONTENT_{SINGLE,ALL,BACKFS_MAP} rather than just being 0,
     to indicate whether we have a single monolithic blob, all the data up
     to cache i_size with no holes or a sparse file with the data mapped by
     the backing file system (as currently upstream).

 (2) For "ALL" type files, the cache's i_size is used to track how much
     data is saved in the cache and no longer bears any relation to the
     netfs i_size.  The actual object size is stored in the xattr.

 (3) For most typical files which are contiguous and written progressively,
     the object type is now set to "ALL".  For anything else, cachefiles
     uses SEEK_DATA/HOLE to find extent outlines at before (this is the
     current behaviour and needs to be fixed, but in a separate set of
     patches as it's not trivial).

Two further things that I'm working on (but not in this branch) are:

 (1) Make it so that a filesystem can be given a copy of a subchain which
     it can then tack header and trailer protocol elements upon to form a
     single message (I have this working for cifs) and even join copies
     together with intervening protocol elements to form compounds.

 (2) Make it so that a filesystem can 'splice' out the contents of the TCP
     receive queue into a bvecq chain.  This allows the socket lock to be
     dropped much more quickly and the copying of data read to the
     destination buffers to happen without the lock.  I have this working
     for cifs too.  Kernel recvmsg() doesn't then block kernel sendmsg()
     for anywhere near as long.

There are also some things I want to consider for the future:

 (1) Create one or more batched iteration functions to 'unlock' all the
     folios in a bio_vec[], where 'unlock' is the appropriate action for
     ending a read or a write.  Batching should hopefully also improve the
     efficiency of wrangling the marks on the xarray.  Very often these
     marks are going to be represented by contiguous bits, so there may be
     a way to change them in bulk.

 (2) Rather than walking the bvecq chain to get each individual folio out
     via bv_page, use the file position stored on the bvecq and the sum of
     bv_len to iterate over the appropriate range in i_pages.

 (3) Change iov_iter to store the initial starting point and for
     iov_iter_revert() to reset to that and advance.  This would (a) help
     prevent over-reversion and (b) dispense with the need for a prev
     pointer.

 (4) Use bvecq to replace scatterlist.  One problem with replacing
     scatterlist is that crypto drivers like to glue bits on the front of
     the scatterlists they're given (something trivial with that API) - and
     this is one way to achieve it.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-next

Thanks,
David

Changes
=======
ver #2)
- Fixed a number of bugs reported by Sashiko[1].
- Split a bunch of fixes out and posted them separately[2].

[1] https://sashiko.dev/#/patchset/20260326104544.509518-1-dhowells%40redhat.com
[2] https://lore.kernel.org/linux-fsdevel/20260512-infozentrum-becher-7f86c47c96c8@brauner/T/#t

David Howells (21):
  cachefiles: Don't rely on backing fs storage map for most use cases
  netfs: Add the cache object ID to netfs_read/write tracepoints
  mm: Make readahead store folio count in readahead_control
  netfs: Bulk load the readahead-provided folios up front
  Add a function to kmap one page of a multipage bio_vec
  iov_iter: Make iov_iter_get_pages*() wrap iov_iter_extract_pages()
  iov_iter: Add a segmented queue of bio_vec[]
  netfs: Add some tools for managing bvecq chains
  netfs: Add a function to extract from an iter into a bvecq
  afs: Use a bvecq to hold dir content rather than folioq
  cifs: Use a bvecq for buffering instead of a folioq
  cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma()
  netfs: Switch to using bvecq rather than folio_queue and
    rolling_buffer
  cifs: Remove support for ITER_FOLIOQ from smb_extract_iter_to_rdma()
  netfs: Remove netfs_alloc/free_folioq_buffer()
  netfs: Remove netfs_extract_user_iter()
  iov_iter: Remove ITER_FOLIOQ
  netfs: Remove folio_queue and rolling_buffer
  netfs: Check for too much data being read
  netfs: Limit the minimum trigger for progress reporting
  netfs: Combine prepare and issue ops and grab the buffers on request

 Documentation/core-api/folio_queue.rst      |  209 ----
 Documentation/core-api/index.rst            |    1 -
 Documentation/filesystems/netfs_library.rst |    2 +-
 fs/9p/vfs_addr.c                            |   49 +-
 fs/afs/dir.c                                |   40 +-
 fs/afs/dir_edit.c                           |   43 +-
 fs/afs/dir_search.c                         |   33 +-
 fs/afs/file.c                               |   28 +-
 fs/afs/fsclient.c                           |    8 +-
 fs/afs/inode.c                              |    2 +-
 fs/afs/internal.h                           |   12 +-
 fs/afs/symlink.c                            |   31 +-
 fs/afs/write.c                              |   32 +-
 fs/afs/yfsclient.c                          |    6 +-
 fs/cachefiles/interface.c                   |   82 +-
 fs/cachefiles/internal.h                    |   13 +-
 fs/cachefiles/io.c                          |  530 +++++++---
 fs/cachefiles/namei.c                       |   19 +-
 fs/cachefiles/xattr.c                       |   24 +-
 fs/ceph/Kconfig                             |    1 +
 fs/ceph/addr.c                              |  119 ++-
 fs/netfs/Kconfig                            |    3 +
 fs/netfs/Makefile                           |    4 +-
 fs/netfs/buffered_read.c                    |  508 +++++----
 fs/netfs/buffered_write.c                   |   30 +-
 fs/netfs/bvecq.c                            |  763 ++++++++++++++
 fs/netfs/direct_read.c                      |  107 +-
 fs/netfs/direct_write.c                     |  167 +--
 fs/netfs/fscache_io.c                       |    8 +-
 fs/netfs/internal.h                         |  112 +-
 fs/netfs/iterator.c                         |  369 ++-----
 fs/netfs/misc.c                             |  168 +--
 fs/netfs/objects.c                          |   22 +-
 fs/netfs/read_collect.c                     |  159 +--
 fs/netfs/read_pgpriv2.c                     |  188 ++--
 fs/netfs/read_retry.c                       |  243 ++---
 fs/netfs/read_single.c                      |  169 +--
 fs/netfs/rolling_buffer.c                   |  222 ----
 fs/netfs/stats.c                            |    6 +-
 fs/netfs/write_collect.c                    |  236 +++--
 fs/netfs/write_issue.c                      | 1049 +++++++++++--------
 fs/netfs/write_retry.c                      |  147 +--
 fs/nfs/Kconfig                              |    1 +
 fs/nfs/fscache.c                            |   23 +-
 fs/smb/client/cifsglob.h                    |    2 +-
 fs/smb/client/cifssmb.c                     |   13 +-
 fs/smb/client/file.c                        |  137 +--
 fs/smb/client/smb2ops.c                     |   79 +-
 fs/smb/client/smb2pdu.c                     |   28 +-
 fs/smb/client/transport.c                   |   15 +-
 fs/smb/smbdirect/connection.c               |  134 ++-
 include/linux/bvec.h                        |   17 +
 include/linux/bvecq.h                       |  325 ++++++
 include/linux/folio_queue.h                 |  282 -----
 include/linux/fscache.h                     |   17 +
 include/linux/iov_iter.h                    |   82 +-
 include/linux/netfs.h                       |  166 +--
 include/linux/pagemap.h                     |   10 +
 include/linux/rolling_buffer.h              |   61 --
 include/linux/uio.h                         |   17 +-
 include/trace/events/cachefiles.h           |   17 +-
 include/trace/events/netfs.h                |  155 ++-
 kernel/bpf/btf.c                            |    2 -
 lib/iov_iter.c                              |  545 +++++-----
 lib/scatterlist.c                           |   59 +-
 lib/tests/kunit_iov_iter.c                  |  135 ++-
 mm/readahead.c                              |    5 +
 net/9p/client.c                             |    8 +-
 68 files changed, 4694 insertions(+), 3605 deletions(-)
 delete mode 100644 Documentation/core-api/folio_queue.rst
 create mode 100644 fs/netfs/bvecq.c
 delete mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 include/linux/bvecq.h
 delete mode 100644 include/linux/folio_queue.h
 delete mode 100644 include/linux/rolling_buffer.h


