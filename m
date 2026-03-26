Return-Path: <linux-erofs+bounces-3025-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF53HOcOxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3025-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:48:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D318333BC3
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:48:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL8h1s8fz2ygp;
	Thu, 26 Mar 2026 21:48:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522084;
	cv=none; b=ie/dqJ8to6eLp7wU1TUFAzRjL+YVz1PZ8sVNL/K6K5OlNwP5LM+q2u09pGmegSJfQuYln8N93eue1gnLNmtiqM25u0o16OGPxxT6CwQwgRvfurAmNi4Fdbpcab81mQhVW4SP3srpiOP0LfV2awSA9czKzgI2Z9zbhWdnv5wQVjD0/Iuoe3j3s4kkqDrFbkQce07XZNbeaG/q1ZLxT6BLRji+rLhEdBP91cZCOEkbBiblNTTQbXF3iHC9VM4z2jOsDiL3gYVS/Y1UCxe+AIjpTd4rDIyVMqFNvC5TWsPQskATZm50JnBl0nyV3ZxbN1ch/p5LMaP1hZSs1OEg44Oayw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522084; c=relaxed/relaxed;
	bh=DxL+yW7+B7jQcX5wo/zZyXW1S1PpGyKQ1dUYF5xN7ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KccBdZn9G14usJrazTTOPgZ2H/21sgXUjX7VHmrd/MFXcWCgJi2geIp86XYR63SS34FO8nCFrFW5u+FEAGXKwaAtOTNVR2aIff4ixrJXZ0F9I7rDerAVRtwlsv6KMnfsC0TPypZg4/+TSn/GTDTCR7KvWLUERlWHrT/yzzcCf1u07472SQWZX6AhEHawcWdkmjMUNRF6AwY34K6f+CcjRk1gokIdwJj5kQOtzC/8WMVpvhn0amu0TGNtc72mj4t+3jHb67CFJvotJ2xoib0H7RGMOUodvVZ9TPdEmAf3rIpTi4eOfPE5g/tUFFMyM4tehmd90CDiKMcPYYKZD3uiFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MffJd40W; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga+vJ+DU; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MffJd40W;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga+vJ+DU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL8f56nGz2yVB
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxL+yW7+B7jQcX5wo/zZyXW1S1PpGyKQ1dUYF5xN7ks=;
	b=MffJd40W/dhSNlhWDupgYqS3Ov/aIcZUuG/EI9VCH7w/pgvikCt5VhHV10ZtimpQARl8E2
	cHyRG93lv967zmvMmu8222OYbKQc2u3Sa2QW3f8Hpz/MU9dmDJrIAuB1OHYJ8fJanQwpwp
	Lx1tmmZV5rDwLHxLBBEINwxlGMUseno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxL+yW7+B7jQcX5wo/zZyXW1S1PpGyKQ1dUYF5xN7ks=;
	b=Ga+vJ+DUznnI3Q0iCXS0dmarqUOwvWaPDCiBhfi5wrCYdYzDUXno1GnkEEEQyblPqe7fh/
	VM8zfe4n3DSWYJDc15KO+KurdU3zwNNBffGy01IhVMOkiG4d8427vwqaww8GtAuKmY1FSR
	nCzZ48RsrbDzytQRqStXHuNExR0Nm6M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-zh8E2yOlOx6RfvhMNxM4VQ-1; Thu,
 26 Mar 2026 06:47:55 -0400
X-MC-Unique: zh8E2yOlOx6RfvhMNxM4VQ-1
X-Mimecast-MFC-AGG-ID: zh8E2yOlOx6RfvhMNxM4VQ_1774522072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A08C1800464;
	Thu, 26 Mar 2026 10:47:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCC0E19560B1;
	Thu, 26 Mar 2026 10:47:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 12/26] iov_iter: Add a segmented queue of bio_vec[]
