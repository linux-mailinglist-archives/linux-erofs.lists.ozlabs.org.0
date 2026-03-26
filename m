Return-Path: <linux-erofs+bounces-3019-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GACE7EOxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3019-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:47:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D376333B74
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:47:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL7f0lp2z2yhG;
	Thu, 26 Mar 2026 21:47:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522030;
	cv=none; b=PByty1hMA+n5wr6QV5pLkkXeDLrzkyQIOq33EuXlQEXJEbyXb5VuRAC5DN1rCQKJ4ut0b95I18LqtTMNzDSeOl/AJ0Z2QMjBtCqc20WTdc725GnUqtuI75Xn4+m7MwwzB1m/kYkvOeipKYoj8pTn6mtci9jJS7V+cLqFDE7w059XXMafe8Z048kMjrC4EQuKsTd7E/bEFr+GY0UNdi9wSXFrb823U/crTbUJPSihANGZLm7yHecGbfLsWPRD1oy99J13Iip+ocv4mMlZYPTrNUqcF0aZdnpvAHaULY/d9soDF6NtQXiQEtD2/QDc8E8vDtT7a48dNKRN0lGvhbNHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522030; c=relaxed/relaxed;
	bh=/tdvGHLBae6cwxkiV/xURdgZGIZUXmsfYZzZeOFw5ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WFmy1Oig0dok8sbgeBhSmM2cSVDcOPPlogM6u/vN1LmgvnV9jv7HPUGFy2RhPKt1IyutzoIoZUjN6gPCEnZ2u0giFui0B8nPF44WVRNi8cSC69vgfzi0FNKGFY4nafTCoeFYcEOVSkOSVYDr67m043JiiPChMbASTPWer0YnJ7SxVrf3Gk7gjLwqQsqJtcn01WhwB6NJF7Kdq13jIHz5iYj+RMmLJf+tNr/aOt5y3+lb+5Wj0DcOamGnm2yTNZ1MuWXWmtlAEw1BsMklZ7rxDj3SdXZ6TAV6viLV1J2GnQ4aNh9RGrdaFb2MpjitamSLUDyRvqAR6o0sIEXCYW7sVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6BnXDkJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6BnXDkJ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6BnXDkJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z6BnXDkJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL7d1dWnz2yVB
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:47:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tdvGHLBae6cwxkiV/xURdgZGIZUXmsfYZzZeOFw5ZU=;
	b=Z6BnXDkJhQZTzwuc6PzR54+W6O4Zhhx7uDpw7mMlcS87CNDRuHmjyS2WTnhbx1lbF7ZbkV
	gMwBGYbGoZMiRU0T7HDDp3BKR/8No5nBPkA7S7KLSMr/JqWiqUtoMq9G8SVqK2GJiB7XEY
	/xoBvVFyxNta4KQTxDrWJvL76T8jsjQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tdvGHLBae6cwxkiV/xURdgZGIZUXmsfYZzZeOFw5ZU=;
	b=Z6BnXDkJhQZTzwuc6PzR54+W6O4Zhhx7uDpw7mMlcS87CNDRuHmjyS2WTnhbx1lbF7ZbkV
	gMwBGYbGoZMiRU0T7HDDp3BKR/8No5nBPkA7S7KLSMr/JqWiqUtoMq9G8SVqK2GJiB7XEY
	/xoBvVFyxNta4KQTxDrWJvL76T8jsjQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-6Q1OkKBWMNewwDpzF46dXQ-1; Thu,
 26 Mar 2026 06:47:02 -0400
X-MC-Unique: 6Q1OkKBWMNewwDpzF46dXQ-1
X-Mimecast-MFC-AGG-ID: 6Q1OkKBWMNewwDpzF46dXQ_1774522020
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1A2819560B4;
	Thu, 26 Mar 2026 10:46:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F741800673;
	Thu, 26 Mar 2026 10:46:53 +0000 (UTC)
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
Subject: [PATCH 06/26] netfs: Fix the handling of stream->front by removing it
Date: Thu, 26 Mar 2026 10:45:21 +0000
Message-ID: <20260326104544.509518-7-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Z2G7enY475whsThX_6d6ARXOtqjyr328LZ8vPVZjKTQ_1774522020
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3019-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,linux.dev:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6D376333B74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netfs_io_stream::front member is meant to point to the subrequest
currently being collected on a stream, but it isn't actually used this way
by direct write (which mostly ignores it).  However, there's a tracepoint
which looks at it.  Further, stream->front is actually redundant with
stream->subrequests.next.

