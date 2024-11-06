Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E659BEA12
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:40:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4YG4jz0z3bg4
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:40:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896817;
	cv=none; b=Rr3zsgyommMoQ0Fi4s8KS5Jprpf29yGkLCltDEIWIgdht+oIpLZZzz6Q4k9UCv/RuLRivTitr9g/7rqAU54Yi9zQuaNg0yRdW7KOEqRpNCchlK+I2mIumsidjZ24S3MQTfm6tKCN6p2PhYjBQdKhS7bLAZKJZp3pP1pCH5GH6QsBwwYEkrPtDZj8ljeHUTfcKFasWkXEn6ZI+g4cum2zvIA5G7GcLX+ZRbElBoRyoSl2t0bknKXkq6GY7iD7NC8e9tt5K7rDdyuUXgb+QARMYD2jzAXHpU3A2QsJ32E2ibYpi0hSrhdjmvaRZqef09iA5vxrfj+uA4ixarA0ErdTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896817; c=relaxed/relaxed;
	bh=QCDL9BqA4pDDX31tPDuoaoWVDY2hJyHDwXlxpfOucp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFrtggNIxX3ugfelIYDyPVnKFJaQIizJ8ggk4Ehe+K+BNxl3NrqhHcLFNEi1YQm3KqxLLfBUsfcl0jk6f4E6CF/x47crS72pcmS1qn627eI0Qvef7Sn7h+vEMkTurixDUP6/NwHeXRa2sbahjgcUqKRSoVUkccZXRKrx+t0ztgaZsP5XM2NgQVPhgDurCjuemRNhcBTkp7G3N1nFkql9YwC+0LbHoLpCq1tbMmo65nJhBlRyqXcx8+E9xe2Mz0QHJ/PmM1x6j/LBUpF6u1XyHc7PMzcUxpl8xX0AoNF3qNciphVtoIg1e3TkIrr3W6k6W7IMa8tipy1EQLy/gmhFKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/RhVXaW; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJumZsVR; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/RhVXaW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJumZsVR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4YD2xMVz30f4
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:40:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCDL9BqA4pDDX31tPDuoaoWVDY2hJyHDwXlxpfOucp0=;
	b=V/RhVXaWQR4a4+soXBVmqbZpGlQwI2uVJaD8VhXP75BE1iraBKJZcyZ6tvOPVDQTfgIfAI
	x+1qVHcMz2pSXOJZ7EGEJAp3CoKVfBXu3d7rO+CeuygJ+GC9tFByN10FaA62GUWRTr1uqv
	piPBb3gKM9Y/enMOm6iamceOgPMEEJM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCDL9BqA4pDDX31tPDuoaoWVDY2hJyHDwXlxpfOucp0=;
	b=LJumZsVRR0Do5OW44Sl6RJnomd5XReY1z8acIGAcqsC1vEmMjRUh0yiueRV6PGMuy6tY7W
	PUxeG76VvYocF+HPoBYvdYgsMivLQ82K23WzVXEWjKPm8foUTuzGkgtqtbX/MhY4wj54XI
	9M1DP/dJd9Qi5ZDKTMNVy7C4tXZWKMs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-nG6qfYvSMVqIxFIznRIAhg-1; Wed,
 06 Nov 2024 07:40:10 -0500
X-MC-Unique: nG6qfYvSMVqIxFIznRIAhg-1
X-Mimecast-MFC-AGG-ID: nG6qfYvSMVqIxFIznRIAhg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B55BE19560BD;
	Wed,  6 Nov 2024 12:40:07 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38EA41955F40;
	Wed,  6 Nov 2024 12:40:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 32/33] afs: Add a tracepoint for afs_read_receive()
Date: Wed,  6 Nov 2024 12:35:56 +0000
Message-ID: <20241106123559.724888-33-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add a tracepoint for afs_read_receive() to allow potential missed wakeups
to be debugged.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c              |  1 +
 include/trace/events/afs.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index c296efebb491..fc15497608c6 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -274,6 +274,7 @@ static void afs_read_receive(struct afs_call *call)
 	state = READ_ONCE(call->state);
 	if (state == AFS_CALL_COMPLETE)
 		return;
+	trace_afs_read_recv(op, call);
 
 	while (state < AFS_CALL_COMPLETE && READ_ONCE(call->need_attention)) {
 		WRITE_ONCE(call->need_attention, false);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index c52fd83ca9b7..2e92487f3f34 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1775,6 +1775,36 @@ TRACE_EVENT(afs_make_call,
 		      __entry->fid.unique)
 	    );
 
+TRACE_EVENT(afs_read_recv,
+	    TP_PROTO(const struct afs_operation *op, const struct afs_call *call),
+
+	    TP_ARGS(op, call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		sreq)
+		    __field(unsigned int,		op)
+		    __field(unsigned int,		op_flags)
+		    __field(unsigned int,		call)
+		    __field(enum afs_call_state,	call_state)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->op = op->debug_id;
+		    __entry->sreq = op->fetch.subreq->debug_index;
+		    __entry->rreq = op->fetch.subreq->rreq->debug_id;
+		    __entry->op_flags = op->flags;
+		    __entry->call = call->debug_id;
+		    __entry->call_state = call->state;
+			   ),
+
+	    TP_printk("R=%08x[%x] OP=%08x c=%08x cs=%x of=%x",
+		      __entry->rreq, __entry->sreq,
+		      __entry->op,
+		      __entry->call, __entry->call_state,
+		      __entry->op_flags)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