Date: Thu, 26 Mar 2026 10:45:27 +0000
Message-ID: <20260326104544.509518-13-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: qXYGszRcsOhUMPcDsp1Jcd6fwJ9TQosdRrOp54TImWw_1774522072
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3025-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pc@manguebit.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,linux.dev:email,infradead.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8D318333BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
indefinite quantity of elements to be handled and allows things like
network filesystems and crypto drivers to glue bits on the ends without
having to reallocate the array.

The bvecq struct that defines each segment also carries capacity/usage
information along with flags indicating whether the constituent memory
regions need freeing or unpinning and the file position of the first
element in a segment.  The bvecq structs are refcounted to allow a queue to
be extracted in batches and split between a number of subrequests.

The bvecq can have the bio_vec[] it manages allocated in with it, but this
is not required.  A flag is provided for if this is the case as comparing
->bv to ->__bv is not sufficient to detect this case.

Add an iterator type ITER_BVECQ for it.  This is intended to replace
ITER_FOLIOQ (and ITER_XARRAY).

Note that the prev pointer is only really needed for iov_iter_revert() and
could be dispensed with if struct iov_iter contained the head information
as well as the current point.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvecq.h      |  46 ++++++
 include/linux/iov_iter.h   |  63 +++++++-
 include/linux/uio.h        |  11 ++
 lib/iov_iter.c             | 288 ++++++++++++++++++++++++++++++++++++-
 lib/scatterlist.c          |  66 +++++++++
 lib/tests/kunit_iov_iter.c | 180 +++++++++++++++++++++++
 6 files changed, 649 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/bvecq.h

diff --git a/include/linux/bvecq.h b/include/linux/bvecq.h
new file mode 100644
index 000000000000..462125af1cc7
--- /dev/null
+++ b/include/linux/bvecq.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Implementation of a segmented queue of bio_vec[].
+ *
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_BVECQ_H
+#define _LINUX_BVECQ_H
+
+#include <linux/bvec.h>
+
+/*
+ * Segmented bio_vec queue.
+ *
+ * These can be linked together to form messages of indefinite length and
+ * iterated over with an ITER_BVECQ iterator.  The list is non-circular; next
+ * and prev are NULL at the ends.
+ *
+ * The bv pointer points to the segment array; this may be __bv if allocated
+ * together.  The caller is responsible for determining whether or not this is
+ * the case as the array pointed to by bv may be follow on directly from the
+ * bvecq by accident of allocation (ie. ->bv == ->__bv is *not* sufficient to
+ * determine this).
+ *
+ * The file position and discontiguity flag allow non-contiguous data sets to
+ * be chained together, but still teased apart without the need to convert the
+ * info in the bio_vec back into a folio pointer.
+ */
+struct bvecq {
+	struct bvecq	*next;		/* Next bvec in the list or NULL */
+	struct bvecq	*prev;		/* Prev bvec in the list or NULL */
+	unsigned long long fpos;	/* File position */
+	refcount_t	ref;
+	u32		priv;		/* Private data */
+	u16		nr_segs;	/* Number of elements in bv[] used */
+	u16		max_segs;	/* Number of elements allocated in bv[] */
+	bool		inline_bv:1;	/* T if __bv[] is being used */
+	bool		free:1;		/* T if the pages need freeing */
+	bool		unpin:1;	/* T if the pages need unpinning, not freeing */
+	bool		discontig:1;	/* T if not contiguous with previous bvecq */
+	struct bio_vec	*bv;		/* Pointer to array of page fragments */
+	struct bio_vec	__bv[];		/* Default array (if ->inline_bv) */
+};
+
+#endif /* _LINUX_BVECQ_H */
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index f9a17fbbd398..999607ece481 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -9,7 +9,7 @@
 #define _LINUX_IOV_ITER_H
 
 #include <linux/uio.h>
