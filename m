Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F7E8A7F05
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 11:03:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxubLoYW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxubLoYW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKFLb3KYQz3dTs
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 19:03:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxubLoYW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxubLoYW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKFLR0RFvz3bnv
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 19:03:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cqHolZFVcFPpeLBdV05ZqicpNbJqZRKW17Kvjt/Abs=;
	b=cxubLoYWIvwowsMd7XhW9razO8JGbTXF9zfuXx4Mrct51SDaOBYY9YKQDkfUi8ydwSFAGi
	UjYR3jgNGVJt5NK1LGWAOSITEhnNZLVlpNCeFO8Zq9ng7J4Ma1I9W99Nstzts8UjsBVJml
	DNo+NcwWYEvN2TBXb2kK6HTLufQvAcE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cqHolZFVcFPpeLBdV05ZqicpNbJqZRKW17Kvjt/Abs=;
	b=cxubLoYWIvwowsMd7XhW9razO8JGbTXF9zfuXx4Mrct51SDaOBYY9YKQDkfUi8ydwSFAGi
	UjYR3jgNGVJt5NK1LGWAOSITEhnNZLVlpNCeFO8Zq9ng7J4Ma1I9W99Nstzts8UjsBVJml
	DNo+NcwWYEvN2TBXb2kK6HTLufQvAcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-UAKkPT0cNTu8x3FwjUWu1g-1; Wed, 17 Apr 2024 05:03:00 -0400
X-MC-Unique: UAKkPT0cNTu8x3FwjUWu1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D56BA10499A0;
	Wed, 17 Apr 2024 09:02:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F32BC13FA2;
	Wed, 17 Apr 2024 09:02:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3570373a3db66151033a3667cb8c28bbf8bc505b.camel@kernel.org>
References: <3570373a3db66151033a3667cb8c28bbf8bc505b.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-10-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 09/26] mm: Provide a means of invalidation without using launder_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28262.1713344568.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 10:02:48 +0100
Message-ID: <28263.1713344568@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Andrew Morton <akp
 m@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> wrote:

> I'd have liked to have seen the first caller of this function too.

Looking again at my code, I also need to make netfs_unbuffered_write_iter()
use this function too.  I missed it before because that wasn't calling
invalidate_inode_pages2_range() directly, but rather going through
kiocb_invalidate_pages().

So I'll add those changes into this patch to give you a first caller.  I also
then need to make filemap_invalidate_inode() take a byte range.

David