Fix the potential problem in the direct code by just removing the member
and using stream->subrequests.next instead, thereby also simplifying the
code.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Reported-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     | 3 +--
 fs/netfs/direct_read.c       | 3 +--
 fs/netfs/direct_write.c      | 1 -
 fs/netfs/read_collect.c      | 4 ++--
 fs/netfs/read_single.c       | 1 -
 fs/netfs/write_collect.c     | 4 ++--
 fs/netfs/write_issue.c       | 3 +--
 include/linux/netfs.h        | 1 -
 include/trace/events/netfs.h | 8 ++++----
 9 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 88a0d801525f..a8c0d86118c5 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -171,9 +171,8 @@ static void netfs_queue_read(struct netfs_io_request *rreq,
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front = subreq;
 		if (!stream->active) {
-			stream->collected_to = stream->front->start;
+			stream->collected_to = subreq->start;
 			/* Store list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a498ee8d6674..f72e6da88cca 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -71,9 +71,8 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &stream->subrequests);
 		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-			stream->front = subreq;
 			if (!stream->active) {
-				stream->collected_to = stream->front->start;
+				stream->collected_to = subreq->start;
 				/* Store list pointers before active flag */
 				smp_store_release(&stream->active, true);
 			}
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 4d9760e36c11..f9ab69de3e29 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -111,7 +111,6 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq = stream->construct;
 			stream->construct = NULL;
-			stream->front = NULL;
 		}
 
 		/* Check if (re-)preparation failed. */
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 137f0e28a44c..e5f6665b3341 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -205,7 +205,8 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 	 * in progress.  The issuer thread may be adding stuff to the tail
 	 * whilst we're doing this.
 	 */
-	front = READ_ONCE(stream->front);
+	front = list_first_entry_or_null(&stream->subrequests,
+					 struct netfs_io_subrequest, rreq_link);
 	while (front) {
 		size_t transferred;
 
@@ -301,7 +302,6 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		list_del_init(&front->rreq_link);
 		front = list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
-		stream->front = front;
 		spin_unlock(&rreq->lock);
 		netfs_put_subrequest(remove,
 				     notes & ABANDON_SREQ ?
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8e6264f62a8f..d0e23bc42445 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -107,7 +107,6 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	stream->front = subreq;
 	/* Store list pointers before active flag */
 	smp_store_release(&stream->active, true);
 	spin_unlock(&rreq->lock);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 83eb3dc1adf8..b194447f4b11 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -228,7 +228,8 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		if (!smp_load_acquire(&stream->active))
 			continue;
 
-		front = stream->front;
+		front = list_first_entry_or_null(&stream->subrequests,
+						 struct netfs_io_subrequest, rreq_link);
 		while (front) {
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
@@ -279,7 +280,6 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			list_del_init(&front->rreq_link);
 			front = list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
-			stream->front = front;
 			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove,
 					     notes & SAW_FAILURE ?
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 437268f65640..2db688f94125 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -206,9 +206,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front = subreq;
 		if (!stream->active) {
-			stream->collected_to = stream->front->start;
+			stream->collected_to = subreq->start;
 			/* Write list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 72ee7d210a74..ba17ac5bf356 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -140,7 +140,6 @@ struct netfs_io_stream {
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */
 	struct list_head	subrequests;	/* Contributory I/O operations */
-	struct netfs_io_subrequest *front;	/* Op being collected */
 	unsigned long long	collected_to;	/* Position we've collected results to */
 	size_t			transferred;	/* The amount transferred from this stream */
 	unsigned short		error;		/* Aggregate error for the stream */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2d366be46a1c..cbe28211106c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -740,19 +740,19 @@ TRACE_EVENT(netfs_collect_stream,
 		    __field(unsigned int,	wreq)
 		    __field(unsigned char,	stream)
 		    __field(unsigned long long,	collected_to)
-		    __field(unsigned long long,	front)
+		    __field(unsigned long long,	issued_to)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->wreq	= wreq->debug_id;
 		    __entry->stream	= stream->stream_nr;
 		    __entry->collected_to = stream->collected_to;
-		    __entry->front	= stream->front ? stream->front->start : UINT_MAX;
+		    __entry->issued_to	= atomic64_read(&wreq->issued_to);
 			   ),
 
-	    TP_printk("R=%08x[%x:] cto=%llx frn=%llx",
+	    TP_printk("R=%08x[%x:] cto=%llx ito=%llx",
 		      __entry->wreq, __entry->stream,
-		      __entry->collected_to, __entry->front)
+		      __entry->collected_to, __entry->issued_to)
 	    );
 
 TRACE_EVENT(netfs_folioq,


