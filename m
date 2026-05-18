Return-Path: <linux-erofs+bounces-3437-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH36F4iTC2ohJgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3437-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:32:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CA574895
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:32:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKCH94T4Qz2xR3;
	Tue, 19 May 2026 08:32:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779143557;
	cv=none; b=C7/q7foKvPnqgkRw41TXBlBnP28/zqB+Mts7cJIBlUI5uVwtGFKDA3WY8afIr3by0sJC6bot6FYr2YIEGbPhInowHQJiRtwmo1PthvjZulCtGlKrZL397CUewVj6w63HSlO3tOsQK0oPW8u4/z+Nwx9GjHH4da+Hehrge8eaXi+wj1PE4/76y7m+zmn6hwakl8I4Eou3bzxCJJqvNOgtb8QJHQQkPGKY1uepLO0G3+O9U3cbdJZ2jnG3PhMJAiiJhQ2ugAXR3HLM9/KPCYUYDY/vmeCC8XXfAGig68jGog1t8+B0BTDuYbWanFOtGmUXaLABHTlhndjPRof09IS6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779143557; c=relaxed/relaxed;
	bh=dDpeP38QOsfxeIaJNWSXWtmDpOF3Fp9FCzxzSp2z87g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OSBaS3ZShUTiI9/XJeKBMSGaMV3Y+yV6amdXKhwaXFCnajdpweTSfbYYbCOSF/2EfsVCB2lZdwHDHm9Is9UngPnLKyzyYXfvio0o2ZvtmHOKbnpr8z3wT9zl2WP30Ym1/oU7WVsyJBL1GBNJ1Wg7pw0EHZn0XE2kY4V41gh9b88pGs2m324bLZ9uDI50d2gSasGOssyrT07KJ5njZ1RVV+x+/hrniPj4i7Sh5gL8cINRrV0/A4LX1k+onebkyFmzkT4ejFbwM8fcEX06uP5LWOBZZ8MQIAtsXwnXYqjo7HxzAYYfQfL/E/hGHm6SrnG6ln63G7cVOKxTtv0JR33Xsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3MQ3lRo; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3MQ3lRo; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3MQ3lRo;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3MQ3lRo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKCH859Tpz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 08:32:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDpeP38QOsfxeIaJNWSXWtmDpOF3Fp9FCzxzSp2z87g=;
	b=C3MQ3lRoMATRMrYdiYvHCB4pF8TX3vAf/ITkZK8WCS9FE/JVXP5pIrp1Ke3BhEgrdTgAvj
	06GqzfWj6zxR4eGOna7moEqmOCXxU/L/cnyWfAufxeiyMVZipv5b2MIVjO2oHqvoqlDn4P
	Elz3bosikofLVc77CRdx55WErFNeO2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDpeP38QOsfxeIaJNWSXWtmDpOF3Fp9FCzxzSp2z87g=;
	b=C3MQ3lRoMATRMrYdiYvHCB4pF8TX3vAf/ITkZK8WCS9FE/JVXP5pIrp1Ke3BhEgrdTgAvj
	06GqzfWj6zxR4eGOna7moEqmOCXxU/L/cnyWfAufxeiyMVZipv5b2MIVjO2oHqvoqlDn4P
	Elz3bosikofLVc77CRdx55WErFNeO2g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-brn1cdqUMFeJu1NB6nTX_g-1; Mon,
 18 May 2026 18:32:31 -0400
X-MC-Unique: brn1cdqUMFeJu1NB6nTX_g-1
X-Mimecast-MFC-AGG-ID: brn1cdqUMFeJu1NB6nTX_g_1779143548
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41C7D19560AA;
	Mon, 18 May 2026 22:32:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3334B180058A;
	Mon, 18 May 2026 22:32:21 +0000 (UTC)
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
Subject: [PATCH v2 16/21] netfs: Remove netfs_extract_user_iter()
Date: Mon, 18 May 2026 23:29:48 +0100
Message-ID: <20260518222959.488126-17-dhowells@redhat.com>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fQhjDESmHe9dJvqhDYsr48ESojP_j_RTo8C9yheb60s_1779143548
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3437-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,manguebit.org:email,samba.org:email]
X-Rspamd-Queue-Id: AB7CA574895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove netfs_extract_user_iter() as it has been replaced with
netfs_extract_iter().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 104 ------------------------------------------
 include/linux/netfs.h |   3 --
 2 files changed, 107 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 10a25a618712..566693ac47ef 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -141,110 +141,6 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
 
 #if 0
