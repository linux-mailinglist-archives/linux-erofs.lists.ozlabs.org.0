Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDD952395
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:41:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bQprglrJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B+an0ACe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkgBp137Yz2yNR
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:41:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bQprglrJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B+an0ACe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkgBh3GLvz2yNR
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:41:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RZCIFt1nFHOn2K81N2VwRb0JQpc16vDcy/7plWa8pc=;
	b=bQprglrJZpJ0+kAJSI4PYKhVIs9Le0CJv1YKhhLGX0ylc7LX3Xs1jeNmLf1DtuJrgg4oKG
	A93z52BjJCG+PJdRRNfSJasN3jB/NDHznBVQsQHUJ/UfxgQn0+QMmNX2dnbZ7iDxDFO2Bu
	Q+5LUDH6dAF3ONcnBsJ+HOHnBRQGbzE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RZCIFt1nFHOn2K81N2VwRb0JQpc16vDcy/7plWa8pc=;
	b=B+an0ACelaPOuUCOnPCmlJtoDJSAdiwzw2OL7yfSWpYUFgLFsnUiWwXGHcDscSKwXhADFk
	vnVm+PtzyAyUmD8pvLMwSGr/AnSyOrGLPvFOSkc3YJtBV7Tvw78PLhYkaCgmL0GEQXVM2q
	BkSyGTfxoJAX0esSmyeL6nxem/atafw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-02X665vNNgu4MYu1Px-cDA-1; Wed,
 14 Aug 2024 16:40:51 -0400
X-MC-Unique: 02X665vNNgu4MYu1Px-cDA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BCED1955F65;
	Wed, 14 Aug 2024 20:40:48 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F4AD196BE80;
	Wed, 14 Aug 2024 20:40:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 14/25] cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
Date: Wed, 14 Aug 2024 21:38:34 +0100
Message-ID: <20240814203850.2240469-15-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make smb_extract_iter_to_rdma() extract page fragments from an ITER_FOLIOQ
iterator into RDMA SGEs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 71 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 7bcc379014ca..c946b38ca825 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -6,6 +6,7 @@
  */
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/folio_queue.h>
 #include "smbdirect.h"
 #include "cifs_debug.h"
 #include "cifsproto.h"
@@ -2463,6 +2464,8 @@ static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2519,6 +2522,65 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/*
+ * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
+ * list.  The folios are not pinned.
+ */
+static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
+					  struct smb_extract_to_rdma *rdma,
+					  ssize_t maxsize)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	unsigned int slot = iter->folioq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	BUG_ON(!folioq);
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		if (WARN_ON_ONCE(!folioq))
+			return -EIO;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t fsize = folioq_folio_size(folioq, slot);
+
+		if (offset < fsize) {
+			size_t part = umin(maxsize - ret, fsize - offset);
+
+			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
+				return -EIO;
+
+			offset += part;
+			ret += part;
+		}
+
+		if (offset >= fsize) {
+			offset = 0;
+			slot++;
+			if (slot >= folioq_nr_slots(folioq)) {
+				if (!folioq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	} while (rdma->nr_sge < rdma->max_sge || maxsize > 0);
+
+	iter->folioq = folioq;
+	iter->folioq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
 	return ret;
 }
 
@@ -2563,6 +2625,8 @@ static ssize_t smb_extract_xarray_to_rdma(struct iov_iter *iter,
 	}
 
 	rcu_read_unlock();
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2590,6 +2654,9 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	case ITER_KVEC:
 		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
 		break;
+	case ITER_FOLIOQ:
+		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
+		break;
 	case ITER_XARRAY:
 		ret = smb_extract_xarray_to_rdma(iter, rdma, len);
 		break;
@@ -2598,9 +2665,7 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 		return -EIO;
 	}
 
-	if (ret > 0) {
-		iov_iter_advance(iter, ret);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		while (rdma->nr_sge > before) {
 			struct ib_sge *sge = &rdma->sge[rdma->nr_sge--];
 

