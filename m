Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D99F3B59
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:45:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsQq1Spkz30YL
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:45:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381938;
	cv=none; b=koBC3PjRDpyVZ68dpFVskAMh7ROe7A/KziMeYFPQRts4jlY5U8inbiFIRuYSfYTj7toKujLudaQo5MonUnfWWfgyFpsdWElsVGU0OQwwlgNds9Xx339TvV64iWKbQiL5TQVIuQUpLWkXfElrGD1tqqwnc21zgtSZImMzZ5txKG618Kiio4PDdsrjZynikhdlpOQBL236LXt5QDTt32DWmTRZcjFo6ENhlTMAMm/u4cT9wGelXdhlIC0tiKUdtOynwGUkhew3lJ6irU2S3g0UR1JfyaXCdRx0aC+Baw/12xQJGeAcOTZWLFVoLxFw2ERP4OcCcqR1vIpB3YGQTTp5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381938; c=relaxed/relaxed;
	bh=Oo1wq8deJtNt2OQQxJVQAHf3OBjfRH+YniUEyQHkJfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlireBZoetyi+yj3wyQ4lWhACe3SnqdmFUfv8L7Hc18UuZVC36rj0uUCby0zle8v3wTTq1mc3RVwRinihIYrNCuMHNCKD4siG+yKjXJoUB66vuOCq9Z/XpuiIm10wgJX/5U2KaL0tVzKkfmnihUO5gCw3OzB6j8AK8za4o7je7/VHw82awvMCNODTJb81h7Rz2p4BaWhAFTVwMpGYM9wPs3zVFA40HmxFXZDyVfrvkXfu/1jw9ZFcnBnJKgVT68f/5Q79C6zX9wQI9bTzBuTu7RgGvyr3MTqLtIR2F96/KcT77+mGIbNWRBfttBeIjGsuQNhRureCwydd36R0EdYPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDwHQU62; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RIj7E6vY; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDwHQU62;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RIj7E6vY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsQn29G5z300g
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:45:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo1wq8deJtNt2OQQxJVQAHf3OBjfRH+YniUEyQHkJfs=;
	b=VDwHQU6255+nhMSZivKrf+aewrX0JXWZp1/8g6TFDuXlXrOWuIimVOftxoUYobE+I0I48E
	MnoWgWfLdoKYd4pfQSrKZ9n0DnI376t6o0+Z4uumhPVRgMVIInF4+w4h9Kdj4AlLet23eV
	sKjhw0EzHwsx+f2o6g2XdEUnFhOWydw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo1wq8deJtNt2OQQxJVQAHf3OBjfRH+YniUEyQHkJfs=;
	b=RIj7E6vYWgREgtGnZ1BuVHIliqTqY6kcIW+9CyVv2+KZt1KbtskMAHzpKKD9NBiog+XQhn
	YGDtYl1zCIhptTJQANftn/tblzlBlTho5GdRDSINpjtFj7HGxB9BdApLDD2D80vX5dL+2X
	Ty7qjHroxDqQ6kme+dPJFxj6PrJSYoM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-XuzHjsQvNUyN5PcUdS5A8w-1; Mon,
 16 Dec 2024 15:45:31 -0500
X-MC-Unique: XuzHjsQvNUyN5PcUdS5A8w-1
X-Mimecast-MFC-AGG-ID: XuzHjsQvNUyN5PcUdS5A8w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8C74195608E;
	Mon, 16 Dec 2024 20:45:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BF4B19560A2;
	Mon, 16 Dec 2024 20:45:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 32/32] netfs: Report on NULL folioq in netfs_writeback_unlock_folios()
Date: Mon, 16 Dec 2024 20:41:22 +0000
Message-ID: <20241216204124.3752367-33-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com, Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Chang Yu <marcus.yu.56@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It seems that it's possible to get to netfs_writeback_unlock_folios() with
an empty rolling buffer during buffered writes.  This should not be
possible as the rolling buffer is initialised as the write request is set
up and thereafter maintains at least one folio_queue struct therein until
it gets destroyed.  This allows lockless addition and removal of
folio_queue structs in the buffer because, unlike with a ring buffer, the
producer and consumer each only need to look at and alter one pointer into
the buffer.

Now, the rolling buffer is only used for buffered I/O operations as
netfs_collect_write_results() should only call
netfs_writeback_unlock_folios() if the request is of origin type
NETFS_WRITEBACK, NETFS_WRITETHROUGH or NETFS_PGPRIV2_COPY_TO_CACHE.

So it would seem that one of the following occurred: (1) I/O started before
the request was fully initialised, (2) the origin got switched mid-flow or
(3) the request has already been freed and this is a UAF error.  I think
the last is the most likely.

Make netfs_writeback_unlock_folios() report information about the request
and subrequests if folioq is seen to be NULL to try and help debug this,
throw a warning and return.

Note that this does not try to fix the problem.

Reported-by: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Chang Yu <marcus.yu.56@gmail.com>
Link: https://lore.kernel.org/r/ZxshMEW4U7MTgQYa@gmail.com/
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1b7f53d01b8d..294f67795f79 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -21,6 +21,34 @@
 #define NEED_RETRY		0x10	/* A front op requests retrying */
 #define SAW_FAILURE		0x20	/* One stream or hit a permanent failure */
 
+static void netfs_dump_request(const struct netfs_io_request *rreq)
+{
+	pr_err("Request R=%08x r=%d fl=%lx or=%x e=%ld\n",
+	       rreq->debug_id, refcount_read(&rreq->ref), rreq->flags,
+	       rreq->origin, rreq->error);
+	pr_err("  st=%llx tsl=%zx/%llx/%llx\n",
+	       rreq->start, rreq->transferred, rreq->submitted, rreq->len);
+	pr_err("  cci=%llx/%llx/%llx\n",
+	       rreq->cleaned_to, rreq->collected_to, atomic64_read(&rreq->issued_to));
+	pr_err("  iw=%pSR\n", rreq->netfs_ops->issue_write);
+	for (int i = 0; i < NR_IO_STREAMS; i++) {
+		const struct netfs_io_subrequest *sreq;
+		const struct netfs_io_stream *s = &rreq->io_streams[i];
+
+		pr_err("  str[%x] s=%x e=%d acnf=%u,%u,%u,%u\n",
+		       s->stream_nr, s->source, s->error,
+		       s->avail, s->active, s->need_retry, s->failed);
+		pr_err("  str[%x] ct=%llx t=%zx\n",
+		       s->stream_nr, s->collected_to, s->transferred);
+		list_for_each_entry(sreq, &s->subrequests, rreq_link) {
+			pr_err("  sreq[%x:%x] sc=%u s=%llx t=%zx/%zx r=%d f=%lx\n",
+			       sreq->stream_nr, sreq->debug_index, sreq->source,
+			       sreq->start, sreq->transferred, sreq->len,
+			       refcount_read(&sreq->ref), sreq->flags);
+		}
+	}
+}
+
 /*
  * Successful completion of write of a folio to the server and/or cache.  Note
  * that we are not allowed to lock the folio here on pain of deadlocking with
@@ -87,6 +115,12 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	unsigned long long collected_to = wreq->collected_to;
 	unsigned int slot = wreq->buffer.first_tail_slot;
 
+	if (WARN_ON_ONCE(!folioq)) {
+		pr_err("[!] Writeback unlock found empty rolling buffer!\n");
+		netfs_dump_request(wreq);
+		return;
+	}
+
 	if (wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE) {
 		if (netfs_pgpriv2_unlock_copied_folios(wreq))
 			*notes |= MADE_PROGRESS;

