Return-Path: <linux-erofs+bounces-3032-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hs+KiIPxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3032-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D24333C05
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL9q5ch7z2ydN;
	Thu, 26 Mar 2026 21:49:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522143;
	cv=none; b=IUGENK/TYJu/q/z+PPqYRQrUkMfCl/bMIbmVb57h4q6TNY34ePnmroteWzgRDq0DTNaq85QYVM7/5PUi0qU6FZUDHWyRRA28nbBFzLUpR1Lf7xxoARkUjsCaL+rA6BOYgyFaFc8KRFV2VnR+dzjc5Prxb8xioGv39dukAERZoenJ+tLByhbTMuL3FDcpyt+8enGiGOc7iKjlrIf3flV4lL5moa/SueqZUMWsd0dXoHfEuIuifqgL451qNM3KGlU3Jqwv8fLM0zAnP+iS6dfic2q7agPa3kY39vKSlcUR9v2Azd8VvcrGftxfDiSSbd9dzL1NGmOQPFJFVwe9+RE2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522143; c=relaxed/relaxed;
	bh=An9ppvJd90yS+MIu3WT/4ujzY282508ExyNV62oMYCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CbwBKRb/eYTNgFHH/3w1OI7RPzsRIUnofweleZzRNBrItafX3USDBGOg6CxisuKISpiQRPFKXfw0cvabTlXlcKjHihts7tk/i6BEpU0sGHgn3zFCAmJU8F7sJMuX0ZxuirMmU6TE8PtOJFHDp+raNqt3H6b02lB4WVQwj+TlX9QWnQ3+9Dwp3DK8Pjo08Otxc1JouQMKYD2PE+WHiNDPBQQbbdyYYyNmhJIaoAFPlCVtTd72hPnmiQdOm3FtlolvQ4MOYUzMZrbbpH0YZaqjCnu+6VikIallU3XNHiXBtxbbKqWhgjnk7XGlH4qiaOVMrSPJd9DwEG/aDT6qLbaY3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLDqb/KY; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLDqb/KY; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLDqb/KY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cLDqb/KY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL9p6pG3z2xN8
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:49:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An9ppvJd90yS+MIu3WT/4ujzY282508ExyNV62oMYCI=;
	b=cLDqb/KYpAnIosxEcpeq5CM9QPG3FhQpY43CdBpaQregtRfmjg83gU7BvyRbZSkbYKPgQz
	ckATz+hwysnkvKiwq+ETmlCAd8nj0+I5NYX5dP4FyQcc1EiXbsICPi4baRmzmfPIyG9ygD
	PmyldwiOmVbOee7PdskDfXY1O11bxBI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An9ppvJd90yS+MIu3WT/4ujzY282508ExyNV62oMYCI=;
	b=cLDqb/KYpAnIosxEcpeq5CM9QPG3FhQpY43CdBpaQregtRfmjg83gU7BvyRbZSkbYKPgQz
	ckATz+hwysnkvKiwq+ETmlCAd8nj0+I5NYX5dP4FyQcc1EiXbsICPi4baRmzmfPIyG9ygD
	PmyldwiOmVbOee7PdskDfXY1O11bxBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-NVW6woi9PzuY_nXMvCratw-1; Thu,
 26 Mar 2026 06:48:56 -0400
