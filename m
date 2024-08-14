Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F59523AF
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:42:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwCrQ3tg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5iTNYvf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkgD86Jcxz2yRZ
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:42:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwCrQ3tg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5iTNYvf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkgD33Kffz2yjR
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:42:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ULLeqms1eMqJp58KKAatHIrhvjPmclhiZnLforJ4Tk=;
	b=AwCrQ3tgxGH+3Ubf9O5hvD3CBGlRfMEc/lh6vVt/jRrLDL3Lu8g9MNrnv/hsb2JoeubvGa
	sfamDGC46faHb/oCPs5/7rfFQhchxoWJo0Xx1ffiBS0dfMrlS698X2fbo7Wu1Yv3dlcIps
	w/utf15rh4YubSF2v+XXrYDNhFgJjzc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ULLeqms1eMqJp58KKAatHIrhvjPmclhiZnLforJ4Tk=;
	b=B5iTNYvfs7tCfG5inGSC4GEYJ5p+vkl4CBQm+MR04/P9KlpwRQBuau88oM2alq2oGFTUy8
	Sim1CEmWHw70o4iCO5Bie+F0ntjMzHUW4IA7/P3rEPV3Vpij26iXHEJA9gxBSqaofc5vdM
	F/gNNQ6qJ8XyS/nSYnjfEmra0GPGvfk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-euL4FeedOwm1Nc0ZUnp-Ig-1; Wed,
 14 Aug 2024 16:42:04 -0400
X-MC-Unique: euL4FeedOwm1Nc0ZUnp-Ig-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 232E718EB234;
	Wed, 14 Aug 2024 20:42:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3628919560A3;
	Wed, 14 Aug 2024 20:41:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 24/25] cifs: Switch crypto buffer to use a folio_queue rather than an xarray
Date: Wed, 14 Aug 2024 21:38:44 +0100
Message-ID: <20240814203850.2240469-25-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Switch cifs from using an xarray to hold the transport crypto buffer to
using a folio_queue and use ITER_FOLIOQ rather than ITER_XARRAY.

This is part of the process of phasing out ITER_XARRAY.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsglob.h |   2 +-
 fs/smb/client/smb2ops.c  | 218 +++++++++++++++++++++------------------
 2 files changed, 121 insertions(+), 99 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1028881098e1..cba3572915ae 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -256,7 +256,7 @@ struct smb_rqst {
 	unsigned int	rq_nvec;	/* number of kvecs in array */
 	size_t		rq_iter_size;	/* Amount of data in ->rq_iter */
 	struct iov_iter	rq_iter;	/* Data iterator */
-	struct xarray	rq_buffer;	/* Page buffer for encryption */
+	struct folio_queue *rq_buffer;	/* Buffer for encryption */
 };
 
 struct mid_q_entry;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 322cabc69c6f..cb9a18e31b03 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -13,6 +13,7 @@
 #include <linux/sort.h>
 #include <crypto/aead.h>
 #include <linux/fiemap.h>
+#include <linux/folio_queue.h>
 #include <uapi/linux/magic.h>
 #include "cifsfs.h"
 #include "cifsglob.h"
@@ -4356,30 +4357,86 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 }
 
 /*
- * Clear a read buffer, discarding the folios which have XA_MARK_0 set.
+ * Clear a read buffer, discarding the folios which have the 1st mark set.
  */
