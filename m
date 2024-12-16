Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32F9F3B0F
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:42:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsLh0D1jz30Sv
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:42:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381722;
	cv=none; b=ijJFxgdvKyMcr9nwCYr27bFIHFwQ57DaTqLQfWqauDcdLWbN/+wYMj90xNdn9VYKhE05neJrMe8VXOOI+BU/11VoHbFhAKLA7LjS1WCQ0oNUnXA2gCxC7YMshgNmeWJpBkxhiNafIzVkw/ioQ897Y1xkvq0A123YYrszYd4gFz02SmiOUUBCzWpKsFxbvayMCR0aU4UT9oIZ31BeUkHIfZlA+ymbY4KKLhT/Eohc1uOHyP8vHG/DpDwUVsRD9f2fZnk4xFAasiQk90NlmB7nGHDAlg+sXRu5uZ4+7UsmWVeC8FHx5Kz/VOxsrvgBDyyFumlenvYAz7O4ncnpLwo2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381722; c=relaxed/relaxed;
	bh=ImLLuUlnuS58zU73BDFFYc3DK9zcBLY9IdUFoq8DTcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Y9ZP8D5PnRbAmHkzqOdGtggzmwfoL5FY3imzWyYsM+8cBXAw/NIYnOvsuAC+98Mr4DYbuhXURNw37N5NRzCTtMfnUBNPucaDR2jr40gX3iS70MFr5P692LHeKIshILpf6/9h8/ZA8oDZF9LedVanwmIZk21yPG238c0Td02AauloIbk8Hs5tINgvbopu8J5z/CADlqIJnFhEV6H2Vg/asCzDAEUvrxW5MFQ0ez4emOr/Mg1hCEZ9ORPyEyqAY7J67WTnFhCNYqFzYcs6n21y9DNRZLZKqQ2Hjw3UkT1YpMg/ZMoggZ1Z3YDEyMx7JHmkNW8D+BJsRWOzErR4txMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GloNetCc; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YXJGc+Qv; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GloNetCc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YXJGc+Qv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsLd2j66z2xxw
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:42:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImLLuUlnuS58zU73BDFFYc3DK9zcBLY9IdUFoq8DTcw=;
	b=GloNetCc9Dj3CbYB7n5PneghEA9CxSZFoVg1puQEQXiuBE7iNcDdqXV4ljYfAJbMjuIAgm
	aS6KT6x5Blhk366Iua29RbcBSIiewbxyCXcHiNeTs617gVhpdVv6JbVL6K7lC9C6Gco6Hp
	sDGbYGQlpcIaVFt1WUk81jANyELB7bg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImLLuUlnuS58zU73BDFFYc3DK9zcBLY9IdUFoq8DTcw=;
	b=YXJGc+QvNSsfI5pL+wYE3D9KuY52Mj1V96YgBcaxlsF1TyUapVfbWGhqJ5t35N9ZnSVI11
	t8vHVXQD4NWTouRi7onXRw/2rGqg8XGE1Fme6NEbZW1Q2oog12AQpfBuqJcMbZFMACyYrC
	u3CdeLvLdAj4+VuklSUqzuK2LpgLZ1A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-UvuEeORjP-aiztK1V-7R9Q-1; Mon,
 16 Dec 2024 15:41:54 -0500
X-MC-Unique: UvuEeORjP-aiztK1V-7R9Q-1
X-Mimecast-MFC-AGG-ID: UvuEeORjP-aiztK1V-7R9Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D031955F4A;
	Mon, 16 Dec 2024 20:41:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 050E219560AD;
	Mon, 16 Dec 2024 20:41:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 02/32] cachefiles: Clean up some whitespace in trace header
