Return-Path: <linux-erofs+bounces-3039-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BhKCVUPxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3039-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C28333C37
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLBm5B6Xz2ygp;
	Thu, 26 Mar 2026 21:49:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522192;
	cv=none; b=N7GO1JjDy/CrR+faqsi4PgqgH/IA91z3Cv13LTQXATYi4k+f1ejRGEu9D8bSPr/Hb73zW7QtSFs8iJUUfGPxFYyMzMNrXZgijYs1yymb+MEtdi4bMqtRWf49BgjUkhi/LDSoXkpEJ2XFsPWscr6bk1QrOzVLCkF79KBsImDzZ2VWMBiPhU0slKyaq/tgftcT7dfCDxp7jtiI5gFWeLWlK0EnwnWnxEcqbudZNY01lWjPWYic/UvK7w8oE55FdegnIy1Q8xTI5o+kBYWNdUlUOSy/UMX49GngND03ADE4aOGywBDC7udLk4PHluCwMvKSD4bOHkY69BK1TY5QGkaYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522192; c=relaxed/relaxed;
	bh=3dua10S0xY5PQQMwCx5ef5lVGVsxRJy1bcsfs1R39zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T6PpbusF37hk1UrWwypzk4JLrO7U4ykpV5phaHDfIZeVmxu0lON9aGyOw5yH6k2AEQshouf2HWuxTserBsgxqKBN/WjNxDV5kDsEu7RjkQ3EALEe5767JXpOGQlJNKb5G99sPeLHZZ5wQ0lHeIKhbKS+WRAXCBpmptQTLiYSBezYheip+7RuLUH88vGUGT5duLx+L2YrBTu2iZ1jxetj+MrVaMHiorWSqDWyqHsA4wugiZ8XCtfGKD+KHMkEafoyYenRQm8vHaRpys9PROOlCNeQsIh34FfRqy3A4WmFT42F7c8xf1XeHhcGet6b/UovQnbPRp9u5yZu2ECPMqyUaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcxTPF0u; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcxTPF0u; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcxTPF0u;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcxTPF0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhLBl6b0Dz2xN8
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:49:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dua10S0xY5PQQMwCx5ef5lVGVsxRJy1bcsfs1R39zY=;
	b=TcxTPF0uZcmERAI9BmKcGgYoRW0pregXwmfjWaYOsUkOSUjjBk6Dj+Nf1NbrfU4Eu3+NfW
	pKZlkAWUJfimMgG4ewu3t02M5VjlEJST6/zxFSSDo2gX1c1TetHXQfUgr/FSG+l3cqaoec
	7gWtPhKscRDJbqFWkUyi6LuwBMBIeS8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dua10S0xY5PQQMwCx5ef5lVGVsxRJy1bcsfs1R39zY=;
	b=TcxTPF0uZcmERAI9BmKcGgYoRW0pregXwmfjWaYOsUkOSUjjBk6Dj+Nf1NbrfU4Eu3+NfW
	pKZlkAWUJfimMgG4ewu3t02M5VjlEJST6/zxFSSDo2gX1c1TetHXQfUgr/FSG+l3cqaoec
	7gWtPhKscRDJbqFWkUyi6LuwBMBIeS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-R25vA0AZMP6MQs6h0YVvDg-1; Thu,
 26 Mar 2026 06:49:45 -0400
X-MC-Unique: R25vA0AZMP6MQs6h0YVvDg-1
X-Mimecast-MFC-AGG-ID: R25vA0AZMP6MQs6h0YVvDg_1774522182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D85219560A6;
	Thu, 26 Mar 2026 10:49:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 022BA1800576;
	Thu, 26 Mar 2026 10:49:35 +0000 (UTC)
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
Subject: [PATCH 25/26] netfs: Limit the the minimum trigger for progress reporting
Date: Thu, 26 Mar 2026 10:45:40 +0000
Message-ID: <20260326104544.509518-26-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: QGJgctD2wnPvx7b700e_gxqckEYaTcOstV911SolbcM_1774522182
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
	TAGGED_FROM(0.00)[bounces-3039-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 32C28333C37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For really big read RPC ops that span multiple folios, netfslib allows the
filesystem to give progress notifications to wake up the collector thread
to do a collection of folios that have now been fetched, even if the RPC is
still ongoing, thereby allowing the application to make progress.

The trigger for this is that at least one folio has been downloaded since
the clean point.  If, however, the folios are small, this means the
collector thread is constantly being woken up - which has a negative
performance impact on the system.

Set a minimum trigger of 256KiB or the size of the folio at the front of
the queue, whichever is larger.

Also, fix the base to be the stream collection point, not the point at
which the collector has cleaned up to (which is currently 0 until something
has been collected).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index bacf047029fa..6d49f9a6b1f0 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -494,15 +494,15 @@ void netfs_read_collection_worker(struct work_struct *work)
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	size_t fsize = PAGE_SIZE << rreq->front_folio_order;
+	struct netfs_io_stream *stream = &rreq->io_streams[subreq->stream_nr];
+	size_t fsize = umax(PAGE_SIZE << rreq->front_folio_order, 256 * 1024);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * getting a ref to it if we were the ones to do so.
 	 */
-	if (subreq->start + subreq->transferred > rreq->cleaned_to + fsize &&
+	if (subreq->start + subreq->transferred >= stream->collected_to + fsize &&
 	    (rreq->origin == NETFS_READAHEAD ||
 	     rreq->origin == NETFS_READPAGE ||
 	     rreq->origin == NETFS_READ_FOR_WRITE) &&


