Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FD8B8EAF
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 19:01:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilcXoEf/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilcXoEf/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VV3Hl1rlpz3cWt
	for <lists+linux-erofs@lfdr.de>; Thu,  2 May 2024 03:01:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilcXoEf/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilcXoEf/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VV3Hc60Tgz3cVf
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 May 2024 03:01:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714582870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbBAwD6JC5VL1ukHU3KFqlt1QekHLcO5vtkGzyQGBMM=;
	b=ilcXoEf/pnceEskk9dURKv2QrwqjB7HAW+C+8dZ2680AWeX8t7NyhWBdF6mU0bdsJp42Sn
	qZVAOK6Bx/h8KQapmaPI5ls1TJpg8SA6imVi0ND/9nvzQCoZVmW5FB23OIt0xu2Qai4ZqK
	yZWlgg6YCQqf5t+NYgI4K8fR0BHem/4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714582870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbBAwD6JC5VL1ukHU3KFqlt1QekHLcO5vtkGzyQGBMM=;
	b=ilcXoEf/pnceEskk9dURKv2QrwqjB7HAW+C+8dZ2680AWeX8t7NyhWBdF6mU0bdsJp42Sn
	qZVAOK6Bx/h8KQapmaPI5ls1TJpg8SA6imVi0ND/9nvzQCoZVmW5FB23OIt0xu2Qai4ZqK
	yZWlgg6YCQqf5t+NYgI4K8fR0BHem/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-jValeIcOO1Sva0kNIIWiZg-1; Wed, 01 May 2024 13:01:07 -0400
X-MC-Unique: jValeIcOO1Sva0kNIIWiZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 014948948A6;
	Wed,  1 May 2024 17:01:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 512842166B31;
	Wed,  1 May 2024 17:01:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-15-dhowells@redhat.com>
References: <20240430140056.261997-15-dhowells@redhat.com> <20240430140056.261997-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 14/22] netfs: New writeback implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <458059.1714582859.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 May 2024 18:00:59 +0100
Message-ID: <458060.1714582859@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This needs the attached change.  It needs to allow for netfs_perform_write=
()
changing i_size whilst we're doing writeback.  The issue is that i_size is
cached in the netfs_io_request struct (as that's what we're going to tell =
the
server the new i_size should be), but we're not updating this properly if
i_size moves between us creating the request and us deciding to write out =
the
folio in which i_size was when we created the request.

This can lead to the folio_zero_segment() that can be seen in the patch be=
low
clearing the wrong amount of the final page - assuming it's still the fina=
l
page.

David
---
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 69c50f4cbf41..e190043bc0da 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -315,13 +315,19 @@ static int netfs_write_folio(struct netfs_io_request=
 *wreq,
 	struct netfs_group *fgroup; /* TODO: Use this with ceph */
 	struct netfs_folio *finfo;
 	size_t fsize =3D folio_size(folio), flen =3D fsize, foff =3D 0;
-	loff_t fpos =3D folio_pos(folio);
+	loff_t fpos =3D folio_pos(folio), i_size;
 	bool to_eof =3D false, streamw =3D false;
 	bool debug =3D false;
 =

 	_enter("");
 =

-	if (fpos >=3D wreq->i_size) {
+	/* netfs_perform_write() may shift i_size around the page or from out
+	 * of the page to beyond it, but cannot move i_size into or through the
+	 * page since we have it locked.
+	 */
+	i_size =3D i_size_read(wreq->inode);
+
+	if (fpos >=3D i_size) {
 		/* mmap beyond eof. */
 		_debug("beyond eof");
 		folio_start_writeback(folio);
@@ -332,6 +338,9 @@ static int netfs_write_folio(struct netfs_io_request *=
wreq,
 		return 0;
 	}
 =

+	if (fpos + fsize > wreq->i_size)
+		wreq->i_size =3D i_size;
+
 	fgroup =3D netfs_folio_group(folio);
 	finfo =3D netfs_folio_info(folio);
 	if (finfo) {
@@ -342,14 +351,14 @@ static int netfs_write_folio(struct netfs_io_request=
 *wreq,
 =

 	if (wreq->origin =3D=3D NETFS_WRITETHROUGH) {
 		to_eof =3D false;
-		if (flen > wreq->i_size - fpos)
-			flen =3D wreq->i_size - fpos;
-	} else if (flen > wreq->i_size - fpos) {
-		flen =3D wreq->i_size - fpos;
+		if (flen > i_size - fpos)
+			flen =3D i_size - fpos;
+	} else if (flen > i_size - fpos) {
+		flen =3D i_size - fpos;
 		if (!streamw)
 			folio_zero_segment(folio, flen, fsize);
 		to_eof =3D true;
-	} else if (flen =3D=3D wreq->i_size - fpos) {
+	} else if (flen =3D=3D i_size - fpos) {
 		to_eof =3D true;
 	}
 	flen -=3D foff;

