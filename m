Return-Path: <linux-erofs+bounces-3846-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ePBFMYXLS2qeaQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3846-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 17:36:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F87712AE7
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 17:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iEpKEqf4;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IeiJEGqT;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3846-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3846-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv7kV5yrxz3bqV;
	Tue, 07 Jul 2026 01:36:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783352194;
	cv=none; b=Muv3Bllu3w+WgG9Gsbb3aM3lY0eABdchhfrbCVdX/mEgvVmQm144+rEjkYM2gf+gIgKY391MPWt/ryHs2cRmAHJ0Sjre7IKDfdjEdTzm4VLnQlCxW48Su6codGkpm+d5SChSkIQGEALnZsL/ov++iRr6fv3JIX9p4XBKNd9HS4B6nR70JArIGcG0ScCO8zOHXsYtuiMKWnGABTPap6xAjXG1Y0GQ3RdO0CKsC+Hcb/L2i2j/H+jXSmP6LbjoB2IX/WPFll6GDS0L7bQdy95FWTdSGXHyIi2EkgWffB7awucqmCx5J5wnU1BiATHu4LWqQNsoQrgeCPemBUq0Ky1oSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783352194; c=relaxed/relaxed;
	bh=zuSbqBEzl5sUq2VZcAey0HBGDIiSczb2suBrxaoJNNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O6CktORibufhURGp36AV12szLqlJffPuSTsmWnjsFh54bQI+YBEZZP7kLBiNKkr5xjS5+9bDjgJBmU+lbeW5XorlYlMiVZRvyZkd2vv3KuiNk4UZaJu7DiOJX+04cIsxdm764BMI+N83u7V+ykYOIwkbAjuHfsnAUPRF4tneg8DtG42y88XGZLpc92aVU+59nQseCuCEzC+5dxOhMrOgpZEHMjhXMgQdo4gaX9kAZBA/TQc8L9RevK1oMnSo1yTQVmop7j5Z1diuxcyn91cKF48grhzDU5OlojeM5w5Vh/YWNcec4f82axEuDIQ8/Oe1zwL7oWRP9P923g8ArfVSLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iEpKEqf4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IeiJEGqT; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv7kT6JZqz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Jul 2026 01:36:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783352190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuSbqBEzl5sUq2VZcAey0HBGDIiSczb2suBrxaoJNNo=;
	b=iEpKEqf4v+ab1z+MOYM/1fJaKMPTbEvAQUPPEgyFbgK9eLtCHqSi2oFrzXE/yUwEC+RIbp
	eWUmQxJY8Z/p/uWYt7GoAl+GMuEirXpJEiLAcBa+iooRfezhEbt0RSVwcELFt5rxghaABg
	jqyl4lI29E2o6THbK7BirVrnIj8JMnw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783352191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuSbqBEzl5sUq2VZcAey0HBGDIiSczb2suBrxaoJNNo=;
	b=IeiJEGqTqY91O95LagrF2ZQ337hKM8Zv5NwXi+HcCx+toTwRLHGlArSpHC6nsScPoMWehs
	0dj2pepwNNxzHIL9Xdg22xn0AHlz+B1983aXpkKHXOFtuSpbr0xOIQqntH3PurhT7HQ0Bh
	XnG8KGBJRtfNXf551P2XDYI5XSZFppI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-t2m0_ZkcMESzz_dMNBvzgg-1; Mon,
 06 Jul 2026 11:36:27 -0400
X-MC-Unique: t2m0_ZkcMESzz_dMNBvzgg-1
X-Mimecast-MFC-AGG-ID: t2m0_ZkcMESzz_dMNBvzgg_1783352184
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59C991955F2A;
	Mon,  6 Jul 2026 15:36:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 734A2195604B;
	Mon,  6 Jul 2026 15:36:18 +0000 (UTC)
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
	Stefan Metzmacher <metze@samba.org>,
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
Subject: [PATCH v5 16/21] netfs: Remove netfs_extract_user_iter()
Date: Mon,  6 Jul 2026 16:34:02 +0100
Message-ID: <20260706153408.1231650-17-dhowells@redhat.com>
In-Reply-To: <20260706153408.1231650-1-dhowells@redhat.com>
References: <20260706153408.1231650-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 7gKTbWbgI13MmJ5rvi9liYj-mJdFv__mOZ2n2WPXTvQ_1783352184
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3846-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:metze@samba.org,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,samba.org:email,manguebit.org:email,linux.dev:email,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6F87712AE7

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
index e57492b262bd..f210ed79af61 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -157,110 +157,6 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
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
index a4efa313087d..00bcda193b31 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -466,9 +466,6 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags);
-ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
-				struct iov_iter *new,
-				iov_iter_extraction_t extraction_flags);
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);


