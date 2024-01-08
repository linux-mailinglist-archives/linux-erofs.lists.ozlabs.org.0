Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D3827AA4
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jan 2024 23:31:59 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pidkx/uF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pidkx/uF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T881k6MdTz30fF
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 09:31:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pidkx/uF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pidkx/uF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T881Y6201z2xqH
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 09:31:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704753099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3fhJdYhF0Jh8djZ9CbUM5+BZiYxRI9hKlm7wmHneNE=;
	b=Pidkx/uFfD924ewqzOQINyXD4Ez0mPNUOTZ+QQlmhqASIQZCHr0NjN1RKvj+2CCVaAb9vG
	7E4yT3oJpViWCDFAWxiz8xdYmG9rPOPUdU+8B7kdE5L0LLSpWsaU8xzDQAopiedB533r/2
	DGr3BUxKMymv/FIWQbJ84ye7UQTiheE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704753099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3fhJdYhF0Jh8djZ9CbUM5+BZiYxRI9hKlm7wmHneNE=;
	b=Pidkx/uFfD924ewqzOQINyXD4Ez0mPNUOTZ+QQlmhqASIQZCHr0NjN1RKvj+2CCVaAb9vG
	7E4yT3oJpViWCDFAWxiz8xdYmG9rPOPUdU+8B7kdE5L0LLSpWsaU8xzDQAopiedB533r/2
	DGr3BUxKMymv/FIWQbJ84ye7UQTiheE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-mFt6nnssNiyKD7dLtjUHgg-1; Mon,
 08 Jan 2024 17:31:35 -0500
X-MC-Unique: mFt6nnssNiyKD7dLtjUHgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CFBE1C29EAA;
	Mon,  8 Jan 2024 22:31:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BECCF1121306;
	Mon,  8 Jan 2024 22:31:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240107160916.GA129355@kernel.org>
References: <20240107160916.GA129355@kernel.org> <20240103145935.384404-1-dhowells@redhat.com> <20240103145935.384404-2-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1544729.1704753090.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jan 2024 22:31:30 +0000
Message-ID: <1544730.1704753090@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Yiqun Leng <yqleng@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Simon Horman <horms@kernel.org> wrote:

> I realise these patches have been accepted, but I have a minor nit:
> pos is now unsigned, and so cannot be less than zero.

Good point.  How about the attached patch.  Whilst I would prefer to use
unsigned long long to avoid the casts, it might =


David
---
cachefiles: Fix signed/unsigned mixup

In __cachefiles_prepare_write(), the start and pos variables were made
unsigned 64-bit so that the casts in the checking could be got rid of -
which should be fine since absolute file offsets can't be negative, except
that an error code may be obtained from vfs_llseek(), which *would* be
negative.  This breaks the error check.

Fix this for now by reverting pos and start to be signed and putting back
the casts.  Unfortunately, the error value checks cannot be replaced with
IS_ERR_VALUE() as long might be 32-bits.

Fixes: 7097c96411d2 ("cachefiles: Fix __cachefiles_prepare_write()")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401071152.DbKqMQMu-lkp@in=
tel.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Gao Xiang <hsiangkao@linux.alibaba.com>
cc: Yiqun Leng <yqleng@linux.alibaba.com>
cc: Jia Zhu <zhujia.zj@bytedance.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/cachefiles/io.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 3eec26967437..9a2cb2868e90 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -522,7 +522,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache =3D object->volume->cache;
-	unsigned long long start =3D *_start, pos;
+	loff_t start =3D *_start, pos;
 	size_t len =3D *_len;
 	int ret;
 =

@@ -556,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if (pos >=3D start + *_len)
+	if ((u64)pos >=3D (u64)start + *_len)
 		goto check_space; /* Unallocated region */
 =

 	/* We have a block that's at least partially filled - if we're low on
@@ -575,7 +575,7 @@ int __cachefiles_prepare_write(struct cachefiles_objec=
t *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if (pos >=3D start + *_len)
+	if ((u64)pos >=3D (u64)start + *_len)
 		return 0; /* Fully allocated */
 =

 	/* Partially allocated, but insufficient space: cull. */

