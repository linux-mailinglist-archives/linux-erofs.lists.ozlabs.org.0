Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB159BEA17
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:40:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4YT1H3fz3bg4
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:40:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896827;
	cv=none; b=O7ZXW9HyJaEpZzm9Boeu56s265kV8ljhpWfO+B1BKB+J3a/iXPri2BrAKTwNslb8/91Wd4sjrhFxMMJbciWkfWZg0o+e2kMWrSZDZTvNOTf9AltZvUprgP+oAt1UU1pbmi9xR6lY+bcol/vBaTXi+npwGiULrwBUjONKDUiWIcAOFRcsKoDbQ6Cx5jDHGbxuroegfmN0kDcwk8JyrtbOewKxVrS9phX/Be9D32TIDV68LLKCcchUDSlS0ni6W7+lNKhToeowYAveu9qh66ZyCWmr+ToCk2Ir9MO4HypYsSdY7JC2vAAbyXuQHWl0abGpI93f7J+nuGFRrrTeiPxDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896827; c=relaxed/relaxed;
	bh=Jlfv2ApsSBgn//KdBsSlx8BkotK5+tCpg2808yZLllw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyx9wFkt7ixHlWoaSM0g1zhNlmkcRRXLP/uKXzcJ9gpBGFAoc/+gZ2qOoh9xJjjgg5e4CrstSYvpcO0yHNjpIFLjvpbVmoN1hKlaPK3oCwVqBF8CRZacNb8hJnaphHuZi1zkFyDZ/pJ3l8OulCjV8GPQEmEWgTr/ODv62h0wmgbQhtd1E8IWGlZItJGhaQ+upddFVOfrF4dOytuiU8AFG2IJYAk0IAQ2bTB9KwGPvul86KS9zn8sk/o74kYlEfd0eEldaIDJzOFR2XYzwYkCq7ANjuS/7jhH+Ai4Ievsx+22EVRYjzVIDYPaQzkvnrf5WZxAX/cEgF8HVOtyfV3bjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cy708ngA; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJM47k8g; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cy708ngA;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJM47k8g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4YQ3QFyz30NN
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:40:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlfv2ApsSBgn//KdBsSlx8BkotK5+tCpg2808yZLllw=;
	b=cy708ngAyFev1ZkX3fVLnC9M4FaUUhqfH4Z4pLe0++Rp4m5Gw8tfnf7Ylb/xoTaWwFb3uU
	YuREZI/nsmsceCGXLjmEbE1yin+So5cNACCOnzvMBlcKpWxv8svb7g9og79TEdmFX6MYhA
	GghtRFhu4Zfw3f3S3oxCc1oCwevbqAo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlfv2ApsSBgn//KdBsSlx8BkotK5+tCpg2808yZLllw=;
	b=aJM47k8gCB9u32IWMspCxumxOZROvx3huVAHSZgd22fOVRCf9vrFTUzEjlJxp6ynkm7rsR
	XP4OrvNlcmwsbj5IiwsE6w8MUe9md2pGhkLzNf2b5A4hpPYe5FVsAUr81fws3Ru2Ihn5xj
	mU8TjoB7/4MMpIi8LvwD0+BZA6Xldy4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-gA0AskNvPJqluj550Slfjg-1; Wed,
 06 Nov 2024 07:40:18 -0500
X-MC-Unique: gA0AskNvPJqluj550Slfjg-1
X-Mimecast-MFC-AGG-ID: gA0AskNvPJqluj550Slfjg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A730195608C;
	Wed,  6 Nov 2024 12:40:15 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A3071955F40;
	Wed,  6 Nov 2024 12:40:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 33/33] netfs: Report on NULL folioq in netfs_writeback_unlock_folios()
Date: Wed,  6 Nov 2024 12:35:57 +0000
Message-ID: <20241106123559.724888-34-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
(3) the request has already been freed and this is a UAF error.  I think the
last is the most likely.

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
index 3d8b87c8e6a6..4a1499167770 100644
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