-#include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/folio_queue.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
@@ -141,6 +141,59 @@ size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
+/*
+ * Handle ITER_BVECQ.
+ */
+static __always_inline
+size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		     iov_step_f step)
+{
+	const struct bvecq *bq = iter->bvecq;
+	unsigned int slot = iter->bvecq_slot;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	if (slot == bq->nr_segs) {
+		/* The iterator may have been extended. */
+		bq = bq->next;
+		slot = 0;
+	}
+
+	do {
+		const struct bio_vec *bvec = &bq->bv[slot];
+		struct page *page = bvec->bv_page + (bvec->bv_offset + skip) / PAGE_SIZE;
+		size_t part, remain, consumed;
+		size_t poff = (bvec->bv_offset + skip) % PAGE_SIZE;
+		void *base;
+
+		part = umin(umin(bvec->bv_len - skip, PAGE_SIZE - poff), len);
+		base = kmap_local_page(page) + poff;
+		remain = step(base, progress, part, priv, priv2);
+		kunmap_local(base);
+		consumed = part - remain;
+		len -= consumed;
+		progress += consumed;
+		skip += consumed;
+		if (skip >= bvec->bv_len) {
+			skip = 0;
+			slot++;
+			if (slot >= bq->nr_segs) {
+				if (!bq->next)
+					break;
+				bq = bq->next;
+				slot = 0;
+			}
+		}
+		if (remain)
+			break;
+	} while (len);
+
+	iter->bvecq_slot = slot;
+	iter->bvecq = bq;
+	iter->iov_offset = skip;
+	iter->count -= progress;
+	return progress;
+}
+
 /*
  * Handle ITER_FOLIOQ.
  */
@@ -306,6 +359,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_bvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_bvecq(iter))
+		return iterate_bvecq(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
@@ -342,8 +397,8 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
  * buffer is presented in segments, which for kernel iteration are broken up by
  * physical pages and mapped, with the mapped address being presented.
  *
- * [!] Note This will only handle BVEC, KVEC, FOLIOQ, XARRAY and DISCARD-type
- * iterators; it will not handle UBUF or IOVEC-type iterators.
+ * [!] Note This will only handle BVEC, KVEC, BVECQ, FOLIOQ, XARRAY and
+ * DISCARD-type iterators; it will not handle UBUF or IOVEC-type iterators.
  *
  * A step functions, @step, must be provided, one for handling mapped kernel
  * addresses and the other is given user addresses which have the potential to
@@ -370,6 +425,8 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_bvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_bvecq(iter))
+		return iterate_bvecq(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..aa50d348dfcc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -27,6 +27,7 @@ enum iter_type {
 	ITER_BVEC,
 	ITER_KVEC,
 	ITER_FOLIOQ,
+	ITER_BVECQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
 };
@@ -69,6 +70,7 @@ struct iov_iter {
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
 				const struct folio_queue *folioq;
+				const struct bvecq *bvecq;
 				struct xarray *xarray;
 				void __user *ubuf;
 			};
@@ -78,6 +80,7 @@ struct iov_iter {
 	union {
 		unsigned long nr_segs;
 		u8 folioq_slot;
+		u16 bvecq_slot;
 		loff_t xarray_start;
 	};
 };
@@ -150,6 +153,11 @@ static inline bool iov_iter_is_folioq(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_FOLIOQ;
 }
 
+static inline bool iov_iter_is_bvecq(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_BVECQ;
+}
+
 static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_XARRAY;
@@ -298,6 +306,9 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  const struct folio_queue *folioq,
 			  unsigned int first_slot, unsigned int offset, size_t count);
+void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
+			 const struct bvecq *bvecq,
+			 unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a63c7fba313..df8d037894b1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -571,6 +571,39 @@ static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
 	i->folioq = folioq;
 }
 
+static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
+{
+	const struct bvecq *bq = i->bvecq;
+	unsigned int slot = i->bvecq_slot;
+
+	if (!i->count)
+		return;
+	i->count -= by;
+
+	if (slot >= bq->nr_segs) {
+		bq = bq->next;
+		slot = 0;
+	}
+
+	by += i->iov_offset; /* From beginning of current segment. */
+	do {
+		size_t len = bq->bv[slot].bv_len;
+
+		if (likely(by < len))
+			break;
+		by -= len;
+		slot++;
+		if (slot >= bq->nr_segs && bq->next) {
+			bq = bq->next;
+			slot = 0;
+		}
+	} while (by);
+
+	i->iov_offset = by;
+	i->bvecq_slot = slot;
+	i->bvecq = bq;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -585,6 +618,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_bvec_advance(i, size);
 	} else if (iov_iter_is_folioq(i)) {
 		iov_iter_folioq_advance(i, size);
+	} else if (iov_iter_is_bvecq(i)) {
+		iov_iter_bvecq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
 	}
