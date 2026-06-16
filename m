Return-Path: <linux-erofs+bounces-3614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hdPaJTshMWrBcAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 12:11:07 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EC68DFEA
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 12:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gybL3Zr8;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HRrDTki7;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3614-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3614-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfjS83dVMz3brH;
	Tue, 16 Jun 2026 20:11:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781604664;
	cv=none; b=AUTZTJUwKSAy0z6KydbS3tL+TM4nSWgnvkkbrDOnKTK3OBx3zbKCCguGpsVmkhyZsQ7Zg6iWyg3dV28Fg8Nnod11Ix6f7Q7iynWyOFsUcAV09YyOx8+PEb+n7sU4uAY/JZGzSCMTklMUk1FdrtTTu+K24PK8aaySHM+rysj/lbpiZLDhtvqyJp0HQowYRH0QFTdWeJbwXZqyTUNfTkLtBmtYUN7lWvhMLfp3mB0czzFje1183U6X9+4fFuLfQtiayhe5gB8twuD5RU1TeLxKTsh5bsc+jDgGwrtssWMPksyc5yMGyk4e7/PXqxjc31C9Nlvhbdqz8SFrYPMs5yuH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781604664; c=relaxed/relaxed;
	bh=QLFUaRD00urZn9aYFgeAIOTJNeoly0OHfeeRUozLVtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=F/QW7xNX9yLhhgnUNMy1AEc49rQZOoIZTrGAEjz9OtSyW4+DNpVSZohqfxM9OEUKa5ac0oqO0/veqVWEt2jYVWvhxXcqCRmm2PMUqxEWnWWTmoMRKl6gZSz7QlkQy1lzaUsZLEG/eBCISUG3L5D1HBpL5WmXHcG9obnbetQN6qfNG850fsEidGgrengRBVYSs5+izAg/g0uZH3drMZhzNfAMHBZT8xKS7fKfHmbnH763iZrQ9XiM9jAW9evkCbW+7qhDAXhZPc3lW1UdA2QCGYUDXxjke9UuJerGiQTb8qnZSmJt3+LpVgCLd4I/8TxJe7xILrTJbBugwovLl7BtKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gybL3Zr8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HRrDTki7; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfjS73wndz3bqh
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2026 20:11:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLFUaRD00urZn9aYFgeAIOTJNeoly0OHfeeRUozLVtA=;
	b=gybL3Zr8z0sL6wLGefzip1/T5x61f2fo/vBj1pFolU7lN47aJjSAPmuniQkdx2hLdedkP3
	2oHEvNsGmweiQgRAaFQyIS7ksubv6xNXuSNTG7hzkho+ZzamQl1TzatMg5V6ved9DQMILO
	kXCbH81dj1In5EWzK6PNSyaOv4wNpzA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLFUaRD00urZn9aYFgeAIOTJNeoly0OHfeeRUozLVtA=;
	b=HRrDTki7sVFUxYVyo1cSvoAOKTe4mKltEE1khiBdSCzon89IegxfH6EtIxB+lc0PeqfgbI
	q2zDJfkgFUJ+BMhI2QSylKOg45zZQUCp4S3xs5ZA9xZaWCwegzheUPz6hTLiyfl9VFP7VS
	gCc4mYy2JOcA/dls02hhoixaojaA19s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-wQZX4sB-PzCGd6G_3UcEEA-1; Tue,
 16 Jun 2026 06:10:56 -0400
X-MC-Unique: wQZX4sB-PzCGd6G_3UcEEA-1
X-Mimecast-MFC-AGG-ID: wQZX4sB-PzCGd6G_3UcEEA_1781604653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DF2219560BB;
	Tue, 16 Jun 2026 10:10:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62958180058F;
	Tue, 16 Jun 2026 10:10:47 +0000 (UTC)
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
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/30] netfs: Add a function to extract from an iter into a bvecq
Date: Tue, 16 Jun 2026 11:08:06 +0100
Message-ID: <20260616100821.2062304-18-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: I1uma6HkQYDTd4rW991OAgHGudlVqiGBsXjeIyasAiU_1781604653
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3614-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,infradead.org:email,manguebit.org:email,linux.dev:email,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF0EC68DFEA

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
 fs/netfs/iterator.c   | 137 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 +
 2 files changed, 140 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index b375567e0520..6f944eb4e281 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,143 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract virtually contiguous pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @max_len: Maximum number of bytes to extract
+ * @max_pages: Maximum number of pages to extract
+ * @fpos: Starting file position to label the bvecq with
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ *
+ * Extract virtually contiguous page fragments from the source iterator up to
+ * the given maxima and build bvec queue that refers to all of those bits.
+ * This allows the original iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * On success or partial success, the amount of data in the bvec is returned,
+ * the original iterator will have been advanced by the amount extracted.
+ *
+ * If an error occurs and no pages are extracted, an error will be returned and
+ * any allocated bvecq will be freed.  The allocated bvecq will also be freed
+ * if no pages are extracted, but no error is recorded.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags)
+{
+	struct bvecq *bq_tail = NULL;
+	ssize_t ret = 0;
+	size_t extracted = 0;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, max_len);
+
+	*_bvecq_head = NULL;
+	if (max_len > orig->count)
+		max_len = orig->count;
+	if (WARN_ON_ONCE(!max_len || !max_pages))
+		return 0;
+
+	max_pages = iov_iter_npages(orig, max_pages);
+	if (!max_pages)
+		return 0;
+
+	do {
+		struct bvecq *bq;
+
+		bq = bvecq_alloc_one(max_pages, GFP_NOFS);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		if (user_backed_iter(orig))
+			bq->mem_type = iov_iter_extract_will_pin(orig) ?
+				BVECQ_MEM_GUP : BVECQ_MEM_PAGECACHE;
+		bq->prev	= bq_tail;
+		bq->fpos	= fpos + extracted;
+
+		if (bq_tail)
+			bq_tail->next = bq;
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (max_len == 0)
+			break;
+
+		struct bio_vec *bv = bq->bv;
+		unsigned int slot = 0;
+		do {
+			struct page **pages;
+			ssize_t got;
+			size_t offset;
+			size_t space = bq->max_slots - slot;
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
+			got = iov_iter_extract_pages(orig, &pages, max_len,
+						     min(space, max_pages),
+						     extraction_flags, &offset);
+			if (got < 0) {
+				ret = got;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zu, %zu\n",
+				       extracted, max_len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (WARN(got > max_len,
+				 "%s: extract_pages overrun %zd > %zu bytes\n",
+				 __func__, got, max_len)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			extracted += got;
+			max_len -= got;
+
+			do {
+				size_t len = umin(got, PAGE_SIZE - offset);
+
+				BUG_ON(slot >= bq->max_slots);
+
+				bvec_set_page(&bq->bv[slot], *pages++, len, offset);
+				slot++;
+				max_pages--;
+				got -= len;
+				offset = 0;
+			} while (got > 0);
+
+			bvecq_filled_to(bq, slot);
+		} while (max_len > 0 && !bvecq_is_full(bq));
+
+	} while (max_len > 0 && max_pages > 0);
+
+out:
+	if (extracted)
+		return extracted;
+	bvecq_put(*_bvecq_head);
+	*_bvecq_head = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a5976afa1a89..7de2b34b000e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -462,6 +462,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