-static void cifs_clear_xarray_buffer(struct xarray *buffer)
+static void cifs_clear_folioq_buffer(struct folio_queue *buffer)
 {
+	struct folio_queue *folioq;
+
+	while ((folioq = buffer)) {
+		for (int s = 0; s < folioq_count(folioq); s++)
+			if (folioq_is_marked(folioq, s))
+				folio_put(folioq_folio(folioq, s));
+		buffer = folioq->next;
+		kfree(folioq);
+	}
+}
+
+/*
+ * Allocate buffer space into a folio queue.
+ */
+static struct folio_queue *cifs_alloc_folioq_buffer(ssize_t size)
+{
+	struct folio_queue *buffer = NULL, *tail = NULL, *p;
 	struct folio *folio;
+	unsigned int slot;
+
+	do {
+		if (!tail || folioq_full(tail)) {
+			p = kmalloc(sizeof(*p), GFP_NOFS);
+			if (!p)
+				goto nomem;
+			folioq_init(p);
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				buffer = p;
+			}
+			tail = p;
+		}
+
+		folio = folio_alloc(GFP_KERNEL|__GFP_HIGHMEM, 0);
+		if (!folio)
+			goto nomem;
+
+		slot = folioq_append_mark(tail, folio);
+		size -= folioq_folio_size(tail, slot);
+	} while (size > 0);
+
+	return buffer;
+
+nomem:
+	cifs_clear_folioq_buffer(buffer);
+	return NULL;
+}
+
+/*
+ * Copy data from an iterator to the folios in a folio queue buffer.
+ */
+static bool cifs_copy_iter_to_folioq(struct iov_iter *iter, size_t size,
+				     struct folio_queue *buffer)
+{
+	for (; buffer; buffer = buffer->next) {
+		for (int s = 0; s < folioq_count(buffer); s++) {
+			struct folio *folio = folioq_folio(buffer, s);
+			size_t part = folioq_folio_size(buffer, s);
 
-	XA_STATE(xas, buffer, 0);
+			part = umin(part, size);
 
-	rcu_read_lock();
-	xas_for_each_marked(&xas, folio, ULONG_MAX, XA_MARK_0) {
-		folio_put(folio);
+			if (copy_folio_from_iter(folio, 0, part, iter) != part)
+				return false;
+			size -= part;
+		}
 	}
-	rcu_read_unlock();
-	xa_destroy(buffer);
+	return true;
 }
 
 void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
-	int i;
-
-	for (i = 0; i < num_rqst; i++)
-		if (!xa_empty(&rqst[i].rq_buffer))
-			cifs_clear_xarray_buffer(&rqst[i].rq_buffer);
+	for (int i = 0; i < num_rqst; i++)
+		cifs_clear_folioq_buffer(rqst[i].rq_buffer);
 }
 
 /*
@@ -4400,53 +4457,33 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
 {
 	struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
-	struct page *page;
 	unsigned int orig_len = 0;
-	int i, j;
 	int rc = -ENOMEM;
 
-	for (i = 1; i < num_rqst; i++) {
+	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct xarray *buffer = &new->rq_buffer;
-		size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
+		struct folio_queue *buffer;
+		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
 		new->rq_iov = old->rq_iov;
 		new->rq_nvec = old->rq_nvec;
 
-		xa_init(buffer);
-
 		if (size > 0) {
-			unsigned int npages = DIV_ROUND_UP(size, PAGE_SIZE);
-
-			for (j = 0; j < npages; j++) {
-				void *o;
-
-				rc = -ENOMEM;
-				page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-				if (!page)
-					goto err_free;
-				page->index = j;
-				o = xa_store(buffer, j, page, GFP_KERNEL);
-				if (xa_is_err(o)) {
-					rc = xa_err(o);
-					put_page(page);
-					goto err_free;
-				}
+			buffer = cifs_alloc_folioq_buffer(size);
+			if (!buffer)
+				goto err_free;
 
-				xa_set_mark(buffer, j, XA_MARK_0);
+			new->rq_buffer = buffer;
+			iov_iter_folio_queue(&new->rq_iter, ITER_SOURCE,
+					     buffer, 0, 0, size);
+			new->rq_iter_size = size;
 
-				seg = min_t(size_t, size - copied, PAGE_SIZE);
-				if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
-					rc = -EFAULT;
-					goto err_free;
-				}
-				copied += seg;
+			if (!cifs_copy_iter_to_folioq(&old->rq_iter, size, buffer)) {
+				rc = -EIO;
+				goto err_free;
 			}
-			iov_iter_xarray(&new->rq_iter, ITER_SOURCE,
-					buffer, 0, size);
-			new->rq_iter_size = size;
 		}
 	}
 
@@ -4511,22 +4548,23 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 }
 
 static int
-cifs_copy_pages_to_iter(struct xarray *pages, unsigned int data_size,
-			unsigned int skip, struct iov_iter *iter)
+cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
+			 size_t skip, struct iov_iter *iter)
 {
-	struct page *page;
-	unsigned long index;
-
-	xa_for_each(pages, index, page) {
-		size_t n, len = min_t(unsigned int, PAGE_SIZE - skip, data_size);
-
-		n = copy_page_to_iter(page, skip, len, iter);
-		if (n != len) {
-			cifs_dbg(VFS, "%s: something went wrong\n", __func__);
-			return -EIO;
+	for (; folioq; folioq = folioq->next) {
+		for (int s = 0; s < folioq_count(folioq); s++) {
+			struct folio *folio = folioq_folio(folioq, s);
+			size_t fsize = folio_size(folio);
+			size_t n, len = umin(fsize - skip, data_size);
+
+			n = copy_folio_to_iter(folio, skip, len, iter);
+			if (n != len) {
+				cifs_dbg(VFS, "%s: something went wrong\n", __func__);
+				return -EIO;
+			}
+			data_size -= n;
+			skip = 0;
 		}
-		data_size -= n;
-		skip = 0;
 	}
 
 	return 0;
@@ -4534,8 +4572,8 @@ cifs_copy_pages_to_iter(struct xarray *pages, unsigned int data_size,
 
 static int
 handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
-		 char *buf, unsigned int buf_len, struct xarray *pages,
-		 unsigned int pages_len, bool is_offloaded)
+		 char *buf, unsigned int buf_len, struct folio_queue *buffer,
+		 unsigned int buffer_len, bool is_offloaded)
 {
 	unsigned int data_offset;
 	unsigned int data_len;
@@ -4632,7 +4670,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		if (data_len > pages_len - pad_len) {
+		if (data_len > buffer_len - pad_len) {
 			/* data_len is corrupt -- discard frame */
 			rdata->result = -EIO;
 			if (is_offloaded)
