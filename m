Return-Path: <linux-erofs+bounces-3627-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VrGuM6EhMWoCcQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3627-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 12:12:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4B68E0B3
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 12:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hvWLRBxu;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c4RGmgro;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3627-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3627-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfjV702PTz3c2G;
	Tue, 16 Jun 2026 20:12:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781604766;
	cv=none; b=Ibba47LUH6y1IE43evAeq8sdWJzdPkulE2fpOnUm8QBPp9PL7iKAKnQOfJrw76lo8chIrSzO4RffhpTjhqKR4c8Vpkg7qcGFJ9Q3Dz7FfzaN8iXopOGYHHOQsRHMoYSWnlhCobqeVeFoVw5EOzBSKGE7d64kPbZH2DaNh6ik45TlT7xM72FEJdyvtYTg5LJfMo1RXHHrIsBW5P+TX1B5AL/TAkXDT+S8IvCYqDFo/PhHqERpUx+DHxdSu665RgS8QxjfAdbo9yUtr6tnCHR3KBezrI/KmeUhGVKc2lg8rjI9UsnXSofDG5bNbbunyJvGr8QjsP0HsZuM136v6mNHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781604766; c=relaxed/relaxed;
	bh=G0n6jjl7CQg3ycUEFyobHO2Y/1gqjiW+QmR0BwEEEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OhSo/egrba50Pkp7Gdsu93dFf0HMGspNeL7OblvX0C2GpZnICfN7MQ2wt/RRcItEcc7ONjoB8BC44Tk1dDZiaX1PuJpGP2XFslSRYJ2d/5QgyeQ2PjIeOGpvGzxDRi+gLvyunUQ+NNg/G2BgH9s8s9D+AsUU2ka9Pg23Mpm31ZrwvyeZGrZDT3vI35x+rh+agu+vQ4LA9ozV6lbTOVCI2wswFZvCRAYKmFVhfVmYi9ZOdFQVKWHPfiqnRQ4xvRXIkFVjfB7H04ZtIE4j0iQEncHeBXdunpqd5OX2wPCvA3vM00avll119HkUbpyb2gOgyOEx7v6KXHFFJYYkBNI1Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hvWLRBxu; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c4RGmgro; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfjV56szgz3brH
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2026 20:12:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0n6jjl7CQg3ycUEFyobHO2Y/1gqjiW+QmR0BwEEEt4=;
	b=hvWLRBxuez3q1GbBFCmoeVzkQCZT+cIPvOhgqz9do7VaVm+ykWmPtEmtui8a7lqRPLkBcl
	xYr+u+KhsF0v2arHBn4aOqJf8LzfC13wmfMDlTT7/qlktnoKp3sMwKUOju4s3bGRU21i5+
	E/P43TYgYrNMnE7jc/l958psQ0qBhz0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0n6jjl7CQg3ycUEFyobHO2Y/1gqjiW+QmR0BwEEEt4=;
	b=c4RGmgrodPBs71KXU5daoi68nFv9oqKIAshzWk1I/XEr/yX80AVCqEOgJfmzGTJD7YdJva
	bno4EzIJhPSZEYyL1YmtkQAD44Cl8T17pK3GAKoYuZ94P9058tbuko+c6dfFNV3Njs+Zlh
	DjU9qBQcGNVOU94zS3RPzxy434yDqp4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-NzcYndrqM-WxUWpiP4tobg-1; Tue,
 16 Jun 2026 06:12:39 -0400
