Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B308A503D
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 15:04:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4htSnzT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4htSnzT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJ6nb66pwz3dVb
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 23:04:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4htSnzT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4htSnzT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJ6nR6N3Kz3bnv
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 23:04:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713186246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ptvnzk1WkI8ph1+6mQtrYI+ziVGUn1LcaZGMSp9/x0=;
	b=O4htSnzTFMKNASZtrc8GTmHfug/tVxRBYod6bDXDYVFAC1TqUR+Wg6ghcKEmR7+Hz3XYzd
	6phUxM66ckdHxjJqJSLCEKuguy1MT6cozpTeGBnocKbdyyCJdNkk8ah6qPKc0ZL+BJoh4q
	Q+9dUVKv4kaZtxIyJABJ5c0PVkvENJw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713186246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ptvnzk1WkI8ph1+6mQtrYI+ziVGUn1LcaZGMSp9/x0=;
	b=O4htSnzTFMKNASZtrc8GTmHfug/tVxRBYod6bDXDYVFAC1TqUR+Wg6ghcKEmR7+Hz3XYzd
	6phUxM66ckdHxjJqJSLCEKuguy1MT6cozpTeGBnocKbdyyCJdNkk8ah6qPKc0ZL+BJoh4q
	Q+9dUVKv4kaZtxIyJABJ5c0PVkvENJw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-A9VRT3_LO8mlZjn-t-8k9g-1; Mon,
 15 Apr 2024 09:04:04 -0400
X-MC-Unique: A9VRT3_LO8mlZjn-t-8k9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE6CA2999B20;
	Mon, 15 Apr 2024 13:04:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 367FB492BC7;
	Mon, 15 Apr 2024 13:03:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org>
References: <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2345943.1713186234.1@warthog.procyon.org.uk>
Date: Mon, 15 Apr 2024 14:03:54 +0100
Message-ID: <2345944.1713186234@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> wrote:

> > +struct cifs_fscache_inode_key {
> > +
> > +	__le64  uniqueid;	/* server inode number */
> > +	__le64  createtime;	/* creation time on server */
> > +	u8	type;		/* S_IFMT file type */
> > +} __packed;
> > +
> 
> Interesting. So the uniqueid of the inode is not unique within the fs?
> Or are the clients are mounting shares that span multiple filesystems?
> Or, are we looking at a situation where the uniqueid is being quickly
> reused for new inodes after the original inode is unlinked?

The problem is that it's not unique over time.  creat(); unlink(); creat();
may yield a repeat of the uniqueid.  It's like i_ino in that respect.

David

