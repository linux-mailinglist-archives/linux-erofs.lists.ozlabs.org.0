Return-Path: <linux-erofs+bounces-3842-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B7znHGvLS2qOaQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3842-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 17:36:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65103712AC4
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 17:36:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QiD68ZeI;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QiD68ZeI;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3842-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3842-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv7jy27n5z3bps;
	Tue, 07 Jul 2026 01:36:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783352166;
	cv=none; b=jQ5vKl/ssrE6beQzLO6AKBvaYvVy5TuLVXA52yDYas3lezT+hgcxncvq5D8BtSzRizJGU/QQbXaCn2SjUT+vdgX+FxoEW485gmrwPXnF2zkKrgSTkKImvGIpXUnvGQcWl0n66JGUzkHky2MiTlFC45nS6lgNZ/a/GxINgy5eonKE3qW7RgVI+9Lnr9qK5Pwk9QhDhPb4tMhFCn/Zq6SdEQOzVTlcExZU5aRqpXa2CMpwHXo7LTMNMtrZ4JESoavrjG4WyQ/GIvJjMT8bBKwSl0OuhF8R9HhkNbuYtXaoZxsy3ovVYuXy5iHG4xoBJNTbD4NtCDEFWf9l+5ubajHxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783352166; c=relaxed/relaxed;
	bh=RVQrMyUBPr4ODMF32RPNpRLnnaMZ+0xSvSjKELOKsNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H28cEt4+uCJDjUqG0C6NHwvNsBXVsDbNjdNHcWqTyRszac3vfVuwtdN0ZnnLLkLKVtZO3NamP+9JCCj24RB1A+CaU3gNbQztdGqvBsoacsqXToKOsw1lFjeHyUxCKy/71zpwC6uBkEc27amQaikEtbfaartECaGWAz4eUQzLuTFTl4aAJqXFZU4kZNCVy+p8JSjBvxItgW5R7a1WrdbZD6FPqsa0o5Obqi7zbOOXdO7Ra5Okq6VT/a+OpNcfuAiD0CCSRnwYHWysG1LYfP6KSagFBaA3O3s41wcI9acg0MFPLTwGDyBpmZWcfaB47AU93jSNA/eQsutQSTirJe1Qdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QiD68ZeI; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QiD68ZeI; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv7jx2WqDz3bp7
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Jul 2026 01:36:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783352162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVQrMyUBPr4ODMF32RPNpRLnnaMZ+0xSvSjKELOKsNY=;
	b=QiD68ZeI/8M8owiBlNVDXP6I1ANYCgeqqAq3qPIokxrodDVxQ4BupYW9PBD1i64wZaqUY0
	kuGWK49sowfdSMRpkQUpKE9SVA28vMMIo5faYcoCuNUyMpArukJux5Du5PxE7tKKeRC1n+
	2rwJ9E4qHK+PV4YdVRg9fQsgVku0MAU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783352162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVQrMyUBPr4ODMF32RPNpRLnnaMZ+0xSvSjKELOKsNY=;
	b=QiD68ZeI/8M8owiBlNVDXP6I1ANYCgeqqAq3qPIokxrodDVxQ4BupYW9PBD1i64wZaqUY0
	kuGWK49sowfdSMRpkQUpKE9SVA28vMMIo5faYcoCuNUyMpArukJux5Du5PxE7tKKeRC1n+
	2rwJ9E4qHK+PV4YdVRg9fQsgVku0MAU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-WEs-jCDnOSWJWox6C_rJjg-1; Mon,
 06 Jul 2026 11:35:54 -0400
X-MC-Unique: WEs-jCDnOSWJWox6C_rJjg-1
X-Mimecast-MFC-AGG-ID: WEs-jCDnOSWJWox6C_rJjg_1783352152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13A8C18009CF;
	Mon,  6 Jul 2026 15:35:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A6A81956096;
	Mon,  6 Jul 2026 15:35:45 +0000 (UTC)
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
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/21] netfs: Add the cache object ID to netfs_read/write tracepoints
Date: Mon,  6 Jul 2026 16:33:58 +0100
Message-ID: <20260706153408.1231650-13-dhowells@redhat.com>
In-Reply-To: <20260706153408.1231650-1-dhowells@redhat.com>
References: <20260706153408.1231650-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: djcsi-l2M_U12i_YlSFSouI3QtWogewEmqKDyN18kQg_1783352152
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3842-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:metze@samba.org,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,manguebit.org:email,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65103712AC4

Add the cache object debug ID to netfs_read/write tracepoints to make
debugging easier as there's now a direct cross-reference with the
cachefiles tracepoints that only log that debug ID.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           |  1 +
 fs/netfs/fscache_io.c        |  2 +-
 include/linux/netfs.h        |  3 ++-
 include/trace/events/netfs.h | 27 +++++++++++++++------------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 42265fdcc17e..7e32b1caf6fe 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -918,6 +918,7 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 			if (!cres->cache_priv2 && file)
 				cres->cache_priv2 = get_file(file);
 			spin_unlock(&object->lock);