Date: Mon, 16 Dec 2024 20:40:52 +0000
Message-ID: <20241216204124.3752367-3-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Clean up some whitespace in the cachefiles trace header.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/cachefiles.h | 172 +++++++++++++++---------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 7d931db02b93..74114c261bcd 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -223,10 +223,10 @@ TRACE_EVENT(cachefiles_ref,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj		)
-		    __field(unsigned int,			cookie		)
-		    __field(enum cachefiles_obj_ref_trace,	why		)
-		    __field(int,				usage		)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			cookie)
+		    __field(enum cachefiles_obj_ref_trace,	why)
+		    __field(int,				usage)
 			     ),
 
 	    TP_fast_assign(
@@ -249,10 +249,10 @@ TRACE_EVENT(cachefiles_lookup,
 	    TP_ARGS(obj, dir, de),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(short,			error	)
-		    __field(unsigned long,		dino	)
-		    __field(unsigned long,		ino	)
+		    __field(unsigned int,		obj)
+		    __field(short,			error)
+		    __field(unsigned long,		dino)
+		    __field(unsigned long,		ino)
 			     ),
 
 	    TP_fast_assign(
@@ -273,8 +273,8 @@ TRACE_EVENT(cachefiles_mkdir,
 	    TP_ARGS(dir, subdir),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			dir	)
-		    __field(unsigned int,			subdir	)
+		    __field(unsigned int,			dir)
+		    __field(unsigned int,			subdir)
 			     ),
 
 	    TP_fast_assign(
@@ -293,8 +293,8 @@ TRACE_EVENT(cachefiles_tmpfile,
 	    TP_ARGS(obj, backer),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
 			     ),
 
 	    TP_fast_assign(
@@ -313,8 +313,8 @@ TRACE_EVENT(cachefiles_link,
 	    TP_ARGS(obj, backer),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
 			     ),
 
 	    TP_fast_assign(
@@ -336,9 +336,9 @@ TRACE_EVENT(cachefiles_unlink,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		ino		)
-		    __field(enum fscache_why_object_killed, why		)
+		    __field(unsigned int,		obj)
+		    __field(unsigned int,		ino)
+		    __field(enum fscache_why_object_killed, why)
 			     ),
 
 	    TP_fast_assign(
@@ -361,9 +361,9 @@ TRACE_EVENT(cachefiles_rename,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		ino		)
-		    __field(enum fscache_why_object_killed, why		)
+		    __field(unsigned int,		obj)
+		    __field(unsigned int,		ino)
+		    __field(enum fscache_why_object_killed, why)
 			     ),
 
 	    TP_fast_assign(
@@ -387,10 +387,10 @@ TRACE_EVENT(cachefiles_coherency,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(enum cachefiles_content,		content	)
-		    __field(u64,				ino	)
+		    __field(unsigned int,			obj)
+		    __field(enum cachefiles_coherency_trace,	why)
+		    __field(enum cachefiles_content,		content)
+		    __field(u64,				ino)
 			     ),
 
 	    TP_fast_assign(
@@ -416,9 +416,9 @@ TRACE_EVENT(cachefiles_vol_coherency,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			vol	)
-		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(u64,				ino	)
+		    __field(unsigned int,			vol)
+		    __field(enum cachefiles_coherency_trace,	why)
+		    __field(u64,				ino)
 			     ),
 
 	    TP_fast_assign(
@@ -445,14 +445,14 @@ TRACE_EVENT(cachefiles_prep_read,
 	    TP_ARGS(obj, start, len, flags, source, why, cache_inode, netfs_inode),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum cachefiles_prepare_read_trace,	why	)
-		    __field(size_t,			len		)
-		    __field(loff_t,			start		)
-		    __field(unsigned int,		netfs_inode	)
-		    __field(unsigned int,		cache_inode	)
+		    __field(unsigned int,		obj)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum cachefiles_prepare_read_trace,	why)
+		    __field(size_t,			len)
+		    __field(loff_t,			start)
+		    __field(unsigned int,		netfs_inode)
+		    __field(unsigned int,		cache_inode)
 			     ),
 
 	    TP_fast_assign(
@@ -484,10 +484,10 @@ TRACE_EVENT(cachefiles_read,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(size_t,				len	)
-		    __field(loff_t,				start	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(size_t,				len)
+		    __field(loff_t,				start)
 			     ),
 
 	    TP_fast_assign(
@@ -513,10 +513,10 @@ TRACE_EVENT(cachefiles_write,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(size_t,				len	)
-		    __field(loff_t,				start	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(size_t,				len)
+		    __field(loff_t,				start)
 			     ),
 
 	    TP_fast_assign(
@@ -540,11 +540,11 @@ TRACE_EVENT(cachefiles_trunc,
 	    TP_ARGS(obj, backer, from, to, why),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_trunc_trace,	why	)
-		    __field(loff_t,				from	)
-		    __field(loff_t,				to	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_trunc_trace,	why)
+		    __field(loff_t,				from)
+		    __field(loff_t,				to)
 			     ),
 
 	    TP_fast_assign(
@@ -571,8 +571,8 @@ TRACE_EVENT(cachefiles_mark_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -592,8 +592,8 @@ TRACE_EVENT(cachefiles_mark_failed,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -613,8 +613,8 @@ TRACE_EVENT(cachefiles_mark_inactive,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -633,10 +633,10 @@ TRACE_EVENT(cachefiles_vfs_error,
 	    TP_ARGS(obj, backer, error, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_error_trace,	where	)
-		    __field(short,				error	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_error_trace,	where)
+		    __field(short,				error)
 			     ),
 
 	    TP_fast_assign(
@@ -660,10 +660,10 @@ TRACE_EVENT(cachefiles_io_error,
 	    TP_ARGS(obj, backer, error, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_error_trace,	where	)
-		    __field(short,				error	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_error_trace,	where)
+		    __field(short,				error)
 			     ),
 
 	    TP_fast_assign(
@@ -687,11 +687,11 @@ TRACE_EVENT(cachefiles_ondemand_open,
 	    TP_ARGS(obj, msg, load),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
-		    __field(unsigned int,	fd		)
-		    __field(unsigned int,	flags		)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
+		    __field(unsigned int,	fd)
+		    __field(unsigned int,	flags)
 			     ),
 
 	    TP_fast_assign(
@@ -717,9 +717,9 @@ TRACE_EVENT(cachefiles_ondemand_copen,
 	    TP_ARGS(obj, msg_id, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	msg_id	)
-		    __field(long,		len	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(long,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -740,9 +740,9 @@ TRACE_EVENT(cachefiles_ondemand_close,
 	    TP_ARGS(obj, msg),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
 			     ),
 
 	    TP_fast_assign(
@@ -764,11 +764,11 @@ TRACE_EVENT(cachefiles_ondemand_read,
 	    TP_ARGS(obj, msg, load),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
-		    __field(loff_t,		start		)
-		    __field(size_t,		len		)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
+		    __field(loff_t,		start)
+		    __field(size_t,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -793,8 +793,8 @@ TRACE_EVENT(cachefiles_ondemand_cread,
 	    TP_ARGS(obj, msg_id),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	msg_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
 			     ),
 
 	    TP_fast_assign(
@@ -814,10 +814,10 @@ TRACE_EVENT(cachefiles_ondemand_fd_write,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	backer	)
-		    __field(loff_t,		start	)
-		    __field(size_t,		len	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	backer)
+		    __field(loff_t,		start)
+		    __field(size_t,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -840,8 +840,8 @@ TRACE_EVENT(cachefiles_ondemand_fd_release,
 	    TP_ARGS(obj, object_id),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	object_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	object_id)
 			     ),
 
 	    TP_fast_assign(

