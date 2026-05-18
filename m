Return-Path: <linux-erofs+bounces-3433-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBHrFWGTC2ohJgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3433-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:32:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF9574848
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 00:32:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKCGQ0rB0z2xSG;
	Tue, 19 May 2026 08:31:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779143518;
	cv=none; b=IIi/ysZQnX2lX1uZOz/VUfnFGF+3MNKpioevJCf0o+ZFgo1w3sSZ7Br9I3l42ZVU9qJi393zb9sqPrsnFC4tAKTGrLnJmrp/BsFc+ietRVoOG9ZMyXl+5f0g/StENRE/Le2nDyAg45qqgX8OsSGrdBizAAAkfwt1ZZEp1eUoYy98uRPvMrH+nFPwluGxDjd48CzxwCWZj52hgI8gxeDh5r7zyxiwsJ57qYonL1WDizYyRoPAt325cJhHPF/5rl4k1NrjCfqC9Irl/VUHQd4YsS5IWWTx9ALt0TwRVmNtQkCHTmZM/kjet3CE+cg6Nkrf0gH3GNlocPQobbIRQUE97A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779143518; c=relaxed/relaxed;
	bh=cTl/y/xoXy47yOY7S3XBgEp05w5k7fiZoqysydk4IiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cfn55giNCVsvmo5RttPOXlLrOUVeuGAFkuWHBi+Sb4oOl9jypdRWMB2wXWHyHclVfjGek/XCIED+YVTuMyrVWKBerSMSK9kE+WwMDywKix7ZvKUnk7785OjgCY0n2khPnViX61IfyvYnrEZQaF/02qhv8t1yYm/4sMOmNurfOl8GOI0K533MjLek8L02x3MZOF//1y8q480eZPlLFOa2ujAyk+a6YILfo0Dc9Fzm0kmLXD2qpCFWcTouBoTqKvHXAwK9NfDw2dKEQ0mgUdLi9mpKFDJYrxxyaLuMXwCnTS22W4GZYVXudsw0yjr0kf4F6xKQ0C7a4eCYIVje34KBhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TG1h8F4D; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TG1h8F4D; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TG1h8F4D;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TG1h8F4D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKCGP1dLgz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 08:31:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTl/y/xoXy47yOY7S3XBgEp05w5k7fiZoqysydk4IiE=;
	b=TG1h8F4DB8wOoDdBRep9+pwBa7nKYROgErQsH0bPxQiUvbHoleXxOG55aXRpu+VAjOGJC1
	UQl7Cy+tZva1EKUfPJguMX2deK5D1AP5Pe3op+p1KZ3pN/2ema9IBIC1N5AGQIdTpW83z3
	H/gPveyxlYi+TDq4tw4TQTJxyA8fikQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTl/y/xoXy47yOY7S3XBgEp05w5k7fiZoqysydk4IiE=;
	b=TG1h8F4DB8wOoDdBRep9+pwBa7nKYROgErQsH0bPxQiUvbHoleXxOG55aXRpu+VAjOGJC1
	UQl7Cy+tZva1EKUfPJguMX2deK5D1AP5Pe3op+p1KZ3pN/2ema9IBIC1N5AGQIdTpW83z3
	H/gPveyxlYi+TDq4tw4TQTJxyA8fikQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-WqrWpMuoPimVOEHW1oA05Q-1; Mon,
 18 May 2026 18:31:49 -0400
X-MC-Unique: WqrWpMuoPimVOEHW1oA05Q-1
X-Mimecast-MFC-AGG-ID: WqrWpMuoPimVOEHW1oA05Q_1779143506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659D91956058;
	Mon, 18 May 2026 22:31:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00B2530001A2;
	Mon, 18 May 2026 22:31:39 +0000 (UTC)
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
Subject: [PATCH v2 11/21] cifs: Use a bvecq for buffering instead of a folioq
Date: Mon, 18 May 2026 23:29:43 +0100
Message-ID: <20260518222959.488126-12-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 5OvHex-ZZsfY1seTYS-pQ8ZE_8eIctHlr5ZYVYjyr6I_1779143506
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3433-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,manguebit.org:email,samba.org:email]
X-Rspamd-Queue-Id: A5EF9574848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a bvecq for internal buffering for crypto purposes instead of a folioq
so that the latter can be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  2 +-
 fs/smb/client/smb2ops.c  | 71 +++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 82e0adc1dabd..fc4028b5b5c8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -288,7 +288,7 @@ struct smb_rqst {
 	struct kvec	*rq_iov;	/* array of kvecs */
 	unsigned int	rq_nvec;	/* number of kvecs in array */
 	struct iov_iter	rq_iter;	/* Data iterator */
-	struct folio_queue *rq_buffer;	/* Buffer for encryption */
+	struct bvecq	*rq_buffer;	/* Buffer for encryption */
 };
 
 struct mid_q_entry;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 189bb863a9af..230102f2e411 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4542,19 +4542,18 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 }
 
 /*
- * Copy data from an iterator to the folios in a folio queue buffer.
+ * Copy data from an iterator to the pages in a bvec queue buffer.
  */