+			cres->object_id = object->debug_id;
 			cres->cache_i_size = i_size_read(file_inode(file));
 			cres->dio_size = object->volume->cache->bsize;
 		}
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 37f05b4d3469..fafa8c6bec57 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -79,7 +79,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 	cres->ops		= NULL;
 	cres->cache_priv	= cookie;
 	cres->cache_priv2	= NULL;
-	cres->debug_id		= cookie->debug_id;
+	cres->cookie_id		= cookie->debug_id;
 	cres->inval_counter	= cookie->inval_counter;
 
 	if (!fscache_begin_cookie_access(cookie, why)) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index bdf9358ed8f7..7de2b34b000e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -165,7 +165,8 @@ struct netfs_cache_resources {
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned long long		cache_i_size;	/* Initial size of cache file */
-	unsigned int			debug_id;	/* Cookie debug ID */
+	unsigned int			cookie_id;	/* Cache cookie debug ID */
+	unsigned int			object_id;	/* Cache object debug ID */
 	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
 	unsigned int			dio_size;	/* DIO block size */
 };
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a857a79ea87f..d5723ce18cbb 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -314,6 +314,7 @@ TRACE_EVENT(netfs_read,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(loff_t,			i_size)
 		    __field(loff_t,			start)
 		    __field(size_t,			len)
@@ -323,7 +324,8 @@ TRACE_EVENT(netfs_read,
 
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
-		    __entry->cookie	= rreq->cache_resources.debug_id;
+		    __entry->cookie	= rreq->cache_resources.cookie_id;
+		    __entry->object	= rreq->cache_resources.object_id;
 		    __entry->i_size	= rreq->i_size;
 		    __entry->start	= start;
 		    __entry->len	= len;
@@ -331,10 +333,10 @@ TRACE_EVENT(netfs_read,
 		    __entry->netfs_inode = rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x ni=%llx s=%llx l=%zx sz=%llx",
+	    TP_printk("R=%08x %s c=%08x o=%08x ni=%llx s=%llx l=%zx sz=%llx",
 		      __entry->rreq,
 		      __print_symbolic(__entry->what, netfs_read_traces),
-		      __entry->cookie,
+		      __entry->cookie, __entry->object,
 		      __entry->netfs_inode,
 		      __entry->start, __entry->len, __entry->i_size)
 	    );
@@ -555,6 +557,7 @@ TRACE_EVENT(netfs_write,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		wreq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(unsigned int,		ino)
 		    __field(enum netfs_write_trace,	what)
 		    __field(unsigned long long,		start)
@@ -562,20 +565,19 @@ TRACE_EVENT(netfs_write,
 			     ),
 
 	    TP_fast_assign(
-		    struct netfs_inode *__ctx = netfs_inode(wreq->inode);
-		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
 		    __entry->wreq	= wreq->debug_id;
-		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->cookie	= wreq->cache_resources.cookie_id;
+		    __entry->object	= wreq->cache_resources.object_id;
 		    __entry->ino	= wreq->inode->i_ino;
 		    __entry->what	= what;
 		    __entry->start	= wreq->start;
 		    __entry->len	= wreq->len;
 			   ),
 
-	    TP_printk("R=%08x %s c=%08x i=%x by=%llx-%llx",
+	    TP_printk("R=%08x %s c=%08x o=%08x i=%x by=%llx-%llx",
 		      __entry->wreq,
 		      __print_symbolic(__entry->what, netfs_write_traces),
-		      __entry->cookie,
+		      __entry->cookie, __entry->object,
 		      __entry->ino,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
@@ -590,22 +592,23 @@ TRACE_EVENT(netfs_copy2cache,
 		    __field(unsigned int,		rreq)
 		    __field(unsigned int,		creq)
 		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		object)
 		    __field(unsigned int,		ino)
 			     ),
 
 	    TP_fast_assign(
-		    struct netfs_inode *__ctx = netfs_inode(rreq->inode);
-		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
 		    __entry->rreq	= rreq->debug_id;
 		    __entry->creq	= creq->debug_id;
-		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->cookie	= rreq->cache_resources.cookie_id;
+		    __entry->object	= rreq->cache_resources.object_id;
 		    __entry->ino	= rreq->inode->i_ino;
 			   ),
 
-	    TP_printk("R=%08x CR=%08x c=%08x i=%x ",
+	    TP_printk("R=%08x CR=%08x c=%08x o=%08x i=%x ",
 		      __entry->rreq,
 		      __entry->creq,
 		      __entry->cookie,
+		      __entry->object,
 		      __entry->ino)
 	    );
 