X-MC-Unique: NVW6woi9PzuY_nXMvCratw-1
X-Mimecast-MFC-AGG-ID: NVW6woi9PzuY_nXMvCratw_1774522133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31466195608B;
	Thu, 26 Mar 2026 10:48:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F81F3000223;
	Thu, 26 Mar 2026 10:48:46 +0000 (UTC)
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
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 19/26] cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_rdma()
Date: Thu, 26 Mar 2026 10:45:34 +0000
Message-ID: <20260326104544.509518-20-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Qq5fcAgfFv_wVrb66LrmSePNcxKxLGkKENrnFJ_h6n0_1774522133
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
	TAGGED_FROM(0.00)[bounces-3032-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org,microsoft.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pc@manguebit.org,m:sprasad@microsoft.com,m:tom@talpey.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,talpey.com:email,samba.org:email,manguebit.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 18D24333C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netfslib now only presents an bvecq queue and an associated ITER_BVECQ
iterator to the filesystem, so it isn't going to see ITER_KVEC, ITER_BVEC
or ITER_FOLIOQ iterators.  So remove that code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 165 --------------------------------------
 1 file changed, 165 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index f8a6be83db98..d9e026d5e9f9 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -3142,162 +3142,6 @@ static bool smb_set_sge(struct smb_extract_to_rdma *rdma,
 	return true;
 }
 
-/*
- * Extract page fragments from a BVEC-class iterator and add them to an RDMA
- * element list.  The pages are not pinned.
- */
-static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
-					struct smb_extract_to_rdma *rdma,
-					ssize_t maxsize)
-{
-	const struct bio_vec *bv = iter->bvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	ssize_t ret = 0;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		size_t off, len;
-
-		len = bv[i].bv_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		len = min_t(size_t, maxsize, len - start);
-		off = bv[i].bv_offset + start;
-
-		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
-			return -EIO;
-
-		ret += len;
-		maxsize -= len;
-		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
-}
-
-/*
- * Extract fragments from a KVEC-class iterator and add them to an RDMA list.
- * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
- * The pages are not pinned.
- */
-static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
-					struct smb_extract_to_rdma *rdma,
-					ssize_t maxsize)
-{
-	const struct kvec *kv = iter->kvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	ssize_t ret = 0;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		struct page *page;
-		unsigned long kaddr;
-		size_t off, len, seg;
-
-		len = kv[i].iov_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		kaddr = (unsigned long)kv[i].iov_base + start;
-		off = kaddr & ~PAGE_MASK;
-		len = min_t(size_t, maxsize, len - start);
-		kaddr &= PAGE_MASK;
-
-		maxsize -= len;
-		do {
-			seg = min_t(size_t, len, PAGE_SIZE - off);
-
-			if (is_vmalloc_or_module_addr((void *)kaddr))
-				page = vmalloc_to_page((void *)kaddr);
-			else
-				page = virt_to_page((void *)kaddr);
-
-			if (!smb_set_sge(rdma, page, off, seg))
-				return -EIO;
-
-			ret += seg;
-			len -= seg;
-			kaddr += PAGE_SIZE;
-			off = 0;
-		} while (len > 0 && rdma->nr_sge < rdma->max_sge);
-
-		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
-}
-
-/*
- * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
- * list.  The folios are not pinned.
- */
-static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
-					  struct smb_extract_to_rdma *rdma,
-					  ssize_t maxsize)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	unsigned int slot = iter->folioq_slot;
-	ssize_t ret = 0;
-	size_t offset = iter->iov_offset;
-
-	BUG_ON(!folioq);
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		if (WARN_ON_ONCE(!folioq))
-			return -EIO;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (offset < fsize) {
-			size_t part = umin(maxsize, fsize - offset);
-
-			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
-				return -EIO;
-
-			offset += part;
-			ret += part;
-			maxsize -= part;
-		}
-
-		if (offset >= fsize) {
-			offset = 0;
-			slot++;
-			if (slot >= folioq_nr_slots(folioq)) {
-				if (!folioq->next) {
-					WARN_ON_ONCE(ret < iter->count);
-					break;
-				}
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
-
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	iter->iov_offset = offset;
-	iter->count -= ret;
-	return ret;
-}
-
 /*
  * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
  * list.  The folios are not pinned.
@@ -3373,15 +3217,6 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	int before = rdma->nr_sge;
 
 	switch (iov_iter_type(iter)) {
-	case ITER_BVEC:
-		ret = smb_extract_bvec_to_rdma(iter, rdma, len);
-		break;
-	case ITER_KVEC:
-		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
-		break;
-	case ITER_FOLIOQ:
-		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
-		break;
 	case ITER_BVECQ:
 		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
 		break;


