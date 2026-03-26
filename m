Return-Path: <linux-erofs+bounces-3027-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxoGfYOxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3027-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:48:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9791B333BD9
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:48:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL8z1DYrz2xN8;
	Thu, 26 Mar 2026 21:48:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522099;
	cv=none; b=oeJJyZ285uIr5pDzMY6BtDEIP+XCNGkUJ6eAa8cI93Da9tVdNyt83yg6xRWiNTm4nGhlcNC8juAProByCN3LqqlD9VGVYqCHto8PaUcOrM54UH/GdUPL62QuWXFRdSkOS1xa4XvETP0Cq3jqTOFxK5sW/14MxPqfj865nZ/QxD+Uktcc1I6NmrQqRBendoWpOl3HH43Nrm7fszxM4Yh0+0mkNVNPZQMcQBjbZYVmPNlNDdFzm6hl1OuD1oCJAM0bSLvA9WBNCaFlDmmXph94Ze7X30eiwuw2SpRkvYNsZ4q5bKdbDGEYe+lfAW+K2ABguy/f6uWWTFho+VtmwLQwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522099; c=relaxed/relaxed;
	bh=0q3CSNpbXi5lOGrcvXbX8mvLw/thJvXIjpsnNa/bq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=W0oEolGHwq8WqURxDgvhkteThFLW/WisvQFV6msU4hODjiWR+ohpwSEgzmkHUZKYB71f0EboEzVCtCS6G6EmQr6A1N6JWgbYfbpuOCJM0w5L9grkJUn5/hjkGr4tG+y+y19kqLWNQiURpLt7JBOBQdnA+Bnzh1WY2GSPTcrbXGwnNkSLuzl3Ur4gmx3LGGCgbjXICCfr5XAyWOeyAsM2KV2XXpwZV3ms6jNZxqx/7RxIYb8ZFbMaC0UPvt0aW2Rr1P1szpL7PRlkP/OOXqZB0WBxCWv7wbbh8OAqvCTXLZb0FYktqWhr6IInFGTBX/TFwWKVttErcudZJkuLOwZhCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ex0928cP; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GAdDXRXl; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ex0928cP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GAdDXRXl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL8y2R71z2yVB
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:48:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q3CSNpbXi5lOGrcvXbX8mvLw/thJvXIjpsnNa/bq6w=;
	b=ex0928cPC6VH7oOzJE0iH+6xHectkRofs0uO5XbrScCMxUTYbfEjzAZftvw9ZaD/YSYLFQ
	7DFTzwXpD0ytD/QtAPVxAsHyt7Vstv/1UsersKbas0lFCIWO0aeneA9WR6wsqiQ3wgKAjf
	+mAT9GZUg2dywUtgfr21D2K8fTzC2oI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q3CSNpbXi5lOGrcvXbX8mvLw/thJvXIjpsnNa/bq6w=;
	b=GAdDXRXlG2qsp0XAsuYBiv3Tm4xxFLy+e62yoMjzr6Wsuc4SUh+iNpXLkLh80XGDl/JudW
	qcxVWkE5Mg0hyOiBx49Jqc8gnlk4SISm4QL6K5T0YVup/B9fDdI+puq9dadE2gF3FnBbzO
	5B/mQz/bW5O36fFmhBi3F7BI4/5ATNQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-H2PjY8ChMyuS7rT40AhezQ-1; Thu,
 26 Mar 2026 06:48:11 -0400
X-MC-Unique: H2PjY8ChMyuS7rT40AhezQ-1
X-Mimecast-MFC-AGG-ID: H2PjY8ChMyuS7rT40AhezQ_1774522089
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D89180034E;
	Thu, 26 Mar 2026 10:48:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 783F11955F25;
	Thu, 26 Mar 2026 10:48:02 +0000 (UTC)
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
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 14/26] netfs: Add a function to extract from an iter into a bvecq
Date: Thu, 26 Mar 2026 10:45:29 +0000
Message-ID: <20260326104544.509518-15-dhowells@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1Z7gTNK2UaWslVmlZeyki429ZCkBGjuG-kKklPu6mN0_1774522089
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
	TAGGED_FROM(0.00)[bounces-3027-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pc@manguebit.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,manguebit.org:email,infradead.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9791B333BD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function to extract a slice of data from an iterator of any type into
a bvec queue chain.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 123 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 ++
 2 files changed, 126 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index adca78747f23..e77fd39327c2 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,129 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract the pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @orig_len: The amount of iterator to copy
+ * @max_segs: Maximum number of contiguous segments
+ * @fpos: Starting file position to label the bvecq with
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * build bvec queue that refers to all of those bits.  This allows the original
+ * iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * On success, the amount of data in the bvec is returned, the original
+ * iterator will have been advanced by the amount extracted.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags)
+{
+	struct bvecq *bq_tail = NULL;
+	ssize_t ret = 0;
+	size_t extracted = 0, nr_pages;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, orig_len);
+
+	WARN_ON_ONCE(orig_len > orig->count);
+
+	nr_pages = iov_iter_npages(orig, max_segs ?: INT_MAX);
+	if (WARN_ON(nr_pages == 0) ||
+	    WARN_ON(nr_pages > max_segs))
+		nr_pages = max_segs;
+	max_segs = nr_pages;
+
+	do {
+		struct bvecq *bq;
+
+		if (WARN_ON(max_segs == 0))
+			break;
+
+		bq = bvecq_alloc_one(max_segs, GFP_NOFS);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		bq->free	= user_backed_iter(orig);
+		bq->unpin	= iov_iter_extract_will_pin(orig);
+		bq->prev	= bq_tail;
+		bq->fpos	= fpos + extracted;
+
+		if (bq_tail)
+			bq_tail->next = bq;
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (orig_len == 0)
+			break;
+
+		struct bio_vec *bv = bq->bv;
+		do {
+			struct page **pages;
+			ssize_t got;
+			size_t offset;
+			size_t space = bq->max_slots - bq->nr_slots;
+			size_t bv_size = array_size(bq->max_slots, sizeof(*bv));
+			size_t pg_size = array_size(space, sizeof(*pages));
+
+			/* Put the page list at the end of the bvec list
+			 * storage.  bvec elements are larger than page
+			 * pointers, so as long as we work 0->last, we should
+			 * be fine.
+			 */
+			pages = (void *)bv + bv_size - pg_size;
+
+			got = iov_iter_extract_pages(orig, &pages, orig_len,
+						     space, extraction_flags, &offset);
+			if (got < 0) {
+				ret = got;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zu, %zu\n",
+				       extracted, orig_len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (got > orig_len - extracted) {
+				pr_err("extract_pages rc=%zd more than %zu\n",
+				       got, orig_len);
+				goto out;
+			}
+
+			extracted += got;
+			orig_len -= got;
+
+			do {
+				size_t len = umin(got, PAGE_SIZE - offset);
+
+				BUG_ON(bq->nr_slots >= bq->max_slots);
+
+				bvec_set_page(&bq->bv[bq->nr_slots],
+					      *pages++, len, offset);
+				bq->nr_slots++;
+				got -= len;
+				offset = 0;
+			} while (got > 0);
+		} while (orig_len > 0 && !bvecq_is_full(bq));
+	} while (orig_len > 0 && max_segs > 0);
+
+out:
+	return extracted ?: ret;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5bc48aacf7f6..b4602f7b6431 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -445,6 +445,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