@@ -4643,8 +4681,8 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		}
 
 		/* Copy the data to the output I/O iterator. */
-		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
-							cur_off, &rdata->subreq.io_iter);
+		rdata->result = cifs_copy_folioq_to_iter(buffer, buffer_len,
+							 cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4652,12 +4690,11 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 				dequeue_mid(mid, rdata->result);
 			return 0;
 		}
-		rdata->got_bytes = pages_len;
+		rdata->got_bytes = buffer_len;
 
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
-		WARN_ONCE(pages && !xa_empty(pages),
-			  "read data can be either in buf or in pages");
+		WARN_ONCE(buffer, "read data can be either in buf or in buffer");
 		length = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
 		if (length < 0)
 			return length;
@@ -4683,7 +4720,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 struct smb2_decrypt_work {
 	struct work_struct decrypt;
 	struct TCP_Server_Info *server;
-	struct xarray buffer;
+	struct folio_queue *buffer;
 	char *buf;
 	unsigned int len;
 };
@@ -4697,7 +4734,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	struct mid_q_entry *mid;
 	struct iov_iter iter;
 
-	iov_iter_xarray(&iter, ITER_DEST, &dw->buffer, 0, dw->len);
+	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
 	rc = decrypt_raw_data(dw->server, dw->buf, dw->server->vals->read_rsp_size,
 			      &iter, true);
 	if (rc) {
@@ -4713,7 +4750,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 		mid->decrypted = true;
 		rc = handle_read_data(dw->server, mid, dw->buf,
 				      dw->server->vals->read_rsp_size,
-				      &dw->buffer, dw->len,
+				      dw->buffer, dw->len,
 				      true);
 		if (rc >= 0) {
 #ifdef CONFIG_CIFS_STATS2
@@ -4746,7 +4783,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	cifs_clear_xarray_buffer(&dw->buffer);
+	cifs_clear_folioq_buffer(dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4756,20 +4793,17 @@ static int
 receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		       int *num_mids)
 {
-	struct page *page;
 	char *buf = server->smallbuf;
 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
 	struct iov_iter iter;
-	unsigned int len, npages;
+	unsigned int len;
 	unsigned int buflen = server->pdu_size;
 	int rc;
-	int i = 0;
 	struct smb2_decrypt_work *dw;
 
 	dw = kzalloc(sizeof(struct smb2_decrypt_work), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
-	xa_init(&dw->buffer);
 	INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
 	dw->server = server;
 
@@ -4785,26 +4819,14 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	len = le32_to_cpu(tr_hdr->OriginalMessageSize) -
 		server->vals->read_rsp_size;
 	dw->len = len;
-	npages = DIV_ROUND_UP(len, PAGE_SIZE);
+	len = round_up(dw->len, PAGE_SIZE);
 
 	rc = -ENOMEM;
-	for (; i < npages; i++) {
-		void *old;
-
-		page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!page)
-			goto discard_data;
-		page->index = i;
-		old = xa_store(&dw->buffer, i, page, GFP_KERNEL);
-		if (xa_is_err(old)) {
-			rc = xa_err(old);
-			put_page(page);
-			goto discard_data;
-		}
-		xa_set_mark(&dw->buffer, i, XA_MARK_0);
-	}
+	dw->buffer = cifs_alloc_folioq_buffer(len);
+	if (!dw->buffer)
+		goto discard_data;
 
-	iov_iter_xarray(&iter, ITER_DEST, &dw->buffer, 0, npages * PAGE_SIZE);
+	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
 
 	/* Read the data into the buffer and clear excess bufferage. */
 	rc = cifs_read_iter_from_socket(server, &iter, dw->len);
@@ -4812,9 +4834,9 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		goto discard_data;
 
 	server->total_read += rc;
-	if (rc < npages * PAGE_SIZE)
-		iov_iter_zero(npages * PAGE_SIZE - rc, &iter);
-	iov_iter_revert(&iter, npages * PAGE_SIZE);
+	if (rc < len)
+		iov_iter_zero(len - rc, &iter);
+	iov_iter_revert(&iter, len);
 	iov_iter_truncate(&iter, dw->len);
 
 	rc = cifs_discard_remaining_data(server);
@@ -4849,7 +4871,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		(*mid)->decrypted = true;
 		rc = handle_read_data(server, *mid, buf,
 				      server->vals->read_rsp_size,
-				      &dw->buffer, dw->len, false);
+				      dw->buffer, dw->len, false);
 		if (rc >= 0) {
 			if (server->ops->is_network_name_deleted) {
 				server->ops->is_network_name_deleted(buf,
@@ -4859,7 +4881,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	}
 
 free_pages:
-	cifs_clear_xarray_buffer(&dw->buffer);
+	cifs_clear_folioq_buffer(dw->buffer);
 free_dw:
 	kfree(dw);
 	return rc;