@@ -617,6 +652,32 @@ static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
 	i->folioq = folioq;
 }
 
+static void iov_iter_bvecq_revert(struct iov_iter *i, size_t unroll)
+{
+	const struct bvecq *bq = i->bvecq;
+	unsigned int slot = i->bvecq_slot;
+
+	for (;;) {
+		size_t len;
+
+		if (slot == 0) {
+			bq = bq->prev;
+			slot = bq->nr_segs;
+		}
+		slot--;
+
+		len = bq->bv[slot].bv_len;
+		if (unroll <= len) {
+			i->iov_offset = len - unroll;
+			break;
+		}
+		unroll -= len;
+	}
+
+	i->bvecq_slot = slot;
+	i->bvecq = bq;
+}
+
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -651,6 +712,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	} else if (iov_iter_is_folioq(i)) {
 		i->iov_offset = 0;
 		iov_iter_folioq_revert(i, unroll);
+	} else if (iov_iter_is_bvecq(i)) {
+		i->iov_offset = 0;
+		iov_iter_bvecq_revert(i, unroll);
 	} else { /* same logics for iovec and kvec */
 		const struct iovec *iov = iter_iov(i);
 		while (1) {
@@ -678,9 +742,12 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		if (iov_iter_is_bvec(i))
 			return min(i->count, i->bvec->bv_len - i->iov_offset);
 	}
+	if (!i->count)
+		return 0;
 	if (unlikely(iov_iter_is_folioq(i)))
-		return !i->count ? 0 :
-			umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
+		return umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
+	if (unlikely(iov_iter_is_bvecq(i)))
+		return min(i->count, i->bvecq->bv[i->bvecq_slot].bv_len - i->iov_offset);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -747,6 +814,35 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_folio_queue);
 
+/**
+ * iov_iter_bvec_queue - Initialise an I/O iterator to use a segmented bvec queue
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @bvecq: The starting point in the bvec queue.
+ * @first_slot: The first slot in the bvec queue to use
+ * @offset: The offset into the bvec in the first slot to start at
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the buffers attached to an
+ * inode or to inject data into those buffers.  The pages *must* be prevented
+ * from evaporation, either by the caller.
+ */
+void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
+			 const struct bvecq *bvecq, unsigned int first_slot,
+			 unsigned int offset, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter) {
+		.iter_type	= ITER_BVECQ,
+		.data_source	= direction,
+		.bvecq		= bvecq,
+		.bvecq_slot	= first_slot,
+		.count		= count,
+		.iov_offset	= offset,
+	};
+}
+EXPORT_SYMBOL(iov_iter_bvec_queue);
+
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
  * @i: The iterator to initialise.
@@ -839,6 +935,37 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 	return res;
 }
 
+static unsigned long iov_iter_alignment_bvecq(const struct iov_iter *iter)
+{
+	const struct bvecq *bq;
+	unsigned long res = 0;
+	unsigned int slot = iter->bvecq_slot;
+	size_t skip = iter->iov_offset;
+	size_t size = iter->count;
+
+	if (!size)
+		return res;
+
+	for (bq = iter->bvecq; bq; bq = bq->next) {
+		for (; slot < bq->nr_segs; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+			size_t part = umin(bvec->bv_len - skip, size);
+
+			res |= bvec->bv_offset + skip;
+			res |= part;
+
+			size -= part;
+			if (size == 0)
+				return res;
+			skip = 0;
+		}
+
+		slot = 0;
+	}
+
+	return res;
+}
+
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
 	if (likely(iter_is_ubuf(i))) {
@@ -858,6 +985,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	/* With both xarray and folioq types, we're dealing with whole folios. */
 	if (iov_iter_is_folioq(i))
 		return i->iov_offset | i->count;
+	if (iov_iter_is_bvecq(i))
+		return iov_iter_alignment_bvecq(i);
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
@@ -1124,6 +1253,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_folioq_get_pages(i, pages, maxsize, maxpages, start);
 	if (iov_iter_is_xarray(i))
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
+	WARN_ON_ONCE(iov_iter_is_bvecq(i));
 	return -EFAULT;
 }
 
