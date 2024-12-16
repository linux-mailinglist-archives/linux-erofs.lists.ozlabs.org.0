Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DE9F3B0D
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:41:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsLY3lBZz30Wp
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:41:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381714;
	cv=none; b=hFOf0ff3dsKMVFp9ZzmbbfunjAi3KB68ugCat459z4MZrR1cJlwdhBFatZzTHatG4wHzuso6wFTl08aZP4GuSPegKPJljD5MzeryCy/2bm7FV7I6UIuZqmPf6WP5FLAL++sfD0GFJkdjg7o2rwSiCpU3XnorjmYr+XdVvmE+9AOOX5AtJWBTIvpE5n3nz8JdJRBE6YeJpHLE0qN8ySsJ2fcWoO2KtPpfh3z0yo8kahKtv6CyZvrQKRJf9/VHeu8JezUtu++VSlXk0FyB5eYmgYwJluO8VezfJq6dYJGK4dkQPGYtZucrCRzOQRTJSexNlVeQVgIlvNyz0AHdN+nZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381714; c=relaxed/relaxed;
	bh=adTBnOlG7OP+mEEaZME4U1Xm6Whye29vdivXZFAeN/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V94devb4RcrBkTu+gyTmjiA46fT8+RgvkIbxQE2pOSe7oYXzgE416C4I2ZprT050b8ZAt96EexoGrN4EgGC9GOixhxm75/VYvEOdJ3pnEsTz1fSMmKFxZ2kbdSJPEEkAI6pch03Jl+QWng6ikcVZDTox/7HlwIhjoZua7H6uAKlzMrjhHqkF7YKRTc53EZkHGfY2XqJHg9ax6v9/xj8pm5+BcRShVoHrWG+Sqyve0AEqOZUoFCiSC/ubZm2MVRiqjtKp2CPqp34/8v0pJ/oNBsOa99mGWavGM6iQON2EFPKncaP7Snvn5Dexnpdbdd14JX7WJtWmE8FUiObvZHWuhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJjI8Az8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFyzTlhv; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJjI8Az8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EFyzTlhv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsLT5m1dz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:41:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adTBnOlG7OP+mEEaZME4U1Xm6Whye29vdivXZFAeN/g=;
	b=WJjI8Az8RxDrgBUsGVaHYzoLvGihfxi6O4rWYXF96ibqgIrdHXYhjF88Wk5xybYZW9OWsp
	+2q36FCxa7EM6pohWDzRUwZqCoJQ85YCBfsRRjrI99BPMb8pcO3f8XuT2JkMhI+ocvW2CF
	Iz1lFQp9TkExkNyEWU2SXYvjoS11XjE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adTBnOlG7OP+mEEaZME4U1Xm6Whye29vdivXZFAeN/g=;
	b=EFyzTlhvEUzCXSfDSJY6uxr6WTyvmZdFTYkavtxt+udQ5RaFXMIuqfqpRQTi6kjDYFvmHR
	oGgtf/Enan5UChMe0Jy+gsGGgwpSwwg3LwW4ESVndTJg7dBhbi3XknTJeXOZXTT8R7b8Cz
	jAhKX8ty8bqGpekBKl76n9D3RC9rw24=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-jA7cNRPXO32tOToDKSMRqw-1; Mon,
 16 Dec 2024 15:41:46 -0500
X-MC-Unique: jA7cNRPXO32tOToDKSMRqw-1
X-Mimecast-MFC-AGG-ID: jA7cNRPXO32tOToDKSMRqw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5273A1956052;
	Mon, 16 Dec 2024 20:41:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B548A19560A2;
	Mon, 16 Dec 2024 20:41:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 01/32] netfs: Clean up some whitespace in trace header
