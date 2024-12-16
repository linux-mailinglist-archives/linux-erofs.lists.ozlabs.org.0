Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2069F3B30
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:43:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsNj48P0z30ML
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:43:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381827;
	cv=none; b=HG3wIKnGlhTwKdOYymo3vhszLZtgVOaP9ZTzE9XQV9aLq40626qRDd+g41DAwjQ2GDl6xnrJQAlQ6hnFu6nE1eUvIyrCr+BvGhaUUGs944lINu04KIT6p6JU3n3oVn/55Jwqi/sd+nNfaTEgexb3xi1gbCgiic1J7WgoYVxi/0hiCK3XtrNjURejoxfWBi5odGtIFGhui9Mn4A8qPuP/kPNflQhIcFNQ8OrCPGTSCZG6etbMzHgaXeF8LkcfunK6/LjW1TyNamif0Qh5vshroUHv1zHi67gIHnepz2LkHJvgPXL/Ix5hKLnJA//b87ZyfREBNiaK1g6pMsc16xTAog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381827; c=relaxed/relaxed;
	bh=E1QZn15v/KOrpymQ+ncs3oOJnWUIUbAVuPqLqJN1nJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBc3lFEJvMriT4Jr+Gn9kPSVu+74Arx1Y/r6y3JqQN6VIxwEqm/NXJLGi82MnG9nxu8PYBaVIrXYK/3lARtkC5nbEjaYVB5nUWgqgMcYeMjHRKVerI6cgE3nQx6r8pyGQQCdCd/jelA/eatBOxGrwEOl6zeMOGN6ELyhIJpfi91jGisa3OrWw37Uuk7oBJjstexPsN4K50gClzAGdkIiop1Sz0k9fFJqNOFqsJzmXr1cBDtLlaEUrIhaDYLzNrifJZHGeLHAcm1GHodvCVMjt7FfWMWA2xatdIUqEvZLFvdo1MKpyoaES9ewYASu5tdNl/jQryUk3pUostZ3yUBCDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fjy5SG4m; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fjy5SG4m; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fjy5SG4m;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fjy5SG4m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsNf6kKHz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:43:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1QZn15v/KOrpymQ+ncs3oOJnWUIUbAVuPqLqJN1nJs=;
	b=Fjy5SG4mYIiJyzseiSCS1CIfcWFOCVFTfb6ApcZ3rPhQV7gue2BbRdRTxaJysVHpsFcvY7
	VWKF4V3qUyHz8cZkVVk2y0asvDh3Dd56mPkaGd5cGCfOo6sWYCwMr5mRErukBYaSK1SYBA
	4weuqoEeJ4U/S4t77SdeoaXX7kgJS+Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1QZn15v/KOrpymQ+ncs3oOJnWUIUbAVuPqLqJN1nJs=;
	b=Fjy5SG4mYIiJyzseiSCS1CIfcWFOCVFTfb6ApcZ3rPhQV7gue2BbRdRTxaJysVHpsFcvY7
	VWKF4V3qUyHz8cZkVVk2y0asvDh3Dd56mPkaGd5cGCfOo6sWYCwMr5mRErukBYaSK1SYBA
	4weuqoEeJ4U/S4t77SdeoaXX7kgJS+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-pvJkCek_NMCX9YjaoDHTsQ-1; Mon,
 16 Dec 2024 15:43:38 -0500
X-MC-Unique: pvJkCek_NMCX9YjaoDHTsQ-1
X-Mimecast-MFC-AGG-ID: pvJkCek_NMCX9YjaoDHTsQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10C1B195608C;
	Mon, 16 Dec 2024 20:43:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CAFD19560AD;
	Mon, 16 Dec 2024 20:43:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 16/32] cachefiles: Add auxiliary data trace
Date: Mon, 16 Dec 2024 20:41:06 +0000
Message-ID: <20241216204124.3752367-17-dhowells@redhat.com>
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

Add a display of the first 8 bytes of the downloaded auxiliary data and of
the on-disk stored auxiliary data as these are used in coherency
management.  In the case of afs, this holds the data version number.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/xattr.c             |  9 ++++++++-
 include/trace/events/cachefiles.h | 13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 7c6f260a3be5..52383b1d0ba6 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -77,6 +77,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
@@ -85,6 +86,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   be64_to_cpup((__be64 *)buf->data),
 					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
@@ -126,7 +128,10 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 				object,
 				"Failed to read aux with error %zd", xlen);
 		why = cachefiles_coherency_check_xattr;
-	} else if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
+		goto out;
+	}
+
+	if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
 		why = cachefiles_coherency_check_type;
 	} else if (memcmp(buf->data, p, len) != 0) {
 		why = cachefiles_coherency_check_aux;
@@ -141,7 +146,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 		ret = 0;
 	}
 
+out:
 	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+				   be64_to_cpup((__be64 *)buf->data),
 				   buf->content, why);
 	kfree(buf);
 	return ret;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 74114c261bcd..a743b2a35ea7 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -380,10 +380,11 @@ TRACE_EVENT(cachefiles_rename,
 TRACE_EVENT(cachefiles_coherency,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     ino_t ino,
+		     u64 disk_aux,
 		     enum cachefiles_content content,
 		     enum cachefiles_coherency_trace why),
 
-	    TP_ARGS(obj, ino, content, why),
+	    TP_ARGS(obj, ino, disk_aux, content, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
@@ -391,6 +392,8 @@ TRACE_EVENT(cachefiles_coherency,
 		    __field(enum cachefiles_coherency_trace,	why)
 		    __field(enum cachefiles_content,		content)
 		    __field(u64,				ino)
+		    __field(u64,				aux)
+		    __field(u64,				disk_aux)
 			     ),
 
 	    TP_fast_assign(
@@ -398,13 +401,17 @@ TRACE_EVENT(cachefiles_coherency,
 		    __entry->why	= why;
 		    __entry->content	= content;
 		    __entry->ino	= ino;
+		    __entry->aux	= be64_to_cpup((__be64 *)obj->cookie->inline_aux);
+		    __entry->disk_aux	= disk_aux;
 			   ),
 
-	    TP_printk("o=%08x %s B=%llx c=%u",
+	    TP_printk("o=%08x %s B=%llx c=%u aux=%llx dsk=%llx",
 		      __entry->obj,
 		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
 		      __entry->ino,
-		      __entry->content)
+		      __entry->content,
+		      __entry->aux,
+		      __entry->disk_aux)
 	    );
 
 TRACE_EVENT(cachefiles_vol_coherency,