@@ -1192,6 +1322,36 @@ static int bvec_npages(const struct iov_iter *i, int maxpages)
 	return npages;
 }
 
+static size_t iov_npages_bvecq(const struct iov_iter *iter, size_t maxpages)
+{
+	const struct bvecq *bq;
+	unsigned int slot = iter->bvecq_slot;
+	size_t npages = 0;
+	size_t skip = iter->iov_offset;
+	size_t size = iter->count;
+
+	for (bq = iter->bvecq; bq; bq = bq->next) {
+		for (; slot < bq->nr_segs; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+			size_t offs = (bvec->bv_offset + skip) % PAGE_SIZE;
+			size_t part = umin(bvec->bv_len - skip, size);
+
+			npages += DIV_ROUND_UP(offs + part, PAGE_SIZE);
+			if (npages >= maxpages)
+				goto out;
+
+			size -= part;
+			if (!size)
+				goto out;
+			skip = 0;
+		}
+
+		slot = 0;
+	}
+out:
+	return umin(npages, maxpages);
+}
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	if (unlikely(!i->count))
@@ -1211,6 +1371,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
 		return min(npages, maxpages);
 	}
+	if (iov_iter_is_bvecq(i))
+		return iov_npages_bvecq(i, maxpages);
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1554,6 +1716,124 @@ static ssize_t iov_iter_extract_folioq_pages(struct iov_iter *i,
 	return extracted;
 }
 