-/**
- * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
- * @orig: The original iterator
- * @orig_len: The amount of iterator to copy
- * @new: The iterator to be set up
- * @extraction_flags: Flags to qualify the request
- *
- * Extract the page fragments from the given amount of the source iterator and
- * build up a second iterator that refers to all of those bits.  This allows
- * the original iterator to be disposed of.
- *
- * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
- * allowed on the pages extracted.
- *
- * On success, the number of elements in the bvec is returned, the original
- * iterator will have been advanced by the amount extracted.
- *
- * The iov_iter_extract_mode() function should be used to query how cleanup
- * should be performed.
- */
-ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
-				struct iov_iter *new,
-				iov_iter_extraction_t extraction_flags)
-{
-	struct bio_vec *bv = NULL;
-	struct page **pages;
-	unsigned int cur_npages;
-	unsigned int max_pages;
-	unsigned int npages = 0;
-	unsigned int i;
-	ssize_t ret = 0;
-	size_t count = orig_len, offset, len;
-	size_t bv_size, pg_size;
-
-	if (WARN_ON_ONCE(!iter_is_ubuf(orig) && !iter_is_iovec(orig)))
-		return -EIO;
-
-	max_pages = iov_iter_npages(orig, INT_MAX);
-	bv_size = array_size(max_pages, sizeof(*bv));
-	bv = kvmalloc(bv_size, GFP_KERNEL);
-	if (!bv)
-		return -ENOMEM;
-
-	/* Put the page list at the end of the bvec list storage.  bvec
-	 * elements are larger than page pointers, so as long as we work
-	 * 0->last, we should be fine.
-	 */
-	pg_size = array_size(max_pages, sizeof(*pages));
-	pages = (void *)bv + bv_size - pg_size;
-
-	while (count && npages < max_pages) {
-		ret = iov_iter_extract_pages(orig, &pages, count,
-					     max_pages - npages, extraction_flags,
-					     &offset);
-		if (unlikely(ret <= 0)) {
-			ret = ret ?: -EIO;
-			break;
-		}
-
-		if (WARN(ret > count,
-			 "%s: extract_pages overrun %zd > %zu bytes\n",
-			 __func__, ret, count)) {
-			ret = -EIO;
-			break;
-		}
-
-		cur_npages = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
-		if (WARN(cur_npages > max_pages - npages,
-			 "%s: extract_pages overrun %u > %u pages\n",
-			 __func__, npages + cur_npages, max_pages)) {
-			ret = -EIO;
-			break;
-		}
-
-		count -= ret;
-		ret += offset;
-
-		for (i = 0; i < cur_npages; i++) {
-			len = ret > PAGE_SIZE ? PAGE_SIZE : ret;
-			bvec_set_page(bv + npages + i, *pages++, len - offset, offset);
-			ret -= len;
-			offset = 0;
-		}
-
-		npages += cur_npages;
-	}
-
-	/* Note: Don't try to clean up after EIO.  Either we got no pages, so
-	 * nothing to clean up, or we got a buffer overrun, memory corruption
-	 * and can't trust the stuff in the buffer (a WARN was emitted).
-	 */
-
-	if (ret < 0 && (ret == -ENOMEM || npages == 0)) {
-		for (i = 0; i < npages; i++)
-			unpin_user_page(bv[i].bv_page);
-		kvfree(bv);
-		return ret;
-	}
-
-	iov_iter_bvec(new, orig->data_source, bv, npages, orig_len - count);
-	return npages;
-}
-EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
-
 /*
  * Select the span of a bvec iterator we're going to use.  Limit it by both maximum
  * size and maximum number of segments.  Returns the size of the span in bytes.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9e551e09054f..d0b1408bd02f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -464,9 +464,6 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags);
-ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
-				struct iov_iter *new,
-				iov_iter_extraction_t extraction_flags);
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);


