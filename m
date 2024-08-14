Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCF952388
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:40:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GSuScijR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbfZ+G5J;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wkg9y0J7kz2yZ0
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:40:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GSuScijR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbfZ+G5J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wkg9n3Cvdz2yWr
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:40:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ILxAt7NrlTMl997Ic8qQaZjEltu0gIkdcefwxoaQ6I=;
	b=GSuScijRofqAp5T9UReYiEWeY4cABK/OVLrWOe1PoRmVUL8nDDxkqNC1DPjXkxR84fak/P
	cBo07bxSK3ZqxUKtfRxjjgZwA+BVwd0aYQLU7PaOItXHsAnPrgzDWg49bkaI/P4LjI9rDW
	w34k0Qz4lJ5UkHfGMy4TU4msjBeXrlQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ILxAt7NrlTMl997Ic8qQaZjEltu0gIkdcefwxoaQ6I=;
	b=VbfZ+G5J63Y3I3yYSFU214OrI419Gl5Dv36UIXOOlB9aLg90o/8YvPHt/1LqRLAgMdQrbo
	L8DvQFaX22gl/zbj/5cVz06t02CC+biE4orAvl8SBI4kTRl8axwX9kqu7XUHZkXrHBYr6Y
	SID3k5KWW+hU2LeVgHwIWC7P+uiWv3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-TmxqWq9ANiW1IsbBOq97nA-1; Wed,
 14 Aug 2024 16:40:07 -0400
X-MC-Unique: TmxqWq9ANiW1IsbBOq97nA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75755195609E;
	Wed, 14 Aug 2024 20:40:04 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 917E219560A3;
	Wed, 14 Aug 2024 20:39:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 08/25] netfs: Reserve netfs_sreq_source 0 as unset/unknown
Date: Wed, 14 Aug 2024 21:38:28 +0100
Message-ID: <20240814203850.2240469-9-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Reserve the 0-valued netfs_sreq_source to mean unset or unknown so that it
can be seen in the trace as such rather than appearing as
download-from-server when it's going to get switched to something else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h        | 1 +
 include/trace/events/netfs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 11fa86640d91..16834751e646 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -43,6 +43,7 @@ static inline void folio_start_private_2(struct folio *folio)
 #define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
 
 enum netfs_io_source {
+	NETFS_SOURCE_UNKNOWN,
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a4fd5dea52f4..f4105b8e5894 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -60,6 +60,7 @@
 	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
 #define netfs_sreq_sources					\
+	EM(NETFS_SOURCE_UNKNOWN,		"----")		\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
 	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\

