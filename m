Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2789C8E0
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 17:53:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+U1MNMc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+U1MNMc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VCtt75593z3dX6
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 01:53:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+U1MNMc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+U1MNMc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VCtt50TYTz3dLQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 01:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712591609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFuGX1yyoTN69ecCATsVj4UhORzkDiRUWoktVVAJ3+Q=;
	b=c+U1MNMcronALfEpB5Zr1rXSWmZ0HD1wh9Y97r8RsGwJ1f3rJ+DaY40cp/ZWKAm4tw1msE
	nM0hAQ9CvZebPOF2x43lZrsksp4IW3sjlzazi+DqzNv/y0WJoNuWAWGZ45Yn9CLLd/FMEB
	13gba6Axg2vIJDn/dfbJb4MmkehDoX8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712591609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFuGX1yyoTN69ecCATsVj4UhORzkDiRUWoktVVAJ3+Q=;
	b=c+U1MNMcronALfEpB5Zr1rXSWmZ0HD1wh9Y97r8RsGwJ1f3rJ+DaY40cp/ZWKAm4tw1msE
	nM0hAQ9CvZebPOF2x43lZrsksp4IW3sjlzazi+DqzNv/y0WJoNuWAWGZ45Yn9CLLd/FMEB
	13gba6Axg2vIJDn/dfbJb4MmkehDoX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-HJAhESVFMaKi_61YaghcgA-1; Mon, 08 Apr 2024 11:53:27 -0400
X-MC-Unique: HJAhESVFMaKi_61YaghcgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEA2C90ACC7;
	Mon,  8 Apr 2024 15:53:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 084C62033AC1;
	Mon,  8 Apr 2024 15:53:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-24-dhowells@redhat.com>
References: <20240328163424.2781320-24-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 23/26] netfs: Cut over to using new writeback code
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <877901.1712591597.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 16:53:17 +0100
Message-ID: <877902.1712591597@warthog.procyon.org.uk>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells <dhowells@redhat.com> wrote:

> +		/* Wait for writeback to complete.  The writeback engine owns
> +		 * the info in folio->private and may change it until it
> +		 * removes the WB mark.
> +		 */
> +		if (folio_wait_writeback_killable(folio)) {
> +			ret =3D written ? -EINTR : -ERESTARTSYS;
> +			goto error_folio_unlock;
> +		}
> +

It turns out that this really kills performance with fio with as many jobs=
 as
cpus.  It's taking up to around 8x longer to complete a pwrite() on averag=
e
and perf shows a 30% of the CPU cycles are being spent in contention on th=
e
i_rwsem.

The reason this was added here is that writeback cannot take the folio loc=
k in
order to clean up folio->private without risking deadlock vs the truncatio=
n
routines (IIRC).

I can mitigate this by skipping the wait if folio->private is not set and =
if
we're not going to attach anything there (see attached).  Note that if
writeout is ongoing and there is nothing attached to ->private, then we sh=
ould
not be engaging write-streaming mode and attaching a new netfs_folio (and =
if
we did, we'd flush the page and wait for it anyway).

The other possibility is if we have a writeback group to set.  This only
applies to ceph for the moment and is something that will need dealing wit=
h
if/when ceph is made to use this code.

David
---

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1eff9413eb1b..279b296f8014 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -255,7 +255,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 		 * the info in folio->private and may change it until it
 		 * removes the WB mark.
 		 */
-		if (folio_wait_writeback_killable(folio)) {
+		if (folio_get_private(folio) &&
+		    folio_wait_writeback_killable(folio)) {
 			ret =3D written ? -EINTR : -ERESTARTSYS;
 			goto error_folio_unlock;
 		}

