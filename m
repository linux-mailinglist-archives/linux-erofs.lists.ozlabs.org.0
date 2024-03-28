Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A856A8905A9
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 17:39:14 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HPMwLo+K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HPMwLo+K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V58Pr3BMfz3vcS
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 03:39:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HPMwLo+K;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HPMwLo+K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V58Pk66btz3vcX
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:39:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=456sspCvb5RC8F6uPLvmqcL+ECbtkHJJvcCgmdRCz9o=;
	b=HPMwLo+KLZNan5yWGELaG57YG3RWYJgCU191bZmiJTl0GLod09oS53xzPbUej+RfpN/dDj
	3F5wl2R0nqhqRGobnnUXhrprU6M6aC2AR/4xxFBl0Rp5TjI5487ExXygUyUCADhI90Rmqr
	KKqPqmwGE1xKQF0a7t5GPfbsEJRvnA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=456sspCvb5RC8F6uPLvmqcL+ECbtkHJJvcCgmdRCz9o=;
	b=HPMwLo+KLZNan5yWGELaG57YG3RWYJgCU191bZmiJTl0GLod09oS53xzPbUej+RfpN/dDj
	3F5wl2R0nqhqRGobnnUXhrprU6M6aC2AR/4xxFBl0Rp5TjI5487ExXygUyUCADhI90Rmqr
	KKqPqmwGE1xKQF0a7t5GPfbsEJRvnA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-5Oh98SDqMqqEMoYuR2MDaA-1; Thu, 28 Mar 2024 12:39:02 -0400
X-MC-Unique: 5Oh98SDqMqqEMoYuR2MDaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02433933EF8;
	Thu, 28 Mar 2024 16:39:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1AEB1C060D0;
	Thu, 28 Mar 2024 16:38:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 25/26] netfs: Miscellaneous tidy ups
Date: Thu, 28 Mar 2024 16:34:17 +0000
Message-ID: <20240328163424.2781320-26-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Do a couple of miscellaneous tidy ups:

 (1) Add a qualifier into a file banner comment.

 (2) Put the writeback folio traces back into alphabetical order.

 (3) Remove some unused folio traces.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c    | 2 +-
 include/trace/events/netfs.h | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 2da9905abec9..1eff9413eb1b 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Network filesystem high-level write support.
+/* Network filesystem high-level buffered write support.
  *
  * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e7700172ae7e..4ba553a6d71b 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -141,12 +141,9 @@
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
-	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_copy,		"copy")		\
-	EM(netfs_folio_trace_copy_plus,		"copy+")	\
+	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
-	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\
@@ -156,7 +153,6 @@
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
-	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
 	EM(netfs_folio_trace_store_copy,	"store-copy")	\