+/*
+ * Extract a list of virtually contiguous pages from an ITER_BVECQ iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
+					    struct page ***pages, size_t maxsize,
+					    unsigned int maxpages,
+					    iov_iter_extraction_t extraction_flags,
+					    size_t *offset0)
+{
+	const struct bvecq *bvecq = iter->bvecq;
+	struct page **p;
+	unsigned int seg = iter->bvecq_slot, count = 0, nr = 0;
+	size_t extracted = 0, offset = iter->iov_offset;
+
+	if (seg >= bvecq->nr_segs) {
+		bvecq = bvecq->next;
+		if (WARN_ON_ONCE(!bvecq))
+			return 0;
+		seg = 0;
+	}
+
+	/* First, we count the run of virtually contiguous pages. */
+	do {
+		const struct bio_vec *bv = &bvecq->bv[seg];
+		size_t boff = bv->bv_offset, blen = bv->bv_len;
+
+		if (!bv->bv_page)
+			blen = 0;
+		if (extracted > 0 && boff % PAGE_SIZE)
+			break;
+
+		if (offset < blen) {
+			size_t part = umin(maxsize - extracted, blen - offset);
+			size_t poff = (boff + offset) % PAGE_SIZE;
+			size_t pcount = DIV_ROUND_UP(poff + blen, PAGE_SIZE);
+
+			offset	  += part;
+			extracted += part;
+			count	  += pcount;
+			if ((boff + blen) % PAGE_SIZE)
+				break;
+		}
+
+		if (offset >= blen) {
+			offset = 0;
+			seg++;
+			if (seg >= bvecq->nr_segs) {
+				if (!bvecq->next) {
+					WARN_ON_ONCE(extracted < iter->count);
+					break;
+				}
+				bvecq = bvecq->next;
+				seg = 0;
+			}
+		}
+	} while (count < maxpages && extracted < maxsize);
+
+	maxpages = umin(maxpages, count);
+
+	if (!*pages) {
+		*pages = kvmalloc_array(maxpages, sizeof(struct page *), GFP_KERNEL);
+		if (!*pages)
+			return -ENOMEM;
+	}
+
+	p = *pages;
+
+	/* Now transcribe the page pointers. */
+	extracted = 0;
+	bvecq = iter->bvecq;
+	offset = iter->iov_offset;
+	seg = iter->bvecq_slot;
+
+	do {
+		const struct bio_vec *bv = &bvecq->bv[seg];
+		size_t boff = bv->bv_offset, blen = bv->bv_len;
+
+		if (!bv->bv_page)
+			blen = 0;
+
+		if (offset < blen) {
+			size_t part = umin(maxsize - extracted, blen - offset);
+			size_t poff = (boff + offset) % PAGE_SIZE;
+			size_t pix = (boff + offset) / PAGE_SIZE;
+
+			if (poff + part > PAGE_SIZE)
+				part = PAGE_SIZE - poff;
+
+			if (!extracted)
+				*offset0 = poff;
+
+			p[nr++] = bv->bv_page + pix;
+			offset += part;
+			extracted += part;
+		}
+
+		if (offset >= blen) {
+			offset = 0;
+			seg++;
+			if (seg >= bvecq->nr_segs) {
+				if (!bvecq->next) {
+					WARN_ON_ONCE(extracted < iter->count);
+					break;
+				}
+				bvecq = bvecq->next;
+				seg = 0;
+			}
+		}
+	} while (nr < maxpages && extracted < maxsize);
+
+	iter->bvecq = bvecq;
+	iter->bvecq_slot = seg;
+	iter->iov_offset = offset;
+	iter->count -= extracted;
+	return extracted;
+}
+
 /*
  * Extract a list of contiguous pages from an ITER_XARRAY iterator.  This does not
  * get references on the pages, nor does it get a pin on them.
@@ -1838,6 +2118,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_folioq_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
 						     offset0);
+	if (iov_iter_is_bvecq(i))
+		return iov_iter_extract_bvecq_pages(i, pages, maxsize,
+						    maxpages, extraction_flags,
+						    offset0);
 	if (iov_iter_is_xarray(i))
 		return iov_iter_extract_xarray_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index d773720d11bf..03e3883a1a2d 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/kmemleak.h>
 #include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/uio.h>
 #include <linux/folio_queue.h>
 
@@ -1328,6 +1329,68 @@ static ssize_t extract_folioq_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract up to sg_max folios from an BVECQ-type iterator and add them to
+ * the scatterlist.  The pages are not pinned.
+ */
+static ssize_t extract_bvecq_to_sg(struct iov_iter *iter,
+				   ssize_t maxsize,
+				   struct sg_table *sgtable,
+				   unsigned int sg_max,
+				   iov_iter_extraction_t extraction_flags)
+{
+	const struct bvecq *bvecq = iter->bvecq;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned int seg = iter->bvecq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	if (seg >= bvecq->nr_segs) {
+		bvecq = bvecq->next;
+		if (WARN_ON_ONCE(!bvecq))
+			return 0;
+		seg = 0;
+	}
+
+	do {
+		const struct bio_vec *bv = &bvecq->bv[seg];
+		size_t blen = bv->bv_len;
+
+		if (!bv->bv_page)
+			blen = 0;
+
+		if (offset < blen) {
+			size_t part = umin(maxsize - ret, blen - offset);
+
+			sg_set_page(sg, bv->bv_page, part, bv->bv_offset + offset);
+			sgtable->nents++;
+			sg++;
+			sg_max--;
+			offset += part;
+			ret += part;
+		}
+
+		if (offset >= blen) {
+			offset = 0;
+			seg++;
+			if (seg >= bvecq->nr_segs) {
+				if (!bvecq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				bvecq = bvecq->next;
+				seg = 0;
+			}
+		}
+	} while (sg_max > 0 && ret < maxsize);
+
+	iter->bvecq = bvecq;
+	iter->bvecq_slot = seg;
+	iter->iov_offset = offset;
+	iter->count -= ret;
+	return ret;
+}
+
 /*
  * Extract up to sg_max folios from an XARRAY-type iterator and add them to
  * the scatterlist.  The pages are not pinned.
@@ -1426,6 +1489,9 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_FOLIOQ:
 		return extract_folioq_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);
+	case ITER_BVECQ:
+		return extract_bvecq_to_sg(iter, maxsize, sgtable, sg_max,
+					   extraction_flags);
 	case ITER_XARRAY:
 		return extract_xarray_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);
diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index bb847e5010eb..5bc941f64343 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/folio_queue.h>
 #include <kunit/test.h>
 
@@ -536,6 +537,183 @@ static void __init iov_kunit_copy_from_folioq(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+static void iov_kunit_destroy_bvecq(void *data)
+{
+	struct bvecq *bq, *next;
+
+	for (bq = data; bq; bq = next) {
+		next = bq->next;
+		for (int i = 0; i < bq->nr_segs; i++)
+			if (bq->bv[i].bv_page)
+				put_page(bq->bv[i].bv_page);
+		kfree(bq);
+	}
+}
+
+static struct bvecq *iov_kunit_alloc_bvecq(struct kunit *test, unsigned int max_segs)
+{
+	struct bvecq *bq;
+
+	bq = kzalloc(struct_size(bq, __bv, max_segs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bq);
+	bq->max_segs = max_segs;
+	return bq;
+}
+
+static struct bvecq *iov_kunit_create_bvecq(struct kunit *test, unsigned int max_segs)
+{
+	struct bvecq *bq;
+
+	bq = iov_kunit_alloc_bvecq(test, max_segs);
+	kunit_add_action_or_reset(test, iov_kunit_destroy_bvecq, bq);
+	return bq;
+}
+
+static void __init iov_kunit_load_bvecq(struct kunit *test,
+					struct iov_iter *iter, int dir,
+					struct bvecq *bq_head,
+					struct page **pages, size_t npages)
+{
+	struct bvecq *bq = bq_head;
+	size_t size = 0;
+
+	for (int i = 0; i < npages; i++) {
+		if (bq->nr_segs >= bq->max_segs) {
+			bq->next = iov_kunit_alloc_bvecq(test, 8);
+			bq->next->prev = bq;
+			bq = bq->next;
+		}
+		bvec_set_page(&bq->bv[bq->nr_segs], pages[i], PAGE_SIZE, 0);
+		bq->nr_segs++;
+		size += PAGE_SIZE;
+	}
+	iov_iter_bvec_queue(iter, dir, bq_head, 0, 0, size);
+}
+
+/*
+ * Test copying to a ITER_BVECQ-type iterator.
+ */
+static void __init iov_kunit_copy_to_bvecq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	bq = iov_kunit_create_bvecq(test, 8);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_bvecq(test, &iter, READ, bq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_bvec_queue(&iter, READ, bq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_to_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		i += size;
+		if (test->status == KUNIT_FAILURE)
+			goto stop;
+	}
+
+	/* Build the expected image in the scratch buffer. */
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+stop:
+	KUNIT_SUCCEED(test);
+}
+
+/*
+ * Test copying from a ITER_BVECQ-type iterator.
+ */
+static void __init iov_kunit_copy_from_bvecq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	bq = iov_kunit_create_bvecq(test, 8);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_bvecq(test, &iter, READ, bq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_bvec_queue(&iter, WRITE, bq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_from_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		i += size;
+	}
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED(test);
+}
+
 static void iov_kunit_destroy_xarray(void *data)
 {
 	struct xarray *xarray = data;
@@ -1016,6 +1194,8 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
 	KUNIT_CASE(iov_kunit_copy_to_folioq),
 	KUNIT_CASE(iov_kunit_copy_from_folioq),
+	KUNIT_CASE(iov_kunit_copy_to_bvecq),
+	KUNIT_CASE(iov_kunit_copy_from_bvecq),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),


