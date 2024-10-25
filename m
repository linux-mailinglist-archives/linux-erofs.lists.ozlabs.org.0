Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B509B102F
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 22:43:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZvrg2bNrz3bj8
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 07:43:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729889025;
	cv=none; b=cPnkySBN4bHonisxLlICZV/OvjxfypIMwr550NvjgZT5OC00mkkWWD4oZYkEaw8eL7Xli+R5da+UeIXezsoWyUbuzGeGUIf4IVXv6zlIqQ7Hj6pPVtEW7JkDpFAi6c7o/sGxoX2YuO1WbWxW4YMMgO2G94RvEI7P+atE3Z4TbQImhr60N7/AeHReMp7bCqZQ3Q829s/ymm6pXaNmgz7KzdlCqvCiJWgElP3h6535Cgt9YgBkUvnznEau8+0oKE5BRMPXyP/cMc3438tdD9tkH8Ivzaqz+7PJJAoCQ5ZSMgk7Kbil5DqtThCAzTtgPAn5cbEZlHhLJpAujL1mGblJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729889025; c=relaxed/relaxed;
	bh=e0urA38A4ADOiCMpfN0uGJZmadb1R6bcZLrketz8DnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMBymTqbXMB1K+1xvQSsneM/oPdkw4MVCF74NTtH8BXU+g80N4cAhYzVrj++NSuitQlolUkT5galBkvt5x9h4RLKbIakEk57ad8ldYzN3UI5/FxIH4hmDzUXR4qxB8dja/vM6efn5cMK9ivKHavQ/zwXbiqSj5ihfZdou4KRUuR1aRDjmDib5VEWn+0RIe7CbM+imLf/oVmqImHX0Wwt7UPj+0SIWyqE03WV5nOse3EtZbUK7dl5tq7GSJtT4ZFbzMOdHvxQ3xpsvMe4aon5ilIEj2UPu0Pp03gdGzo2EwIKfVX5zl35ZvqhK87OlMWBa4hRBtmRx5N74bNput6X4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZUT2W0j; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZUT2W0j; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZUT2W0j;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZUT2W0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZvrc2MQ3z2yGv
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 07:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0urA38A4ADOiCMpfN0uGJZmadb1R6bcZLrketz8DnY=;
	b=WZUT2W0jHOGRkJfNKCxU8UdWFnngFmnXshYOx3O1oLA0rEhKpChli/rfCvJT+gQlzA81lF
	yWJ0i/cEQF+nr2PSHB/VORpx/rSMD4NOwHGWeRU0a/6mnMd/KZxrFLQMs88IRl5lGl7Y/k
	DaitvTqfRlOqJZCxSs9A2/gyfiJQY/E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0urA38A4ADOiCMpfN0uGJZmadb1R6bcZLrketz8DnY=;
	b=WZUT2W0jHOGRkJfNKCxU8UdWFnngFmnXshYOx3O1oLA0rEhKpChli/rfCvJT+gQlzA81lF
	yWJ0i/cEQF+nr2PSHB/VORpx/rSMD4NOwHGWeRU0a/6mnMd/KZxrFLQMs88IRl5lGl7Y/k
	DaitvTqfRlOqJZCxSs9A2/gyfiJQY/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-bOhXfy4qM0m2gI-6uqYeIg-1; Fri,
 25 Oct 2024 16:43:38 -0400
X-MC-Unique: bOhXfy4qM0m2gI-6uqYeIg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6085719560B8;
	Fri, 25 Oct 2024 20:43:35 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AAD3196BB7E;
	Fri, 25 Oct 2024 20:43:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 30/31] afs: Add a tracepoint for afs_read_receive()
Date: Fri, 25 Oct 2024 21:39:57 +0100
Message-ID: <20241025204008.4076565-31-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
index e89a98735317..dbc108c6cae5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -270,6 +270,7 @@ static void afs_read_receive(struct afs_call *call)
 	enum afs_call_state state;
 
 	_enter("");
+	trace_afs_read_recv(op, call);
 
 	state = READ_ONCE(call->state);
 	if (state == AFS_CALL_COMPLETE)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 020ab7302a6b..8da64c9d25e6 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1773,6 +1773,36 @@ TRACE_EVENT(afs_make_call,
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