-static bool cifs_copy_iter_to_folioq(struct iov_iter *iter, size_t size,
-				     struct folio_queue *buffer)
+static bool cifs_copy_iter_to_bvecq(struct iov_iter *iter, size_t size,
+				    struct bvecq *buffer)
 {
 	for (; buffer; buffer = buffer->next) {
-		for (int s = 0; s < folioq_count(buffer); s++) {
-			struct folio *folio = folioq_folio(buffer, s);
-			size_t part = folioq_folio_size(buffer, s);
+		for (int s = 0; s < buffer->nr_slots; s++) {
+			struct bio_vec *bv = &buffer->bv[s];
+			size_t part = umin(bv->bv_len, size);
 
-			part = umin(part, size);
-
-			if (copy_folio_from_iter(folio, 0, part, iter) != part)
+			if (copy_page_from_iter(bv->bv_page, bv->bv_offset,
+						part, iter) != part)
 				return false;
 			size -= part;
 		}
@@ -4566,7 +4565,7 @@ void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
 	for (int i = 0; i < num_rqst; i++)
-		netfs_free_folioq_buffer(rqst[i].rq_buffer);
+		bvecq_put(rqst[i].rq_buffer);
 }
 
 /*
@@ -4593,7 +4592,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer = NULL;
+		struct bvecq *buffer = NULL;
 		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
@@ -4601,17 +4600,16 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		new->rq_nvec = old->rq_nvec;
 
 		if (size > 0) {
-			size_t cur_size = 0;
-			rc = netfs_alloc_folioq_buffer(NULL, &buffer, &cur_size,
-						       size, GFP_NOFS);
-			if (rc < 0)
+			rc = -ENOMEM;
+			buffer = bvecq_alloc_buffer(size, GFP_NOFS);
+			if (!buffer)
 				goto err_free;
 
 			new->rq_buffer = buffer;
-			iov_iter_folio_queue(&new->rq_iter, ITER_SOURCE,
-					     buffer, 0, 0, size);
+			iov_iter_bvec_queue(&new->rq_iter, ITER_SOURCE,
+					    buffer, 0, 0, size);
 
-			if (!cifs_copy_iter_to_folioq(&old->rq_iter, size, buffer)) {
+			if (!cifs_copy_iter_to_bvecq(&old->rq_iter, size, buffer)) {
 				rc = smb_EIO1(smb_eio_trace_tx_copy_iter_to_buf, size);
 				goto err_free;
 			}
@@ -4701,16 +4699,15 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 }
 
 static int
-cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
-			 size_t skip, struct iov_iter *iter)
+cifs_copy_bvecq_to_iter(struct bvecq *bq, size_t data_size,
+			size_t skip, struct iov_iter *iter)
 {
-	for (; folioq; folioq = folioq->next) {
-		for (int s = 0; s < folioq_count(folioq); s++) {
-			struct folio *folio = folioq_folio(folioq, s);
-			size_t fsize = folio_size(folio);
-			size_t n, len = umin(fsize - skip, data_size);
+	for (; bq; bq = bq->next) {
+		for (int s = 0; s < bq->nr_slots; s++) {
+			struct bio_vec *bv = &bq->bv[s];
+			size_t n, len = umin(bv->bv_len - skip, data_size);
 
-			n = copy_folio_to_iter(folio, skip, len, iter);
+			n = copy_page_to_iter(bv->bv_page, bv->bv_offset + skip, len, iter);
 			if (n != len) {
 				cifs_dbg(VFS, "%s: something went wrong\n", __func__);
 				return smb_EIO2(smb_eio_trace_rx_copy_to_iter,
@@ -4726,7 +4723,7 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
 
 static int
 handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
-		 char *buf, unsigned int buf_len, struct folio_queue *buffer,
+		 char *buf, unsigned int buf_len, struct bvecq *buffer,
 		 unsigned int buffer_len, bool is_offloaded)
 {
 	unsigned int data_offset;
@@ -4836,8 +4833,8 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		}
 
 		/* Copy the data to the output I/O iterator. */
-		rdata->result = cifs_copy_folioq_to_iter(buffer, buffer_len,
-							 cur_off, &rdata->subreq.io_iter);
+		rdata->result = cifs_copy_bvecq_to_iter(buffer, buffer_len,
+							cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4876,7 +4873,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 struct smb2_decrypt_work {
 	struct work_struct decrypt;
 	struct TCP_Server_Info *server;
-	struct folio_queue *buffer;
+	struct bvecq *buffer;
 	char *buf;
 	unsigned int len;
 };
@@ -4890,7 +4887,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	struct mid_q_entry *mid;
 	struct iov_iter iter;
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
 	rc = decrypt_raw_data(dw->server, dw->buf, dw->server->vals->read_rsp_size,
 			      &iter, true);
 	if (rc) {
@@ -4939,7 +4936,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	netfs_free_folioq_buffer(dw->buffer);
+	bvecq_put(dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4985,12 +4982,12 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	dw->len = len;
 	len = round_up(dw->len, PAGE_SIZE);
 
-	size_t cur_size = 0;
-	rc = netfs_alloc_folioq_buffer(NULL, &dw->buffer, &cur_size, len, GFP_NOFS);
-	if (rc < 0)
+	rc = -ENOMEM;
+	dw->buffer = bvecq_alloc_buffer(len, GFP_NOFS);
+	if (!dw->buffer)
 		goto discard_data;
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
 
 	/* Read the data into the buffer and clear excess bufferage. */
 	rc = cifs_read_iter_from_socket(server, &iter, dw->len);
@@ -5048,7 +5045,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	}
 
 free_pages:
-	netfs_free_folioq_buffer(dw->buffer);
+	bvecq_put(dw->buffer);
 free_dw:
 	kfree(dw);
 	return rc;