X-MC-Unique: NzcYndrqM-WxUWpiP4tobg-1
X-Mimecast-MFC-AGG-ID: NzcYndrqM-WxUWpiP4tobg_1781604756
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBD401956055;
	Tue, 16 Jun 2026 10:12:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDB891771;
	Tue, 16 Jun 2026 10:12:30 +0000 (UTC)
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
Subject: [PATCH v4 30/30] CHANGES
Date: Tue, 16 Jun 2026 11:08:19 +0100
Message-ID: <20260616100821.2062304-31-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: h2HPVg8dUR7l4cIl-yzJI4dPqPKsewO1720NP_LBpA4_1781604756
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
	TAGGED_FROM(0.00)[bounces-3627-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33A4B68E0B3

---
 fs/netfs/iterator.c    | 22 ++++++++++++++--------
 fs/netfs/read_retry.c  | 12 +++++++++---
 fs/netfs/write_issue.c | 24 ++++++++++++++++++++++--
 fs/netfs/write_retry.c | 23 ++++++++++++++---------
 fs/nfs/fscache.c       |  3 ++-
 fs/smb/client/file.c   |  2 +-
 6 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index d464e1784b8a..5e8e816eeff3 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -33,8 +33,8 @@
  * the original iterator will have been advanced by the amount extracted.
  *
  * If an error occurs and no pages are extracted, an error will be returned and
- * any allocated bvecq will be freed.  The allocated bvecq will also be freed
- * if no pages are extracted, but no error is recorded.
+ * any allocated bvecq will be freed.  If there is no data to be extracted (or
+ * @max_len or @max_pages are zero), a single empty bvecq will be returned.
  *
  * The bvecq segments are marked with indications on how to get clean up the
  * extracted fragments.
@@ -43,7 +43,7 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags)
 {
-	struct bvecq *bq_tail = NULL;
+	struct bvecq *bq_tail = NULL, *bq;
 	ssize_t ret = 0;
 	size_t extracted = 0;
 
@@ -53,15 +53,13 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
 	if (max_len > orig->count)
 		max_len = orig->count;
 	if (WARN_ON_ONCE(!max_len || !max_pages))
-		return 0;
+		goto alloc_empty;
 
 	max_pages = iov_iter_npages(orig, max_pages);
 	if (!max_pages)
-		return 0;
+		goto alloc_empty;
 
 	do {
-		struct bvecq *bq;
-
 		bq = bvecq_alloc_one(max_pages, GFP_NOFS);
 		if (!bq) {
 			ret = -ENOMEM;
@@ -142,10 +140,18 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
 	} while (max_len > 0 && max_pages > 0);
 
 out:
-	if (extracted)
+	if (extracted || ret == 0)
 		return extracted;
 	bvecq_put(*_bvecq_head);
 	*_bvecq_head = NULL;
 	return ret;
+
+alloc_empty:
+	bq = bvecq_alloc_one(1, GFP_NOFS);
+	if (!bq)
+		return -ENOMEM;
+	*_bvecq_head = bq;
+	return 0;
+
 }
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index a5cd6e20cae1..0f8ff53fe703 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -79,11 +79,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	if (rreq->netfs_ops->retry_request)
 		rreq->netfs_ops->retry_request(rreq, NULL);
 
+	/* Read pointer to subreq before reading subreq state. */
+	next = smp_load_acquire(&stream->subrequests.next);
+
 	/* Renegotiate all the download requests and flip any failed cache
 	 * reads over to being download requests and negotiate those also.
 	 */
-	next = stream->subrequests.next;
-
 	do {
 		struct netfs_io_subrequest *from, *to, *tmp;
 		unsigned long long start;
@@ -110,7 +111,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			goto abandon;
 		}
 
-		list_for_each_continue(next, &stream->subrequests) {
+		for (;;) {
+			/* Read pointer to subreq before reading subreq state. */
+			next = smp_load_acquire(&next->next);
+			if (next == &stream->subrequests)
+				break;
+
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start != start + len ||
 			    subreq->transferred > 0 ||
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index e2e35d619119..37e5b5ee1cea 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -722,6 +722,20 @@ static int netfs_queue_wb_folio(struct netfs_io_request *wreq,
 	goto out;
 }
 
+static void writeback_iter_cancel(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct folio *folio, int *error,
+				  bool unlocked)
+{
+	do {
+		if (!unlocked) {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			unlocked = false;
+		}
+	} while ((folio = writeback_iter(mapping, wbc, folio, error)));
+}
+
 /*
  * Write some of the pending data back to the server
  */
@@ -776,11 +790,15 @@ int netfs_writepages(struct address_space *mapping,
 
 		params.notes &= NOTES__KEEP_MASK;
 		error = netfs_queue_wb_folio(wreq, wbc, folio, &params);
-		if (error < 0)
+		if (error < 0) {
+			writeback_iter_cancel(mapping, wbc, folio, &error, false);
 			break;
+		}
 		error = netfs_issue_streams(wreq, &params);
-		if (error < 0)
+		if (error < 0) {
+			writeback_iter_cancel(mapping, wbc, folio, &error, true);
 			break;
+		}
 
 		bvecq_pos_step(&params.dispatch_cursor);
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
@@ -924,6 +942,7 @@ int netfs_advance_writethrough(struct netfs_writethrough *wthru,
 	folio_put(wthru->in_progress);
 	wthru->in_progress = NULL;
 	wreq->submitted = wreq->len;
+	bvecq_pos_step(&wthru->params.dispatch_cursor);
 	return ret;
 }
 
@@ -945,6 +964,7 @@ ssize_t netfs_end_writethrough(struct netfs_writethrough *wthru,
 		ret = netfs_queue_wb_folio(wreq, wbc, folio, &wthru->params);
 		if (ret == 0)
 			ret = netfs_issue_streams(wreq, &wthru->params);
+		bvecq_pos_step(&wthru->params.dispatch_cursor);
 		folio_put(folio);
 		wthru->in_progress = NULL;
 		wreq->submitted = wreq->len;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index e7955cc707e0..d9cc49f21346 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -23,7 +23,6 @@ int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
 				     unsigned int max_segs)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
-	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
 	size_t len;
 
 	bvecq_pos_set(&subreq->dispatch_pos, &wreq->retry_cursor);
@@ -35,9 +34,9 @@ int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
 		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
 	}
 
-	stream->issue_from += len;
-	stream->buffered   -= len;
-	if (stream->buffered == 0)
+	wreq->retry_start += len;
+	wreq->retry_buffered   -= len;
+	if (wreq->retry_buffered == 0)
 		bvecq_pos_unset(&wreq->retry_cursor);
 	return 0;
 }
@@ -63,7 +62,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 	if (unlikely(stream->failed))
 		return;
 
-	next = stream->subrequests.next;
+	/* Read pointer to subreq before reading subreq state. */
+	next = smp_load_acquire(&stream->subrequests.next);
 
 	do {
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
@@ -84,7 +84,12 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
 			goto out;
 
-		list_for_each_continue(next, &stream->subrequests) {
+		for (;;) {
+			/* Read pointer to subreq before reading subreq state. */
+			next = smp_load_acquire(&next->next);
+			if (next == &stream->subrequests)
+				break;
+
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start != start + len ||
 			    subreq->transferred > 0 ||
@@ -135,7 +140,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* If we managed to use fewer subreqs, we can discard the
 		 * excess; if we used the same number, then we're done.
 		 */
-		if (!len) {
+		if (!wreq->retry_buffered) {
 			if (subreq == to)
 				continue;
 			list_for_each_entry_safe_from(subreq, tmp,
@@ -158,7 +163,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq = netfs_alloc_subrequest(wreq);
 			subreq->source		= to->source;
 			subreq->start		= start;
-			subreq->len		= len;
+			subreq->len		= wreq->retry_buffered;
 			subreq->stream_nr	= to->stream_nr;
 			subreq->retry_count	= 1;
 
@@ -188,7 +193,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 			stream->issue_write(subreq);
-		} while (len);
+		} while (wreq->retry_buffered > 0);
 
 	} while (!list_is_head(next, &stream->subrequests));
 
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cf750faaec6a..f39a351c566d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -324,7 +324,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 
 	netfs = nfs_netfs_alloc(sreq);
 	if (!netfs) {
-		sreq->error = err;
+		sreq->error = -ENOMEM;
 		goto term;
 	}
 
@@ -343,6 +343,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
+	return;
 term:
 	return netfs_read_subreq_terminated(sreq);
 }
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index d3a9041786ac..b770c349137a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -222,7 +222,7 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 			rc = cifs_reopen_file(req->cfile, true);
 		} while (rc == -EAGAIN);
 		if (rc)
-			goto failed;
+			goto fail_with_credits;
 	}
 
 	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&