Date: Mon, 16 Dec 2024 20:40:51 +0000
Message-ID: <20241216204124.3752367-2-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Clean up some whitespace in the netfs trace header.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/netfs.h | 130 +++++++++++++++++------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index bf511bca896e..c3c309f8fbe1 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -250,13 +250,13 @@ TRACE_EVENT(netfs_read,
 	    TP_ARGS(rreq, start, len, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		cookie		)
-		    __field(loff_t,			i_size		)
-		    __field(loff_t,			start		)
-		    __field(size_t,			len		)
-		    __field(enum netfs_read_trace,	what		)
-		    __field(unsigned int,		netfs_inode	)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		cookie)
+		    __field(loff_t,			i_size)
+		    __field(loff_t,			start)
+		    __field(size_t,			len)
+		    __field(enum netfs_read_trace,	what)
+		    __field(unsigned int,		netfs_inode)
 			     ),
 
 	    TP_fast_assign(
@@ -284,10 +284,10 @@ TRACE_EVENT(netfs_rreq,
 	    TP_ARGS(rreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		flags		)
-		    __field(enum netfs_io_origin,	origin		)
-		    __field(enum netfs_rreq_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		flags)
+		    __field(enum netfs_io_origin,	origin)
+		    __field(enum netfs_rreq_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -311,15 +311,15 @@ TRACE_EVENT(netfs_sreq,
 	    TP_ARGS(sreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
-		    __field(short,			error		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum netfs_sreq_trace,	what		)
-		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
-		    __field(loff_t,			start		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned short,		index)
+		    __field(short,			error)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum netfs_sreq_trace,	what)
+		    __field(size_t,			len)
+		    __field(size_t,			transferred)
+		    __field(loff_t,			start)
 			     ),
 
 	    TP_fast_assign(
@@ -351,15 +351,15 @@ TRACE_EVENT(netfs_failure,
 	    TP_ARGS(rreq, sreq, error, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(short,			index		)
-		    __field(short,			error		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum netfs_failure,		what		)
-		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
-		    __field(loff_t,			start		)
+		    __field(unsigned int,		rreq)
+		    __field(short,			index)
+		    __field(short,			error)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum netfs_failure,		what)
+		    __field(size_t,			len)
+		    __field(size_t,			transferred)
+		    __field(loff_t,			start)
 			     ),
 
 	    TP_fast_assign(
@@ -390,9 +390,9 @@ TRACE_EVENT(netfs_rreq_ref,
 	    TP_ARGS(rreq_debug_id, ref, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(int,			ref		)
-		    __field(enum netfs_rreq_ref_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(int,			ref)
+		    __field(enum netfs_rreq_ref_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -414,10 +414,10 @@ TRACE_EVENT(netfs_sreq_ref,
 	    TP_ARGS(rreq_debug_id, subreq_debug_index, ref, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		subreq		)
-		    __field(int,			ref		)
-		    __field(enum netfs_sreq_ref_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		subreq)
+		    __field(int,			ref)
+		    __field(enum netfs_sreq_ref_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -465,10 +465,10 @@ TRACE_EVENT(netfs_write_iter,
 	    TP_ARGS(iocb, from),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned long long,		start		)
-		    __field(size_t,			len		)
-		    __field(unsigned int,		flags		)
-		    __field(unsigned int,		ino		)
+		    __field(unsigned long long,		start)
+		    __field(size_t,			len)
+		    __field(unsigned int,		flags)
+		    __field(unsigned int,		ino)
 			     ),
 
 	    TP_fast_assign(
@@ -489,12 +489,12 @@ TRACE_EVENT(netfs_write,
 	    TP_ARGS(wreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		ino		)
-		    __field(enum netfs_write_trace,	what		)
-		    __field(unsigned long long,		start		)
-		    __field(unsigned long long,		len		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+		    __field(enum netfs_write_trace,	what)
+		    __field(unsigned long long,		start)
+		    __field(unsigned long long,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -522,10 +522,10 @@ TRACE_EVENT(netfs_collect,
 	    TP_ARGS(wreq),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		len		)
-		    __field(unsigned long long,		transferred	)
-		    __field(unsigned long long,		start		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		len)
+		    __field(unsigned long long,		transferred)
+		    __field(unsigned long long,		start)
 			     ),
 
 	    TP_fast_assign(
@@ -548,12 +548,12 @@ TRACE_EVENT(netfs_collect_sreq,
 	    TP_ARGS(wreq, subreq),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		subreq		)
-		    __field(unsigned int,		stream		)
-		    __field(unsigned int,		len		)
-		    __field(unsigned int,		transferred	)
-		    __field(unsigned long long,		start		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		subreq)
+		    __field(unsigned int,		stream)
+		    __field(unsigned int,		len)
+		    __field(unsigned int,		transferred)
+		    __field(unsigned long long,		start)
 			     ),
 
 	    TP_fast_assign(
@@ -579,11 +579,11 @@ TRACE_EVENT(netfs_collect_folio,
 	    TP_ARGS(wreq, folio, fend, collected_to),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	wreq		)
-		    __field(unsigned long,	index		)
-		    __field(unsigned long long,	fend		)
-		    __field(unsigned long long,	cleaned_to	)
-		    __field(unsigned long long,	collected_to	)
+		    __field(unsigned int,	wreq)
+		    __field(unsigned long,	index)
+		    __field(unsigned long long,	fend)
+		    __field(unsigned long long,	cleaned_to)
+		    __field(unsigned long long,	collected_to)
 			     ),
 
 	    TP_fast_assign(
@@ -608,10 +608,10 @@ TRACE_EVENT(netfs_collect_state,
 	    TP_ARGS(wreq, collected_to, notes),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	wreq		)
-		    __field(unsigned int,	notes		)
-		    __field(unsigned long long,	collected_to	)
-		    __field(unsigned long long,	cleaned_to	)
+		    __field(unsigned int,	wreq)
+		    __field(unsigned int,	notes)
+		    __field(unsigned long long,	collected_to)
+		    __field(unsigned long long,	cleaned_to)
 			     ),
 
 	    TP_fast_assign(

